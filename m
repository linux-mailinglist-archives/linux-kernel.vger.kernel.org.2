Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650B832BDB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352127AbhCCQ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbhCCLr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:47:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193EC061225
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 03:46:14 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a18so15122112wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 03:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MeQqLKfUpWUw4m4oMpwWQScKW8kK3AHyes4EBhAmAkY=;
        b=HhgsIYiiTod2dmWWRk3//eBmB2MYwsQLBC29KvdiN6vETMyE+ZMNnNqWQL9Q/yCDRg
         Yg7jpXpcAlfCciQCb1dhadnF1MPG3VwptYH/Ffc5eM5IfYHwxK1t23w8y4ntWhdpi+hX
         BIdAy9ioa8VWsHKWh1hl1XsGVsLbZ9vzImWgu2vPeKZlly2rSxusiAHRfNCBs86+vq9L
         olhq+VMNM4Pu76UAGBI/m9kUSvPY0HVIku76Yb6QYkeBp3nUkcM8Ef8f8KMwHu3fumMR
         Uk0aD7BckV9mia2RFglhuobhexzKfCjQt53ygUBx6ogiReBN9axN2qTu5jFGUVE/4b0H
         4YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MeQqLKfUpWUw4m4oMpwWQScKW8kK3AHyes4EBhAmAkY=;
        b=Q2S1YixUuWFkdNiLjqXR/PfbcPptcIXz2w9YtjfYoZI2KVCzf6osWLeUvT/ZFK4UcW
         zOl7WtGX8fBoG/aLs/9sVMsrd0kDHaZUInFMiurASvuk+60xxrFLQsRllUIqB+14Re26
         qrirfsMAvqIfBxFER4+J8oUdYP0C4ZEdE7pAxBM0JkUFawiKfappEEApiKpNu6VjfVYU
         RxNvYSZpoGt2TYToAmzrQO2oR2CkPvJTd4uwGHkRJ6p92Bqj2ounihGit3lr8QBYgfX/
         tWb3PscPd/N7PQxHhzvpcFRmx8flVodiYAwYgwUcW1kACEJBN81POzccVtPBF0S9CyKp
         lNGw==
X-Gm-Message-State: AOAM532YKh4lHYxXlqTgT5c1AxsI9Qq3mGNNPTvA42uAOFk9Nwh/SlL2
        OiLPUA/sW23ffXTcwFXXm/+7P+YbbC5xNQ==
X-Google-Smtp-Source: ABdhPJx6TiVE2WzgqGC5H4bW+t5fZtoXZpTTF4vyAcjFnqKb7ufY0KvoXlWsJCX56BMIZ1QB/VTfFQ==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr26294650wrr.81.1614771973791;
        Wed, 03 Mar 2021 03:46:13 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id y10sm23512424wrl.19.2021.03.03.03.46.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 03:46:13 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/3] soundwire: qcom: add clock stop via runtime pm
 support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
 <20210226170250.9067-4-srinivas.kandagatla@linaro.org>
 <2899ca9e-2938-4d8d-5e56-49eba8cdb920@linux.intel.com>
Message-ID: <75a7a05c-d34d-aa3f-e8e8-4bbb89e1beca@linaro.org>
Date:   Wed, 3 Mar 2021 11:46:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2899ca9e-2938-4d8d-5e56-49eba8cdb920@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for reviewing this in detail!


On 26/02/2021 17:41, Pierre-Louis Bossart wrote:
...

>>       return 0;
>>   err_master_add:
>> @@ -1214,6 +1261,47 @@ static int qcom_swrm_remove(struct 
>> platform_device *pdev)
>>       return 0;
>>   }
>> +static int swrm_runtime_resume(struct device *dev)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +    reinit_completion(&ctrl->enumeration);
>> +    clk_prepare_enable(ctrl->hclk);
>> +    ctrl->reg_write(ctrl, SWRM_COMP_SW_RESET, 0x01);
>> +    qcom_swrm_get_device_status(ctrl);
>> +    sdw_handle_slave_status(&ctrl->bus, ctrl->status);
>> +    qcom_swrm_init(ctrl);
>> +    wait_for_completion_timeout(&ctrl->enumeration,
>> +                    msecs_to_jiffies(TIMEOUT_MS));
>> +    usleep_range(100, 105);
>> +
>> +    pm_runtime_mark_last_busy(dev);
> 
> Humm, what 'clock stop' are we talking about here?
> 
> In SoundWire 1.x devices, you can stop the BUS clock and not have to 
> redo any enumeration on resume, devices are required to save their 
> context.  You have to also follow the pattern of preparing and 
> broadcasting the CLOCK STOP NOW message.
> 
> It looks like you are stopping something else, and completely resetting 
> the hardware. It's fine, it's just a reset but not clock stop support as 
> defined in the SoundWire spec.
> 

This is clock stop that Soundwire Spec refers to.

However I think I messed up this patch! :-)




>> +
>> +    return 0;
>> +}
>> +
>> +static int __maybe_unused swrm_runtime_suspend(struct device *dev)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +    /* Mask bus clash interrupt */
>> +    ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR, ctrl->intr_mask);
>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
>> +    /* clock stop sequence */
>> +    qcom_swrm_cmd_fifo_wr_cmd(ctrl, 0x2, 0xF, SDW_SCP_CTRL);
> 
> Humm, this looks like writing in SCP_CTRL::ClockStopNow, so why is 
> enumeration required on restart?
> 
One of the controller instance needed a full reset so there is a mix of 
code for both clock stop and reset here!

Am working on cleaning up this in a better way!

I will also address the runtime pm comments that you have noticed in 
next version!

--srini


> If you take down the bus and reset everything, you don't need to do this 
> sequence. a hardware reset will do...
> 
>> +
>> +    clk_disable_unprepare(ctrl->hclk);
>> +
>> +    usleep_range(100, 105);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dev_pm_ops swrm_dev_pm_ops = {
>> +    SET_RUNTIME_PM_OPS(swrm_runtime_suspend, swrm_runtime_resume, NULL)
>> +};
>> +
>>   static const struct of_device_id qcom_swrm_of_match[] = {
>>       { .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>>       { .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
>> @@ -1228,6 +1316,7 @@ static struct platform_driver qcom_swrm_driver = {
>>       .driver = {
>>           .name    = "qcom-soundwire",
>>           .of_match_table = qcom_swrm_of_match,
>> +        .pm = &swrm_dev_pm_ops,
>>       }
>>   };
>>   module_platform_driver(qcom_swrm_driver);
>>
