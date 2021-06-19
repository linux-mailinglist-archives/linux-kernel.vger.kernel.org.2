Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532CA3ADBF4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhFSWNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 18:13:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51582 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFSWNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 18:13:33 -0400
Received: from p508fcd5b.dip0.t-ipconnect.de ([80.143.205.91] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lujBJ-0000aH-CD; Sun, 20 Jun 2021 00:11:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Tianling Shen <cnsztl@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Chen-Yu Tsai <wens@csie.org>, Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
Date:   Sun, 20 Jun 2021 00:11:12 +0200
Message-ID: <4448985.BddDVKsqQX@phil>
In-Reply-To: <20210610091357.6780-1-cnsztl@gmail.com>
References: <20210610091357.6780-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 10. Juni 2021, 11:13:57 CEST schrieb Tianling Shen:
> NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
> stores the MAC address.
> 
> Changes in v2:
> - Added the size of EEPROM
> - Added `mac-address` cell to pass the MAC address to kernel
> - Removed `read-only` property in EEPROM node
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>

this produces errors when building the dtb:
  DTC     arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dtb
../arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts:84.4-22: Warning (reg_format): /i2c@ff120000/eeprom@51/mac-address@fa:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
../arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts:83.31-85.5: Warning (avoid_default_addr_size): /i2c@ff120000/eeprom@51/mac-address@fa: Relying on default #address-cells value
../arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts:83.31-85.5: Warning (avoid_default_addr_size): /i2c@ff120000/eeprom@51/mac-address@fa: Relying on default #size-cells value

in the eeprom node you'll need to define #address-cells and #size-cells
for this to work.

Thanks
Heiko


> ---
>  .../boot/dts/rockchip/rk3399-nanopi-r4s.dts    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> index cef4d18b599d..50d3b11eb925 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> @@ -68,6 +68,24 @@
>  	status = "disabled";
>  };
>  
> +&gmac {
> +	nvmem-cells = <&mac_address>;
> +	nvmem-cells-names = "mac-address";
> +};
> +
> +&i2c2 {
> +	eeprom@51 {
> +		compatible = "microchip,24c02", "atmel,24c02";
> +		reg = <0x51>;
> +		pagesize = <16>;
> +		size = <256>;
> +
> +		mac_address: mac-address@fa {
> +			reg = <0xfa 0x06>;
> +		};
> +	};
> +};
> +
>  &i2c4 {
>  	status = "disabled";
>  };
> 




