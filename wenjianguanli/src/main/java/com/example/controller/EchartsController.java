package com.example.controller;

import cn.hutool.json.JSONObject;
import com.example.common.Result;
import com.example.entity.*;
import com.example.service.*;
import com.example.vo.*;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequestMapping("/echarts")
public class EchartsController {

	@Resource
	private AdminInfoService adminInfoService;
	@Resource
	private UserInfoService userInfoService;
	@Resource
	private TypeInfoService typeInfoService;
	@Resource
    private FileInfoService fileInfoService;


    @GetMapping("/get/{modelName}")
    Result<List<EchartsData>> getEchartsData(@PathVariable String modelName) {
        List<EchartsData> list = new ArrayList<>();
        switch (modelName) {
			case "adminInfo":
				List<AdminInfoVo> adminInfoList = adminInfoService.findAll();
				List<AdminInfo> adminInfoMaleList = adminInfoList.stream().filter(x -> "男".equals(x.getSex())).collect(Collectors.toList());
				Map<String, Integer> adminInfoMap = new HashMap<>(2);
				adminInfoMap.put("男", adminInfoMaleList.size());
				adminInfoMap.put("女", adminInfoList.size() - adminInfoMaleList.size());
				getPieData("管理员", list, adminInfoMap);
				getBarData("管理员", list, adminInfoMap);

				break;
			case "userInfo":
				List<UserInfoVo> userInfoList = userInfoService.findAll();
				List<UserInfo> userInfoMaleList = userInfoList.stream().filter(x -> "男".equals(x.getSex())).collect(Collectors.toList());
				Map<String, Integer> userInfoMap = new HashMap<>(2);
				userInfoMap.put("男", userInfoMaleList.size());
				userInfoMap.put("女", userInfoList.size() - userInfoMaleList.size());
				getPieData("用户", list, userInfoMap);
				getBarData("用户", list, userInfoMap);

				break;

			case "typeInfo":
				List<TypeInfoVo> typeInfoList = typeInfoService.findAll();
                List<FileInfoVo> all = fileInfoService.findAll();
                Map<String, Integer> typeInfoMap = new HashMap<>();
				for (TypeInfo typeInfo : typeInfoList) {
                    List<FileInfoVo> collect = all.stream().filter(x -> typeInfo.getId().equals(x.getTypeId())).collect(Collectors.toList());
                    typeInfoMap.put(typeInfo.getName(), collect.size());
				}
				getPieData("文件分类", list, typeInfoMap);
				getBarData("文件分类", list, typeInfoMap);

				break;

            case "danweiInfo":
                List<FileInfoVo> fileList = fileInfoService.findAll();
                Map<String, Integer> map = new HashMap<>();
                // 根据单位进行分组统计
                Set<Map.Entry<String, List<FileInfoVo>>> entries = fileList.stream()
                        // 根据单位进行分组
                        .collect(Collectors.groupingBy(FileInfo::getDanwei))
                        .entrySet();
                for (Map.Entry<String, List<FileInfoVo>> entry : entries) {
                    map.put(entry.getKey(), entry.getValue().size());
                }
                getPieData("来报单位", list, map);
                getBarData("来报单位", list, map);

                break;

            case "titleInfo":
                List<FileInfoVo> titleInfoList = fileInfoService.findAll();
                Map<String, Integer> titleInfoMap = new HashMap<>();
                // 根据标题进行分组统计
                Set<Map.Entry<String, List<FileInfoVo>>> titleInfoCollect = titleInfoList.stream()
                        // 根据标题进行分组
                        .collect(Collectors.groupingBy(FileInfo::getName))
                        .entrySet();
                for (Map.Entry<String, List<FileInfoVo>> entry : titleInfoCollect) {
                    titleInfoMap.put(entry.getKey(), entry.getValue().size());
                }
                getPieData("标题统计", list, titleInfoMap);
                getBarData("标题统计", list, titleInfoMap);

                break;

            case "keywordInfo":
                List<FileInfoVo> keywordInfoList = fileInfoService.findAll();
                Map<String, Integer> keywordInfoMap = new HashMap<>();
                // 根据关键字进行分组统计
                Set<Map.Entry<String, List<FileInfoVo>>> keywordInfoCollect = keywordInfoList.stream()
                        // 根据关键字进行分组
                        .collect(Collectors.groupingBy(FileInfo::getKeyword))
                        .entrySet();
                for (Map.Entry<String, List<FileInfoVo>> entry : keywordInfoCollect) {
                    keywordInfoMap.put(entry.getKey(), entry.getValue().size());
                }
                getPieData("关键字统计", list, keywordInfoMap);
                getBarData("关键字统计", list, keywordInfoMap);

                break;

            case "uploadInfo":
                List<FileInfoVo> uploadInfoList = fileInfoService.findAll();
                Map<String, Integer> uploadInfoMap = new HashMap<>();
                // 根据上传人进行分组统计
                Set<Map.Entry<String, List<FileInfoVo>>> uploadInfoCollect = uploadInfoList.stream()
                        // 根据上传人进行分组
                        .collect(Collectors.groupingBy(FileInfoVo::getUserName))
                        .entrySet();
                for (Map.Entry<String, List<FileInfoVo>> entry : uploadInfoCollect) {
                    uploadInfoMap.put(entry.getKey(), entry.getValue().size());
                }
                getPieData("上传人统计", list, uploadInfoMap);
                getBarData("上传人统计", list, uploadInfoMap);

                break;

            case "timeInfo":
                List<FileInfoVo> timeInfoList = fileInfoService.findAll();
                List<FileInfoVo> collect = timeInfoList.stream().map(x -> {
                    FileInfoVo vo = new FileInfoVo();
                    BeanUtils.copyProperties(x, vo);
                    vo.setTime(x.getTime().split(" ")[0]);
                    return vo;
                }).collect(Collectors.toList());

                Map<String, Integer> timeInfoMap = new HashMap<>();
                // 根据时间进行分组统计
                Set<Map.Entry<String, List<FileInfoVo>>> timeInfoCollect = collect.stream()
                        // 根据时间进行分组
                        .collect(Collectors.groupingBy(FileInfo::getTime))
                        .entrySet();
                for (Map.Entry<String, List<FileInfoVo>> entry : timeInfoCollect) {
                    timeInfoMap.put(entry.getKey(), entry.getValue().size());
                }
                getPieData("时间统计", list, timeInfoMap);
                getBarData("时间统计", list, timeInfoMap);

                break;

            default:
                break;
        }
        return Result.success(list);
    }

