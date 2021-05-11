Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB037A2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEKJDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhEKJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:03:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98D6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:02:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso816166wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CEqjQE0LJp86UhhhWQsigU5SfvAnHBasJfR3WeTYln8=;
        b=N9gEJwltPLthv2q1yoI/pqI+yrjTFO+T2OyYXoZKmuY7q/ZXPgcWi4EVmtbR3j3dg4
         t5TlqdijCc0Mdbn6CSXDKLHEcyRnjA61a2vsxTC4i6UVYj2PiAtxmiUt39TU6K06GAVF
         SoenjZNnAgtFvrkNHpnGWb5/9sdWdydVKWEwwDSZCbQ/7GcSAE7znMwFmxlHbdfS2jM+
         zcSpiPyEdmlGhXVliIfit8yK+4CT6As0ZrekUC/XNOvMcfbhknjrmH4muLs1fcFfsbmu
         IEV31oX2VxJ+Fps8p/CXBPwEDT+np2wG/cu0IIncQAK2D98BtJZBhDCFxLLNwL6/j26y
         c8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CEqjQE0LJp86UhhhWQsigU5SfvAnHBasJfR3WeTYln8=;
        b=hbokpdUQJ4LASUfpzSSAfO4NEtLspNv4knpLUJApdB6Zqftoh+rnZhEkqQnQJY50Uw
         YftRGoEqfuOfv/MCtMtZF1BHxCkqGp/6SbsA5nyvDDedQnMtLS4Ijcz9HVDs7PfZcfAs
         pxZkhN+lBGyt+TuoKp/Oe+L3Yh051jdWfvZT6+ml0h/MrEhIegk9SynN5NoTSGkZ33d0
         t1wTmC7CCMy2N2oZTOoD8ZSHFHcCtVg4FpVjePW9yFTBX/z0o19+d/kjvBh+hMLw/sEi
         yBvs5Ag64u+M19iEpJhYPtjozrtg1hZTb5jq27XX6J2ngSkFbw040GOhSy99hvanZGFM
         hGDg==
X-Gm-Message-State: AOAM53266odz6RB6rpKpkfusWgY5yMLyKzBOa8RiVQ6gyEISuRD7jTOA
        kcQKMY3LYtM1jdN1u35l6T3B0Q==
X-Google-Smtp-Source: ABdhPJzuaZ+c7GRyJ53sAuqLrcIj4BIYh6qkySDh3UN7HQ1xOcnIEghI+AOcFVJnBXhYn3HBUGGPwA==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr3998488wml.13.1620723730553;
        Tue, 11 May 2021 02:02:10 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id z6sm22732422wmf.9.2021.05.11.02.02.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 02:02:09 -0700 (PDT)
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: wcd934x: add bindings for Headset
 Button detection
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, lee.jones@linaro.org
References: <20210510101201.7281-1-srinivas.kandagatla@linaro.org>
 <20210510101201.7281-2-srinivas.kandagatla@linaro.org>
 <20210510164532.GA241925@robh.at.kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <26d6ce69-20ad-3195-e9b5-e95998babdef@linaro.org>
Date:   Tue, 11 May 2021 10:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210510164532.GA241925@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2021 17:45, Rob Herring wrote:
> On Mon, May 10, 2021 at 11:11:58AM +0100, Srinivas Kandagatla wrote:
>> Add bindings required for Multi Button Headset detection.
>> WCD934x support Headsets with upto 8 buttons including, impedance measurement
>> on both L/R Headset speakers and cross connection detection.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,wcd934x.yaml          | 65 +++++++++++++++++++
>>   1 file changed, 65 insertions(+)
> 
> A search tells me this is not v1...
> 

I did submit something for wcd9335 in the past but not for wcd934x which 
is still v1.

Most of these codecs have same MBHC block so the mbhc bindings look same 
across them.


>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
>> index e8f716b5f875..b25c6ca4e97c 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
>> @@ -77,6 +77,64 @@ properties:
>>       minimum: 1800000
>>       maximum: 2850000
>>   
>> +  qcom,hphl-jack-type-normally-closed:
>> +    description: Indicates that HPHL jack switch type is normally closed
>> +    type: boolean
>> +
>> +  qcom,ground-jack-type-normally-closed:
>> +    description: Indicates that Headset Ground switch type is normally closed
>> +    type: boolean
> 
> I asked before if 'normally closed' was the more common case and you
> said yes. So I'd expect 'open' here, but now you've changed the
> polarity of the property. And now not present is not described at all.

Yes "normally closed" is the normal use case however Banajit commented 
on these binding with normally-open at https://lkml.org/lkml/2018/9/26/410

Ground pin may not be present on most of the headset jacks.
So we can not consider the headset jacks as Normally closed when this 
property is not specified in the device tree.

So having binding with normally-closed makes it much safer to use.

> 
>> +
>> +  qcom,mbhc-headset-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset detection
>> +    minimum: 0
>> +    maximum: 2850000
>> +
>> +  qcom,mbhc-headphone-vthreshold-microvolt:
>> +    description: Voltage threshold value for headphone detection
>> +    minimum: 0
>> +    maximum: 2850000
>> +
>> +  qcom,mbhc-button0-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button0
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button1-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button1
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button2-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button2
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button3-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button3
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button4-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button4
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button5-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button5
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button6-vthreshold-microvolt:
>> +    description: Voltage threshold value for headset button6
>> +    minimum: 0
>> +    maximum: 500000
>> +
>> +  qcom,mbhc-button7-vthreshold-microvolt:
>> +    description: Voltage threshold value headset button7
>> +    minimum: 0
>> +    maximum: 500000
> 
> These can all be a single pattern property:
> '^qcom,mbhc-button[0-7]-vthreshold-microvolt$'

Thanks for the hint, this works, will change it in next version.

--srini
