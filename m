Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE7426BA9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbhJHNau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbhJHNap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:30:45 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155DDC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 06:28:50 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r9so10033084ile.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DA1+CK5AzrInIImQDKUxiCJSHUSR5glPj+jHyem+igQ=;
        b=Jqba4r+yRfnJgMJ0NN3g/tWxFKdbjdovXs0ZYh3DS8LPKZGJ34rguH+BlfSnJ2X7oU
         HHa+8DdZ/gRvjGi8LyrNyMGYaGxcVI5MO/bbNbkLHiXBN28/2yQUbicxkLloJpBXxfxv
         KSRT7khBjLYPvRoLfmWS0u0xA7lXRUeAkmjZH/RoBK7X62yEsaMHF1VGuVDFFuObqfp6
         gT0UoqS0ztHfV8XNyehICz+B0Py5teOxDwdylla2nylAa7TEQ7L+luQQ1O+Gfe+pVt7/
         nOqFE8PtAGPqBnQzaMPbgI4tmzqXZ4PiFe90VL8UTmRKc6vbricxhY+MWEWSVL6bLWff
         NGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DA1+CK5AzrInIImQDKUxiCJSHUSR5glPj+jHyem+igQ=;
        b=U439DStsbb9bTKLHaCgqXQN+BerpIseQEy8HoO3LQ9uKU7RIEgFmKt/oG7udkK9XE9
         A962a7NVeiBeAHg1Gk3tW3qH3isSiRMvCHv516bHipvy+N8eW7JAxIy50W9uL6h8D8TO
         IRKSogNe0CJNo7UwOHJZ1+gWWlK+OcedhysFYEOnjDlqo9pMg9Sr62u6wx5wN/PwEtd7
         DveFyPrLlvf+YtZweG/w7Ft5lRyvlqDMKAfaYvWIjxowumEDhGGHrOhCzZoYS4xGO/Gi
         JL2j4UM0giGtDp4+fpgnKBaMaRBKHn9Up33NcVUT92hxbSYW1HF/v5iahHfiNFW0gCZC
         Wd9w==
X-Gm-Message-State: AOAM530GAdIlgMsR4KHNOFzEoO29EvUMepqZbgt+dS6R/+Or8NHBLdnd
        6UYER2lV8TSdLhbWnQmyTtr4B2vZgCcjKCMmuRrd1g==
X-Google-Smtp-Source: ABdhPJyushrootzHis7GiMvYNrvQ/zV/Ag2v8NkIlLOJCIM76Ksh6DO7/N/T3KGwWxmSd+Sw8QYzCkrvPsxCowfMdZw=
X-Received: by 2002:a05:6e02:bc4:: with SMTP id c4mr7751742ilu.129.1633699729302;
 Fri, 08 Oct 2021 06:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211008114343.57920-1-robert.marko@sartura.hr> <20211008120855.46zbo2fl5edwf7ja@pali>
