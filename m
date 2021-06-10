Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C943A2D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFJNh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:37:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23014 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230413AbhFJNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:37:57 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ADRTRM027439;
        Thu, 10 Jun 2021 15:35:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=PVwoi7QXAKZzjqIJrJlU43OTjFre496R9tdNWd8Ac2w=;
 b=ZN81NbvDFhrXwk4O1UyjffqcLGTinleTVxJhmVMlxYd5rFaqSI/dX2wNs1w2DGinAbNh
 Lt8/ZcUg5m0Ncdsjg0M6PEn/h5cniXxt1kuO1hOPYkb0BNIN3jxBzL0OOOF8AwSzSRHZ
 /jLKxZ8ARy7finN7O9nUCe5fnM4T64Z5Dxd/SsFfUgyCp+2BPFIYWqAR5V1LndMt5SNJ
 rjo/l64Jg4AQCtfpzScvPu6zaAvb6UhWrK0u9NCsKTYD4RFb7so9WENiByooWQ3/Ok6u
 mnfPKfUlIRVQ98HRjwzP+cIPkoOHqiRoHGvs0W3obLUGD7VSc4FJRhDTnPa6JcUIMt4p Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 392xq7y0g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 15:35:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38EB2100034;
        Thu, 10 Jun 2021 15:35:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 195B7228817;
        Thu, 10 Jun 2021 15:35:41 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 15:35:40 +0200
Subject: Re: [PATCH v2] ARM: dts: stm32: add a new DCMI pins group
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <fcee4f30-446e-f4da-6d95-c9223cf82981@pengutronix.de>
 <YLj2emwxhAVVOeIo@nx64de-df6d00>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <0b37872e-4ae9-acd6-5698-b188ad38bb8a@foss.st.com>
Date:   Thu, 10 Jun 2021 15:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLj2emwxhAVVOeIo@nx64de-df6d00>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/3/21 5:34 PM, Grzegorz Szymaszek wrote:
> The Seeed Odyssey-STM32MP157C board has a 20-pin DVP camera output.
> stm32mp15-pinctrl.dtsi contained one pin state definition for the DCMI
> interface, dcmi-0, AKA phandle dcmi_pins_a. This definition was
> incompatible with the pins used on the Odyssey board, where:
> - there are 8 data pins instead of 12,
> - DCMI_HSYNC is available at PA4 instead of PH8,
> - DCMI_D0 is at PC6 instead of PH9,
> - DCMI_D3 is at PE1 instead of PH12,
> - DCMI_D4 is at PE11 instead of PH14,
> - DCMI_D5 is at PD3 instead of PI4,
> - DCMI_D6 is at PE13 instead of PB8,
> - DCMI_D7 is at PB9 instead of PE6.
> 
> Add the DCMI pins used on the Odyssey board as a new DCMI pin state
> definition, dcmi-1, AKA phandle dcmi_pins_b.
> 
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
> V1 -> V2: Removed the pinctrl override from the Odyssey device tree,
> added a new pinctrl in stm32mp15-pinctrl.dtsi instead
> 
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 33 ++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 

Applied on stm32-next. I just updated the commit title by
"ARM: dts: stm32: add a new DCMI pins group on stm32mp15"

Thanks.
Alex


> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index 060baa8b7e9d..5b60ecbd718f 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -118,6 +118,39 @@ pins {
>   		};
>   	};
>   
> +	dcmi_pins_b: dcmi-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 4,  AF13)>,/* DCMI_HSYNC */
> +				 <STM32_PINMUX('B', 7,  AF13)>,/* DCMI_VSYNC */
> +				 <STM32_PINMUX('A', 6,  AF13)>,/* DCMI_PIXCLK */
> +				 <STM32_PINMUX('C', 6,  AF13)>,/* DCMI_D0 */
> +				 <STM32_PINMUX('H', 10, AF13)>,/* DCMI_D1 */
> +				 <STM32_PINMUX('H', 11, AF13)>,/* DCMI_D2 */
> +				 <STM32_PINMUX('E', 1,  AF13)>,/* DCMI_D3 */
> +				 <STM32_PINMUX('E', 11, AF13)>,/* DCMI_D4 */
> +				 <STM32_PINMUX('D', 3,  AF13)>,/* DCMI_D5 */
> +				 <STM32_PINMUX('E', 13, AF13)>,/* DCMI_D6 */
> +				 <STM32_PINMUX('B', 9,  AF13)>;/* DCMI_D7 */
> +			bias-disable;
> +		};
> +	};
> +
> +	dcmi_sleep_pins_b: dcmi-sleep-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 4,  ANALOG)>,/* DCMI_HSYNC */
> +				 <STM32_PINMUX('B', 7,  ANALOG)>,/* DCMI_VSYNC */
> +				 <STM32_PINMUX('A', 6,  ANALOG)>,/* DCMI_PIXCLK */
> +				 <STM32_PINMUX('C', 6,  ANALOG)>,/* DCMI_D0 */
> +				 <STM32_PINMUX('H', 10, ANALOG)>,/* DCMI_D1 */
> +				 <STM32_PINMUX('H', 11, ANALOG)>,/* DCMI_D2 */
> +				 <STM32_PINMUX('E', 1,  ANALOG)>,/* DCMI_D3 */
> +				 <STM32_PINMUX('E', 11, ANALOG)>,/* DCMI_D4 */
> +				 <STM32_PINMUX('D', 3,  ANALOG)>,/* DCMI_D5 */
> +				 <STM32_PINMUX('E', 13, ANALOG)>,/* DCMI_D6 */
> +				 <STM32_PINMUX('B', 9,  ANALOG)>;/* DCMI_D7 */
> +		};
> +	};
> +
>   	ethernet0_rgmii_pins_a: rgmii-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
> 

