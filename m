Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1CD31C275
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBOT3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:29:54 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55819 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBOT3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:29:51 -0500
Received: by mail-wm1-f51.google.com with SMTP id o15so7066846wmq.5;
        Mon, 15 Feb 2021 11:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2lp9Aq2D4MoBftdOs5M770eBIHydvgoiWpAn4VIL1kc=;
        b=BJPwROOC2497yd2VA/qnAr5XX9I30ocDoCihP/+kV/GIyigiFOMe4vSZxvnEhpbHPz
         9PwAhWbZARNxykAoz2yow2X/UCutiQFutX2oUSLVgQVvoiczyq3w6oWpXG2cUlFDpm3T
         FWurC+e0szFx9DKmoM1+1tPCGalBvL33ujiASKX71jn5uaWEdQU/g43VjfoR19pvludw
         jpam94wFD5RdqhGosKK2BPcmpKR/r7B5LwZByZUyHCgLYODHZ1CFp8oHR1PtWtbT19Ul
         MXxwg+Y3SutkW4TnKw3iXc1rVIFUQ43XdVAoeiV/CADToe6BRf8SGrmeDsgFxZse+IQ/
         D46Q==
X-Gm-Message-State: AOAM5332t65sbfPkfR9pPQx4FcTpwPuCc+r1a2U0YJwS2EbCPBziTBD+
        677Sajbrdo0Itp9bIso2TF0=
X-Google-Smtp-Source: ABdhPJyWhB/a8bczdLa3D9lA7fMvaTLZGHadDzpEngNC2B6nbD0EiuZvGHab9XCVOWL6VxNrEtVgGQ==
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr316326wma.37.1613417348734;
        Mon, 15 Feb 2021 11:29:08 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r17sm3262947wrx.82.2021.02.15.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:29:07 -0800 (PST)
Date:   Mon, 15 Feb 2021 20:29:06 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/25] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <20210215192906.7k3unuhph5wnkj5g@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-26-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-26-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:17:13PM +0900, Hector Martin wrote:
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
>  arch/arm64/boot/dts/apple/apple-j274.dts |  41 ++++++++
>  arch/arm64/boot/dts/apple/apple-m1.dtsi  | 124 +++++++++++++++++++++++
>  5 files changed, 169 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/Makefile
>  create mode 100644 arch/arm64/boot/dts/apple/apple-j274.dts
>  create mode 100644 arch/arm64/boot/dts/apple/apple-m1.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8f258fbb5f1..87db1c947f45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1635,6 +1635,7 @@ C:	irc://chat.freenode.net/asahi-dev
>  T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/apple.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +F:	arch/arm64/boot/dts/apple/
>  F:	arch/arm64/include/asm/sysreg_apple.h
>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
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
> index 000000000000..9a1be91a2cf0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/apple-j274.dts
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT

() around licenses, so:
(GPL-2.0+ OR MIT)

> +/*
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;
> +
> +#include "apple-m1.dtsi"
> +
> +/ {
> +	compatible = "apple,j274", "apple,m1", "apple,arm-platform";
> +	model = "Apple Mac Mini M1 2020";
> +
> +	aliases {
> +		serial0 = &serial0;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		stdout-path = "serial0:1500000";
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
> +		reg = <0 0 0 0>; /* To be filled by loader */

dtc and dtschema might complain, so could you set here fake memory
address 0x800000000? Would that work for your bootloader?

> +	};
> +};
> +
> +&serial0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/apple-m1.dtsi b/arch/arm64/boot/dts/apple/apple-m1.dtsi
> new file mode 100644
> index 000000000000..45c87771b057
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/apple-m1.dtsi
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <dt-bindings/interrupt-controller/apple-aic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "apple,m1", "apple,arm-platform";
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "apple,icestorm";
> +			device_type = "cpu";
> +			reg = <0x0 0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>; /* To be filled by loader */
> +		};

New line after every device node, please.

With this minor changes, fine for me:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
