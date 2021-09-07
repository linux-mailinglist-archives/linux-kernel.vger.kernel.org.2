Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714E0402B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbhIGPSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:18:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42318 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhIGPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:18:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 187FGnSU058788;
        Tue, 7 Sep 2021 10:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631027809;
        bh=Qq5UbFpRo0+EzK0Lf5n2wVetqnYGvrZeUvOSaRyrsjo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pwOfpcHEH5oBQiHt0CAk0bLgorWr8H7AXPyOASmCs5ETJ0qHbOdq+nPmqfGa+KMhd
         AIHkTM5EnttV17Rs5pDCyvNnqKy+Z1r0dO82tvnWBRWy03jSbPAE/iRPmV9JGscyDU
         xlXuqwa49FPaW8kS4mYWTbrUTlVAGeD3szGlcStU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 187FGnva001689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Sep 2021 10:16:49 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Sep 2021 10:16:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Sep 2021 10:16:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 187FGmdB062299;
        Tue, 7 Sep 2021 10:16:48 -0500
Date:   Tue, 7 Sep 2021 10:16:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: iot2050: Add support for product
 generation 2 boards
Message-ID: <20210907151648.5z4hnlgppurheloz@stroller>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
 <d678e0a2d77fbd71c95d554dcac4646c7e8e6cf0.1631024536.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d678e0a2d77fbd71c95d554dcac4646c7e8e6cf0.1631024536.git.jan.kiszka@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:22-20210907, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Product Generations 1 and 2 differ in the SOC revision which requires
> separate device trees.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>  .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 ++++++++++++++++
>  .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 ++++++++++++++++++
>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 35 +-----------
>  ...ts => k3-am6528-iot2050-basic-common.dtsi} | 12 ++---
>  .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 21 ++++++++
>  .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 53 ++-----------------
>  ...=> k3-am6548-iot2050-advanced-common.dtsi} |  8 +--
>  .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 26 +++++++++
>  .../dts/ti/k3-am6548-iot2050-advanced.dts     | 52 ++----------------
>  10 files changed, 161 insertions(+), 145 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
>  copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts => k3-am6528-iot2050-basic-common.dtsi} (80%)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
>  copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts => k3-am6548-iot2050-advanced-common.dtsi} (86%)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts


Few things:

a) Could you split this patch so that the refactoring for SR1 is the
   first patch and then introduce the SR2?
