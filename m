Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497E7363352
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 06:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhDREZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 00:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhDREZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 00:25:01 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689BBC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 21:24:32 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l19so22545870ilk.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 21:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Yk7wDR5DVLigW8+aCafiruNBKM5TwcUcMGWu4mLtg0=;
        b=Z5vgfGPS72+uOuBhyoYQHeT77NEAdWuEV0xordn3BP93Px0x/eNLQcy3MyT1cj2GEU
         Tv/7ov+BqLNTktOdzPxaQtTulGp4CozLo/MTZfAHzhDhH4AfsXJetxSgBIawtqE2wD9b
         BRHxqbD2IHFPJPc5WBrFodTGE9Ntvqq5EDy5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Yk7wDR5DVLigW8+aCafiruNBKM5TwcUcMGWu4mLtg0=;
        b=nOrewlhFuXLSNrHDr63welJdTLaWxnKJDmMyYrG4aVa+bPdbsxqTW60DeSLq3E25vF
         A5nphNYQQfINcynX4yQeRW0nzJBZgqxL3ra5QnNzjaTub9rJ2wsueG0VVGRQEYN45jxp
         /J9BETPTShAX8gZ97bYtBPXLyVH3xmAz78k/BcniaeTsYmoBz+BNZLHHLeo3pPvjZZZG
         x9NJzCPn86goJKeAhVl2+VaoMY5e0IiHdKZhYeNs3evghO3lEsOr1F5qBYv/OoA+Ube2
         KXqBHKNRE97ZUm2nKx7fHimx/wJ09prxrS2iBufQ8ZxFM6gd5KtrVVjO6aog8AZETaex
         5RMg==
X-Gm-Message-State: AOAM5311ED8OqxpDOPXdtTEg4E8yd8fjwz7jVsP3smLdjHuvvLf/UpxM
        Lu6S/6SSFfYNsPY+Kg5kgMYxOvUJQPfHq9q+g/NW
X-Google-Smtp-Source: ABdhPJyH4zlvjSkE3YLi25ug0PTDgsPYtVwooLmwW3swhg9mKZ5IckwsYc5Ze10/HQ81xj6KsdE+MlZ4s0YNCwzcQ0c=
X-Received: by 2002:a92:a30f:: with SMTP id a15mr10147998ili.126.1618719870902;
 Sat, 17 Apr 2021 21:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210303200253.1827553-1-atish.patra@wdc.com> <20210303200253.1827553-4-atish.patra@wdc.com>
 <7eb2b954-6b0a-b143-9107-57f4dd90d0cf@ghiti.fr> <CAM4kBBJXguCi7n_Y+inWqh5cp3Vq7UtQZz76Lox34ajNvU+Pwg@mail.gmail.com>
 <CAOnJCUJCqVnBjQYuKPZwLUPVipMbm6nPHwA0roQ6+iXQOToEKA@mail.gmail.com>
