Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8549D362480
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhDPPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:53:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24842 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235676AbhDPPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:53:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GFatue019016;
        Fri, 16 Apr 2021 17:52:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Bw/LpDxwLjnc9O3u0xRK0A8jPAhQBjd5ZdY8L9kkF84=;
 b=uqm2U4FehdigsCmM3+wpsxjknXqR6NPeGCmC9dN8J+VdCulrsYFNlqGjdA+h+3Utwx+7
 pNbrBOYaYhv7TUByNtLDLkCAZCxReTtanwjbwX5AP9qD1Vh4Vjk1GRVKCL1mCR9K9BSO
 OnlYC6Kao61roNJFNJ4M7MaNKE25Lu2Q2+A5n5UUP1V6dN15WANSJzUnw/0zoT5ni1Ub
 bBDOTGKZM1pwdo0ebFAmgO8OaAUR10E19nVo8KaJJ+SYoqGSJAT9COOaMN6P//sC+VNR
 mHvFqV4oVNt9muK5JU4OAjt8fNJhg/TORyC8kZROgcUDkK9chXpWSFyhjhONZ7xAb8ZR lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37y0g84ehy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 17:52:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8064100034;
        Fri, 16 Apr 2021 17:52:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92F7225D00B;
        Fri, 16 Apr 2021 17:52:52 +0200 (CEST)
Received: from [10.211.14.227] (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Apr
 2021 17:52:18 +0200
Subject: Re: [Linux-stm32] [PATCH 03/13] ARM: dts: stm32: fix timer nodes on
 STM32 MCU to prevent warnings
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <arnd@arndb.de>, <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuba@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-4-alexandre.torgue@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <c329f116-458c-0d33-3c8f-ee5d22189ca4@foss.st.com>
Date:   Fri, 16 Apr 2021 17:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415101037.1465-4-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 12:10 PM, Alexandre Torgue wrote:
> Prevent warning seen with "make dtbs_check W=1" command:
> 
> Warning (avoid_unnecessary_addr_size): /soc/timers@40001c00: unnecessary
> address-cells/size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

Hi Alexandre,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index 41e0087bdbf9..8748d5850298 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -283,8 +283,6 @@
>  		};
>  
>  		timers13: timers@40001c00 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-timers";
>  			reg = <0x40001C00 0x400>;
>  			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM13)>;
> @@ -299,8 +297,6 @@
>  		};
>  
>  		timers14: timers@40002000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-timers";
>  			reg = <0x40002000 0x400>;
>  			clocks = <&rcc 0 STM32F4_APB1_CLOCK(TIM14)>;
> @@ -633,8 +629,6 @@
>  		};
>  
>  		timers10: timers@40014400 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-timers";
>  			reg = <0x40014400 0x400>;
>  			clocks = <&rcc 0 STM32F4_APB2_CLOCK(TIM10)>;
> @@ -649,8 +643,6 @@
>  		};
>  
>  		timers11: timers@40014800 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-timers";
>  			reg = <0x40014800 0x400>;
>  			clocks = <&rcc 0 STM32F4_APB2_CLOCK(TIM11)>;
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index e1df603fc981..72c1b76684b6 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -265,8 +265,6 @@
>  		};
>  
>  		timers13: timers@40001c00 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-timers";
>  			reg = <0x40001C00 0x400>;
>  			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM13)>;
> @@ -281,8 +279,6 @@
>  		};
>  
>  		timers14: timers@40002000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-timers";
>  			reg = <0x40002000 0x400>;
>  			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM14)>;
> @@ -531,8 +527,6 @@
>  		};
>  
>  		timers10: timers@40014400 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-timers";
>  			reg = <0x40014400 0x400>;
>  			clocks = <&rcc 0 STM32F7_APB2_CLOCK(TIM10)>;
> @@ -547,8 +541,6 @@
>  		};
>  
>  		timers11: timers@40014800 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-timers";
>  			reg = <0x40014800 0x400>;
>  			clocks = <&rcc 0 STM32F7_APB2_CLOCK(TIM11)>;
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 05ecdf9ff03a..6e42ca2dada2 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -485,8 +485,6 @@
>  		};
>  
>  		lptimer4: timer@58002c00 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-lptimer";
>  			reg = <0x58002c00 0x400>;
>  			clocks = <&rcc LPTIM4_CK>;
> @@ -501,8 +499,6 @@
>  		};
>  
>  		lptimer5: timer@58003000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  			compatible = "st,stm32-lptimer";
>  			reg = <0x58003000 0x400>;
>  			clocks = <&rcc LPTIM5_CK>;
> 
