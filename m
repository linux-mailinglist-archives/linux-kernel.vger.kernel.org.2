Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8999140B8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhINUQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:16:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38282 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhINUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:16:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18EKFIfi118112;
        Tue, 14 Sep 2021 15:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631650518;
        bh=lq5McLfHFnZJXtETVxRy65ZaGodFkG723+t3RoSPFM4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=otS7QF9mQZU398UqW7r+/wmhofqprg1+SB029eFwX/94uDEiTeYjDFVTTj0V2hXF3
         aFgybhvi8eVH72uXzM25Q72BfWISpG+a7YjwD+VYdJZeQ3edowOCM6qTTe+Y9V8i2n
         qt23qd4nTW04tNI4joq9J+XB9PhWDSK25Im7RIVE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18EKFHd2074345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Sep 2021 15:15:17 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Sep 2021 15:15:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Sep 2021 15:15:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18EKFHqE054096;
        Tue, 14 Sep 2021 15:15:17 -0500
Date:   Tue, 14 Sep 2021 15:15:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: iot2050: Add support for product
 generation 2 boards
Message-ID: <20210914201517.s7cd23kj24seskm5@dallying>
References: <cover.1631216478.git.jan.kiszka@siemens.com>
 <206d28002626bb9e2e0ac3f82d3c6f9fdbbfc984.1631216478.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <206d28002626bb9e2e0ac3f82d3c6f9fdbbfc984.1631216478.git.jan.kiszka@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:41-20210909, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This adds the devices trees for IOT2050 Product Generation 2 (PG2)
> boards. We have Basic and an Advanced variants again, differing in
> number of cores, RAM size, availability of eMMC and further details.
> The major difference to PG1 is the used silicon revision (SR2.x on
> PG2).
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>  .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 +++++++++++++++++++
>  .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 24 +++++++++
>  .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 29 +++++++++++
>  4 files changed, 106 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index d56c742f5a10..41a4bc96e6bd 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -8,7 +8,9 @@
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> new file mode 100644
> index 000000000000..2323628b0444
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Siemens AG, 2021
> + *
> + * Authors:
> + *   Chao Zeng <chao.zeng@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>
> + *
> + * Common bits of the IOT2050 Basic and Advanced variants, PG2
> + */
> +
> +&main_pmx0 {
> +	cp2102n_reset_pin_default: cp2102n_reset_pin_default {

	cp2102n_reset_pin_default: cp2102n-reset-pin-default

> +		pinctrl-single,pins = <
> +			/* (AF12) GPIO1_24, used as cp2102 reset */
> +			AM65X_IOPAD(0x01e0, PIN_OUTPUT, 7)
> +		>;
> +	};
> +};
> +
> +&main_gpio1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp2102n_reset_pin_default>;
> +	gpio-line-names =
> +		"", "", "", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "", "", "",
> +		"", "", "", "", "CP2102N-RESET";
> +};
> +
> +&dss {
> +	/* Workaround needed to get DP clock of 154Mhz */
> +	assigned-clocks = <&k3_clks 67 0>;
> +};
> +
> +&serdes0 {
> +	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
> +	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
> +};
> +
> +&dwc3_0 {
> +	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
> +				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
> +	phys = <&serdes0 PHY_TYPE_USB3 0>;
> +	phy-names = "usb3-phy";
> +};
> +
> +&usb0_phy {
> +	maximum-speed = "super-speed";
> +	snps,dis-u1-entry-quirk;
> +	snps,dis-u2-entry-quirk;
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
> new file mode 100644
> index 000000000000..c62549a4b436
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Siemens AG, 2018-2021
> + *
> + * Authors:
> + *   Le Jin <le.jin@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>
> + *
> + * AM6528-based (dual-core) IOT2050 Basic variant, Product Generation 2
> + * 1 GB RAM, no eMMC, main_uart0 on connector X30
> + *
> + * Product homepage:
> + * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am6528-iot2050-basic-common.dtsi"
> +#include "k3-am65-iot2050-common-pg2.dtsi"
> +
> +/ {
> +	compatible = "siemens,iot2050-basic-pg2", "ti,am654";
> +	model = "SIMATIC IOT2050 Basic PG2";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> new file mode 100644
> index 000000000000..f00dc86d01b9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Siemens AG, 2018-2021
> + *
> + * Authors:
> + *   Le Jin <le.jin@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>
> + *
> + * AM6548-based (quad-core) IOT2050 Advanced variant, Product Generation 2
> + * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
> + *
> + * Product homepage:
> + * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am6548-iot2050-advanced-common.dtsi"
> +#include "k3-am65-iot2050-common-pg2.dtsi"
> +
> +/ {
> +	compatible = "siemens,iot2050-advanced-pg2", "ti,am654";

^^ siemens,iot2050-basic-pg2 -> needs a yaml update?

> +	model = "SIMATIC IOT2050 Advanced PG2";
> +};
> +
> +&mcu_r5fss0 {
> +	/* lock-step mode not supported on this board */
> +	ti,cluster-mode = <0>;
> +};
> -- 
> 2.31.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
