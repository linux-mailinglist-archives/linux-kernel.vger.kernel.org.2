Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78A3A4A25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFKUdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:33:33 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33431 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhFKUdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:33:32 -0400
Received: by mail-ed1-f53.google.com with SMTP id f5so33508069eds.0;
        Fri, 11 Jun 2021 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qkN0AO/46OjWRT9PADiybil1jeYRgRfOTZb/+oZbXks=;
        b=pSsSHInu6XM//mfEujgy+dDYDIxO8g4iJ9E8Q3jKKmCnyF+79S4vuAkRhunEN/+cJg
         K/r0SY/VeX5w7/isFdpGncBNrMSv9f40E7xC/1sf4bQ9VZuWJjEjtd12CB44ysTJH74l
         SuKkVbPRhY0IsypL79Cgozv1PF8XSeeRwJyB/1w45ydojDRUcxGpsKlJYCMEI6SIKtI6
         X2yqgfjWHfNG4PINOdlI/2wDNZCGlrTBJcQtt8Wm3c0YPat72NB13WKSV/ZRqi/p6IAq
         o2Bm4m6erZUlYVX50wfTNmeeYfxyCScJqc3ZdLy9SE4HFpBii2W1jUvAXRAbqUz6d4ua
         1bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkN0AO/46OjWRT9PADiybil1jeYRgRfOTZb/+oZbXks=;
        b=KiwmtnTSWbVfTFuQC0nrMegQbazSN4wFBAyQv6K7pIDvL9uIU56vI3mJPj4ugPLztA
         YVHM7FBqOAn1HNJa0Od5n83oOKSikYKeqWHbAUp4Yyy0EVUAQCiIgz9jBFSWzqJN+g8O
         HRgcwEmj72uJxX8AzexyMzMucBxlUf6MxVkVd1hsYoXHfcEyo0EIoZ4NVpUaoMW2kDcX
         JFsCDdm4JnU65ZzmYHwqGvqYCdPTg+KlIOpswU5crgD0d+0ibgs9sHkvyCR87x2f3Oj7
         T3iZpauFDqNdKWI2d51kC82Qm6mWd8sDMLEbD28I61KhfFiZl7kQ4ID0lEgpy6iHBKZh
         FzNA==
X-Gm-Message-State: AOAM533gz3LfQEyPlzWrqjIgdKTFXAnkYMS2N2ypxS+WXg4oo3Ys0J52
        Sx30M+mSkHEMTfq0c6/Z9j4=
X-Google-Smtp-Source: ABdhPJyHl8voOpFgIlUqxxEy8/h8evFb+gmOEvLOPk278Vz2pxh81jcD5TYnggJ7g+hIVpH31rsVmA==
X-Received: by 2002:aa7:d648:: with SMTP id v8mr5286241edr.203.1623443433222;
        Fri, 11 Jun 2021 13:30:33 -0700 (PDT)
Received: from skbuf ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id c13sm3022543edv.27.2021.06.11.13.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:30:32 -0700 (PDT)
Date:   Fri, 11 Jun 2021 23:30:31 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] ARM: dts: NSP: Add common bindings for MX64/MX65
Message-ID: <20210611203031.fj3g32o7kgupgzjy@skbuf>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
 <20210610232727.1383117-4-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610232727.1383117-4-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:27:15AM +0100, Matthew Hagan wrote:
> These bindings are required for all Meraki MX64/MX65 devices.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---
>  .../dts/bcm958625-meraki-mx6x-common.dtsi     | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
> 
> diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
> new file mode 100644
> index 000000000000..47a30dedf7b3
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Common Bindings for Cisco Meraki MX64 (Kingpin) and MX65 (Alamo) devices.
> + *
> + * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
> + */
> +
> +#include "bcm-nsp.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x60000000 0x80000000>;
> +	};
> +
> +	pwm-leds {
> +		compatible = "pwm-leds";
> +
> +		red {
> +			label = "red:led";
> +			pwms = <&pwm 1 50000>;
> +		};
> +
> +		green {
> +			label = "green:led";
> +			pwms = <&pwm 2 50000>;
> +		};
> +
> +		blue {
> +			label = "blue:led";
> +			pwms = <&pwm 3 50000>;
> +		};
> +	};
> +};
> +
> +&L2 {
> +	arm,io-coherent;
> +	prefetch-data = <1>;
> +	prefetch-instr = <1>;
> +};

It is common practice to sort labels alphabetically and nodes by unit address.

> +
> +&uart0 {
> +	clock-frequency = <62500000>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	at24@50 {
> +		compatible = "atmel,24c64";
> +		pagesize = <32>;
> +		reg = <0x50>;
> +	};
> +};
> +
> +&amac2 {
> +	status = "okay";
> +};
> +
> +&nand {
> +	nandcs@0 {
> +		compatible = "brcm,nandcs";
> +		reg = <0>;
> +		nand-on-flash-bbt;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		nand-ecc-strength = <24>;
> +		nand-ecc-step-size = <1024>;
> +
> +		brcm,nand-oob-sector-size = <27>;
> +
> +		partition@0 {
> +			label = "u-boot";
> +			reg = <0x0 0x80000>;
> +			read-only;
> +		};
> +
> +		partition@80000 {
> +			label = "shmoo";
> +			reg = <0x80000 0x80000>;
> +			read-only;
> +		};
> +
> +		partition@100000 {
> +			label = "bootkernel1";
> +			reg = <0x100000 0x300000>;
> +		};
> +
> +		partition@400000 {
> +			label = "senao_nvram";
> +			reg = <0x400000 0x100000>;
> +		};
> +
> +		partition@500000 {
> +			label = "bootkernel2";
> +			reg = <0x500000 0x300000>;
> +		};
> +
> +		partition@800000 {
> +			label = "ubi";
> +			reg = <0x800000 0x3f700000>;
> +		};
> +	};
> +};
> +
> +&qspi {
> +	status = "disabled";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&pwm {
> +	status = "okay";
> +	#pwm-cells = <2>;

What is the reason for overriding this to 2?

> +	chan0 {
> +		channel = <1>;
> +		active_low = <1>;
> +		};

Bad indentation for this bracket.

> +	chan1 {
> +		channel = <2>;
> +		active_low = <1>;
> +	};
> +	chan2 {
> +		channel = <3>;
> +		active_low = <1>;
> +	};
> +};
> +
> +&ccbtimer1 {
> +	status = "disabled";
> +};
> +
> +&sata_phy {
> +	status = "disabled";
> +};

It is common practice to disable these in the common SoC dtsi and let
individual boards enable them as necessary, instead of the opposite.

> -- 
> 2.26.3
> 

