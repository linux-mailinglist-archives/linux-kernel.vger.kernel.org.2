Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95B37AA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhEKPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:10:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58638 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhEKPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:10:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14BF9c8l100508;
        Tue, 11 May 2021 10:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620745778;
        bh=Dd3BAY4LHeMGt4I7Gn+peV7+TPMSkkQjBljubv2gyC0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R5VmpG5HumEEfO1DV0oTYVmhrwgz4rCL95Ft5hs4nW3yJU4Vbap9aWo0RjgQVxUD4
         dk6qsCTYTFRAVqiTc2goyV6KjtZKQmuWXQiir7TCdOBYH2dEo2G/9glZQrgMcUVgfv
         b3oJdqQuuOFAm3rmRsCS8z2uRrwzstxkbJwQmu7g=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14BF9cJk033955
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 10:09:38 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 10:09:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 10:09:37 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14BF9WRc090534;
        Tue, 11 May 2021 10:09:35 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am65|j721e|am64: Map the dma /
 navigator subsystem via explicit ranges
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <grygorii.strashko@ti.com>
CC:     <lokeshvutla@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210510145429.8752-1-nm@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <67cc87c4-2ad8-04ab-e583-0b544bcadbce@ti.com>
Date:   Tue, 11 May 2021 20:39:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510145429.8752-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/21 8:24 PM, Nishanth Menon wrote:
> Instead of using empty ranges property, lets map explicitly the address
> range that is mapped onto the dma / navigator subsystems (navss/dmss).
> 
> This is also exposed via the dtbs_check with dt-schema newer than
> 2021.03 version by throwing out following:
> arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: bus@100000: main-navss:
> {'type': 'object'} is not allowed for
> {'compatible': ['simple-mfd'], '#address-cells': [[2]], .....
> 
> This has already been correctly done for J7200, however was missed for
> other k3 SoCs. Fix that oversight.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

> if possible, I'd like to pick this fixup for 5.13 window..
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 4 ++--
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         | 4 ++--
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 4 ++--
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index a49e41021573..bb19db04a746 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -42,12 +42,12 @@ gic_its: msi-controller@1820000 {
>  		};
>  	};
>  
> -	dmss: dmss {
> +	dmss: bus@48000000 {
>  		compatible = "simple-mfd";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		dma-ranges;
> -		ranges;
> +		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>;
>  
>  		ti,sci-dev-id = <25>;
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 037f9776c4c8..fea8260d33a8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -445,11 +445,11 @@ intr_main_gpio: interrupt-controller@a00000 {
>  		ti,interrupt-ranges = <0 392 32>;
>  	};
>  
> -	main-navss {
> +	main_navss: bus@30800000 {
>  		compatible = "simple-mfd";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x0 0x30800000 0x0 0x30800000 0x0 0xbc00000>;
>  		dma-coherent;
>  		dma-ranges;
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 0388c02c2203..f5b8ef2f5f77 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -116,11 +116,11 @@ adc {
>  		};
>  	};
>  
> -	mcu-navss {
> +	mcu_navss: bus@28380000 {
>  		compatible = "simple-mfd";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
>  		dma-coherent;
>  		dma-ranges;
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 512371e36a30..b2d25af872e2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -88,11 +88,11 @@ main_gpio_intr: interrupt-controller@a00000 {
>  		ti,interrupt-ranges = <8 392 56>;
>  	};
>  
> -	main-navss {
> +	main_navss: bus@30000000 {
>  		compatible = "simple-mfd";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
>  		dma-coherent;
>  		dma-ranges;
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index ad12a5c9f209..172629fa3c7c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -250,11 +250,11 @@ adc {
>  		};
>  	};
>  
> -	mcu-navss {
> +	mcu_navss: bus@28380000 {
>  		compatible = "simple-mfd";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
>  		dma-coherent;
>  		dma-ranges;
>  
> 
