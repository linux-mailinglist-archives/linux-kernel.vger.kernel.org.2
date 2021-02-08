Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9727313075
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhBHLOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:14:47 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45654 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhBHLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:05:25 -0500
Received: by mail-ed1-f54.google.com with SMTP id t5so17495798eds.12;
        Mon, 08 Feb 2021 03:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZnXtuKDtjfCK+Wau43axfzEHC52NhOuAsUoAI9Jo0T4=;
        b=riQqe6kYYu34lb0WY9hZYpefBOKHzxHTSk1jpeh4fbUaO0IT85oK7kEG6Vg2k2Ou4g
         sdk8hysA8GmJTLmuwvprMNM0stLdKKj+LOUlIlsj9ij3WWeQ4Bcy1faba16cm5M9go0u
         Aj/zTDzsGp7uvy2HAfHZXSiUgKKbStPQBISIwqGpDDLSFSrpRu/Srn0CLyTFcbuDL1Zg
         M3Ccgf+dDacnk8FgrCzu8iPHh81+1gBkCreEigKY/lhcqIRHgoPVjs0871YckkqoF8dW
         KERWcdBV/ZxBltR2wJ1D2PdU0tAVp1FogFT/FlGfIquXXwR9V7MDSB3Wqu4QDWJea1hP
         HRYA==
X-Gm-Message-State: AOAM530JduDipcpXDtIdumsQsiV0XetJ7Lu86YP4WtA4C01mOJyDLM0T
        b4rEech6S8zWiMMMxae4JuQ=
X-Google-Smtp-Source: ABdhPJyTpLeaD+lc+pF/9E0BTCIWBbMdXbaxi0/0fqwRf5MYHywFNGGihVKmvcrpNDgjFNZ32RWqjw==
X-Received: by 2002:a50:bf42:: with SMTP id g2mr16650172edk.101.1612782283762;
        Mon, 08 Feb 2021 03:04:43 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id lc11sm3180759ejc.95.2021.02.08.03.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:04:42 -0800 (PST)
Date:   Mon, 8 Feb 2021 12:04:41 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <20210208110441.25qc6yken4effd6c@kozik-lap>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204203951.52105-19-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:39:51AM +0900, Hector Martin wrote:
> This currently supports:
> 
> * SMP (via spin-tables)
> * AIC IRQs
> * Serial (with earlycon)
> * Framebuffer
> 
> A number of properties are dynamic, and based on system firmware
> decisions that vary from version to version. These are expected
> to be filled in by the loader.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  MAINTAINERS                              |   1 +
>  arch/arm64/boot/dts/Makefile             |   1 +
>  arch/arm64/boot/dts/apple/Makefile       |   2 +
>  arch/arm64/boot/dts/apple/apple-j274.dts | 143 +++++++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/Makefile
>  create mode 100644 arch/arm64/boot/dts/apple/apple-j274.dts
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a54ee5747d3..5481b5bc2ef7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1635,6 +1635,7 @@ C:	irc://chat.freenode.net/asahi-dev
>  T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/AAPL.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/AAPL,aic.yaml
> +F:	arch/arm64/boot/dts/AAPL/

apple

Don't make things different for this one platform (comparing to all
other platforms). Apple is not that special. :)

>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
>  
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 9b1170658d60..64f055d94948 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -6,6 +6,7 @@ subdir-y += amazon
>  subdir-y += amd
>  subdir-y += amlogic
>  subdir-y += apm
> +subdir-y += apple
>  subdir-y += arm
>  subdir-y += bitmain
>  subdir-y += broadcom
> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
> new file mode 100644
> index 000000000000..ec03c474efd4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_APPLE) += apple-j274.dtb
> diff --git a/arch/arm64/boot/dts/apple/apple-j274.dts b/arch/arm64/boot/dts/apple/apple-j274.dts
> new file mode 100644
> index 000000000000..238a1bcee066
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/apple-j274.dts
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 Hector Martin <marcan@marcan.st>

A lot here might be difficult to reverse-egineer or figure out by
ourself, so usually people rely on vendor sources (the open source
compliance package). Didn't you receive such for the iOS (or whatever
was on your Mac)?

> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/interrupt-controller/apple-aic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "Apple Mac Mini M1 2020";
> +	compatible = "AAPL,j274", "AAPL,m1", "AAPL,arm-platform";

I guess Rob will comment on the dt-bindings more... but for me a generic
"arm-platform" is too generic. What's the point of it? I didn't see any
of such generic compatibles in other platforms.

> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		bootargs = "earlycon";

This should not be hard-coded in DTS. Pass it from bootloader.

> +		stdout-path = "serial0:1500000";

Use aliases.

> +
> +		framebuffer0: framebuffer@0 {
> +			compatible = "AAPL,simple-framebuffer", "simple-framebuffer";
> +			reg = <0 0 0 0>; // To be filled by loader
> +			// Format properties will be added by loader

Use /* style of comments

> +			status = "disabled";
> +		};
> +	};
> +
> +	memory@800000000 {
> +		device_type = "memory";
> +		reg = <0 0 0 0>; // To be filled by loader
> +	};
> +
> +	aliases {
> +		serial0 = &serial0;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "AAPL,icestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; // To be filled by loader
> +		};
> +		cpu1: cpu@1 {
> +			compatible = "AAPL,icestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x1>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; // To be filled by loader
> +		};
> +		cpu2: cpu@2 {
> +			compatible = "AAPL,icestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x2>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; // To be filled by loader
> +		};
> +		cpu3: cpu@3 {
> +			compatible = "AAPL,icestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x3>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; // To be filled by loader
> +		};
> +		cpu4: cpu@10100 {
> +			compatible = "AAPL,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10100>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; // To be filled by loader
> +		};
> +		cpu5: cpu@10101 {
> +			compatible = "AAPL,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10101>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; // To be filled by loader
> +		};
> +		cpu6: cpu@10102 {
> +			compatible = "AAPL,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10102>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; // To be filled by loader
> +		};
> +		cpu7: cpu@10103 {
> +			compatible = "AAPL,firestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x10103>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; // To be filled by loader
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&aic>;
> +		interrupts = <AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_FIQ 1 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_FIQ 0 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	clk24: clk24 {

Just "clock". Node names should be generic.

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "clk24";

What clock is it? Part of board or SoC? Isn't it a work-around for
missing clock drivers?

> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		aic: interrupt-controller@23b100000 {
> +			compatible = "AAPL,m1-aic", "AAPL,aic";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x2 0x3b100000 0x0 0x8000>;
> +		};
> +
> +		serial0: serial@235200000 {
> +			compatible = "AAPL,s5l-uart";
> +			reg = <0x2 0x35200000 0x0 0x1000>;
> +			reg-io-width = <4>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 605 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk24>, <&clk24>;
> +			clock-names = "uart", "clk_uart_baud0";
> +		};
> +

No blank lines at end of blocks.

Best regards,
Krzysztof
