Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11C53323B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhCILN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:13:57 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:40418 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhCILNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:13:33 -0500
X-Greylist: delayed 998 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 06:13:32 EST
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.18])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lJa2g-00066w-9p; Tue, 09 Mar 2021 10:56:46 +0000
Subject: Re: [PATCH v4 3/5] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
References: <20210303200253.1827553-1-atish.patra@wdc.com>
 <20210303200253.1827553-4-atish.patra@wdc.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <e97e6dd6-fcb5-fac1-41e2-534f524bf5d2@codethink.co.uk>
Date:   Tue, 9 Mar 2021 10:56:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303200253.1827553-4-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 20:02, Atish Patra wrote:
> Add initial DTS for Microchip ICICLE board having only
> essential devices (clocks, sdhci, ethernet, serial, etc).
> The device tree is based on the U-Boot patch.
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.10142-6-padmarao.begari@microchip.com/
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>   arch/riscv/boot/dts/Makefile                  |   1 +
>   arch/riscv/boot/dts/microchip/Makefile        |   2 +
>   .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
>   .../boot/dts/microchip/microchip-mpfs.dtsi    | 329 ++++++++++++++++++
>   4 files changed, 404 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>   create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>   create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index 7ffd502e3e7b..fe996b88319e 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   subdir-y += sifive
>   subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
> +subdir-y += microchip
>   
>   obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> new file mode 100644
> index 000000000000..622b12771fd3
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> new file mode 100644
> index 000000000000..ec79944065c9
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +#include "microchip-mpfs.dtsi"
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define RTCCLK_FREQ		1000000
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "Microchip PolarFire-SoC Icicle Kit";
> +	compatible = "microchip,mpfs-icicle-kit";
> +
> +	chosen {
> +		stdout-path = &serial0;
> +	};
> +
> +	cpus {
> +		timebase-frequency = <RTCCLK_FREQ>;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x40000000>;
> +		clocks = <&clkcfg 26>;
> +	};
> +

The latest Microchip releases have two memory nodes to provide the
full 2GiB of memory space.

> +	soc {
> +	};
> +};
> +
> +&serial0 {
> +	status = "okay";
> +};
> +
> +&serial1 {
> +	status = "okay";
> +};
> +
> +&serial2 {
> +	status = "okay";
> +};
> +
> +&serial3 {
> +	status = "okay";
> +};
> +
> +&sdcard {
> +	status = "okay";
> +};
> +
> +&emac0 {
> +	phy-mode = "sgmii";
> +	phy-handle = <&phy0>;
> +	phy0: ethernet-phy@8 {
> +		reg = <8>;
> +		ti,fifo-depth = <0x01>;
> +	};
> +};
> +
> +&emac1 {
> +	status = "okay";
> +	phy-mode = "sgmii";
> +	phy-handle = <&phy1>;
> +	phy1: ethernet-phy@9 {
> +		reg = <9>;
> +		ti,fifo-depth = <0x01>;
> +	};
> +};



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