b) Please call these as sr (silicon revision) rather than pg.
c) usual request: Please add urls for the board

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
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> new file mode 100644
> index 000000000000..51f902fa35a7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Siemens AG, 2021
> + *
> + * Authors:
> + *   Jan Kiszka <jan.kiszka@siemens.com>
> + *
> + * Common bits of the IOT2050 Basic and Advanced variants, PG1
> + */
> +
> +&dss {
> +	assigned-clocks = <&k3_clks 67 2>;
> +	assigned-clock-parents = <&k3_clks 67 5>;
> +};
> +
> +&serdes0 {
> +	status = "disabled";
> +};
> +
> +&sdhci1 {
> +	no-1-8-v;
> +};
> +
> +&tx_pru0_0 {
> +	status = "disabled";
> +};
> +
> +&tx_pru0_1 {
> +	status = "disabled";
> +};
> +
> +&tx_pru1_0 {
> +	status = "disabled";
> +};
> +
> +&tx_pru1_1 {
> +	status = "disabled";
> +};
> +
> +&tx_pru2_0 {
> +	status = "disabled";
> +};
> +
> +&tx_pru2_1 {
> +	status = "disabled";
> +};
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
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index fb3f3e4ed753..47730fe3a797 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -4,13 +4,11 @@
>   *
>   * Authors:
>   *   Le Jin <le.jin@siemens.com>
> - *   Jan Kiszka <jan.kiszk@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>
>   *
> - * Common bits of the IOT2050 Basic and Advanced variants
> + * Common bits of the IOT2050 Basic and Advanced variants, PG1 and PG2
>   */
>  
> -/dts-v1/;
> -
>  #include "k3-am654.dtsi"
>  #include <dt-bindings/phy/phy.h>
>  
> @@ -555,7 +553,6 @@ &sdhci1 {
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
> -	no-1-8-v;
>  };
>  
>  &usb0 {
> @@ -635,10 +632,6 @@ dpi_out: endpoint {
>  	};
>  };
>  
> -&serdes0 {
> -	status = "disabled";
> -};
> -
>  &pcie0_rc {
>  	status = "disabled";
>  };
> @@ -720,27 +713,3 @@ &icssg1_mdio {
>  &icssg2_mdio {
>  	status = "disabled";
>  };
> -
> -&tx_pru0_0 {
> -	status = "disabled";
> -};
> -
> -&tx_pru0_1 {
> -	status = "disabled";
> -};
> -
> -&tx_pru1_0 {
> -	status = "disabled";
> -};
> -
> -&tx_pru1_1 {
> -	status = "disabled";
> -};
> -
> -&tx_pru2_0 {
> -	status = "disabled";
> -};
> -
> -&tx_pru2_1 {
> -	status = "disabled";
> -};
> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
> similarity index 80%
> copy from arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> copy to arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
> index 94bb5dd39122..4a9bf7d7c07d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
> @@ -4,20 +4,14 @@
>   *
>   * Authors:
>   *   Le Jin <le.jin@siemens.com>
> - *   Jan Kiszka <jan.kiszk@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>
>   *
> - * AM6528-based (dual-core) IOT2050 Basic variant
> - * 1 GB RAM, no eMMC, main_uart0 on connector X30
> + * Common bits of the IOT2050 Basic variant, PG1 and PG2
>   */
>  
> -/dts-v1/;
> -
>  #include "k3-am65-iot2050-common.dtsi"
>  
>  / {
> -	compatible = "siemens,iot2050-basic", "ti,am654";
> -	model = "SIMATIC IOT2050 Basic";
> -
>  	memory@80000000 {
>  		device_type = "memory";
>  		/* 1G RAM */
> @@ -61,6 +55,6 @@ &main_uart0 {
>  };
>  
>  &mcu_r5fss0 {
> -	/* lock-step mode not supported on this board */
> +	/* lock-step mode not supported on Basic boards */
>  	ti,cluster-mode = <0>;
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
> new file mode 100644
> index 000000000000..5ce609dd49ad
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
> @@ -0,0 +1,21 @@
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
> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> index 94bb5dd39122..368a25d449a9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> @@ -4,63 +4,18 @@
>   *
>   * Authors:
>   *   Le Jin <le.jin@siemens.com>
> - *   Jan Kiszka <jan.kiszk@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>
>   *
> - * AM6528-based (dual-core) IOT2050 Basic variant
> + * AM6528-based (dual-core) IOT2050 Basic variant, Product Generation 1
>   * 1 GB RAM, no eMMC, main_uart0 on connector X30
>   */
>  
>  /dts-v1/;
>  
> -#include "k3-am65-iot2050-common.dtsi"
> +#include "k3-am6528-iot2050-basic-common.dtsi"
> +#include "k3-am65-iot2050-common-pg1.dtsi"
>  
>  / {
>  	compatible = "siemens,iot2050-basic", "ti,am654";
>  	model = "SIMATIC IOT2050 Basic";
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		/* 1G RAM */
> -		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
> -	};
> -
> -	cpus {
> -		cpu-map {
> -			/delete-node/ cluster1;
> -		};
> -		/delete-node/ cpu@100;
> -		/delete-node/ cpu@101;
> -	};
> -
> -	/delete-node/ l2-cache1;
> -};
> -
> -/* eMMC */
> -&sdhci0 {
> -	status = "disabled";
> -};
> -
> -&main_pmx0 {
> -	main_uart0_pins_default: main-uart0-pins-default {
> -		pinctrl-single,pins = <
> -			AM65X_IOPAD(0x01e4, PIN_INPUT,  0)  /* (AF11) UART0_RXD */
> -			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)  /* (AE11) UART0_TXD */
> -			AM65X_IOPAD(0x01ec, PIN_INPUT,  0)  /* (AG11) UART0_CTSn */
> -			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)  /* (AD11) UART0_RTSn */
> -			AM65X_IOPAD(0x0188, PIN_INPUT,  1)  /* (D25) UART0_DCDn */
> -			AM65X_IOPAD(0x018c, PIN_INPUT,  1)  /* (B26) UART0_DSRn */
> -			AM65X_IOPAD(0x0190, PIN_OUTPUT, 1)  /* (A24) UART0_DTRn */
> -			AM65X_IOPAD(0x0194, PIN_INPUT,  1)  /* (E24) UART0_RIN */
> -		>;
> -	};
> -};
> -
> -&main_uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_uart0_pins_default>;
> -};
> -
> -&mcu_r5fss0 {
> -	/* lock-step mode not supported on this board */
> -	ti,cluster-mode = <0>;
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> similarity index 86%
> copy from arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> copy to arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> index d1d5278e0b94..d5fa660a2abe 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
> @@ -4,10 +4,9 @@
>   *
>   * Authors:
>   *   Le Jin <le.jin@siemens.com>
> - *   Jan Kiszka <jan.kiszk@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>
>   *
> - * AM6548-based (quad-core) IOT2050 Advanced variant
> - * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
> + * Common bits of the IOT2050 Advanced variant, PG1 and PG2
>   */
>  
>  /dts-v1/;
> @@ -15,9 +14,6 @@
>  #include "k3-am65-iot2050-common.dtsi"
>  
>  / {
> -	compatible = "siemens,iot2050-advanced", "ti,am654";
> -	model = "SIMATIC IOT2050 Advanced";
> -
>  	aliases {
>  		mmc0 = &sdhci1;
>  		mmc1 = &sdhci0;
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> new file mode 100644
> index 000000000000..066390616b4d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> @@ -0,0 +1,26 @@
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
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> index d1d5278e0b94..7ee5e4942c07 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> @@ -4,62 +4,18 @@
>   *
>   * Authors:
>   *   Le Jin <le.jin@siemens.com>
> - *   Jan Kiszka <jan.kiszk@siemens.com>
> + *   Jan Kiszka <jan.kiszka@siemens.com>
>   *
> - * AM6548-based (quad-core) IOT2050 Advanced variant
> + * AM6548-based (quad-core) IOT2050 Advanced variant, Product Generation 1
>   * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
>   */
>  
>  /dts-v1/;
>  
> -#include "k3-am65-iot2050-common.dtsi"
> +#include "k3-am6548-iot2050-advanced-common.dtsi"
> +#include "k3-am65-iot2050-common-pg1.dtsi"
>  
>  / {
>  	compatible = "siemens,iot2050-advanced", "ti,am654";
>  	model = "SIMATIC IOT2050 Advanced";
> -
> -	aliases {
> -		mmc0 = &sdhci1;
> -		mmc1 = &sdhci0;
> -	};
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		/* 2G RAM */
> -		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> -	};
> -};
> -
> -&main_pmx0 {
> -	main_mmc0_pins_default: main-mmc0-pins-default {
> -		pinctrl-single,pins = <
> -			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)  /* (B25) MMC0_CLK */
> -			AM65X_IOPAD(0x01ac, PIN_INPUT_PULLUP,   0)  /* (B27) MMC0_CMD */
> -			AM65X_IOPAD(0x01a4, PIN_INPUT_PULLUP,   0)  /* (A26) MMC0_DAT0 */
> -			AM65X_IOPAD(0x01a0, PIN_INPUT_PULLUP,   0)  /* (E25) MMC0_DAT1 */
> -			AM65X_IOPAD(0x019c, PIN_INPUT_PULLUP,   0)  /* (C26) MMC0_DAT2 */
> -			AM65X_IOPAD(0x0198, PIN_INPUT_PULLUP,   0)  /* (A25) MMC0_DAT3 */
> -			AM65X_IOPAD(0x0194, PIN_INPUT_PULLUP,   0)  /* (E24) MMC0_DAT4 */
> -			AM65X_IOPAD(0x0190, PIN_INPUT_PULLUP,   0)  /* (A24) MMC0_DAT5 */
> -			AM65X_IOPAD(0x018c, PIN_INPUT_PULLUP,   0)  /* (B26) MMC0_DAT6 */
> -			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP,   0)  /* (D25) MMC0_DAT7 */
> -			AM65X_IOPAD(0x01b8, PIN_OUTPUT_PULLUP,  7)  /* (B23) MMC0_SDWP */
> -			AM65X_IOPAD(0x01b4, PIN_INPUT_PULLUP,   0)  /* (A23) MMC0_SDCD */
> -			AM65X_IOPAD(0x01b0, PIN_INPUT,          0)  /* (C25) MMC0_DS */
> -		>;
> -	};
> -};
> -
> -/* eMMC */
> -&sdhci0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_mmc0_pins_default>;
> -	bus-width = <8>;
> -	non-removable;
> -	ti,driver-strength-ohm = <50>;
> -	disable-wp;
> -};
> -
> -&main_uart0 {
> -	status = "disabled";
>  };
> -- 
> 2.31.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
