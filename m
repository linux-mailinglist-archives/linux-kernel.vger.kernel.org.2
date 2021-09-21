Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9206413073
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhIUIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhIUIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:51:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35ACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:50:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c21so70779693edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HkZu14VXfctwaSYuyiW2cjsB/gvRTdwNouV+ANcmUeA=;
        b=UyRnDpqdswRLmsQG5I5Jdpc+raHc/RhHCnlPuDh7FiDb6cmpYgvKarJg15lj78G/aX
         ZvB6AjbD8o9O3+l2ikaaXuKOYJZS7U/uZGOYYaZLdH4clg8DF040OaztEZu6FykSTNkg
         nb+lyiHFcKAe1lhSudlde/N4UhUwiiHKeR8MVMgHB6uRxOTn1JSdF1CsnmtIsnxivocE
         ABV33p6gYp1Ahufj5YWkBqRqf+S+1y3ZAkV48FTrHuoGHI4af0PnV9cq75O+lagsl8Mq
         0FPqpsKfpOc6yx8Psu452KiQLTRpP/NuweQppUGWhMH5/iD5v1BHj3EubGznAHvhwhwf
         KdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HkZu14VXfctwaSYuyiW2cjsB/gvRTdwNouV+ANcmUeA=;
        b=rODI5/1e22aBb8mnuosNgC254w6jy9M9bC7c/765HhhnMp5/pjSJ6puUsBUbSIr8e8
         ORmbFZWDMQ1Gaavd71UpQI95ylYKT2ZRfFmiANOakT5PTbDvQM1uJzrXgpjaXsKGQiL1
         U7DVDstw/BPqlaq5/bydjTl5DG8Wg0W2S2YRJJmte5yWjRFNq6m/khl24JTbjDQ3wl95
         iIxSy/YzQ4E2ALS/n9KvkGG1RMgoGNLDYRy/WYiuUhA3Wqomh3VFr+4eWUByGZbBUocR
         ey7DWfDR2OGxNg7iQiWQ3wMEfATpLzeh5qnNNyu1FgxlWfVP5x7tw3jJY7gY8LFBLolv
         aLTQ==
X-Gm-Message-State: AOAM5301eNuLKT7MLbgXfTT+7SyoG1sz4RYvnhE17Ji/F2elgBKfuZP6
        CXOWPVj2rQaHKeKNiZTYPVzCHg==
X-Google-Smtp-Source: ABdhPJwWRAkE4BoH7wMvkEWUdH/YMDpklvYMJ0cU4PsrWFWjRQsEvKOUFvxDE4yNsbo7QuGoGEbmEA==
X-Received: by 2002:a17:907:7844:: with SMTP id lb4mr33363272ejc.381.1632214210366;
        Tue, 21 Sep 2021 01:50:10 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id w13sm8751343ede.24.2021.09.21.01.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 01:50:09 -0700 (PDT)
Subject: Re: [PATCH 4/7] ASoC: codecs: lpass-va-macro: Change bulk voting to
 individual clock voting
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1632123331-2425-1-git-send-email-srivasam@codeaurora.org>
 <1632123331-2425-5-git-send-email-srivasam@codeaurora.org>
 <5f915592-0ca6-2839-43fc-6d9aef1484b7@linaro.org>
 <2378b5b1-fe45-171d-f8f9-373f8cece37f@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a29cfafc-5a29-0760-2578-f1c52cdb1e42@linaro.org>
Date:   Tue, 21 Sep 2021 09:50:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2378b5b1-fe45-171d-f8f9-373f8cece37f@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2021 09:14, Srinivasa Rao Mandadapu wrote:
> 
> On 9/20/2021 6:55 PM, Srinivas Kandagatla wrote:
>>
>>
> Thanks for Your time Srini!!!
>> On 20/09/2021 08:35, Srinivasa Rao Mandadapu wrote:
>>> Change bulk clock frequency voting to individual voting.
>>>
>> Can you please explain why do we need to move out using clk bulk apis?
>>
>> Am not seeing any thing obvious behavior changing as part of this 
>> patch, more details please..
> 
> In ADSP bypass use case, few clocks like macro and decode, are optional. 
> So is the main reason for move out.


Have you tried using clk_bulk_get_optional()