In-Reply-To: <20211008120855.46zbo2fl5edwf7ja@pali>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 8 Oct 2021 15:28:38 +0200
Message-ID: <CA+HBbNGvFtws2GF7RLbznAbXfvjKx4rOJ=eMeuHOJ6s7iANtzw@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: dts: marvell: add Globalscale MOCHAbin
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 2:08 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello! See some notes below.
>
> On Friday 08 October 2021 13:43:43 Robert Marko wrote:
> > Globalscale MOCHAbin is a Armada 7040 based development board.
> >
> > Specifications:
> > * Armada 7040 Quad core ARMv8 Cortex A-72 @ 1.4GHz
> > * 2 / 4 / 8 GB of DDR4 DRAM
> > * 16 GB eMMC
> > * 4MB SPI-NOR (Bootloader)
> > * 1x M.2-2280 B-key socket (for SSD expansion, SATA3 only)
> > * 1x M.2-2250 B-key socket (for modems, USB2.0 and I2C only)
> > * 1x Mini-PCIe 3.0 (x1, USB2.0 and I2C)
> > * 1x SATA 7+15 socket (SATA3)
> > * 1x 16-pin (2=C3=978) MikroBus Connector
> > * 1x SIM card slot (Connected to the mini-PCIe and both M.2 slots)
> > * 2x USB3.0 Type-A ports via SMSC USB5434B hub
> > * Cortex 2x5 JTAG
> > * microUSB port for UART (PL2303GL/PL2303SA onboard)
> > * 1x 10G SFP+
> > * 1x 1G SFP (Connected to 88E1512 PHY)
> > * 1x 1G RJ45 with PoE PD (Connected to 88E1512 PHY)
> > * 4x 1G RJ45 ports via Topaz 88E6141 switch
> > * RTC with battery holder (SoC provided, requires CR2032 battery)
> > * 1x 12V DC IN
> > * 1x Power switch
> > * 1x 12V fan header (3-pin, power only)
> > * 1x mini-PCIe LED header (2x0.1" pins)
> > * 1x M.2-2280 LED header (2x0.1" pins)
> > * 6x Bootstrap jumpers
> > * 1x Power LED (Green)
> > * 3x Tri-color RGB LEDs (Controllable)
> > * 1x Microchip ATECC608B secure element
> >
> > Note that 1G SFP and 1G WAN cannot be used at the same time as they are=
 in
> > parallel connected to the same PHY.
>
> + Marek
>
> Robert, how it works? Is there some detection which source port (SFP or
> WAN) should be activated? And what happens if you plug SFP module and
> also 1G WAN at the same time?

Hi, Pali.
It works due to the Marvell PHY driver adding support for attaching an
SFP recently
specifically for the 88E151x family.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/net/phy/marvell.c?h=3Dv5.15-rc4&id=3Db697d9d38a5a5ab405d7cc4743d39fe=
2c5d7517c

It simply uses the standard SFP driver as the SFP cage is properly
connected to see if a
the compatible module is connected and if so configures the 88E1512 to
SGMII/1000Base-X/100Base-FX modes
and attaches the SFP bus to the upstream ethernet controller so that
you can use ethtool on it.
So if you plug in an SFP module and then copper it will continue using
the SFP module until its removed at which
the time it will reconfigure the PHY back to copper mode.
And if you plug in SFP after copper it will use it again as the
presence status triggers it.

>
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > Changes in v5:
> > * Change LED labels to use the common "color:name" format instead
> >
> > Changes in v4:
> > * Rename the "u-boot" partition to "firmware" which is more appropriate
> > as it a concatenation of mv-ddr + TF-A + U-boot
> >
> > Changes in v3:
> > * Use IRQ_TYPE_LEVEL_LOW instead of IRQ_TYPE_EDGE_FALLING as both the
> > PCA9554 and Topaz switch have an active LOW IRQ signal.
> >
> > Changes in v2:
> > * Use "10gbase-r" instead of "10gbase-kr"
> > ---
> >  arch/arm64/boot/dts/marvell/Makefile          |   1 +
> >  .../boot/dts/marvell/armada-7040-mochabin.dts | 452 ++++++++++++++++++
> >  2 files changed, 453 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dt=
s
> >
> > diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts=
/marvell/Makefile
> > index 34efe0fb6f37..4d3a2ae9adbd 100644
> > --- a/arch/arm64/boot/dts/marvell/Makefile
> > +++ b/arch/arm64/boot/dts/marvell/Makefile
> > @@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-espressobin-v=
7-emmc.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-turris-mox.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-3720-uDPU.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-7040-db.dtb
> > +dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-7040-mochabin.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-8040-clearfog-gt-8k.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-8040-db.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-8040-mcbin.dtb
> > diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arc=
h/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> > new file mode 100644
> > index 000000000000..61f3104a18cf
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> > @@ -0,0 +1,452 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Device Tree file for Globalscale MOCHAbin
> > + * Copyright (C) 2019 Globalscale technologies, Inc.
> > + * Copyright (C) 2021 Sartura Ltd.
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include "armada-7040.dtsi"
> > +
> > +/ {
> > +     model =3D "Globalscale MOCHAbin";
> > +     compatible =3D "globalscale,mochabin", "marvell,armada7040",
> > +                  "marvell,armada-ap806-quad", "marvell,armada-ap806";
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     aliases {
> > +             ethernet0 =3D &cp0_eth0;
> > +             ethernet1 =3D &cp0_eth1;
> > +             ethernet2 =3D &cp0_eth2;
> > +             ethernet3 =3D &swport1;
> > +             ethernet4 =3D &swport2;
> > +             ethernet5 =3D &swport3;
> > +             ethernet6 =3D &swport4;
> > +     };
> > +
> > +     /* SFP+ 10G */
> > +     sfp_eth0: sfp-eth0 {
> > +             compatible =3D "sff,sfp";
> > +             i2c-bus =3D <&cp0_i2c1>;
> > +             los-gpio =3D <&sfp_gpio 3 GPIO_ACTIVE_HIGH>;
> > +             mod-def0-gpio =3D <&sfp_gpio 2 GPIO_ACTIVE_LOW>;
> > +             tx-disable-gpio =3D <&sfp_gpio 1 GPIO_ACTIVE_HIGH>;
> > +             tx-fault-gpio  =3D <&sfp_gpio 0 GPIO_ACTIVE_HIGH>;
> > +     };
> > +
> > +     /* SFP 1G */
> > +     sfp_eth2: sfp-eth2 {
> > +             compatible =3D "sff,sfp";
> > +             i2c-bus =3D <&cp0_i2c0>;
> > +             los-gpio =3D <&sfp_gpio 7 GPIO_ACTIVE_HIGH>;
> > +             mod-def0-gpio =3D <&sfp_gpio 6 GPIO_ACTIVE_LOW>;
> > +             tx-disable-gpio =3D <&sfp_gpio 5 GPIO_ACTIVE_HIGH>;
> > +             tx-fault-gpio  =3D <&sfp_gpio 4 GPIO_ACTIVE_HIGH>;
> > +     };
> > +};
> > +
> > +/* microUSB UART console */
> > +&uart0 {
> > +     status =3D "okay";
> > +
> > +     pinctrl-0 =3D <&uart0_pins>;
> > +     pinctrl-names =3D "default";
> > +};
> > +
> > +/* eMMC */
> > +&ap_sdhci0 {
> > +     status =3D "okay";
> > +
> > +     bus-width =3D <4>;
> > +     non-removable;
> > +     /delete-property/ marvell,xenon-phy-slow-mode;
> > +     no-1-8-v;
> > +};
> > +
> > +&cp0_pinctrl {
> > +     cp0_uart0_pins: cp0-uart0-pins {
> > +             marvell,pins =3D "mpp6", "mpp7";
> > +             marvell,function =3D "uart0";
> > +     };
> > +
> > +     cp0_spi0_pins: cp0-spi0-pins {
> > +             marvell,pins =3D "mpp56", "mpp57", "mpp58", "mpp59";
> > +             marvell,function =3D "spi0";
> > +     };
> > +
> > +     cp0_spi1_pins: cp0-spi1-pins {
> > +             marvell,pins =3D "mpp13", "mpp14", "mpp15", "mpp16";
> > +             marvell,function =3D "spi1";
> > +     };
> > +
> > +     cp0_i2c0_pins: cp0-i2c0-pins {
> > +             marvell,pins =3D "mpp37", "mpp38";
> > +             marvell,function =3D "i2c0";
> > +     };
> > +
> > +     cp0_i2c1_pins: cp0-i2c1-pins {
> > +             marvell,pins =3D "mpp2", "mpp3";
> > +             marvell,function =3D "i2c1";
> > +     };
> > +
> > +     pca9554_int_pins: pca9554-int-pins {
> > +             marvell,pins =3D "mpp27";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     cp0_rgmii1_pins: cp0-rgmii1-pins {
> > +             marvell,pins =3D "mpp44", "mpp45", "mpp46", "mpp47", "mpp=
48", "mpp49",
> > +                            "mpp50", "mpp51", "mpp52", "mpp53", "mpp54=
", "mpp55";
> > +             marvell,function =3D "ge1";
> > +     };
> > +
> > +     is31_sdb_pins: is31-sdb-pins {
> > +             marvell,pins =3D "mpp30";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     cp0_pcie_reset_pins: cp0-pcie-reset-pins {
> > +             marvell,pins =3D "mpp9";
> > +             marvell,function =3D "gpio";
>
> Now I spotted this. Why is PERST# pin configured into gpio mode? Is
> there some issue that this pin in pcie mode is not working properly,
> that PCIe controller cannot handle it correctly? Or something else?

Its because I have seen way too many broken controllers when it comes
to PERST and
other Armada 7k/8k devices are using it in GPIO mode as well.
Just look at the number of conversions back to GPIO for other
platforms as there is always some bug.
>
> > +     };
> > +
> > +     cp0_switch_pins: cp0-switch-pins {
> > +             marvell,pins =3D "mpp0", "mpp1";
> > +             marvell,function =3D "gpio";
> > +     };
> > +
> > +     cp0_phy_pins: cp0-phy-pins {
> > +             marvell,pins =3D "mpp12";
> > +             marvell,function =3D "gpio";
> > +     };
> > +};
> > +
> > +/* mikroBUS UART */
> > +&cp0_uart0 {
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&cp0_uart0_pins>;
> > +};
> > +
> > +/* mikroBUS SPI */
> > +&cp0_spi0 {
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&cp0_spi0_pins>;
> > +};
> > +
> > +/* SPI-NOR */
> > +&cp0_spi1{
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&cp0_spi1_pins>;
> > +
> > +     spi-flash@0 {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             compatible =3D "jedec,spi-nor";
> > +             reg =3D <0>;
> > +             spi-max-frequency =3D <20000000>;
> > +
> > +             partitions {
> > +                     compatible =3D "fixed-partitions";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +
> > +                     partition@0 {
> > +                             label =3D "firmware";
> > +                             reg =3D <0x0 0x3e0000>;
> > +                             read-only;
> > +                     };
> > +
> > +                     partition@3e0000 {
> > +                             label =3D "hw-info";
> > +                             reg =3D <0x3e0000 0x10000>;
> > +                             read-only;
> > +                     };
> > +
> > +                     partition@3f0000 {
> > +                             label =3D "u-boot-env";
> > +                             reg =3D <0x3f0000 0x10000>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +/* mikroBUS, 1G SFP and GPIO expander */
> > +&cp0_i2c0 {
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&cp0_i2c0_pins>;
> > +     clock-frequency =3D <100000>;
> > +
> > +     sfp_gpio: pca9554@39 {
> > +             compatible =3D "nxp,pca9554";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pca9554_int_pins>;
> > +             reg =3D <0x39>;
> > +
> > +             interrupt-parent =3D <&cp0_gpio1>;
> > +             interrupts =3D <27 IRQ_TYPE_LEVEL_LOW>;
> > +             interrupt-controller;
> > +             #interrupt-cells =3D <2>;
> > +
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +
> > +             /*
> > +              * IO0_0: SFP+_TX_FAULT
> > +              * IO0_1: SFP+_TX_DISABLE
> > +              * IO0_2: SFP+_PRSNT
> > +              * IO0_3: SFP+_LOSS
> > +              * IO0_4: SFP_TX_FAULT
> > +              * IO0_5: SFP_TX_DISABLE
> > +              * IO0_6: SFP_PRSNT
> > +              * IO0_7: SFP_LOSS
> > +              */
> > +     };
> > +};
> > +
> > +/* IS31FL3199, mini-PCIe and 10G SFP+ */
> > +&cp0_i2c1 {
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&cp0_i2c1_pins>;
> > +     clock-frequency =3D <100000>;
> > +
> > +     leds@64 {
> > +             compatible =3D "issi,is31fl3199";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&is31_sdb_pins>;
> > +             shutdown-gpios =3D <&cp0_gpio1 30 GPIO_ACTIVE_HIGH>;
> > +             reg =3D <0x64>;
> > +
> > +             led1_red: led@1 {
> > +                     label =3D "red:led1";
> > +                     reg =3D <1>;
> > +                     led-max-microamp =3D <20000>;
> > +             };
> > +
> > +             led1_green: led@2 {
> > +                     label =3D "green:led1";
> > +                     reg =3D <2>;
> > +             };
> > +
> > +             led1_blue: led@3 {
> > +                     label =3D "blue:led1";
> > +                     reg =3D <3>;
> > +             };
> > +
> > +             led2_red: led@4 {
> > +                     label =3D "red:led2";
> > +                     reg =3D <4>;
> > +             };
> > +
> > +             led2_green: led@5 {
> > +                     label =3D "green:led2";
> > +                     reg =3D <5>;
> > +             };
> > +
> > +             led2_blue: led@6 {
> > +                     label =3D "blue:led2";
> > +                     reg =3D <6>;
> > +             };
> > +
> > +             led3_red: led@7 {
> > +                     label =3D "red:led3";
> > +                     reg =3D <7>;
> > +             };
> > +
> > +             led3_green: led@8 {
> > +                     label =3D "green:led3";
> > +                     reg =3D <8>;
> > +             };
> > +
> > +             led3_blue: led@9 {
> > +                     label =3D "blue:led3";
> > +                     reg =3D <9>;
> > +             };
> > +     };
> > +};
> > +
> > +&cp0_mdio {
> > +     status =3D "okay";
> > +
> > +     /* 88E1512 PHY */
> > +     eth2phy: ethernet-phy@1 {
> > +             reg =3D <1>;
> > +             sfp =3D <&sfp_eth2>;
> > +
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&cp0_phy_pins>;
> > +             reset-gpios =3D <&cp0_gpio1 12 GPIO_ACTIVE_LOW>;
> > +     };
> > +
> > +     /* 88E6141 Topaz switch */
> > +     switch: switch@3 {
> > +             compatible =3D "marvell,mv88e6085";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             reg =3D <3>;
> > +
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&cp0_switch_pins>;
> > +             reset-gpios =3D <&cp0_gpio1 0 GPIO_ACTIVE_LOW>;
> > +
> > +             interrupt-parent =3D <&cp0_gpio1>;
> > +             interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             ports {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     swport1: port@1 {
> > +                             reg =3D <1>;
> > +                             label =3D "lan0";
> > +                             phy-handle =3D <&swphy1>;
> > +                     };
> > +
> > +                     swport2: port@2 {
> > +                             reg =3D <2>;
> > +                             label =3D "lan1";
> > +                             phy-handle =3D <&swphy2>;
> > +                     };
> > +
> > +                     swport3: port@3 {
> > +                             reg =3D <3>;
> > +                             label =3D "lan2";
> > +                             phy-handle =3D <&swphy3>;
> > +                     };
> > +
> > +                     swport4: port@4 {
> > +                             reg =3D <4>;
> > +                             label =3D "lan3";
> > +                             phy-handle =3D <&swphy4>;
> > +                     };
> > +
> > +                     port@5 {
> > +                             reg =3D <5>;
> > +                             label =3D "cpu";
> > +                             ethernet =3D <&cp0_eth1>;
> > +                             phy-mode =3D "2500base-x";
> > +                             managed =3D "in-band-status";
> > +                     };
> > +             };
> > +
> > +             mdio {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     swphy1: swphy1@17 {
> > +                             reg =3D <17>;
> > +                     };
> > +
> > +                     swphy2: swphy2@18 {
> > +                             reg =3D <18>;
> > +                     };
> > +
> > +                     swphy3: swphy3@19 {
> > +                             reg =3D <19>;
> > +                     };
> > +
> > +                     swphy4: swphy4@20 {
> > +                             reg =3D <20>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&cp0_ethernet {
> > +     status =3D "okay";
> > +};
> > +
> > +/* 10G SFP+ */
> > +&cp0_eth0 {
> > +     status =3D "okay";
> > +
> > +     phy-mode =3D "10gbase-r";
> > +     phys =3D <&cp0_comphy4 0>;
> > +     managed =3D "in-band-status";
> > +     sfp =3D <&sfp_eth0>;
> > +};
> > +
> > +/* Topaz switch uplink */
> > +&cp0_eth1 {
> > +     status =3D "okay";
> > +
> > +     phy-mode =3D "2500base-x";
> > +     phys =3D <&cp0_comphy0 1>;
> > +
> > +     fixed-link {
> > +             speed =3D <2500>;
> > +             full-duplex;
> > +     };
> > +};
> > +
> > +/* 1G SFP or 1G RJ45 */
> > +&cp0_eth2 {
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&cp0_rgmii1_pins>;
> > +
> > +     phy =3D <&eth2phy>;
> > +     phy-mode =3D "rgmii-id";
> > +};
> > +
> > +&cp0_utmi {
> > +     status =3D "okay";
> > +};
> > +
> > +/* SMSC USB5434B hub */
> > +&cp0_usb3_0 {
> > +     status =3D "okay";
> > +
> > +     phys =3D <&cp0_comphy1 0>, <&cp0_utmi0>;
> > +     phy-names =3D "cp0-usb3h0-comphy", "utmi";
> > +};
> > +
> > +/* miniPCI-E USB */
> > +&cp0_usb3_1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&cp0_sata0 {
> > +     status =3D "okay";
> > +
> > +     /* 7 + 12 SATA connector (J24) */
> > +     sata-port@0 {
> > +             phys =3D <&cp0_comphy2 0>;
> > +             phy-names =3D "cp0-sata0-0-phy";
> > +     };
> > +
> > +     /* M.2-2250 B-key (J39) */
> > +     sata-port@1 {
> > +             phys =3D <&cp0_comphy3 1>;
> > +             phy-names =3D "cp0-sata0-1-phy";
> > +     };
> > +};
> > +
> > +/* miniPCI-E (J5) */
> > +&cp0_pcie2 {
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&cp0_pcie_reset_pins>;
> > +     phys =3D <&cp0_comphy5 2>;
> > +     phy-names =3D "cp0-pcie2-x1-phy";
> > +     reset-gpio =3D <&cp0_gpio1 9 GPIO_ACTIVE_LOW>;
>
> Per snps,dw-pcie.yaml file is 'reset-gpio' property deprecated. There
> is 'reset-gpios' property which should be used according pci.txt file.

Yeah, just saw it now, will update the property.

Regards,
Robert
>
> > +};
> > --
> > 2.33.0
> >



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
