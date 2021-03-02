Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571C532A446
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379513AbhCBK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382769AbhCBKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:14:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3036C061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:13:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u16so1219643wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xcr6nYe2UxMWOTbC9+BHvb9NVTHNUG0GFxt3b2FnksY=;
        b=wfbHLmk1lwwkYx86pI0Jkn8A4TeGXZ3p7PcqGzBtQL+jbzrKHa2QushbeL0kgmOdcy
         DgRzk8eyg9PolPbdM3IuVmiUiXwumX8jiYo+Az6BKjJQyHI/wxCidy0es4Sg/ui4IVRr
         CSoRejo3PTgnj9U5Q8z5qf5LdSLQyJ4FoWf0ejC0JtmtL5t4ClG4TNUyG9LMuPD8SiJw
         pUxrhmPmfIXj9Z2yLlTM5vOD7n1+AuoVDPFDVpg1naVBsWnTZLowkWzBE82WitZfKLfr
         Ok3Or4yLG9EruAJZj1F7LTSH/SsCefgCzU0y7P0wNZpObT7J/AwAQUyGpJEI8lBxCBId
         NK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xcr6nYe2UxMWOTbC9+BHvb9NVTHNUG0GFxt3b2FnksY=;
        b=JpEuFitGvVr4sGaeNvGyL9rqpFxTKTo1d6276k/aVcuFMyi2y+QC3cgSJSQroeEEiS
         4SWF/CStP37NWEnLc+229NlB0gw89sRAA+hPm9DFvpSr5rlPl0skOVFzcsV4oCP8xJe1
         l1oTd+BTVsJVjbrOTfbUFs04/Nt62pwNB06LwfgTWXaGnSRfByADTqtTgwWep0zCXCue
         9OE3Hij92lASpSd+WGKwbNiIUVhkGycndTw6CrFn6R5SGyWbHQgY2bcZnlfEoR8tLT0N
         xT8iG02MkQU1xacKHFFFVEJDyC1WwUYLuGZCMYVOOC243V1ybCJYWsAM7VxvWAEfcBCa
         +bKQ==
X-Gm-Message-State: AOAM533esOOX14MmvzBLzNvNEq76r98675E9nTwejR8NZjzS4Pf7xCwX
        vtxbj7gdHImaoCZVfktHYFzm5BrtcTiuJw==
X-Google-Smtp-Source: ABdhPJy4Qs3kI/CTheU4YQQqlrXckGJI2rZKeSgmj9W2cepKFmwaH6mvOExt2Nu/KMdKtNXug6CARg==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr21901451wrw.33.1614679994411;
        Tue, 02 Mar 2021 02:13:14 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 12sm2051210wmw.43.2021.03.02.02.13.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 02:13:13 -0800 (PST)
Subject: Re: [PATCH v2 1/5] soundwire: qcom: add support to missing transport
 params
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
 <20210226155814.27536-2-srinivas.kandagatla@linaro.org>
 <00842f73-c0fb-5728-3ed0-c0a1fd75f94e@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <31eca99d-9f84-e088-443b-9aae782c2df2@linaro.org>
Date:   Tue, 2 Mar 2021 10:13:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <00842f73-c0fb-5728-3ed0-c0a1fd75f94e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for reviewing the patches!

