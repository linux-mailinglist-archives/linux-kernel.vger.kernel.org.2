Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577F041AAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbhI1IdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbhI1IdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:33:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DE3C061740
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:31:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so1478228wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YmNYTNBGpZvwgNJ/3llhM6f6fKai+uXQmO5CueqZOHU=;
        b=Iw9B8dZqcRBTDvMkHFJwYFI6cS196dXNMLcqp+SpVn27CUxZ72207rqrBMBRVmYSdS
         AKWkGAC2ASDfYg9nsHaSeou/w02RfowYKr6/Gp1KOQIHNdF1fO1dg4V31ml4gDZR5sSy
         AMYRXIPaD0TMoab+JHxtXFwVrIOM8pbq6D4xrYqSIOeUR9p2IyYWMxORLxroadaJE/6b
         Ez9W1dY2gAzaIlhNdM5yest9yeGSsAMEUBOtpTnbqa7I6XxchvtgadxlX7g7s9iNvyWk
         9Ka0VxbN4MHmEH/gYfJXb6u4O1dj2O67RwNsYiiMNy0zV+oSCeEh2QV1uiO0YjsHGNLQ
         JStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmNYTNBGpZvwgNJ/3llhM6f6fKai+uXQmO5CueqZOHU=;
        b=OC7YZdc+sKlJNl/Hn9xX1HWYHqiV5/FHsbDcCFgnP2aoYnnP3QT39KUKTwmeppqxpl
         nioVvyHNgpAq6wmNFW26N7JjajZIOXmpgYnJNbsuqWrp0rNhYrafe77Ek4T0l+dRR26M
         +5AMsMNrDToL/hPOdopbNiX5fqsXvClQJDZKinlnZSr6uUScs0G3cDDGzVkxsFhr4v9c
         TWVd6dR/jRV+mWJR5n3VVckGJRsKRbYX9dO8c7+37tW3yo4qy2dKvYitadn3YxswfGLJ
         oH4CrcJiVSqEYUu3Qx6Ch5uzQXrTJQ4GujUDjtzodFXRPfHORyI+dRQfuE62KS+oB4Xt
         6xhg==
X-Gm-Message-State: AOAM532Vc0KWmejqeh4m5oVNij7dWDO7Lu9/spQ0E7hDhwd5Whp3B1pa
        +fOibfphF6hQLqVNfaDaldHsTw==
X-Google-Smtp-Source: ABdhPJz6fv4dVDrrADbMFfj+UPr/oF1PoftGT0gkA4xkC1zU4drUe8tTSfrMzDQxXRS90YiKxN0lKA==
X-Received: by 2002:a1c:28b:: with SMTP id 133mr2103589wmc.15.1632817881868;
        Tue, 28 Sep 2021 01:31:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id y13sm1331454wrm.48.2021.09.28.01.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 01:31:21 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] ASoC: codecs: tx-macro: Update tx default values
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <agross@kernel.org; bjorn.andersson@linaro.org;
 lgirdwood@gmail.com; broonie@kernel.org;robh+dt@kernel.org;
 plai@codeaurora.org; bgoswami@codeaurora.org; perex@perex.cz;
 tiwai@suse.com;srinivas.kandagatla@linaro.org; rohitkr@codeaurora.org;
 linux-arm-msm@vger.kernel.org; alsa-devel@alsa-project.org;
 devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
 swboyd@chromium.org; judyhsiao@chromium.org;>
 <1632313878-12089-1-git-send-email-srivasam@codeaurora.org>
 <1632313878-12089-5-git-send-email-srivasam@codeaurora.org>
 <e65c77f4-766c-a5ce-9cbd-f1697c1be28c@linaro.org>
 <20ddc4ea-e99c-5492-1931-be1999655563@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <da23bfce-23cd-0869-d752-b0713136072a@linaro.org>
Date:   Tue, 28 Sep 2021 09:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20ddc4ea-e99c-5492-1931-be1999655563@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/2021 17:42, Srinivasa Rao Mandadapu wrote:
> 
> On 9/27/2021 4:12 PM, Srinivas Kandagatla wrote:
> Thanks for your time Srini!!
>>
>> On 22/09/2021 13:31, Srinivasa Rao Mandadapu wrote:
>>> Update mic control register default values to hardware reset values
>>>
>>> Fixes: c39667ddcfc5 (ASoC: codecs: lpass-tx-macro: add support for 
>>> lpass tx macro)
>>>
>>> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>>> ---
>>>   sound/soc/codecs/lpass-tx-macro.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sound/soc/codecs/lpass-tx-macro.c 
>>> b/sound/soc/codecs/lpass-tx-macro.c
>>> index e980b2e..66c39fb 100644
>>> --- a/sound/soc/codecs/lpass-tx-macro.c
>>> +++ b/sound/soc/codecs/lpass-tx-macro.c
>>> @@ -279,7 +279,7 @@ static const struct reg_default tx_defaults[] = {
>>>       { CDC_TX_CLK_RST_CTRL_SWR_CONTROL, 0x00},
>>>       { CDC_TX_TOP_CSR_TOP_CFG0, 0x00},
>>>       { CDC_TX_TOP_CSR_ANC_CFG, 0x00},
>>> -    { CDC_TX_TOP_CSR_SWR_CTRL, 0x00},
>>> +    { CDC_TX_TOP_CSR_SWR_CTRL, 0x60},
>>
>> This does not make sense as this register only has one bit to control.
>> Why do we even need to change this, can you please explain what 
>> happens if we do not change this?
> 
> This register change is not making any impact. But when verified , reset 
> state of this register is 0x60. so is the reason for change.
> 
> Will revert it and post again.
> 
>>
>>>       { CDC_TX_TOP_CSR_FREQ_MCLK, 0x00},
>>>       { CDC_TX_TOP_CSR_DEBUG_BUS, 0x00},
>>>       { CDC_TX_TOP_CSR_DEBUG_EN, 0x00},
>>> @@ -290,8 +290,8 @@ static const struct reg_default tx_defaults[] = {
>>>       { CDC_TX_TOP_CSR_SWR_DMIC1_CTL, 0x00},
>>>       { CDC_TX_TOP_CSR_SWR_DMIC2_CTL, 0x00},
>>>       { CDC_TX_TOP_CSR_SWR_DMIC3_CTL, 0x00},
>>> -    { CDC_TX_TOP_CSR_SWR_AMIC0_CTL, 0x00},
>>> -    { CDC_TX_TOP_CSR_SWR_AMIC1_CTL, 0x00},
>>> +    { CDC_TX_TOP_CSR_SWR_AMIC0_CTL, 0x0E},
>>> +    { CDC_TX_TOP_CSR_SWR_AMIC1_CTL, 0x0E},
>>
>> These two registers should have default value of 0x06 as this has only 
>> one clk selection field with bits 2:1.
> 
> In Kodiak document reset state 0x0E and clk selection field is with bits 3:1
> 
> *LPASS_TX_TX_TOP_CSR_SWR_MIC1_CTL*|0x32200D4
> Offset: 	0x54 	Reset State: 	0x0000000E 

In that case you should probably consider using regmap_register_patch() 
for corrections to the default registers in sm8250 case.

--srini

> 
>>
>> -srini
>>
>>
>>>       { CDC_TX_INP_MUX_ADC_MUX0_CFG0, 0x00},
>>>       { CDC_TX_INP_MUX_ADC_MUX0_CFG1, 0x00},
>>>       { CDC_TX_INP_MUX_ADC_MUX1_CFG0, 0x00},
>>>
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
