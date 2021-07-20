Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127543CF0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbhGSXir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441828AbhGSWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:13:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE5C061786
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:44:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i4so9220013qvq.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KsSqPnOKXzUDkjkKz916uS2F4jfUfpSikrt0gPU4ujs=;
        b=FnDo6BSq5ek6KNmpUa/nNGm0q1xDQdeYnwwcltGagTCUujdDC4OC/gf2xNNinEgrzw
         4bCtjeq+McwFHwzzbk4VOP8fXyp+rxC1zfo82Rhu7d5UsDr1BrfksI6zId6t1f0X7a1m
         n6jqBW/PeTHX6ukZoJW7usONW3IP4jEGJGD+B36Iby57j3YjdJ4vwoATivQTorSBe/0u
         75pLS62JNWtYD5obEQyxV4dBQQHIQpqPzCaIT0RakyEMn6i1ro1b/k7rQIC/PkGzIl6A
         O+oqFyhFPwCsScGy3HRbPT4Mc1fMFb2OKqtrqxzhGesDFTShHC/25VZX2Vlnptt4JNnO
         j/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KsSqPnOKXzUDkjkKz916uS2F4jfUfpSikrt0gPU4ujs=;
        b=QDP4UUp7L1BICYEe65/SpxVVTTdi+up0NpZx8/yzByTsOWCtbtkc5PD14E3cqiUjZ4
         LV1dirkCwjYueHVKa82cUnDa7wDVpgEoSNvWxzH1uDd/rHo3rMJzKl54d94A71Ou2hoX
         +KGgNbVIs1f9y4PtgEswAsLjqsSx9vClp/ZIKS1hz6INS9RR+oCfwr3qm3seLkNaeA9x
         QqaY3ei4f07akRemLIr4Vl1OovJ5rXoRK3EWRBpHEhkfr/rkHP9K0hosuH/zcDVXQzSC
         8xjnmrlNBm757BjFyRf4Rd3UMmGam6KVkle1M8/j9AqGnzw+HqhI90nENNkziv2JFcpK
         +9cQ==
X-Gm-Message-State: AOAM533uo6b5XWxnKWEHpkt19DxnsBrf5UirUNg4iXEIewEJ3ES4Oi44
        nOiqt3OwLJL1k2Q2+nMnCciIpw==
X-Google-Smtp-Source: ABdhPJxSKGYNHpkUmKywBNW+LP3z28nthNwVLk+4YBXqefO2jufOKFoWN8phbw3HWG8HcfBr6Df64A==
X-Received: by 2002:a0c:fa08:: with SMTP id q8mr21918403qvn.8.1626734670372;
        Mon, 19 Jul 2021 15:44:30 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id o2sm6625742qkm.109.2021.07.19.15.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 15:44:29 -0700 (PDT)
Subject: Re: [Patch v3 4/6] arm64: boot: dts: qcom: sdm45: Add support for LMh
 node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-5-thara.gopinath@linaro.org> <YPWpPt+EfTtAUEOH@yoga>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <4ae91093-625a-f2fa-f0ce-79ec391f6463@linaro.org>
Date:   Mon, 19 Jul 2021 18:44:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPWpPt+EfTtAUEOH@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 12:33 PM, Bjorn Andersson wrote:
> On Thu 08 Jul 07:06 CDT 2021, Thara Gopinath wrote:
> 
>> Add LMh nodes for cpu cluster0 and cpu cluster1. Also add interrupt
>> support in cpufreq node to capture the LMh interrupt and let the scheduler
>> know of the max frequency throttling.
>>
> 
> Just noticed, could you please drop "boot: " from $subject and add the
> missing '8', as you're resubmitting the series.

Sure..

Warm Regards
Thara
> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v2->v3:
>> 	- Changed the LMh low and high trip to 94500 and 95000 mC from
>> 	  74500 and 75000 mC. This was a bug that got introduced in v2.
>> v1->v2:
>> 	- Dropped dt property qcom,support-lmh as per Bjorn's review comments.
>> 	- Changed lmh compatible from generic to platform specific.
>> 	- Introduced properties specifying arm, low and high temp thresholds for LMh
>> 	  as per Daniel's suggestion.
>>
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 0a86fe71a66d..4da6b8f3dd7b 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -3646,6 +3646,30 @@ swm: swm@c85 {
>>   			};
>>   		};
>>   
>> +		lmh_cluster1: lmh@17d70800 {
>> +			compatible = "qcom,sdm845-lmh";
>> +			reg = <0 0x17d70800 0 0x401>;
>> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> +			qcom,lmh-cpu-id = <0x4>;
>> +			qcom,lmh-temperature-arm = <65000>;
>> +			qcom,lmh-temperature-low = <94500>;
>> +			qcom,lmh-temperature-high = <95000>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +		};
>> +
>> +		lmh_cluster0: lmh@17d78800 {
>> +			compatible = "qcom,sdm845-lmh";
>> +			reg = <0 0x17d78800 0 0x401>;
>> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +			qcom,lmh-cpu-id = <0x0>;
>> +			qcom,lmh-temperature-arm = <65000>;
>> +			qcom,lmh-temperature-low = <94500>;
>> +			qcom,lmh-temperature-high = <95000>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +		};
>> +
>>   		sound: sound {
>>   		};
>>   
>> @@ -4911,6 +4935,8 @@ cpufreq_hw: cpufreq@17d43000 {
>>   			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
>>   			reg-names = "freq-domain0", "freq-domain1";
>>   
>> +			interrupts-extended = <&lmh_cluster0 0>, <&lmh_cluster1 0>;
>> +
>>   			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>>   			clock-names = "xo", "alternate";
>>   
>> -- 
>> 2.25.1
>>


