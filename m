Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1832654B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBZQNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:13:05 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35692 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhBZQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:12:55 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QGBT5J031134;
        Fri, 26 Feb 2021 17:11:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=bKqtubj8V3HWEd3a42zfyuBRldvZminXSbviOOCrD6c=;
 b=voN1q8Ax+cdgRvT4wESIZIVPayJ+PYEjsbe+ufus45iWAHjZlctpb4xxgSe/ycg/MpaC
 Oev1duzmykG63n+qfVgaQ5oPPtx6kSf4sD/yErfJKzVUw0l5EE/HiIP0Vw9x0XUiB2U/
 8UZ1bp0ZP7a6FwvBLIM0maNsyOCpCXOopwtkc1NSz3oTJb+98pAXkb8V4DPIyytIx37/
 BaVJl2R0Y2dQAtNkRSrbFieSfKSrs3nZXcBr40HsPiEI3qGzvrah4+V7rTJ2U+4mfxU1
 QjCzcvGsZ6d3Q9l/EKZY4iwTC5eO6p2t60ATp2Kedpwkp804sCwsM1Ltc0FV1Ef1a2hO AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36w66cxqm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 17:11:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B5A9310002A;
        Fri, 26 Feb 2021 17:11:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 89BC92A4D73;
        Fri, 26 Feb 2021 17:11:57 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Feb
 2021 17:11:56 +0100
Subject: Re: [PATCH v2 02/10] ARM: dts: stm32: Add Engicam MicroGEA STM32MP1
 SoM
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Francesco Utel <francesco.utel@engicam.com>,
        <linux-kernel@vger.kernel.org>,
        Mirko Ardinghi <mirko.ardinghi@engicam.com>,
        <linux-amarula@amarulasolutions.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210226070304.8028-1-jagan@amarulasolutions.com>
 <20210226070304.8028-3-jagan@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <611bce6f-7adb-f0b5-0c9b-d5d7bb8b90fb@foss.st.com>
Date:   Fri, 26 Feb 2021 17:11:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226070304.8028-3-jagan@amarulasolutions.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_05:2021-02-26,2021-02-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan

On 2/26/21 8:02 AM, Jagan Teki wrote:
> MicroGEA STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.
> 
> General features:
> - STM32MP157AAC
> - Up to 1GB DDR3L-800
> - 512MB Nand flash
> - I2S
> 
> MicroGEA STM32MP1 needs to mount on top of Engicam MicroDev carrier
> boards for creating complete platform solutions.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Francesco Utel <francesco.utel@engicam.com>
> Signed-off-by: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Minor question: if the stm32mp157 is soldered on Microdev boards why do 
you mention it in this commit message ?

+ a minor comment bellow.

thanks
Alex

> ---
> Changes for v2:
> - none
> 
>   .../dts/stm32mp157a-microgea-stm32mp1.dtsi    | 147 ++++++++++++++++++
>   1 file changed, 147 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> 
> diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> new file mode 100644
> index 000000000000..97d569107bfe
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (c) STMicroelectronics 2019 - All Rights Reserved
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutons(India)
> + */
> +
> +/ {
> +	compatible = "engicam,microgea-stm32mp1", "st,stm32mp157";
> +
> +	memory@c0000000 {

you could add 		device_type = "memory";


> +		reg = <0xc0000000 0x10000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mcuram2: mcuram2@10000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10000000 0x40000>;
> +			no-map;
> +		};
> +
> +		vdev0vring0: vdev0vring0@10040000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10040000 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@10041000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10041000 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0buffer: vdev0buffer@10042000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10042000 0x4000>;
> +			no-map;
> +		};
> +
> +		mcuram: mcuram@30000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x30000000 0x40000>;
> +			no-map;
> +		};
> +
> +		retram: retram@38000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x38000000 0x10000>;
> +			no-map;
> +		};
> +	};
> +
> +	vin: regulator-vin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vin";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	vddcore: regulator-vddcore {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vddcore";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		vin-supply = <&vin>;
> +	};
> +
> +	vdd: regulator-vdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&vin>;
> +	};
> +
> +	vddq_ddr: regulator-vddq-ddr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vddq_ddr";
> +		regulator-min-microvolt = <1350000>;
> +		regulator-max-microvolt = <1350000>;
> +		regulator-always-on;
> +		vin-supply = <&vin>;
> +	};
> +};
> +
> +&dts {
> +	status = "okay";
> +};
> +
> +&fmc {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&fmc_pins_a>;
> +	pinctrl-1 = <&fmc_sleep_pins_a>;
> +	status = "okay";
> +
> +	nand-controller@4,0 {
> +		status = "okay";
> +
> +		nand@0 {
> +			reg = <0>;
> +			nand-on-flash-bbt;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +	};
> +};
> +
> +&ipcc {
> +	status = "okay";
> +};
> +
> +&iwdg2{
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
> +&m4_rproc{
> +	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
> +			<&vdev0vring1>, <&vdev0buffer>;
> +	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
> +	mbox-names = "vq0", "vq1", "shutdown";
> +	interrupt-parent = <&exti>;
> +	interrupts = <68 1>;
> +	status = "okay";
> +};
> +
> +&rng1 {
> +	status = "okay";
> +};
> +
> +&rtc{
> +	status = "okay";
> +};
> +
> +&vrefbuf {
> +	regulator-min-microvolt = <2500000>;
> +	regulator-max-microvolt = <2500000>;
> +	vdda-supply = <&vdd>;
> +	status = "okay";
> +};
> 
