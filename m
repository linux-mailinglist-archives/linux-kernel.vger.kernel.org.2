Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2883456E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhKSL24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:28:56 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:61911 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhKSL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:28:54 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id c4d4f740;
        Fri, 19 Nov 2021 12:25:51 +0100 (CET)
Date:   Fri, 19 Nov 2021 12:25:51 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Janne Grunau <j@jannau.net>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211116215315.22528-3-j@jannau.net> (message from Janne Grunau
        on Tue, 16 Nov 2021 22:53:15 +0100)
Subject: Re: [PATCH 2/2] arm64: dts: apple: Add missing M1 (t8103) devices
References: <20211116215315.22528-1-j@jannau.net> <20211116215315.22528-3-j@jannau.net>
Message-ID: <d3cae936e9f6668e@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Janne Grunau <j@jannau.net>
> Cc: Mark Kettenis <mark.kettenis@xs4all.nl>,
>         linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
>         linux-kernel@vger.kernel.org
> Date: Tue, 16 Nov 2021 22:53:15 +0100
> 
> This adds support for following Apple M1 devices:
>  - MacBook Pro (13-inch, M1, 2020)
>  - MacBook Air (M1, 2020)
>  - iMac (24-inch 2021)
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm64/boot/dts/apple/Makefile        |  4 ++
>  arch/arm64/boot/dts/apple/t8103-j274.dts  | 29 +-------------
>  arch/arm64/boot/dts/apple/t8103-j293.dts  | 33 +++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-j313.dts  | 33 +++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-j456.dts  | 41 +++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-j457.dts  | 47 ++++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 49 +++++++++++++++++++++++
>  7 files changed, 208 insertions(+), 28 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi

