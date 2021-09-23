Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DF04163B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbhIWQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:58:05 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44965 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhIWQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:57:58 -0400
Received: by mail-ot1-f45.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso9334251otb.11;
        Thu, 23 Sep 2021 09:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u0vSF2zhWmzDeHFMOpnl/4kxZUI8rXOSct9vbIB6qjw=;
        b=dK2TC/aJZ6iW71wLWtHYFKKf1ATAwhJkCrLZE5PazrVNE/O9Z9BRJnq+dPR7CUcGo5
         zBqbzAdAwX4TvGPa4P6QGZi9+OQ+3ZnUUXD25ENbglNyoDjy1t4Z3+bVnWcXhSreSw1j
         yuVgn0GTHc/SfYQ6BiF7E3C9rnjsMS5BsrVJXUm4nPypVkxhSQxmaZ0bXpZngmvqKymM
         MnaMeuW4DGqze03V7wr7Sxcphnlb1bRbeJ2+8P7BG/Jl9JZfLUGyci9KsJ8ykJnhWquI
         IC2I1CuzoM1o5qRiozDgvW4G9JWxsw4bC/P2oitptcX+Luwl2kayEW1xHzhgNfspqxqu
         ArUQ==
X-Gm-Message-State: AOAM532chvlxcJ6puTuXeS8k0d2yTzw6Jiirkwlh5jcPe0Ti1mywQB0F
        Sh1D0RyfKAD082X2qfq+0g==
X-Google-Smtp-Source: ABdhPJy45eXPbJjkYsqHzQJhRQAOOe9N9xX/SfBtgp8UFfRJplXpTQpsDPN1sx9bPSoGl3cO6Ec9WA==
X-Received: by 2002:a9d:7150:: with SMTP id y16mr5427647otj.145.1632416186429;
        Thu, 23 Sep 2021 09:56:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l19sm1404693otj.77.2021.09.23.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:56:25 -0700 (PDT)
Received: (nullmailer pid 3164589 invoked by uid 1000);
        Thu, 23 Sep 2021 16:56:24 -0000
Date:   Thu, 23 Sep 2021 11:56:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, dinguyen@kernel.org,
        p.zabel@pengutronix.de, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tn@semihalf.com,
        ka@semihalf.com, jam@semihalf.com,
        Joanna Brozek <jbrozek@antmicro.com>,
        Mariusz Glebocki <mglebocki@antmicro.com>,
        Tomasz Gorochowik <tgorochowik@antmicro.com>,
        Maciej Mikunda <mmikunda@antmicro.com>
Subject: Re: [PATCH 2/3] dts: socfpga: Add Mercury+ AA1 devicetree
Message-ID: <YUyxuIVcjS5h+3cT@robh.at.kernel.org>
References: <20210920124141.1166544-1-pan@semihalf.com>
 <20210920124140.u56dOOGofORjfYeTSsKGqD2HNw-7gu5UqvN2ocHwr-g@z>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210920124140.u56dOOGofORjfYeTSsKGqD2HNw-7gu5UqvN2ocHwr-g@z>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:41:40PM +0200, Paweł Anikiel wrote:
> Add support for the Mercury+ AA1 module for Arria 10 SoC FPGA.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> Signed-off-by: Joanna Brozek <jbrozek@antmicro.com>
> Signed-off-by: Mariusz Glebocki <mglebocki@antmicro.com>
> Signed-off-by: Tomasz Gorochowik <tgorochowik@antmicro.com>
> Signed-off-by: Maciej Mikunda <mmikunda@antmicro.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/socfpga_arria10_mercury_aa1.dts  | 127 ++++++++++++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e0934180724..0a7809eb3795 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1078,6 +1078,7 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
>  	socfpga_arria10_socdk_nand.dtb \
>  	socfpga_arria10_socdk_qspi.dtb \
>  	socfpga_arria10_socdk_sdmmc.dtb \
> +	socfpga_arria10_mercury_aa1.dtb \
>  	socfpga_cyclone5_chameleon96.dtb \
>  	socfpga_cyclone5_mcvevk.dtb \
>  	socfpga_cyclone5_socdk.dtb \
> diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
> new file mode 100644
> index 000000000000..c13f16afa72f
> --- /dev/null
> +++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "socfpga_arria10.dtsi"
> +
> +/ {
> +
> +	model = "Enclustra Mercury AA1";
> +	compatible = "altr,socfpga-arria10", "altr,socfpga";
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		serial1 = &uart1;
> +	};
> +
> +	memory {

memory@0

> +		name = "memory";
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>; /* 2GB */
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +};
> +
> +&osc1 {
> +	clock-frequency = <33330000>;
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +/* Following mappings are taken from arria10 socdk dts */
> +&mmc {
> +	status = "okay";
> +	cap-sd-highspeed;
> +	broken-cd;
> +	bus-width = <4>;
> +};
> +
> +&eccmgr {
> +	sdmmca-ecc@ff8c2c00 {
> +		compatible = "altr,socfpga-sdmmc-ecc";
> +		reg = <0xff8c2c00 0x400>;
> +		altr,ecc-parent = <&mmc>;
> +		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
> +			     <47 IRQ_TYPE_LEVEL_HIGH>,
> +			     <16 IRQ_TYPE_LEVEL_HIGH>,
> +			     <48 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +};
> +
> +&gmac0 {
> +	phy-mode = "rgmii";
> +	phy-addr = <0xffffffff>; /* probe for phy addr */
> +
> +	max-frame-size = <3800>;
> +	status = "okay";
> +
> +	phy-handle = <&phy3>;
> +
> +	mdio0 {

'mdio' doesn't work?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy3: ethernet-phy@3 {
> +			txd0-skew-ps = <0>; /* -420ps */
> +			txd1-skew-ps = <0>; /* -420ps */
> +			txd2-skew-ps = <0>; /* -420ps */
> +			txd3-skew-ps = <0>; /* -420ps */
> +			rxd0-skew-ps = <420>; /* 0ps */
> +			rxd1-skew-ps = <420>; /* 0ps */
> +			rxd2-skew-ps = <420>; /* 0ps */
> +			rxd3-skew-ps = <420>; /* 0ps */
> +			txen-skew-ps = <0>; /* -420ps */
> +			txc-skew-ps = <1860>; /* 960ps */
> +			rxdv-skew-ps = <420>; /* 0ps */
> +			rxc-skew-ps = <1680>; /* 780ps */
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	isl12022: isl12022@6f {
> +		status = "okay";
> +		compatible = "isil,isl12022";
> +		reg = <0x6f>;
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "disabled";
> +
> +	flash0: n25q00@0 {

flash@0

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "n25q00";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +		cdns,page-size = <256>;
> +		cdns,block-size = <16>;
> +		m25p,fast-read;
> +		cdns,read-delay = <4>;
> +		cdns,tshsl-ns = <200>;
> +		cdns,tsd2d-ns = <255>;
> +		cdns,tchsh-ns = <20>;
> +		cdns,tslch-ns = <20>;
> +
> +		part0: qspi-boot@0 {

Put these under a 'partitions' node.

> +			label = "Flash 0 Raw Data";
> +			reg = <0x0 0x01340000>;
> +		};
> +		part1: qspi-rootfs@1320000 {
> +			label = "Flash 1 jffs2 Filesystem";
> +			reg = <0x01340000 0x2cc0000>;
> +		};
> +	};
> +};
> -- 
> 2.25.1
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