In-Reply-To: <CAOnJCUJCqVnBjQYuKPZwLUPVipMbm6nPHwA0roQ6+iXQOToEKA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sat, 17 Apr 2021 21:24:18 -0700
Message-ID: <CAOnJCUJFfnoYdAEEvpvb91z+r3dwJfKo1Ta7=Wg6nFd_j8Vavw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] RISC-V: Initial DTS for Microchip ICICLE board
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Alex Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 8:36 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Mon, Mar 29, 2021 at 10:04 AM Vitaly Wool <vitaly.wool@konsulko.com> w=
rote:
> >
> > On Sat, Mar 27, 2021 at 6:24 PM Alex Ghiti <alex@ghiti.fr> wrote:
> > >
> > > Hi Atish,
> > >
> > > Le 3/3/21 =C3=A0 3:02 PM, Atish Patra a =C3=A9crit :
> > > > Add initial DTS for Microchip ICICLE board having only
> > > > essential devices (clocks, sdhci, ethernet, serial, etc).
> > > > The device tree is based on the U-Boot patch.
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.101=
42-6-padmarao.begari@microchip.com/
> > > >
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >   arch/riscv/boot/dts/Makefile                  |   1 +
> > > >   arch/riscv/boot/dts/microchip/Makefile        |   2 +
> > > >   .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
> > > >   .../boot/dts/microchip/microchip-mpfs.dtsi    | 329 +++++++++++++=
+++++
> > > >   4 files changed, 404 insertions(+)
> > > >   create mode 100644 arch/riscv/boot/dts/microchip/Makefile
> > > >   create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-i=
cicle-kit.dts
> > > >   create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.d=
tsi
> > > >
> > > > diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Mak=
efile
> > > > index 7ffd502e3e7b..fe996b88319e 100644
> > > > --- a/arch/riscv/boot/dts/Makefile
> > > > +++ b/arch/riscv/boot/dts/Makefile
> > > > @@ -1,5 +1,6 @@
> > > >   # SPDX-License-Identifier: GPL-2.0
> > > >   subdir-y +=3D sifive
> > > >   subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) +=3D canaan
> > > > +subdir-y +=3D microchip
> > > >
> > > >   obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> > > > diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/bo=
ot/dts/microchip/Makefile
> > > > new file mode 100644
> > > > index 000000000000..622b12771fd3
> > > > --- /dev/null
> > > > +++ b/arch/riscv/boot/dts/microchip/Makefile
> > > > @@ -0,0 +1,2 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) +=3D microchip-mpfs-icicle-k=
it.dtb
> > >
> > > I'm playing (or trying to...) with XIP_KERNEL and I had to add the
> > > following to have the device tree actually builtin the kernel:
> > >
> > > diff --git a/arch/riscv/boot/dts/microchip/Makefile
> > > b/arch/riscv/boot/dts/microchip/Makefile
> > > index 622b12771fd3..855c1502d912 100644
> > > --- a/arch/riscv/boot/dts/microchip/Makefile
> > > +++ b/arch/riscv/boot/dts/microchip/Makefile
> > > @@ -1,2 +1,3 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) +=3D microchip-mpfs-icicle-ki=
t.dtb
> > > +obj-$(CONFIG_BUILTIN_DTB) +=3D $(addsuffix .o, $(dtb-y))
> > >
> > > Alex
> >
> > Yes, I believe this is necessary for BUILTIN_DTB to work on Polarfire,
> > regardless of whether the kernel is XIP or not.
> >
>
> But there is no usecase for BUILTIN_DTB for polarfire except XIP kernel.
> The bootloaders for polarfire is capable of providing a DTB to kernel.
>
> If XIP kernel is enabled, the following line in
> arch/riscv/boot/dts/Makefile should take care of things
>
(Sorry. The mail was sent by mistake earlier with incomplete response)
Otherwise, we need a similar change for unleashed as well. No ?

