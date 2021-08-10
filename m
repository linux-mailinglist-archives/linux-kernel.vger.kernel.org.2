Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA123DA1DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhG2LOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbhG2LOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:14:45 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB66C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:14:42 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d2so3634732qto.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2K9Otu8LW9SDTcXYYe2i+NmHsFiLd0L5gZwCfWSKEmo=;
        b=ph0P5vCb0OFIqgeqV14YecFS4sAcx7v1LDkjpxvpx7VtzA6H2FeZks2PCB2rjJKhRX
         kLhKCbXdc5goS+AdVlhEsnetACl2h0f5owIWTAEgmg3qAoX1BPI5qKBCgRzjYY3TWEE8
         ap3iJH2pOO1jZIL5BP9xn84HJ5I+j1ydD2+a6LXoDIBVhZXOQcz3MEjsEvct+h/bm6xM
         gnplsF4FOoT8dTcNlnMELEExf92mE7CBje0LlNJKpk7+qZ+E6tNgyvh8V8ONZmyEUTpg
         se0Bpo7uSiruq79wFoz3MGg70+MQQOeWPjGdYhZi9vMdfMxab/ZcGI6L01PEAkZcQUwZ
         /9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2K9Otu8LW9SDTcXYYe2i+NmHsFiLd0L5gZwCfWSKEmo=;
        b=ky/zNGQWPgg4FR4w12rNLIgCf6jZx8njwfJOOWQIzpwPzOlopsyHCaCApQoEV79oeL
         rqF2FgP8I7Jz9Nw2dJtSwFX3JrFvTMPmL/GMfUE67kqdyGK4cyRi796I8KopYJD1JCxK
         VaYf0COGlCXixL67MhsEfUspkonvTBz0MbfVOBu2v6ybig9XzEHSYEHc82sQKCEfFqLg
         lA+XP6jbck0/xE87lQictpopOhKS8cJFGnULkeknQx2LcwhEYejRtn2kCOziBn2b+rTh
         yYF2wOjG/RCcA+RUSPZVI+imgwXMTMRMGKd6Hh7kKJh8+QyYBCNL+hcFlbGl4NeM+ebP
         dl8g==
X-Gm-Message-State: AOAM531YGtQwHHtWeSm4BI5pipDZLo4gOFbXXNM4JoawySk2MTApzcJ8
        uPTeuxjt0llZ1pF+FGPv351rvP5WjtQsaebV
X-Google-Smtp-Source: ABdhPJwAn3IRMTD72AerbI9G7j4vBNcMivwHurVclQz1qrLLqObsXzzh3n/4sqCOpuRq/b1tT4J2LA==
X-Received: by 2002:ac8:41c2:: with SMTP id o2mr3599898qtm.237.1627557281670;
        Thu, 29 Jul 2021 04:14:41 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id j127sm1596873qkf.20.2021.07.29.04.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 04:14:41 -0700 (PDT)
Subject: Re: [PATCH 14/39] arm64: dts: qcom: sdm630: Add TSENS node
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210728222542.54269-1-konrad.dybcio@somainline.org>
 <20210728222542.54269-15-konrad.dybcio@somainline.org>
 <860f1120-c5a4-f531-3ea9-aa90c6b063dc@linaro.org>
 <2318377c-959a-a42b-81b5-44e2629570d5@somainline.org>
 <afee55a8-d7d3-709a-ea4f-0306698c9976@linaro.org>
 <b16d8000-85a7-d957-77d2-d921e5b09829@somainline.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <a7f90fe0-ee24-a47d-089d-e716a5766fcd@linaro.org>
Date:   Thu, 29 Jul 2021 07:14:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b16d8000-85a7-d957-77d2-d921e5b09829@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/21 6:55 AM, Konrad Dybcio wrote:
> 
> On 29.07.2021 12:54, Thara Gopinath wrote:
>>
>>
>> On 7/29/21 6:52 AM, Konrad Dybcio wrote:
>>>
>>> On 29.07.2021 12:50, Thara Gopinath wrote:
>>>> Hi Konrad,
>>>>
>>>> On 7/28/21 6:25 PM, Konrad Dybcio wrote:
>>>>> This will enable temperature reporting for various SoC
>>>>> components.
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>> ---
>>>>>     .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
>>>>>     arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
>>>>>     2 files changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>> index 4a2eaf28e3fd..d3b9e9b600a2 100644
>>>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>>> @@ -48,6 +48,7 @@ properties:
>>>>>                   - qcom,sc7180-tsens
>>>>>                   - qcom,sc7280-tsens
>>>>>                   - qcom,sc8180x-tsens
>>>>> +              - qcom,sdm630-tsens
>>>>>                   - qcom,sdm845-tsens
>>>>>                   - qcom,sm8150-tsens
>>>>>                   - qcom,sm8250-tsens
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>>>> index 1e54828817d5..7e9c80e35fba 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>>>> @@ -627,6 +627,17 @@ mnoc: interconnect@1745000 {
>>>>>                      <&mmcc AHB_CLK_SRC>;
>>>>>             };
>>>>>     +        tsens: thermal-sensor@10ae000 {
>>>>> +            compatible = "qcom,sdm630-tsens", "qcom,tsens-v2";
>>>>> +            reg = <0x010ae000 0x1000>, /* TM */
>>>>> +                  <0x010ad000 0x1000>; /* SROT */
>>>>> +            #qcom,sensors = <12>;
>>>>
>>>> Are all 12 sensors used ? I see that in a later patch "arm64: dts: qcom: sdm630: Add thermal-zones configuration" only 9 are used.
>>>
>>> Hi,
>>>
>>> if I recall correctly, they all give output but not all of the mappings were documented in the downstream sources and we have no documentation whatsoever :(
>>
>> Right. In that case, why not change #qcom,sensors to 9 and add rest of the sensors if and when needed ?
>>
> I don't think it makes sense to describe the hardware incorrectly, even if some of it is unused.

My thinking was more along the lines of don't expose unused h/w bits.

> 
> 
> 

-- 
Warm Regards
Thara (She/Her/Hers)
