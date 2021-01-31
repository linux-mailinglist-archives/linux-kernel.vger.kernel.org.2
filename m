Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCD309CB7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhAaOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhAaN3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:29:08 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB94BC061786;
        Sun, 31 Jan 2021 05:23:35 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c127so10866244wmf.5;
        Sun, 31 Jan 2021 05:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5E3Apls6csqets4H7DMOXx41lFaOtmaam4e5XL6M4iw=;
        b=hKM5x/yzzHesMc2ZpkKhTKSmDwsFbaDW8pXz3naNKGR7dtpBt7kB6KqE1u9C2awrce
         E2mJt7sayawkHsBlBqnZR0sZ98qHFlge6DlwXFBY10lWYoYsxg2SEV9rpQl2avlPySYG
         /+Xe75o0nfa2ORqJyGplwR9nVJi35CQnx62GFAQ/zTGA6CtDIOZKqOY3RtsEpbrr3+/S
         vkoNMDDwShhXaBiI27aXHZEhRwyD9wULZfxAmffWqh97FDbjjRfUZ2Ln+b3BH+zTtHQ2
         fjoTRb2o5IC4lnLDG+4tjFLpE0cj4Pu/b5OOU+jcq/g7hnNqrjUWFc6TG16DNTFkp+2t
         +otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5E3Apls6csqets4H7DMOXx41lFaOtmaam4e5XL6M4iw=;
        b=Srruj55V9lLozkbOo0w0o8Qym6UW+xGCokcp//lqeju+2hr98HqBwSixXU1rOYOOwj
         IrRkNKZl11QqYTamVJAOD0wvqcZwhoCNFdYQidrkZ9rYJnJ2MzOOVJ/avfQnGpZXbul1
         aIwcGn70bthcg+T+QRi+q1X+PNS8nJH1cG4kV1mdws6PiFjIIlVHnTPgJ6CWu8Np4OHf
         t65CkHdijbKfL5LcMDb6QxYLlFE1bZgsFae0AGCJBxGu7iE4aD9SGoIrLtVdmlznk1kG
         mR0FuNlt30sqhMpgPgSvwtBdYPYP+0VkB4rEL0s7BeJPZu1nKn/um7mbrggTBum0+Ej6
         TxQw==
X-Gm-Message-State: AOAM531DnNX7+eL0a7nHrHDgB2nuuuuCw2IID0mIJ50xgUWwWfpImBrS
        KSIQIXTFOnW/W97+LF8Hf5Y=
X-Google-Smtp-Source: ABdhPJzHqd0I71FRkOquB11nCB3oZaqjsEewergd0ffPGMIBxyOJhBoy0IcAW6hOaIBgt9VG0/TodQ==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr11020512wmr.179.1612099414528;
        Sun, 31 Jan 2021 05:23:34 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id d17sm13518011wma.2.2021.01.31.05.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 05:23:33 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: mt8192: Add cpu-idle-states
To:     James Liao <jamesjj.liao@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20201222045820.26355-1-jamesjj.liao@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4b702785-9c30-fa24-e5bc-ad3aa9457a5c@gmail.com>
Date:   Sun, 31 Jan 2021 14:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201222045820.26355-1-jamesjj.liao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/2020 05:58, James Liao wrote:
> Add idle states for cpu-off and cluster-off.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Applied to v5.11-next/dts64

Thanks!

>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 44 ++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> This patch bases on v5.10 and [1], adds idle-states for MT8192 CPUs.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20201030092207.26488-2-seiya.wang@mediatek.com/
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index e12e024de122..c7f2ec9ea4f1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -39,6 +39,7 @@
>  			reg = <0x000>;
>  			enable-method = "psci";
>  			clock-frequency = <1701000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>  			next-level-cache = <&l2_0>;
>  			capacity-dmips-mhz = <530>;
>  		};
> @@ -49,6 +50,7 @@
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			clock-frequency = <1701000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>  			next-level-cache = <&l2_0>;
>  			capacity-dmips-mhz = <530>;
>  		};
> @@ -59,6 +61,7 @@
>  			reg = <0x200>;
>  			enable-method = "psci";
>  			clock-frequency = <1701000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>  			next-level-cache = <&l2_0>;
>  			capacity-dmips-mhz = <530>;
>  		};
> @@ -69,6 +72,7 @@
>  			reg = <0x300>;
>  			enable-method = "psci";
>  			clock-frequency = <1701000000>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
>  			next-level-cache = <&l2_0>;
>  			capacity-dmips-mhz = <530>;
>  		};
> @@ -79,6 +83,7 @@
>  			reg = <0x400>;
>  			enable-method = "psci";
>  			clock-frequency = <2171000000>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
>  			next-level-cache = <&l2_1>;
>  			capacity-dmips-mhz = <1024>;
>  		};
> @@ -89,6 +94,7 @@
>  			reg = <0x500>;
>  			enable-method = "psci";
>  			clock-frequency = <2171000000>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
>  			next-level-cache = <&l2_1>;
>  			capacity-dmips-mhz = <1024>;
>  		};
> @@ -99,6 +105,7 @@
>  			reg = <0x600>;
>  			enable-method = "psci";
>  			clock-frequency = <2171000000>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
>  			next-level-cache = <&l2_1>;
>  			capacity-dmips-mhz = <1024>;
>  		};
> @@ -109,6 +116,7 @@
>  			reg = <0x700>;
>  			enable-method = "psci";
>  			clock-frequency = <2171000000>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
>  			next-level-cache = <&l2_1>;
>  			capacity-dmips-mhz = <1024>;
>  		};
> @@ -158,6 +166,42 @@
>  		l3_0: l3-cache {
>  			compatible = "cache";
>  		};
> +
> +		idle-states {
> +			entry-method = "arm,psci";
> +			cpuoff_l: cpuoff_l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <55>;
> +				exit-latency-us = <140>;
> +				min-residency-us = <780>;
> +			};
> +			cpuoff_b: cpuoff_b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <35>;
> +				exit-latency-us = <145>;
> +				min-residency-us = <720>;
> +			};
> +			clusteroff_l: clusteroff_l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010002>;
> +				local-timer-stop;
> +				entry-latency-us = <60>;
> +				exit-latency-us = <155>;
> +				min-residency-us = <860>;
> +			};
> +			clusteroff_b: clusteroff_b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010002>;
> +				local-timer-stop;
> +				entry-latency-us = <40>;
> +				exit-latency-us = <155>;
> +				min-residency-us = <780>;
> +			};
> +		};
>  	};
>  
>  	pmu-a55 {
> 
