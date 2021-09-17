Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A011440F07A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbhIQDpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:45:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43846 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbhIQDp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:45:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18H3hvv7073907;
        Thu, 16 Sep 2021 22:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631850237;
        bh=QoWt9ODwaJ+EvPiInP1312PqFr3B8vLYtAlZiGqDtm4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UVTRVOPPQ9OMzRmSNX+GYwVtzKjKqlh7NNZyuCtFbPd3HN1LXunH1SwyrfzmDB5yv
         x3n5yXFLJSRH8hp7MWzOIJbLcqoGU11DbIIgPxwPxRlTosyEaw9XhYYqsRcF92Br3P
         yi5ZRYxZVeEmusrQVw7MSciPiK5a+5IfZlaA2tUQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18H3hvJv029583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 22:43:57 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Sep 2021 22:43:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Sep 2021 22:43:57 -0500
Received: from [10.250.233.30] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18H3hr5P093146;
        Thu, 16 Sep 2021 22:43:54 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Relocate thermal-zones to SoC
 specific location
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20210916181801.32588-1-nm@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <2afceb2e-e076-1261-4db4-1afd1f00f78f@ti.com>
Date:   Fri, 17 Sep 2021 09:13:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916181801.32588-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/2021 11:48 PM, Nishanth Menon wrote:
> When commit 64f9147d914d ("arm64: dts: ti: am654: Add thermal
> zones") introduced thermal-zones for am654, it defined as under the
> common am65-wakeup bus segment, when it is am654 specific (other SoC
> spins can have slightly different thermal characteristics). Futher,
> thermal-zones is introduced under simple-bus node, when it has no
> actual register or base address.
> 
> So, move it to it's rightful place under am654 SoC dtsi under the base
> node.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> NOTE:
> 1. This is a cosmetic fixup, so skip the "Fixes" tag.
> 2. This fixes up noisy dtbs_check warning around thermal.
> 
>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 4 ----
>   arch/arm64/boot/dts/ti/k3-am654.dtsi       | 4 ++++
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index 9d21cdf6fce8..9c69d0917f69 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -100,8 +100,4 @@ wkup_vtm0: temperature-sensor@42050000 {
>   		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
>   		#thermal-sensor-cells = <1>;
>   	};
> -
> -	thermal_zones: thermal-zones {
> -		#include "k3-am654-industrial-thermal.dtsi"
> -	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> index f0a6541b8042..a89257900047 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> @@ -112,4 +112,8 @@ msmc_l3: l3-cache0 {
>   		compatible = "cache";
>   		cache-level = <3>;
>   	};
> +
> +	thermal_zones: thermal-zones {
> +		#include "k3-am654-industrial-thermal.dtsi"
> +	};
>   };
> 
