Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11344265E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 05:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhKBEZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 00:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhKBEZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 00:25:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C408C061714;
        Mon,  1 Nov 2021 21:22:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w1so17433157edd.10;
        Mon, 01 Nov 2021 21:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wvlsTEh9v6d7t2lqZ3L4fn0Kl7+4KHrTzQoMERiXTg=;
        b=VrxGInNXD0B4oQVm8NkWETycecI5eXLtWhb8kTg8HD4lP84ibgT0vUOVkIwSzT1eEy
         yoxOeUGulCy8lX1byszNOYTqIOIXQSOsXAiJVV/cCAbdRhLjy/CUXp3BSXeALbhODKM/
         UzRDsNG69E6VYV1/whtSuUFkTMrwI1m3CyvQdl719RtpChPfZXX9C2kSfl2UK+Ecqd68
         OCQ+E27sOrMNbd0obOeiSSmdeUVO2oQhLu+1bNHdr+wYRXvc+NBEOw8ApWusvZAzyuHx
         U6mx6hk3xUQNAthJdVZWvuF3Ni3qS5jXAL0E8PJ75+ACrjalFtxdUeEN2SGJ2w7OI3VC
         kfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wvlsTEh9v6d7t2lqZ3L4fn0Kl7+4KHrTzQoMERiXTg=;
        b=FOM2YOXW3T3Rn06i36139QLpdvjbdnj1NbTWr1iGNizRmNmheddshpuzOwcn9ob/vy
         00GCkKt2fFsPkoJrkk4QNQFq3zJj+OsL1BAj8g9ilATMNYmMm8uPRHuQ8ud7LsmY/Q39
         pBNHjd6snnPPR7aYni9n4uM+4Ew4PjoeO57+9vyDhoiEyAcHhkFefdr+SSnGpk/igEFW
         ejD6syW+QCiVPZYEJS/YgEO8aea8Sr8oiqxo4oVGoq6NCFRhIZ1PCMhUqO+tKYdL8kOq
         r+3PSMgb7pdnrSODH2hg9NpXJgOHHR5MjWZM4/C+5TegQPmuskxD/CYaWpA+t9M2H63W
         SpTA==
X-Gm-Message-State: AOAM532xdNUFOZMdfNmrQ4y5EUR/x67KYR+hMWrue56mz4tRGL1yNT5I
        sBlu5HsMxxRZUjEudQaY+bh772FfXCnfLFivqRs=
X-Google-Smtp-Source: ABdhPJz04lDpzZsKg7vUXthp25hdWbyRKaHlNT+vcWzgKd1s76PCi4SjNQat12axJKG6PcfAq/CMGarHTyyNgg2o2BM=
X-Received: by 2002:a17:906:284e:: with SMTP id s14mr41215732ejc.332.1635826952470;
 Mon, 01 Nov 2021 21:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211101222857.6940-1-tomm.merciai@gmail.com> <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
 <20211101225827.GA9208@tom-desktop>
In-Reply-To: <20211101225827.GA9208@tom-desktop>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 1 Nov 2021 23:22:21 -0500
Message-ID: <CAHCN7xLDHCQoA41FJpP3GY+nbFm99zf=tspHSOXkeFogMF22+A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m: add syscon node for display_blk_ctrl
 module regs
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 5:58 PM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
>
> On Mon, Nov 01, 2021 at 11:35:49PM +0100, Ahmad Fatoum wrote:
> > Hello Tommaso,
> >
> > On 01.11.21 23:28, Tommaso Merciai wrote:
> > > Add system controller node for registers of module Display Block Control
> > > (DISPLAY_BLK_CTRL, base address: 0x32e28000).
> > > The DISPLAY_BLK_CTRL module contains general purpose registers (GPRs),
> > > which control varied features of the associated peripherals.
> > > Reference: IMX8MMRM Rev. 3, 11/2020, p 3897
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index 2f632e8ca388..3e496b457e1a 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -961,6 +961,11 @@ aips4: bus@32c00000 {
> > >                     #size-cells = <1>;
> > >                     ranges = <0x32c00000 0x32c00000 0x400000>;
> > >
> > > +                   dispmix_gpr: display-gpr@32e28000 {
> > > +                           compatible = "fsl, imx8mm-iomuxc-gpr", "syscon";
> >
> > Please read vendor patches before submitting them. The space
> > is out-of-place in the compatible and the compatible is wrong:
> > This doesn't look like a i.MX8MM pin controller.
> >
> > Cheers,
> > Ahmad
>
>   Hi Ahmad,
>   Thanks for your review. Do you think this is correct?
>
>   compatible = "fsl,imx8mm-dispmix-gpr", "syscon";
>
>   Let me know.

There was already a driver created for the blk-ctrl stuff and it has a
device tree binding at 32e28000.  It's tied into the power-domain
system, so if you want to enable the csi, dsi, or lcd, etc. you can
just reference the blt-ctrl power domain index, and it enables the
device's gpc power domain and takes the corresponding device out of
reset.

adam
>
>   Thanks,
>   Tommaso
>
> >
> > > +                           reg = <0x32e28000 0x100>;
> > > +                   };
> > > +
> > >                     usbotg1: usb@32e40000 {
> > >                             compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> > >                             reg = <0x32e40000 0x200>;
> > >
> >
> >
> > --
> > Pengutronix e.K.                           |                             |
> > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
