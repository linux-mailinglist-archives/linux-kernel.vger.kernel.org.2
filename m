Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35797413C26
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhIUVQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:16:19 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46983 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhIUVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:16:18 -0400
Received: by mail-oi1-f180.google.com with SMTP id s69so1072300oie.13;
        Tue, 21 Sep 2021 14:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bWK8KCUSeXUYwhPHrqeGzMe4z+4xKUHwvqCID3Fe/NY=;
        b=Y/8hiWkr5eoT6VXQn7zIHPfqj/R2hQa0TmIFURzVZ3KkgZdHrlkP9ZJdEqicuOXHkh
         Ee+ZXCpS/VqqQZi8Q2k9fvj5gKQpq3XANCvSEJt7vwIwZYGSENYZGW4/u/cuQKL2v82j
         gqk06s+bDK+cbrVebR07yaerJosrIeDOL8lRRQOF+V6Es8ZQuAmi9mGLZMUPUQC3ewM+
         Q//xTNsXbfnnbnV4Rd4G0eDaNCJsZMVY94yQAVuwZWZo8FLPGbsvWvjp/78ku3GkwGgD
         tsPF3Panv5sfUYVkTi5fK1YU8XUrvvbxYHuGTgfU2PuMT8Glg/J0KFEkIh7pwLN8cAyQ
         DNsg==
X-Gm-Message-State: AOAM532g4bIBNyInBmUpDnlFq6M7EtvtlWrPwtTKwBgZFF2hSc+qxaJc
        98q/M1Vio2nMliI6RjvKXc7i+JE/Lw==
X-Google-Smtp-Source: ABdhPJxYmZeWu5VVqrUSlvevv8NkNVD23DL8Au484/U1knhXunjVhMEM7oiiqhYKzZftCzl+Rdw/7Q==
X-Received: by 2002:a05:6808:494:: with SMTP id z20mr5371431oid.103.1632258889729;
        Tue, 21 Sep 2021 14:14:49 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com. [192.154.179.36])
        by smtp.gmail.com with ESMTPSA id j10sm32163oiw.32.2021.09.21.14.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:14:49 -0700 (PDT)
Received: (nullmailer pid 3336121 invoked by uid 1000);
        Tue, 21 Sep 2021 21:14:48 -0000
Date:   Tue, 21 Sep 2021 16:14:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Daniel Palmer <daniel@0x0f.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: dts: mstar: Add the Wireless Tag
 IDO-SBC2D06-V1B-22W
Message-ID: <YUpLSLNh27ifUGz1@robh.at.kernel.org>
References: <20210914184141.32700-1-romain.perier@gmail.com>
 <20210914184141.32700-4-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914184141.32700-4-romain.perier@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:41:41PM +0200, Romain Perier wrote:
> The Wireless Tag IDO-SBC2D06-V1B-22W[1] is an SBC powered by SSD202D
> with a dual Ethernet and a connector for a 4-inch and 7-inch display.
> It embeds a System-On-Module IDO-SOM2D01[2] with an Mstar SSD202 SoC
> dual-core Cortex-A7 CPU @ 1.2Ghz , 2D GPU, 128 MB DDR3 (on-chip) and
> a 256MB SPI NAND flash. This commit adds basic definition for this
> board.
> 
> 1. http://linux-chenxing.org/infinity2/ido-sbc2d06
> 2. http://www.wireless-tag.com/portfolio/ido-som2d01
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../devicetree/bindings/arm/mstar/mstar.yaml  |  2 ++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  .../dts/mstar-infinity2m-ssd201-som2d01.dtsi  | 20 +++++++++++++
>  ...sd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts | 23 +++++++++++++++
>  ...ity2m-ssd202d-wirelesstag-ido-som2d01.dtsi | 28 +++++++++++++++++++
>  5 files changed, 74 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
>  create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
>  create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
> index a316eef1b728..10efd703717e 100644
> --- a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
> +++ b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
> @@ -25,6 +25,8 @@ properties:
>            - enum:
>                - honestar,ssd201htv2 # Honestar SSD201_HT_V2 devkit
>                - m5stack,unitv2 # M5Stack UnitV2
> +              - wirelesstag,ido-som2d01 # Wireless Tag IDO-SOM2D01
> +              - wirelesstag,ido-sbc2d06-v1b-22w # Wireless Tag IDO-SBC2D06-1VB-22W
>            - const: mstar,infinity2m
>  
>        - description: infinity3 boards
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e0934180724..7f0e92cea716 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1448,6 +1448,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
>  dtb-$(CONFIG_ARCH_MSTARV7) += \
>  	mstar-infinity-msc313-breadbee_crust.dtb \
> +	mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dtb \
>  	mstar-infinity2m-ssd202d-ssd201htv2.dtb \
>  	mstar-infinity2m-ssd202d-unitv2.dtb \
>  	mstar-infinity3-msc313e-breadbee.dtb \
> diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
> new file mode 100644
> index 000000000000..34df472fed71
> --- /dev/null
> +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + * Author: Romain Perier <romain.perier@gmail.com>
> + */
> +
> +/ {
> +	reg_vcc_dram: regulator-vcc-dram {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_dram";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&pm_uart {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
> new file mode 100644
> index 000000000000..20b40b711d4f
> --- /dev/null
> +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + * Author: Romain Perier <romain.perier@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Wireless Tag IDO-SBC2D06-1VB-22W";
> +	compatible = "wirelesstag,ido-sbc2d06-v1b-22w", "wirelesstag,ido-som2d01", "mstar,infinity2m";

Doesn't match the schema. Please run 'make dtbs_check' on this and don't 
add new (non-duplicate) warnings.
 
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		sys_led {
> +			gpios = <&gpio SSD20XD_GPIO_GPIO85 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
> new file mode 100644
> index 000000000000..d877aff85033
> --- /dev/null
> +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + * Author: Romain Perier <romain.perier@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "mstar-infinity2m-ssd202d.dtsi"
> +#include "mstar-infinity2m-ssd201-som2d01.dtsi"
> +
> +/ {
> +	model = "Wireless Tag IDO-SOM2D01 (SSD202D)";
> +	compatible = "wirelesstag,ido-som2d01", "mstar,infinity2m";
> +
> +	aliases {
> +		serial0 = &pm_uart;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&reg_vcc_dram {
> +	regulator-min-microvolt = <1500000>;
> +	regulator-max-microvolt = <1500000>;
> +};
> -- 
> 2.33.0
> 
> 
