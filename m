Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C1D42F1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhJONHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:07:00 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:52574 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235659AbhJONG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:06:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FAbXld027694;
        Fri, 15 Oct 2021 15:04:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=aEZaGrrmg2Zt0uaWNQWpGKoc5PGCSBKRzFbdK81ndw4=;
 b=XJQZbyU06bU80GmeDLNEzaNWWEaw/jV7LFiDiasBNwye7RS/RS3IEjk17UBedUoeaJ8X
 gHOv7CVvZZriDpPq5/Hypw2NiSiLSPlNVn5nIXSMr5bVzZnwnBMqOYZhCVqDVmn9KOtg
 iBHeX6lygsOeWDBNlSJwtPI1K80gdrzMOb6B87tm3j5n2cXOcPIDF4hap7q2FGDspmIv
 4pmnCl8cH+ek+KL5pbuBcjAQ2bd+mI1PmBvarztRj7NmZrr7rhwVJ2jQPKYr/XFsMGJD
 aA5/R13lwJkRiImViRHbYbJb62ysiG+4c4qpJ77FaEBelYjiHEEbEx3YZMXN1NWohO4x xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bq32bavrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 15:04:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC5DA10002A;
        Fri, 15 Oct 2021 15:04:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B0B0922A6CB;
        Fri, 15 Oct 2021 15:04:41 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 15 Oct
 2021 15:04:40 +0200
Subject: Re: [PATCH v2] ARM: dts: stm32: fix AV96 board SAI2 pin muxing on
 stm32mp15
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20211004090304.8984-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <cc69637e-7b3e-33b6-69ca-94c1cb8f1b21@foss.st.com>
Date:   Fri, 15 Oct 2021 15:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004090304.8984-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_04,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 11:03 AM, Olivier Moysan wrote:
> Fix SAI2A and SAI2B pin muxings for AV96 board on STM32MP15.
> Change sai2a-4 & sai2a-5 to sai2a-2 & sai2a-2.
> Change sai2a-4 & sai2a-sleep-5 to sai2b-2 & sai2b-sleep-2
> 
> Fixes: dcf185ca8175 ("ARM: dts: stm32: Add alternate pinmux for SAI2 pins on stm32mp15")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index 5b60ecbd718f..2ebafe27a865 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1179,7 +1179,7 @@
>   		};
>   	};
>   
> -	sai2a_pins_c: sai2a-4 {
> +	sai2a_pins_c: sai2a-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 13, AF10)>, /* SAI2_SCK_A */
>   				 <STM32_PINMUX('D', 11, AF10)>, /* SAI2_SD_A */
> @@ -1190,7 +1190,7 @@
>   		};
>   	};
>   
> -	sai2a_sleep_pins_c: sai2a-5 {
> +	sai2a_sleep_pins_c: sai2a-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('D', 13, ANALOG)>, /* SAI2_SCK_A */
>   				 <STM32_PINMUX('D', 11, ANALOG)>, /* SAI2_SD_A */
> @@ -1235,14 +1235,14 @@
>   		};
>   	};
>   
> -	sai2b_pins_c: sai2a-4 {
> +	sai2b_pins_c: sai2b-2 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('F', 11, AF10)>; /* SAI2_SD_B */
>   			bias-disable;
>   		};
>   	};
>   
> -	sai2b_sleep_pins_c: sai2a-sleep-5 {
> +	sai2b_sleep_pins_c: sai2b-sleep-2 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 11, ANALOG)>; /* SAI2_SD_B */
>   		};
>

Applied on stm32-next.

Thanks
Alex
