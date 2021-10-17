Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5010B430BE1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbhJQTyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242720AbhJQTyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:54:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A865C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 12:51:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so8322702wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C+4nWeup4/gwCXQu3XhO8jC3A9rFG74OE5AqXe6N5nE=;
        b=X/1kP4zKJH1etPW4lSUQTjGY6eE9Cuh5mzx5wZcf9WX/1QQl0oZAdreBBEDfJVA0Ui
         9xVqu6tNklEwNV5mbBTLnHYBGOkSQ3RVuFgcGlFgd0RjFxU+8oMO4fsuw2e+Yo61Tf1Q
         IykFRd9dFGqlCt6q6Znq38z/OufcdTm9R4KgSZSAUJq/kxROkY3aQyvI10CpGpfXq/Xa
         mJ//aFAqRNDHh3+h6X5svRvqei76KP/ynqzu7pXjUgG/305cUNs/yzsxtgPr8x7eMJOE
         Kk5DfXmN0OdMJ/gHY0L2I8itU6d6nGHRM9F73k61D602WcdN4fVyM87vRdJ0DwMpkc+2
         YqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+4nWeup4/gwCXQu3XhO8jC3A9rFG74OE5AqXe6N5nE=;
        b=KVrexhvSWH+jJQ/+4O+a0qibCSpX6Dqiy4LYiA2BdxfvaE8karW4UoK/MMNY8ULJOv
         Q0rf6ocu28T4XSF6neYstDrNCRIE0hQx4LdIQoXv+UCGeTjS9tZZRFWVaCjWomkHCmul
         LSnDSt7G6/kKpQrlaIzje+B0gFuFl2fQtzF5jr9xaInFlnzShmtB8tkvFjOCsW1FMR4n
         Sc5y+OalgRUI4PLv9J5FqyQDiwUM9i5O5ay/ZtuNAUEeT4sWZBbF1Wq5hO6v0Hdf7sg2
         O8a8EcCf8p9DiaIbef85SXC9xbB5uFxLQYxzxSZ57sTMX/xyY1Sx3H/QCwAQApsaffDM
         5oDQ==
X-Gm-Message-State: AOAM5311ARxLhbQY3jToL8DYdxhzSXZNOfTaw65fTagyc0dYj5CgUTQo
        hY1wsmaKcX7YvQi7Ash+duNTu6YxPIZfS2ML
X-Google-Smtp-Source: ABdhPJzm4jJHZqzptEO4ig0kyyTjsFhOTlsYY4qmJXIj7kj6iHgzWlYjSkLZhJdeYoYlmof/QWKVFQ==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr40809445wma.53.1634500315582;
        Sun, 17 Oct 2021 12:51:55 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b2b3:1133:5bdb:b2f2? ([2a01:e34:ed2f:f020:b2b3:1133:5bdb:b2f2])
        by smtp.googlemail.com with ESMTPSA id l2sm17396892wmi.1.2021.10.17.12.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 12:51:55 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Add idle cooling devices
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211001161728.1729664-1-daniel.lezcano@linaro.org>
 <2808512.kKcWQYovEV@phil>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <30f0cbda-5172-6af1-c06d-2e9c4b96d46b@linaro.org>
Date:   Sun, 17 Oct 2021 21:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2808512.kKcWQYovEV@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Heiko,


On 17/10/2021 12:13, Heiko Stuebner wrote:
> Hi Daniel,
> 
> Am Freitag, 1. Oktober 2021, 18:17:28 CEST schrieb Daniel Lezcano:
>> The thermal framework accepts now the cpu idle cooling device as an
>> alternative when the cpufreq cooling device fails.
>>
>> Add the node in the DT so the cooling devices will be present and the
>> platforms can extend the thermal zone definition to add them.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 3871c7fd83b0..9ac232ffd284 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -124,6 +124,11 @@ cpu_b0: cpu@100 {
>>  			#cooling-cells = <2>; /* min followed by max */
>>  			dynamic-power-coefficient = <436>;
>>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>> +			thermal-idle {
>> +				#cooling-cells = <2>;
>> +				duration-us = <10000>;
>> +				exit-latency-us = <500>;
>> +			};
> 
> I guess the basic question would be where do the duration
> and exit-latency values come from. And also what happened
> to cpu_l0-l3 (aka the little cores)?

The duration is an arbitrary value, I've done some testing [1] to cool
down the CPU.

The exit-latency is a value to ignore idle states with greater exit
latency. In our case, it discards the cluster power down state.

My experiments on this platform showed the little cluster does not
contribute significantly to the heat, so having idle injection is not
really useful.

Just to clarify that idle injection is not better than dvfs, it can be
used in addition or as a backup solution if the dvfs fails. That is the
reason why there is no setup for the thermal zones.

[1] https://www.linaro.org/blog/force-idle-when-a-cpu-is-overheating/

>>  		};
>>  
>>  		cpu_b1: cpu@101 {
>> @@ -136,6 +141,11 @@ cpu_b1: cpu@101 {
>>  			#cooling-cells = <2>; /* min followed by max */
>>  			dynamic-power-coefficient = <436>;
>>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>> +			thermal-idle {
>> +				#cooling-cells = <2>;
>> +				duration-us = <10000>;
>> +				exit-latency-us = <500>;
>> +			};
>>  		};
>>  
>>  		idle-states {
>>
> 
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
