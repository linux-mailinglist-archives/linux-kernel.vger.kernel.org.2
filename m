Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7163E0C24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbhHEBh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhHEBhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:37:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19374C061765;
        Wed,  4 Aug 2021 18:37:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a12so2822594qtb.2;
        Wed, 04 Aug 2021 18:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrUoo33QzEJCzngHbzWb8s99OZ12IEF2BT6Mt/7njNs=;
        b=AZMTagmVx5eejByIyQys2K/49jkyGBhQzkLw/QFB6IgxGy60S7upUAzkbgW6FEtYKy
         Cyq/Qlkpswvq++QE9aqwpXfmhBWkHDE+BpH5YudP4jfe2LGZYxC0LCLWoKuNCmF6nndn
         +vf2lReDlCNnTQXnKBSbpRbbP974F1vDQwCaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrUoo33QzEJCzngHbzWb8s99OZ12IEF2BT6Mt/7njNs=;
        b=AOMqkbbmoVzWZ2nTVLkXOFveLq7rd/2KZCR+2RIz45KMUzpLouqgWrPP/GqBdawmU7
         c6Fphd6dM9OP22i9mTj5ISjt2lHJ5UNEtA8moJnjDjoj7sae4N0yoZ/4/JueBe4EL+Rw
         bU4TXgJ1zAJTtye8hCVscNtzCLMXBK0GRJ2L2JFBBiH70yZA0utP6zS5fhNiAf7x0tel
         PN6zK7e/4awNDicHLERcIO7bAoNYcqx3eJjkUQt9EdNpt6QCtYDnQcvKCajpcWewoYg1
         Ck2WxV66J5KAOtdp1tsqxd7O1YuYwBiPolsH03BWUbxhErdFH++vVMR35PJAK+/PZMU+
         wqgQ==
X-Gm-Message-State: AOAM53379HjKtmZ86zxIOXpDYUSoxl3SWQkcjepBnLSnQV1ID/En8Af+
        svC3p+maGvASq58m1YnhPUUHRgGhbjPGaaulxZ0=
X-Google-Smtp-Source: ABdhPJzkNflBi0/hcQs0RygNLaYq4Ikw4O/RVE49w7ODSfujoVNMCs0z8N9Deen1yHKjIc+T8utXCWILRUPuESZlWKo=
X-Received: by 2002:ac8:7454:: with SMTP id h20mr1967482qtr.263.1628127461174;
 Wed, 04 Aug 2021 18:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210728233755.17963-1-rentao.bupt@gmail.com> <20210728233755.17963-7-rentao.bupt@gmail.com>
 <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com> <20210805011951.GA28444@taoren-ubuntu-R90MNF91>
In-Reply-To: <20210805011951.GA28444@taoren-ubuntu-R90MNF91>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 5 Aug 2021 01:37:29 +0000
Message-ID: <CACPK8XcwsOa5NzsUZeiv5qdWV5H6HBa7WK+cwbnqayP4zhoNkg@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 at 01:20, Tao Ren <rentao.bupt@gmail.com> wrote:
>
> On Thu, Aug 05, 2021 at 12:28:02AM +0000, Joel Stanley wrote:
> > On Wed, 28 Jul 2021 at 23:38, <rentao.bupt@gmail.com> wrote:
> > >
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > >
> > > Add initial version of device tree for Facebook Fuji (AST2600) BMC.
> >
> > I like to read what kind of platform the BMC is going into if you can
> > add that detail, but it's not essential.
>
> Sure. I will add more details in v2.
>
> > > +&spi1 {
> > > +       status = "okay";
> > > +
> > > +       /*
> > > +        * Customize spi1 flash memory size to 32MB (maximum flash size on
> > > +        * the bus) to save vmalloc space.
> > > +        */
> > > +       reg = < 0x1e630000 0xc4
> > > +               0x30000000 0x2000000 >;
> >
> > Which driver supports this?
> >
> > It would be great to see Facebook work to get the SPI NOR driver for
> > the ast2600 merged to mainline.
> >
> > I doubt the IBM team will get to this, as we are using eMMC instead.
>
> Ah, I just checked aspeed-g6.dtsi (ast2600-spi) in mainline and I thought
> the driver patches were also upstreamed. Let me remove the entry for now,
> and will add it back when the driver is ready.

If it helps you, I don't mind it staying in your dts. I would like to
see some effort on the driver though.

>
> >
> > > +
> > > +       flash@0 {
> > > +               status = "okay";
> > > +               m25p,fast-read;
> > > +               label = "spi1.0";
> > > +               spi-max-frequency = <5000000>;
> > > +
> > > +               partitions {
> > > +                       compatible = "fixed-partitions";
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <1>;
> > > +
> > > +                       flash1@0 {
> > > +                               reg = <0x0 0x2000000>;
> > > +                               label = "system-flash";
> > > +                       };
> > > +               };
> > > +       };
> > > +};
> >
> > > +&ehci1 {
> > > +       status = "okay";
> > > +};
> >
> > Have you verified that USB works with mainline? I've had reports of it
> > working on 5.8 but it seems to have regressed as of v5.10.
>
> It stopped working on ASPEED since commit 280a9045bb18 ("ehci: fix EHCI
> host controller initialization sequence"): ehci_handshake() returns
> error because HCHalted bit EHCI24[12] stays at 1.
>
> I have a dirty hack in my tree (ignoring the halt bit) and it "works" on
> AST2500 and AST2600. Let me send an email to openbmc and aspeed email
> groups to see if anyone has more context.

We discovered the same, except in my testing it wasn't actually
"working" on my EVB. I have a A3 EVB on my desk and when plugging in a
USB key nothing happened.

>
> Meanwhile, should I delete the entry until the fix is ready in driver?

Again, leave it in I think.

>
> > > +&mdio1 {
> > > +       status = "okay";
> > > +
> > > +       ethphy3: ethernet-phy@13 {
> > > +               compatible = "ethernet-phy-ieee802.3-c22";
> > > +               reg = <0x0d>;
> > > +       };
> > > +};
> > > +
> > > +&mac3 {
> > > +       phy-handle = <&ethphy3>;
> >
> > status = okay?
> >
> > You should specify the pinmux too I think, even if the default happens
> > to work, so that other devices cannot claim the pins.
>
> status is set in ast2600 common dtsi, but let me set it here to avoid
> confusion. Will update pinmux in v2. Thanks.

Are you looking at mainline? I think it's disabled by default there:

https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/aspeed-g6.dtsi#L246

>
> >
> > Cheers,
> >
> > Joel
>
> Cheers,
>
> Tao