>
> > Best regards,
> >    Vitaly
> >
> > > > diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-ki=
t.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> > > > new file mode 100644
> > > > index 000000000000..ec79944065c9
> > > > --- /dev/null
> > > > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> > > > @@ -0,0 +1,72 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/* Copyright (c) 2020 Microchip Technology Inc */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "microchip-mpfs.dtsi"
> > > > +
> > > > +/* Clock frequency (in Hz) of the rtcclk */
> > > > +#define RTCCLK_FREQ          1000000
> > > > +
> > > > +/ {
> > > > +     #address-cells =3D <2>;
> > > > +     #size-cells =3D <2>;
> > > > +     model =3D "Microchip PolarFire-SoC Icicle Kit";
> > > > +     compatible =3D "microchip,mpfs-icicle-kit";
> > > > +
> > > > +     chosen {
> > > > +             stdout-path =3D &serial0;
> > > > +     };
> > > > +
> > > > +     cpus {
> > > > +             timebase-frequency =3D <RTCCLK_FREQ>;
> > > > +     };
> > > > +
> > > > +     memory@80000000 {
> > > > +             device_type =3D "memory";
> > > > +             reg =3D <0x0 0x80000000 0x0 0x40000000>;
> > > > +             clocks =3D <&clkcfg 26>;
> > > > +     };
> > > > +
> > > > +     soc {
> > > > +     };
> > > > +};
> > > > +
> > > > +&serial0 {
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&serial1 {
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&serial2 {
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&serial3 {
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&sdcard {
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&emac0 {
> > > > +     phy-mode =3D "sgmii";
> > > > +     phy-handle =3D <&phy0>;
> > > > +     phy0: ethernet-phy@8 {
> > > > +             reg =3D <8>;
> > > > +             ti,fifo-depth =3D <0x01>;
> > > > +     };
> > > > +};
> > > > +
> > > > +&emac1 {
> > > > +     status =3D "okay";
> > > > +     phy-mode =3D "sgmii";
> > > > +     phy-handle =3D <&phy1>;
> > > > +     phy1: ethernet-phy@9 {
> > > > +             reg =3D <9>;
> > > > +             ti,fifo-depth =3D <0x01>;
> > > > +     };
> > > > +};
> > > > diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/ar=
ch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > > > new file mode 100644
> > > > index 000000000000..b9819570a7d1
> > > > --- /dev/null
> > > > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> > > > @@ -0,0 +1,329 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/* Copyright (c) 2020 Microchip Technology Inc */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +/ {
> > > > +     #address-cells =3D <2>;
> > > > +     #size-cells =3D <2>;
> > > > +     model =3D "Microchip MPFS Icicle Kit";
> > > > +     compatible =3D "microchip,mpfs-icicle-kit";
> > > > +
> > > > +     chosen {
> > > > +     };
> > > > +
> > > > +     cpus {
> > > > +             #address-cells =3D <1>;
> > > > +             #size-cells =3D <0>;
> > > > +
> > > > +             cpu@0 {
> > > > +                     clock-frequency =3D <0>;
> > > > +                     compatible =3D "sifive,e51", "sifive,rocket0"=
, "riscv";
> > > > +                     device_type =3D "cpu";
> > > > +                     i-cache-block-size =3D <64>;
> > > > +                     i-cache-sets =3D <128>;
> > > > +                     i-cache-size =3D <16384>;
> > > > +                     reg =3D <0>;
> > > > +                     riscv,isa =3D "rv64imac";
> > > > +                     status =3D "disabled";
> > > > +
> > > > +                     cpu0_intc: interrupt-controller {
> > > > +                             #interrupt-cells =3D <1>;
> > > > +                             compatible =3D "riscv,cpu-intc";
> > > > +                             interrupt-controller;
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             cpu@1 {
> > > > +                     clock-frequency =3D <0>;
> > > > +                     compatible =3D "sifive,u54-mc", "sifive,rocke=
t0", "riscv";
> > > > +                     d-cache-block-size =3D <64>;
> > > > +                     d-cache-sets =3D <64>;
> > > > +                     d-cache-size =3D <32768>;
> > > > +                     d-tlb-sets =3D <1>;
> > > > +                     d-tlb-size =3D <32>;
> > > > +                     device_type =3D "cpu";
> > > > +                     i-cache-block-size =3D <64>;
> > > > +                     i-cache-sets =3D <64>;
> > > > +                     i-cache-size =3D <32768>;
> > > > +                     i-tlb-sets =3D <1>;
> > > > +                     i-tlb-size =3D <32>;
> > > > +                     mmu-type =3D "riscv,sv39";
> > > > +                     reg =3D <1>;
> > > > +                     riscv,isa =3D "rv64imafdc";
> > > > +                     tlb-split;
> > > > +                     status =3D "okay";
> > > > +
> > > > +                     cpu1_intc: interrupt-controller {
> > > > +                             #interrupt-cells =3D <1>;
> > > > +                             compatible =3D "riscv,cpu-intc";
> > > > +                             interrupt-controller;
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             cpu@2 {
> > > > +                     clock-frequency =3D <0>;
> > > > +                     compatible =3D "sifive,u54-mc", "sifive,rocke=
t0", "riscv";
> > > > +                     d-cache-block-size =3D <64>;
> > > > +                     d-cache-sets =3D <64>;
> > > > +                     d-cache-size =3D <32768>;
> > > > +                     d-tlb-sets =3D <1>;
> > > > +                     d-tlb-size =3D <32>;
> > > > +                     device_type =3D "cpu";
> > > > +                     i-cache-block-size =3D <64>;
> > > > +                     i-cache-sets =3D <64>;
> > > > +                     i-cache-size =3D <32768>;
> > > > +                     i-tlb-sets =3D <1>;
> > > > +                     i-tlb-size =3D <32>;
> > > > +                     mmu-type =3D "riscv,sv39";
> > > > +                     reg =3D <2>;
> > > > +                     riscv,isa =3D "rv64imafdc";
> > > > +                     tlb-split;
> > > > +                     status =3D "okay";
> > > > +
> > > > +                     cpu2_intc: interrupt-controller {
> > > > +                             #interrupt-cells =3D <1>;
> > > > +                             compatible =3D "riscv,cpu-intc";
> > > > +                             interrupt-controller;
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             cpu@3 {
> > > > +                     clock-frequency =3D <0>;
> > > > +                     compatible =3D "sifive,u54-mc", "sifive,rocke=
t0", "riscv";
> > > > +                     d-cache-block-size =3D <64>;
> > > > +                     d-cache-sets =3D <64>;
> > > > +                     d-cache-size =3D <32768>;
> > > > +                     d-tlb-sets =3D <1>;
> > > > +                     d-tlb-size =3D <32>;
> > > > +                     device_type =3D "cpu";
> > > > +                     i-cache-block-size =3D <64>;
> > > > +                     i-cache-sets =3D <64>;
> > > > +                     i-cache-size =3D <32768>;
> > > > +                     i-tlb-sets =3D <1>;
> > > > +                     i-tlb-size =3D <32>;
> > > > +                     mmu-type =3D "riscv,sv39";
> > > > +                     reg =3D <3>;
> > > > +                     riscv,isa =3D "rv64imafdc";
> > > > +                     tlb-split;
> > > > +                     status =3D "okay";
> > > > +
> > > > +                     cpu3_intc: interrupt-controller {
> > > > +                             #interrupt-cells =3D <1>;
> > > > +                             compatible =3D "riscv,cpu-intc";
> > > > +                             interrupt-controller;
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             cpu@4 {
> > > > +                     clock-frequency =3D <0>;
> > > > +                     compatible =3D "sifive,u54-mc", "sifive,rocke=
t0", "riscv";
> > > > +                     d-cache-block-size =3D <64>;
> > > > +                     d-cache-sets =3D <64>;
> > > > +                     d-cache-size =3D <32768>;
> > > > +                     d-tlb-sets =3D <1>;
> > > > +                     d-tlb-size =3D <32>;
> > > > +                     device_type =3D "cpu";
> > > > +                     i-cache-block-size =3D <64>;
> > > > +                     i-cache-sets =3D <64>;
> > > > +                     i-cache-size =3D <32768>;
> > > > +                     i-tlb-sets =3D <1>;
> > > > +                     i-tlb-size =3D <32>;
> > > > +                     mmu-type =3D "riscv,sv39";
> > > > +                     reg =3D <4>;
> > > > +                     riscv,isa =3D "rv64imafdc";
> > > > +                     tlb-split;
> > > > +                     status =3D "okay";
> > > > +                     cpu4_intc: interrupt-controller {
> > > > +                             #interrupt-cells =3D <1>;
> > > > +                             compatible =3D "riscv,cpu-intc";
> > > > +                             interrupt-controller;
> > > > +                     };
> > > > +             };
> > > > +     };
> > > > +
> > > > +     soc {
> > > > +             #address-cells =3D <2>;
> > > > +             #size-cells =3D <2>;
> > > > +             compatible =3D "simple-bus";
> > > > +             ranges;
> > > > +
> > > > +             cache-controller@2010000 {
> > > > +                     compatible =3D "sifive,fu540-c000-ccache", "c=
ache";
> > > > +                     cache-block-size =3D <64>;
> > > > +                     cache-level =3D <2>;
> > > > +                     cache-sets =3D <1024>;
> > > > +                     cache-size =3D <2097152>;
> > > > +                     cache-unified;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <1 2 3>;
> > > > +                     reg =3D <0x0 0x2010000 0x0 0x1000>;
> > > > +             };
> > > > +
> > > > +             clint@2000000 {
> > > > +                     compatible =3D "sifive,clint0";
> > > > +                     reg =3D <0x0 0x2000000 0x0 0xC000>;
> > > > +                     interrupts-extended =3D <&cpu0_intc 3 &cpu0_i=
ntc 7
> > > > +                                             &cpu1_intc 3 &cpu1_in=
tc 7
> > > > +                                             &cpu2_intc 3 &cpu2_in=
tc 7
> > > > +                                             &cpu3_intc 3 &cpu3_in=
tc 7
> > > > +                                             &cpu4_intc 3 &cpu4_in=
tc 7>;
> > > > +             };
> > > > +
> > > > +             plic: interrupt-controller@c000000 {
> > > > +                     #interrupt-cells =3D <1>;
> > > > +                     compatible =3D "sifive,plic-1.0.0";
> > > > +                     reg =3D <0x0 0xc000000 0x0 0x4000000>;
> > > > +                     riscv,ndev =3D <186>;
> > > > +                     interrupt-controller;
> > > > +                     interrupts-extended =3D <&cpu0_intc 11
> > > > +                                     &cpu1_intc 11 &cpu1_intc 9
> > > > +                                     &cpu2_intc 11 &cpu2_intc 9
> > > > +                                     &cpu3_intc 11 &cpu3_intc 9
> > > > +                                     &cpu4_intc 11 &cpu4_intc 9>;
> > > > +             };
> > > > +
> > > > +             dma@3000000 {
> > > > +                     compatible =3D "sifive,fu540-c000-pdma";
> > > > +                     reg =3D <0x0 0x3000000 0x0 0x8000>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <23 24 25 26 27 28 29 30>;
> > > > +                     #dma-cells =3D <1>;
> > > > +             };
> > > > +
> > > > +             refclk: refclk {
> > > > +                     compatible =3D "fixed-clock";
> > > > +                     #clock-cells =3D <0>;
> > > > +                     clock-frequency =3D <600000000>;
> > > > +                     clock-output-names =3D "msspllclk";
> > > > +             };
> > > > +
> > > > +             clkcfg: clkcfg@20002000 {
> > > > +                     compatible =3D "microchip,mpfs-clkcfg";
> > > > +                     reg =3D <0x0 0x20002000 0x0 0x1000>;
> > > > +                     reg-names =3D "mss_sysreg";
> > > > +                     clocks =3D <&refclk>;
> > > > +                     #clock-cells =3D <1>;
> > > > +                     clock-output-names =3D "cpu", "axi", "ahb", "=
envm",       /* 0-3   */
> > > > +                              "mac0", "mac1", "mmc", "timer",     =
           /* 4-7   */
> > > > +                             "mmuart0", "mmuart1", "mmuart2", "mmu=
art3",     /* 8-11  */
> > > > +                             "mmuart4", "spi0", "spi1", "i2c0",   =
           /* 12-15 */
> > > > +                             "i2c1", "can0", "can1", "usb",       =
           /* 16-19 */
> > > > +                             "rsvd", "rtc", "qspi", "gpio0",      =
           /* 20-23 */
> > > > +                             "gpio1", "gpio2", "ddrc", "fic0",    =
           /* 24-27 */
> > > > +                             "fic1", "fic2", "fic3", "athena", "cf=
m";        /* 28-32 */
> > > > +             };
> > > > +
> > > > +             serial0: serial@20000000 {
> > > > +                     compatible =3D "ns16550a";
> > > > +                     reg =3D <0x0 0x20000000 0x0 0x400>;
> > > > +                     reg-io-width =3D <4>;
> > > > +                     reg-shift =3D <2>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <90>;
> > > > +                     current-speed =3D <115200>;
> > > > +                     clocks =3D <&clkcfg 8>;
> > > > +                     status =3D "disabled";
> > > > +             };
> > > > +
> > > > +             serial1: serial@20100000 {
> > > > +                     compatible =3D "ns16550a";
> > > > +                     reg =3D <0x0 0x20100000 0x0 0x400>;
> > > > +                     reg-io-width =3D <4>;
> > > > +                     reg-shift =3D <2>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <91>;
> > > > +                     current-speed =3D <115200>;
> > > > +                     clocks =3D <&clkcfg 9>;
> > > > +                     status =3D "disabled";
> > > > +             };
> > > > +
> > > > +             serial2: serial@20102000 {
> > > > +                     compatible =3D "ns16550a";
> > > > +                     reg =3D <0x0 0x20102000 0x0 0x400>;
> > > > +                     reg-io-width =3D <4>;
> > > > +                     reg-shift =3D <2>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <92>;
> > > > +                     current-speed =3D <115200>;
> > > > +                     clocks =3D <&clkcfg 10>;
> > > > +                     status =3D "disabled";
> > > > +             };
> > > > +
> > > > +             serial3: serial@20104000 {
> > > > +                     compatible =3D "ns16550a";
> > > > +                     reg =3D <0x0 0x20104000 0x0 0x400>;
> > > > +                     reg-io-width =3D <4>;
> > > > +                     reg-shift =3D <2>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <93>;
> > > > +                     current-speed =3D <115200>;
> > > > +                     clocks =3D <&clkcfg 11>;
> > > > +                     status =3D "disabled";
> > > > +             };
> > > > +
> > > > +             emmc: mmc@20008000 {
> > > > +                     compatible =3D "cdns,sd4hc";
> > > > +                     reg =3D <0x0 0x20008000 0x0 0x1000>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <88 89>;
> > > > +                     pinctrl-names =3D "default";
> > > > +                     clocks =3D <&clkcfg 6>;
> > > > +                     bus-width =3D <4>;
> > > > +                     cap-mmc-highspeed;
> > > > +                     mmc-ddr-3_3v;
> > > > +                     max-frequency =3D <200000000>;
> > > > +                     non-removable;
> > > > +                     no-sd;
> > > > +                     no-sdio;
> > > > +                     voltage-ranges =3D <3300 3300>;
> > > > +                     status =3D "disabled";
> > > > +             };
> > > > +
> > > > +             sdcard: sdhc@20008000 {
> > > > +                     compatible =3D "cdns,sd4hc";
> > > > +                     reg =3D <0x0 0x20008000 0x0 0x1000>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <88>;
> > > > +                     pinctrl-names =3D "default";
> > > > +                     clocks =3D <&clkcfg 6>;
> > > > +                     bus-width =3D <4>;
> > > > +                     disable-wp;
> > > > +                     cap-sd-highspeed;
> > > > +                     card-detect-delay =3D <200>;
> > > > +                     sd-uhs-sdr12;
> > > > +                     sd-uhs-sdr25;
> > > > +                     sd-uhs-sdr50;
> > > > +                     sd-uhs-sdr104;
> > > > +                     max-frequency =3D <200000000>;
> > > > +                     status =3D "disabled";
> > > > +             };
> > > > +
> > > > +             emac0: ethernet@20110000 {
> > > > +                     compatible =3D "cdns,macb";
> > > > +                     reg =3D <0x0 0x20110000 0x0 0x2000>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <64 65 66 67>;
> > > > +                     local-mac-address =3D [00 00 00 00 00 00];
> > > > +                     clocks =3D <&clkcfg 4>, <&clkcfg 2>;
> > > > +                     clock-names =3D "pclk", "hclk";
> > > > +                     status =3D "disabled";
> > > > +                     #address-cells =3D <1>;
> > > > +                     #size-cells =3D <0>;
> > > > +             };
> > > > +
> > > > +             emac1: ethernet@20112000 {
> > > > +                     compatible =3D "cdns,macb";
> > > > +                     reg =3D <0x0 0x20112000 0x0 0x2000>;
> > > > +                     interrupt-parent =3D <&plic>;
> > > > +                     interrupts =3D <70 71 72 73>;
> > > > +                     mac-address =3D [00 00 00 00 00 00];
> > > > +                     clocks =3D <&clkcfg 5>, <&clkcfg 2>;
> > > > +                     status =3D "disabled";
> > > > +                     clock-names =3D "pclk", "hclk";
> > > > +                     #address-cells =3D <1>;
> > > > +                     #size-cells =3D <0>;
> > > > +             };
> > > > +
> > > > +     };
> > > > +};
> > > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish



--=20
Regards,
Atish
