Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D03AE54B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhFUIyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:54:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39667 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFUIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:54:10 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvFet-0005rk-CN
        for linux-kernel@vger.kernel.org; Mon, 21 Jun 2021 08:51:55 +0000
Received: by mail-ed1-f71.google.com with SMTP id f12-20020a056402150cb029038fdcfb6ea2so5575872edw.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ggXee6A796CsVt4xk+5DiytAJr6HRec0kihk7+kdguU=;
        b=I5zBZrJH37VJgffT5/loSPfdaoFDsAaXu31aHcvdSy4H6r5BsJf11Q7DDsYdogZZF5
         3x6Dut1Ovoh97b8Q0LPEVw8RnNua32tmsdBhPSoyIryLBN2oN2U7gKMNyKN3h5WOuOaT
         pv6VhLRkP+uqeV53ED1xQFNmjKNRXEtKC+bAK7jr7RqM3uXMBx/2o/NIdb9GRwcbFy+7
         YtpVlgjhct0+Mgw3SFfVimbf3Vv1G0A0L+XRV/nGbWTxqgN3oU28xl0tCKWL8SmJj5GO
         ngiX6OjaK27SGvBDmvc+s/yIlj9jon5s7tzWHjBlHAN00OVaUmgEDxn1IkA68oFy9IYs
         DCSQ==
X-Gm-Message-State: AOAM531MQC9fLZCxy/Of5sDImQKWWKZX6vfnqX6IoHZ7w97p4DiqjSVT
        DgPcOYsgYX9Pt0XiQsJwCQktgJQhsV54xnDArokLODjEwcUPn+FlqdJIHCZH9LX7TwsZXPp7oyW
        ITkQcH7n/Dble+uZaSqk2gZ8nuAI166w3mWBH91Ws7w==
X-Received: by 2002:a17:906:b190:: with SMTP id w16mr23951028ejy.332.1624265514881;
        Mon, 21 Jun 2021 01:51:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw/9DH/lZzejm4BaxNnmKxMr/3WyMC6hKB5u1jhTfs5PGPy2HClTCywxxBQkefzrdj/XXQDw==
X-Received: by 2002:a17:906:b190:: with SMTP id w16mr23951016ejy.332.1624265514735;
        Mon, 21 Jun 2021 01:51:54 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id og37sm2584474ejc.100.2021.06.21.01.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 01:51:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: exynos5433: Add cpu cache information
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     linux-samsung-soc@vger.kernel.org
References: <20210617113739.66911-1-alim.akhtar@samsung.com>
 <CGME20210617113314epcas5p4652e98d24d7f56a7c8461175bbb25456@epcas5p4.samsung.com>
 <20210617113739.66911-2-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0120db2f-e25e-a4ae-669b-a404dbfae05b@canonical.com>
Date:   Mon, 21 Jun 2021 10:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617113739.66911-2-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 13:37, Alim Akhtar wrote:
> This patch adds cpu caches information to its dt
> nodes so that the same is available to userspace
> via sysfs.
> This SoC has 48/32 KB I/D cache for each A57 cores
> with 2MB L2 cache.
> And 32/32 KB I/D cache for each A53 cores with
> 256KB L2 cache.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 18a912eee360..8183a59e9046 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -62,6 +62,13 @@
>  			clock-names = "apolloclk";
>  			operating-points-v2 = <&cluster_a53_opp_table>;
>  			#cooling-cells = <2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&apollo_l2>;
>  		};
>  
>  		cpu1: cpu@101 {
> @@ -72,6 +79,13 @@
>  			clock-frequency = <1300000000>;
>  			operating-points-v2 = <&cluster_a53_opp_table>;
>  			#cooling-cells = <2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&apollo_l2>;
>  		};
>  
>  		cpu2: cpu@102 {
> @@ -82,6 +96,13 @@
>  			clock-frequency = <1300000000>;
>  			operating-points-v2 = <&cluster_a53_opp_table>;
>  			#cooling-cells = <2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&apollo_l2>;
>  		};
>  
>  		cpu3: cpu@103 {
> @@ -92,6 +113,13 @@
>  			clock-frequency = <1300000000>;
>  			operating-points-v2 = <&cluster_a53_opp_table>;
>  			#cooling-cells = <2>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&apollo_l2>;
>  		};
>  
>  		cpu4: cpu@0 {
> @@ -104,6 +132,13 @@
>  			clock-names = "atlasclk";
>  			operating-points-v2 = <&cluster_a57_opp_table>;
>  			#cooling-cells = <2>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&atlas_l2>;
>  		};
>  
>  		cpu5: cpu@1 {
> @@ -114,6 +149,13 @@
>  			clock-frequency = <1900000000>;
>  			operating-points-v2 = <&cluster_a57_opp_table>;
>  			#cooling-cells = <2>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&atlas_l2>;
>  		};
>  
>  		cpu6: cpu@2 {
> @@ -124,6 +166,13 @@
>  			clock-frequency = <1900000000>;
>  			operating-points-v2 = <&cluster_a57_opp_table>;
>  			#cooling-cells = <2>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&atlas_l2>;
>  		};
>  
>  		cpu7: cpu@3 {
> @@ -134,6 +183,27 @@
>  			clock-frequency = <1900000000>;
>  			operating-points-v2 = <&cluster_a57_opp_table>;
>  			#cooling-cells = <2>;
> +			i-cache-size = <0xc000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&atlas_l2>;
> +		};
> +
> +		atlas_l2: l2-cache0 {

Few other nodes (PMU, OPP tables) use a57/a53 names instead of
codenames, so I would prefer to stay with them (so cluster_a57_l2).

For Exynos7 it's fine as it uses Atlas already in labels.

> +			compatible = "cache";
> +			cache-size = <0x200000>;
> +			cache-line-size = <64>;
> +			cache-sets = <2048>;
> +		};
> +
> +		apollo_l2: l2-cache1 {
> +			compatible = "cache";
> +			cache-size = <0x40000>;
> +			cache-line-size = <64>;
> +			cache-sets = <256>;
>  		};
>  	};
>  
> 


Best regards,
Krzysztof
