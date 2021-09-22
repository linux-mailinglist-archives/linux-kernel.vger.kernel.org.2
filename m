Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F596414D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhIVQA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:00:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56984 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhIVQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:00:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18MFwiw6054321;
        Wed, 22 Sep 2021 10:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632326324;
        bh=yOcYshpy9NXbBhUxW7buhVqSE8u9TAcg9tbSZimEaSY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=k2ZpW0a/786iPLnhuQgUsrQB4pO9UI4TWUWRg0z7rcD00mh3JavkkpmilogSXWB7r
         OonnGhu1PnG3GzSejEEryy2tvTuFGKuBpNUcTGypzrvd+KIgGeNFg8IX83q2PBXgl9
         sZcjvQy82PsecxGbYz36i9eleh0o+e0l29Wr5/Hc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18MFwiZQ126892
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Sep 2021 10:58:44 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Sep 2021 10:58:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Sep 2021 10:58:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18MFwhIN093009;
        Wed, 22 Sep 2021 10:58:43 -0500
Date:   Wed, 22 Sep 2021 10:58:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: ti: iot2050: Add support for product
 generation 2 boards
Message-ID: <20210922155843.gjn5aezf4lmgtn3d@undecided>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
 <a4d6ab1dd1f5582b940ac25395eb878e683b3a38.1631708830.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a4d6ab1dd1f5582b940ac25395eb878e683b3a38.1631708830.git.jan.kiszka@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:27-20210915, Jan Kiszka wrote:
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
> index 000000000000..c25bce7339b7
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
> +	cp2102n_reset_pin_default: cp2102n-reset-pin-default {
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

^^
	did you mean &usb0?
usb0_phy uses Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
usb0 uses Documentation/devicetree/bindings/usb/snps,dwc3.yaml

am i missing a "maximum-speed" there? quirks look like belonging to the
controller ?


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
