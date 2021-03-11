Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780903370DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhCKLIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:08:52 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:2972 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhCKLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:08:41 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BB71vr007933;
        Thu, 11 Mar 2021 12:08:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OkqMTQRlY95MowGjpWpOMwJs3OwDCODKW0EREFO2LDk=;
 b=PlSp072KAq0ETEh1TFvqP2wtL9xTdVJdnTtJXhyNum/M6GAoI7C7FaBx3I5LoqDR5smm
 IdT1nwOO8beOSN1d/WNSZx5RmL5eBjwh8i3UtYgBNC/rV+CihAgYIO77l4cqoBD9Zdr0
 2Sc+2tgp6IKLNmbFMD0o6oGwUtWmOdrckR2PFRa4ajB5+e690VP8loPrmRSMgezl5iEH
 pKcE9S5nOa+5FBooh2XYK285ojD6hbSOMqJFE/dVO+6ZYpNkULvX7KIPdTKtX9b6DuQv
 I+rTYduy6IM3CZmQsyo23rLMSLl1TdBzSJv1xyjxLDE/6e13gCUxUuQzZoj4an52rIUB sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3740376aw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 12:08:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 114C810002A;
        Thu, 11 Mar 2021 12:08:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3CEA231DEA;
        Thu, 11 Mar 2021 12:08:32 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Mar
 2021 12:08:32 +0100
Subject: Re: [PATCH] ARM: dts: stm32: fix usart 2 & 3 pinconf to wake up with
 flow control
To:     Valentin CARON - foss <valentin.caron@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210211110620.31594-1-valentin.caron@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <6dffddbe-235b-a607-a82c-5f3c3756e3a7@foss.st.com>
Date:   Thu, 11 Mar 2021 12:08:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211110620.31594-1-valentin.caron@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_04:2021-03-10,2021-03-11 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin

On 2/11/21 12:07 PM, Valentin CARON - foss wrote:
> Modify usart 2 & 3 pins to allow wake up from low power mode while the
> hardware flow control is activated. UART RTS pin need to stay configure
> in idle mode to receive characters in order to wake up.
> 
> Fixes: 842ed898a757 ("ARM: dts: stm32: add usart2, usart3 and uart7 pins in stm32mp15-pinctrl")
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---

Applied on stm32-fixes.

Thanks
Alex

>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index 7b4249ed1983..060baa8b7e9d 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1891,10 +1891,15 @@
>   	usart2_idle_pins_c: usart2-idle-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('D', 5, ANALOG)>, /* USART2_TX */
> -				 <STM32_PINMUX('D', 4, ANALOG)>, /* USART2_RTS */
>   				 <STM32_PINMUX('D', 3, ANALOG)>; /* USART2_CTS_NSS */
>   		};
>   		pins2 {
> +			pinmux = <STM32_PINMUX('D', 4, AF7)>; /* USART2_RTS */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <3>;
> +		};
> +		pins3 {
>   			pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
>   			bias-disable;
>   		};
> @@ -1940,10 +1945,15 @@
>   	usart3_idle_pins_b: usart3-idle-1 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> -				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
>   				 <STM32_PINMUX('I', 10, ANALOG)>; /* USART3_CTS_NSS */
>   		};
>   		pins2 {
> +			pinmux = <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins3 {
>   			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
>   			bias-disable;
>   		};
> @@ -1976,10 +1986,15 @@
>   	usart3_idle_pins_c: usart3-idle-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> -				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
>   				 <STM32_PINMUX('B', 13, ANALOG)>; /* USART3_CTS_NSS */
>   		};
>   		pins2 {
> +			pinmux = <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins3 {
>   			pinmux = <STM32_PINMUX('B', 12, AF8)>; /* USART3_RX */
>   			bias-disable;
>   		};
> 