--srini
> 
> And sometimes we are seeing bulk voting failed in Kodiak setup.
> 
>>> Fixes: 908e6b1df26e (ASoC: codecs: lpass-va-macro: Add support to VA 
>>> Macro)
>>
>> Why this has Fixes tag? Are we fixing any bug with this patch?
> Okay. As such we are not fixing any bug. Will remove this fixes tag on 
> your suggestion.
>>
>>>
>>> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>>> ---
>>>   sound/soc/codecs/lpass-va-macro.c | 46 
>>> ++++++++++++++++++++++++---------------
>>>   1 file changed, 28 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/sound/soc/codecs/lpass-va-macro.c 
>>> b/sound/soc/codecs/lpass-va-macro.c
>>> index d312a14..0ea39ae 100644
>>> --- a/sound/soc/codecs/lpass-va-macro.c
>>> +++ b/sound/soc/codecs/lpass-va-macro.c
>>> @@ -193,7 +193,10 @@ struct va_macro {
>>>         int dec_mode[VA_MACRO_NUM_DECIMATORS];
>>>       struct regmap *regmap;
>>> -    struct clk_bulk_data clks[VA_NUM_CLKS_MAX];
>>> +    struct clk *mclk;
>>> +    struct clk *macro;
>>> +    struct clk *dcodec;
>>> +
>>>       struct clk_hw hw;
>>>         s32 dmic_0_1_clk_cnt;
>>> @@ -1321,7 +1324,7 @@ static const struct clk_ops fsgen_gate_ops = {
>>>     static int va_macro_register_fsgen_output(struct va_macro *va)
>>>   {
>>> -    struct clk *parent = va->clks[2].clk;
>>> +    struct clk *parent = va->mclk;
>>>       struct device *dev = va->dev;
>>>       struct device_node *np = dev->of_node;
>>>       const char *parent_clk_name;
>>> @@ -1404,15 +1407,18 @@ static int va_macro_probe(struct 
>>> platform_device *pdev)
>>>           return -ENOMEM;
>>>         va->dev = dev;
>>> -    va->clks[0].id = "macro";
>>> -    va->clks[1].id = "dcodec";
>>> -    va->clks[2].id = "mclk";
>>>   -    ret = devm_clk_bulk_get(dev, VA_NUM_CLKS_MAX, va->clks);
>>> -    if (ret) {
>>> -        dev_err(dev, "Error getting VA Clocks (%d)\n", ret);
>>> -        return ret;
>>> -    }
>>> +    va->macro = devm_clk_get_optional(dev, "macro");
>>> +    if (IS_ERR(va->macro))
>>> +        return PTR_ERR(va->macro);
>>> +
>>> +    va->dcodec = devm_clk_get_optional(dev, "dcodec");
>>> +    if (IS_ERR(va->dcodec))
>>> +        return PTR_ERR(va->dcodec);
>>> +
>>> +    va->mclk = devm_clk_get(dev, "mclk");
>>> +    if (IS_ERR(va->mclk))
>>> +        return PTR_ERR(va->mclk);
>>>         ret = of_property_read_u32(dev->of_node, 
>>> "qcom,dmic-sample-rate",
>>>                      &sample_rate);
>>> @@ -1426,10 +1432,11 @@ static int va_macro_probe(struct 
>>> platform_device *pdev)
>>>       }
>>>         /* mclk rate */
>>> -    clk_set_rate(va->clks[1].clk, VA_MACRO_MCLK_FREQ);
>>> -    ret = clk_bulk_prepare_enable(VA_NUM_CLKS_MAX, va->clks);
>>> -    if (ret)
>>> -        return ret;
>>> +    clk_set_rate(va->mclk, VA_MACRO_MCLK_FREQ);
>>> +
>>> +    clk_prepare_enable(va->mclk);
>>> +    clk_prepare_enable(va->macro);
>>> +    clk_prepare_enable(va->dcodec);
>>>         base = devm_platform_ioremap_resource(pdev, 0);
>>>       if (IS_ERR(base)) {
>>> @@ -1457,8 +1464,9 @@ static int va_macro_probe(struct 
>>> platform_device *pdev)
>>>       return ret;
>>>     err:
>>> -    clk_bulk_disable_unprepare(VA_NUM_CLKS_MAX, va->clks);
>>> -
>>> +    clk_disable_unprepare(va->mclk);
>>> +    clk_disable_unprepare(va->macro);
>>> +    clk_disable_unprepare(va->dcodec);
>>>       return ret;
>>>   }
>>>   @@ -1466,8 +1474,10 @@ static int va_macro_remove(struct 
>>> platform_device *pdev)
>>>   {
>>>       struct va_macro *va = dev_get_drvdata(&pdev->dev);
>>>   -    clk_bulk_disable_unprepare(VA_NUM_CLKS_MAX, va->clks);
>>> -
>>> +    of_clk_del_provider(pdev->dev.of_node);
>>
>> fsgen clk is registered using devm_* variant of clk apis, so why do we 
>> need this here?
>>
> Okay. Will remove it and post new patch.
>>
>> --srini
>>> +    clk_disable_unprepare(va->mclk);
>>> +    clk_disable_unprepare(va->macro);
>>> +    clk_disable_unprepare(va->dcodec);
>>>       return 0;
>>>   }
>>>