    @GetMapping("/options")
        Result<List<Map<String, String>>> getOptions() {
        List<Map<String, String>> options = new ArrayList<>();

		Map<String, String> optionMap1 = new HashMap<>();
		optionMap1.put("value", "adminInfo");
		optionMap1.put("label", "管理员统计");
		options.add(optionMap1);
		Map<String, String> optionMap2 = new HashMap<>();
		optionMap2.put("value", "userInfo");
		optionMap2.put("label", "用户统计");
		options.add(optionMap2);
		Map<String, String> optionMap3 = new HashMap<>();
		optionMap3.put("value", "typeInfo");
		optionMap3.put("label", "文件分类统计");
		options.add(optionMap3);

        Map<String, String> optionMap4 = new HashMap<>();
        optionMap4.put("value", "danweiInfo");
        optionMap4.put("label", "来报单位统计");
        options.add(optionMap4);

        Map<String, String> optionMap5 = new HashMap<>();
        optionMap5.put("value", "titleInfo");
        optionMap5.put("label", "标题统计");
        options.add(optionMap5);

        Map<String, String> optionMap6 = new HashMap<>();
        optionMap6.put("value", "keywordInfo");
        optionMap6.put("label", "关键字统计");
        options.add(optionMap6);

        Map<String, String> optionMap7 = new HashMap<>();
        optionMap7.put("value", "uploadInfo");
        optionMap7.put("label", "上传人统计");
        options.add(optionMap7);

        Map<String, String> optionMap8 = new HashMap<>();
        optionMap8.put("value", "timeInfo");
        optionMap8.put("label", "上传时间统计");
        options.add(optionMap8);

        return Result.success(options);
    }

    private void getPieData(String name, List<EchartsData> pieList, Map<String, Integer> dataMap) {
        EchartsData pieData = new EchartsData();
        EchartsData.Series series = new EchartsData.Series();

        Map<String, String> titleMap = new HashMap<>(2);
        titleMap.put("text", name + "信息");
        pieData.setTitle(titleMap);

        series.setName(name + "比例");
        series.setType("pie");
        series.setRadius("55%");

        List<Object> objects = new ArrayList<>();
        List<Object> legendList = new ArrayList<>();
        for (String key : dataMap.keySet()) {
            Integer value = dataMap.get(key);
            objects.add(new JSONObject().putOpt("name", key).putOpt("value", value));
            legendList.add(key);
        }
        series.setData(objects);

        pieData.setSeries(Collections.singletonList(series));
        Map<String, Boolean> map = new HashMap<>();
        map.put("show", true);
        pieData.setTooltip(map);

        Map<String, Object> legendMap = new HashMap<>(4);
        legendMap.put("orient", "vertical");
        legendMap.put("x", "left");
        legendMap.put("y", "center");
        legendMap.put("data", legendList);
        pieData.setLegend(legendMap);

        pieList.add(pieData);
    }

    private void getBarData(String name, List<EchartsData> barList, Map<String, Integer> dataMap) {
        EchartsData barData = new EchartsData();
        EchartsData.Series series = new EchartsData.Series();

        List<Object> seriesObjs = new ArrayList<>();
        List<Object> xAxisObjs = new ArrayList<>();
            for (String key : dataMap.keySet()) {
            Integer value = dataMap.get(key);
            xAxisObjs.add(key);
            seriesObjs.add(value);
        }

        series.setType("bar");
        series.setName(name);
        series.setData(seriesObjs);
        barData.setSeries(Collections.singletonList(series));

        Map<String, Object> xAxisMap = new HashMap<>(1);
        xAxisMap.put("data", xAxisObjs);
        barData.setxAxis(xAxisMap);

        barData.setyAxis(new HashMap<>());

        Map<String, Object> legendMap = new HashMap<>(1);
        legendMap.put("data", Collections.singletonList(name));
        barData.setLegend(legendMap);

        Map<String, Boolean> map = new HashMap<>(1);
        map.put("show", true);
        barData.setTooltip(map);

        Map<String, String> titleMap = new HashMap<>(1);
        titleMap.put("text", name + "信息");
        barData.setTitle(titleMap);

        barList.add(barData);
    }

}