There are multiple ways to skin this cat.  But I think this is a
reasonable way to do things and this should work fine for U-Boot and
OpenBSD.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
> index cbbd701ebf05..c0510c25ca6a 100644
> --- a/arch/arm64/boot/dts/apple/Makefile
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -1,2 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8103-j456.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8103-j457.dtb
> diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts b/arch/arm64/boot/dts/apple/t8103-j274.dts
> index 02c36301e985..9e01ef70039d 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j274.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
> @@ -10,39 +10,15 @@
>  /dts-v1/;
>  
>  #include "t8103.dtsi"
> +#include "t8103-jxxx.dtsi"
>  
>  / {
>  	compatible = "apple,j274", "apple,t8103", "apple,arm-platform";
>  	model = "Apple Mac mini (M1, 2020)";
>  
>  	aliases {
> -		serial0 = &serial0;
>  		ethernet0 = &ethernet0;
>  	};
> -
> -	chosen {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		stdout-path = "serial0";
> -
> -		framebuffer0: framebuffer@0 {
> -			compatible = "apple,simple-framebuffer", "simple-framebuffer";
> -			reg = <0 0 0 0>; /* To be filled by loader */
> -			/* Format properties will be added by loader */
> -			status = "disabled";
> -		};
> -	};
> -
> -	memory@800000000 {
> -		device_type = "memory";
> -		reg = <0x8 0 0x2 0>; /* To be filled by loader */
> -	};
> -};
> -
> -&serial0 {
> -	status = "okay";
>  };
>  
>  /*
> @@ -50,9 +26,6 @@ &serial0 {
>   * on-board devices and properties that are populated by the bootloader
>   * (such as MAC addresses).
>   */
> -&port00 {
> -	bus-range = <1 1>;
> -};
>  
>  &port01 {
>  	bus-range = <2 2>;
> diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
> new file mode 100644
> index 000000000000..466035f00b69
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple MacBook Pro (13-inch, M1, 2020)
> + *
> + * target-type: J293
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;
> +
> +#include "t8103.dtsi"
> +#include "t8103-jxxx.dtsi"
> +
> +/ {
> +	compatible = "apple,j293", "apple,t8103", "apple,arm-platform";
> +	model = "Apple MacBook Pro (13-inch, M1, 2020)";
> +};
> +
> +/*
> + * Remove unused PCIe ports and disable the associated DARTs.
> + */
> +
> +&pcie0_dart_1 {
> +	status = "disabled";
> +};
> +
> +&pcie0_dart_2 {
> +	status = "disabled";
> +};
> +
> +/delete-node/ &port01;
> +/delete-node/ &port02;
> diff --git a/arch/arm64/boot/dts/apple/t8103-j313.dts b/arch/arm64/boot/dts/apple/t8103-j313.dts
> new file mode 100644
> index 000000000000..b0ebb45bdb6f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8103-j313.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple MacBook Air (M1, 2020)
> + *
> + * target-type: J313
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;
> +
> +#include "t8103.dtsi"
> +#include "t8103-jxxx.dtsi"
> +
> +/ {
> +	compatible = "apple,j313", "apple,t8103", "apple,arm-platform";
> +	model = "Apple MacBook Air (M1, 2020)";
> +};
> +
> +/*
> + * Remove unused PCIe ports and disable the associated DARTs.
> + */
> +
> +&pcie0_dart_1 {
> +	status = "disabled";
> +};
> +
> +&pcie0_dart_2 {
> +	status = "disabled";
> +};
> +
> +/delete-node/ &port01;
> +/delete-node/ &port02;
> diff --git a/arch/arm64/boot/dts/apple/t8103-j456.dts b/arch/arm64/boot/dts/apple/t8103-j456.dts
> new file mode 100644
> index 000000000000..7267e069355b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8103-j456.dts
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple iMac (24-inch, 4x USB-C, M1, 2020)
> + *
> + * target-type: J456
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;
> +
> +#include "t8103.dtsi"
> +#include "t8103-jxxx.dtsi"
> +
> +/ {
> +	compatible = "apple,j456", "apple,t8103", "apple,arm-platform";
> +	model = "Apple iMac (24-inch, 4x USB-C, M1, 2020)";
> +
> +	aliases {
> +		ethernet0 = &ethernet0;
> +	};
> +};
> +
> +/*
> + * Force the bus number assignments so that we can declare some of the
> + * on-board devices and properties that are populated by the bootloader
> + * (such as MAC addresses).
> + */
> +
> +&port01 {
> +	bus-range = <2 2>;
> +};
> +
> +&port02 {
> +	bus-range = <3 3>;
> +	ethernet0: ethernet@0,0 {
> +		reg = <0x30000 0x0 0x0 0x0 0x0>;
> +		/* To be filled by the loader */
> +		local-mac-address = [00 10 18 00 00 00];
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103-j457.dts b/arch/arm64/boot/dts/apple/t8103-j457.dts
> new file mode 100644
> index 000000000000..d7c622931627
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8103-j457.dts
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple iMac (24-inch, 2x USB-C, M1, 2020)
> + *
> + * target-type: J457
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;
> +
> +#include "t8103.dtsi"
> +#include "t8103-jxxx.dtsi"
> +
> +/ {
> +	compatible = "apple,j457", "apple,t8103", "apple,arm-platform";
> +	model = "Apple iMac (24-inch, 2x USB-C, M1, 2020)";
> +
> +	aliases {
> +		ethernet0 = &ethernet0;
> +	};
> +};
> +
> +/*
> + * Force the bus number assignments so that we can declare some of the
> + * on-board devices and properties that are populated by the bootloader
> + * (such as MAC addresses).
> + */
> +
> +&port02 {
> +	bus-range = <3 3>;
> +	ethernet0: ethernet@0,0 {
> +		reg = <0x30000 0x0 0x0 0x0 0x0>;
> +		/* To be filled by the loader */
> +		local-mac-address = [00 10 18 00 00 00];
> +	};
> +};
> +
> +/*
> + * Remove unused PCIe port and disable the associated DART.
> + */
> +
> +&pcie0_dart_1 {
> +	status = "disabled";
> +};
> +
> +/delete-node/ &port01;
> diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> new file mode 100644
> index 000000000000..53d22b434d76
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple M1 Mac mini, MacBook Air/Pro, iMac 24" (M1, 2020/2021)
> + *
> + * This file contains parts common to all Apple M1 devices using the t8103.
> + *
> + * target-type: J274, J293, J313, J456, J457
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/ {
> +	aliases {
> +		serial0 = &serial0;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		stdout-path = "serial0";
> +
> +		framebuffer0: framebuffer@0 {
> +			compatible = "apple,simple-framebuffer", "simple-framebuffer";
> +			reg = <0 0 0 0>; /* To be filled by loader */
> +			/* Format properties will be added by loader */
> +			status = "disabled";
> +		};
> +	};
> +
> +	memory@800000000 {
> +		device_type = "memory";
> +		reg = <0x8 0 0x2 0>; /* To be filled by loader */
> +	};
> +};
> +
> +&serial0 {
> +	status = "okay";
> +};
> +
> +/*
> + * Force the bus number assignments so that we can declare some of the
> + * on-board devices and properties that are populated by the bootloader
> + * (such as MAC addresses).
> + */
> +&port00 {
> +	bus-range = <1 1>;
> +};
> -- 
> 2.33.1
> 
> 