On 26/02/2021 16:45, Pierre-Louis Bossart wrote:
> 
> 
> On 2/26/21 9:58 AM, Srinivas Kandagatla wrote:
>> Some of the transport parameters derived from device tree
>> are not fully parsed by the driver.
>>
>> This patch adds support to parse those missing parameters.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 99 ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 95 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 6d22df01f354..fee7465c72c2 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -54,7 +54,13 @@
>>   #define SWRM_MCP_SLV_STATUS                    0x1090
>>   #define SWRM_MCP_SLV_STATUS_MASK                GENMASK(1, 0)
>>   #define SWRM_DP_PORT_CTRL_BANK(n, m)    (0x1124 + 0x100 * (n - 1) + 
>> 0x40 * m)
>> +#define SWRM_DP_PORT_CTRL_2_BANK(n, m)    (0x1128 + 0x100 * (n - 1) + 
>> 0x40 * m)
>> +#define SWRM_DP_BLOCK_CTRL_1(n)        (0x112C + 0x100 * (n - 1))
>> +#define SWRM_DP_BLOCK_CTRL2_BANK(n, m)    (0x1130 + 0x100 * (n - 1) + 
>> 0x40 * m)
>> +#define SWRM_DP_PORT_HCTRL_BANK(n, m)    (0x1134 + 0x100 * (n - 1) + 
>> 0x40 * m)
>>   #define SWRM_DP_BLOCK_CTRL3_BANK(n, m)    (0x1138 + 0x100 * (n - 1) 
>> + 0x40 * m)
>> +#define SWRM_DIN_DPn_PCM_PORT_CTRL(n)    (0x1054 + 0x100 * (n - 1))
>> +
>>   #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT                0x18
>>   #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT                0x10
>>   #define SWRM_DP_PORT_CTRL_OFFSET1_SHFT                0x08
>> @@ -73,12 +79,20 @@
>>   #define QCOM_SDW_MAX_PORTS    14
>>   #define DEFAULT_CLK_FREQ    9600000
>>   #define SWRM_MAX_DAIS        0xF
>> +#define SWR_INVALID_PARAM 0xFF
>> +#define SWR_HSTOP_MAX_VAL 0xF
>> +#define SWR_HSTART_MIN_VAL 0x0
>>   struct qcom_swrm_port_config {
>>       u8 si;
>>       u8 off1;
>>       u8 off2;
>>       u8 bp_mode;
>> +    u8 hstart;
>> +    u8 hstop;
>> +    u8 word_length;
>> +    u8 blk_group_count;
>> +    u8 lane_control;
>>   };
>>   struct qcom_swrm_ctrl {
>> @@ -396,7 +410,13 @@ static int qcom_swrm_port_params(struct sdw_bus 
>> *bus,
>>                    struct sdw_port_params *p_params,
>>                    unsigned int bank)
>>   {
>> -    /* TBD */
>> +    struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +
>> +    if (p_params->bps != SWR_INVALID_PARAM)
> 
> this is odd. sdw_port_params is a structure in 
> include/linux/soundwire/sdw.h, but here you are comparing the value with 
> a private qualcomm-defined value.
> 
> The Word length of the port is limited by the standard (64), so your 
> choice of 0xFF for SWR_INVALID_PARAM is legit, but it should be a 
> 'public' define.
> 
Am not sure if this really make sense to add it as a public define!

This is more of how the parameters are marked as not applicable for some 
ports while passing these values from device tree.


But I agree with your comments, now I have modified the code to look at 
the qcom_swrm_port_config instead of checking the "struct 
sdw_port_params" or "struct sdw_transport_params" which should make this 
INVALID flag not relevant to these data-structures anymore!


>> +        return ctrl->reg_write(ctrl,
>> +                       SWRM_DP_BLOCK_CTRL_1(p_params->num),
>> +                       p_params->bps - 1);
>> +
>>       return 0;
>>   }
>> @@ -415,10 +435,32 @@ static int qcom_swrm_transport_params(struct 
>> sdw_bus *bus,
>>       ret = ctrl->reg_write(ctrl, reg, value);
>> -    if (!ret && params->blk_pkg_mode) {
>> -        reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
>> +    if (params->lane_ctrl != SWR_INVALID_PARAM) {
>> +        reg = SWRM_DP_PORT_CTRL_2_BANK(params->port_num, bank);
>> +        value = params->lane_ctrl;
>> +        ret = ctrl->reg_write(ctrl, reg, value);
>> +    }
>> -        ret = ctrl->reg_write(ctrl, reg, 1);
>> +    if (params->blk_grp_ctrl != SWR_INVALID_PARAM) {
>> +        reg = SWRM_DP_BLOCK_CTRL2_BANK(params->port_num, bank);
>> +        value = params->blk_grp_ctrl;
>> +        ret = ctrl->reg_write(ctrl, reg, value);
>> +    }
>> +
>> +    if (params->hstart != SWR_INVALID_PARAM
>> +            && params->hstop != SWR_INVALID_PARAM) {
>> +        reg = SWRM_DP_PORT_HCTRL_BANK(params->port_num, bank);
>> +        value = (params->hstop << 4) | params->hstart;
>> +        ret = ctrl->reg_write(ctrl, reg, value);
>> +    } else {
>> +        reg = SWRM_DP_PORT_HCTRL_BANK(params->port_num, bank);
>> +        value = (SWR_HSTOP_MAX_VAL << 4) | SWR_HSTART_MIN_VAL;
>> +        ret = ctrl->reg_write(ctrl, reg, value);
>> +    }
>> +
>> +    if (params->blk_pkg_mode != SWR_INVALID_PARAM) {
>> +        reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
>> +        ret = ctrl->reg_write(ctrl, reg, params->blk_pkg_mode);
>>       }
> 
> same comments here, you should define a public define for all those 
> parameters.
> 
>>       return ret;
>> @@ -470,6 +512,17 @@ static int qcom_swrm_compute_params(struct 
>> sdw_bus *bus)
>>               p_rt->transport_params.offset1 = pcfg->off1;
>>               p_rt->transport_params.offset2 = pcfg->off2;
>>               p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
>> +            p_rt->transport_params.blk_grp_ctrl = pcfg->blk_group_count;
>> +            p_rt->transport_params.hstart = pcfg->hstart;
>> +            p_rt->transport_params.hstop = pcfg->hstop;
>> +            p_rt->transport_params.lane_ctrl = pcfg->lane_control;
>> +            if (pcfg->word_length != SWR_INVALID_PARAM) {
>> +                sdw_fill_port_params(&p_rt->port_params,
>> +                         p_rt->num,  pcfg->word_length + 1,
>> +                         SDW_PORT_FLOW_MODE_ISOCH,
>> +                         SDW_PORT_DATA_MODE_NORMAL);
>> +            }
>> +
>>           }
>>           list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>> @@ -481,6 +534,18 @@ static int qcom_swrm_compute_params(struct 
>> sdw_bus *bus)
>>                   p_rt->transport_params.offset1 = pcfg->off1;
>>                   p_rt->transport_params.offset2 = pcfg->off2;
>>                   p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
>> +                p_rt->transport_params.blk_grp_ctrl = 
>> pcfg->blk_group_count;
>> +
>> +                p_rt->transport_params.hstart = pcfg->hstart;
>> +                p_rt->transport_params.hstop = pcfg->hstop;
>> +                p_rt->transport_params.lane_ctrl = pcfg->lane_control;
>> +                if (pcfg->word_length != SWR_INVALID_PARAM) {
>> +                    sdw_fill_port_params(&p_rt->port_params,
>> +                             p_rt->num,
>> +                             pcfg->word_length + 1,
>> +                             SDW_PORT_FLOW_MODE_ISOCH,
>> +                             SDW_PORT_DATA_MODE_NORMAL);
>> +                }
>>                   i++;
>>               }
>>           }
>> @@ -728,6 +793,11 @@ static int qcom_swrm_get_port_config(struct 
>> qcom_swrm_ctrl *ctrl)
>>       u8 off2[QCOM_SDW_MAX_PORTS];
>>       u8 si[QCOM_SDW_MAX_PORTS];
>>       u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
>> +    u8 hstart[QCOM_SDW_MAX_PORTS];
>> +    u8 hstop[QCOM_SDW_MAX_PORTS];
>> +    u8 word_length[QCOM_SDW_MAX_PORTS];
>> +    u8 blk_group_count[QCOM_SDW_MAX_PORTS];
>> +    u8 lane_control[QCOM_SDW_MAX_PORTS];
>>       int i, ret, nports, val;
>>       ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
>> @@ -772,11 +842,32 @@ static int qcom_swrm_get_port_config(struct 
>> qcom_swrm_ctrl *ctrl)
>>       ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
>>                       bp_mode, nports);
>> +
>> +    memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>> +    of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
>> +
>> +    memset(hstop, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>> +    of_property_read_u8_array(np, "qcom,ports-hstop", hstop, nports);
>> +
>> +    memset(word_length, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>> +    of_property_read_u8_array(np, "qcom,ports-word-length", 
>> word_length, nports);
>> +
>> +    memset(blk_group_count, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>> +    of_property_read_u8_array(np, "qcom,ports-block-group-count", 
>> blk_group_count, nports);
>> +
>> +    memset(lane_control, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>> +    of_property_read_u8_array(np, "qcom,ports-lane-control", 
>> lane_control, nports);
>> +
>>       for (i = 0; i < nports; i++) {
>>           ctrl->pconfig[i].si = si[i];
>>           ctrl->pconfig[i].off1 = off1[i];
>>           ctrl->pconfig[i].off2 = off2[i];
>>           ctrl->pconfig[i].bp_mode = bp_mode[i];
>> +        ctrl->pconfig[i].hstart = hstart[i];
>> +        ctrl->pconfig[i].hstop = hstop[i];
>> +        ctrl->pconfig[i].word_length = word_length[i];
>> +        ctrl->pconfig[i].blk_group_count = blk_group_count[i];
>> +        ctrl->pconfig[i].lane_control = lane_control[i];
>>       }
> 
> I don't get why you test the values parsed from DT before writing the 
> registers. Why do test them here? if some values are incorrect it's much 
> better to provide an error log instead of writing a partially valid 
> setup to hardware, no?

from DT we pass parameters for all the master ports, however some of 
these parameters are not really applicable for some of the ports! so the 
way we handle this is by marking them as 0xFF which means these values 
are not applicable for those ports! Having said that I think I should 
probably redefine SWR_INVALID_PARAM to QCOM_SWR_PARAM_NA or something on 
those lines!


--srini
>>       return 0;
>>
