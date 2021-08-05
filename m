Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC60C3E0C52
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhHECKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhHECKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:10:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D2C061765;
        Wed,  4 Aug 2021 19:09:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so11743474pjb.3;
        Wed, 04 Aug 2021 19:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cwuq2KjV5PT9ZJMXdePEjRCatXRYF+kDCB8wvMO+fn0=;
        b=gbxJaA7XOAhLlxfezEgRXPviamNE+pDtYHJgokLsRio1ffkZgpLGC/k5m/3IU3m/Ed
         H+HLg7odROgTrh0FHMu1TiqZk8MRW8hSbXzGCUEYiCDhpa4ONExdHFQ9kX8kcaqN7Yg8
         m7nzs0LfhCEY88AEcyAPSkqeMugQTdXiXxduBCYTAZinSwQMwz2yynNPZOxJbi9AsDDA
         8SCMJj3k/0gBQS0S09Gc00KRHLeAXsIRJWnsEDkx7HvJksUDhxK7lDr1wOnrIk3qshY2
         MfLZw59IOhN6AJKTxVixu//fYNODZ9xfOUUMpCqVqvU5ZV+IfST6zjRujaDy75NctJnd
         msnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cwuq2KjV5PT9ZJMXdePEjRCatXRYF+kDCB8wvMO+fn0=;
        b=EUIufoDyrMERKvBC7zA6ZLobiLqajf3SCHw6YZYMHwNuplqML9bUuiKvF2JB51ouEH
         5wkK8XHMgE+0UebWiTjr8uGPA1ALEta8p6ztcKQxOsB0XqWUkurqM4mqSyeROhNsAQrZ
         QakyKNaJFaxlAntJ/praPIRIETQGu3yjiZ01wMCuqrMAccXFFxfhehrj7B0TQnIarVq7
         1omUCm3MdM7ApB/E0FhWMX5BGn6RJzB37ZeltJXtcSN7dvErJXn7ilJLGJvDUOGoyORG
         OjTfskjGEfu8kBPvL+jmKmX22TlVbc3POQ6aer/nVlBbFTq7yV0diW9MBV+v+YSJvb5A
         mKkw==
X-Gm-Message-State: AOAM530N1/teUB1vAZBDaUN4Wt4rTsRhQFVAZMO+mwSmlsjHO6m9YYL0
        OPAJQtWeJWr0kfoW1c3qUPs=
X-Google-Smtp-Source: ABdhPJxs/lH462HevDdQYzdAuskPQJACBS+taPHcjQaHrNLfbXS9sBF86pf7I2q+GX4JSgto84yy7Q==
X-Received: by 2002:a62:36c5:0:b029:32b:83fa:3a3e with SMTP id d188-20020a6236c50000b029032b83fa3a3emr2426065pfa.52.1628129393615;
        Wed, 04 Aug 2021 19:09:53 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id a20sm7375508pjh.46.2021.08.04.19.09.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Aug 2021 19:09:53 -0700 (PDT)
Date:   Wed, 4 Aug 2021 19:09:46 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH 6/6] ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC
Message-ID: <20210805020946.GA29371@taoren-ubuntu-R90MNF91>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
 <20210728233755.17963-7-rentao.bupt@gmail.com>
 <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
 <20210805011951.GA28444@taoren-ubuntu-R90MNF91>
 <CACPK8XcwsOa5NzsUZeiv5qdWV5H6HBa7WK+cwbnqayP4zhoNkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcwsOa5NzsUZeiv5qdWV5H6HBa7WK+cwbnqayP4zhoNkg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 01:37:29AM +0000, Joel Stanley wrote:
> On Thu, 5 Aug 2021 at 01:20, Tao Ren <rentao.bupt@gmail.com> wrote:
> >
> > On Thu, Aug 05, 2021 at 12:28:02AM +0000, Joel Stanley wrote:
> > > On Wed, 28 Jul 2021 at 23:38, <rentao.bupt@gmail.com> wrote:
> > > >
> > > > From: Tao Ren <rentao.bupt@gmail.com>
> > > >
> > > > Add initial version of device tree for Facebook Fuji (AST2600) BMC.
> > >
> > > I like to read what kind of platform the BMC is going into if you can
> > > add that detail, but it's not essential.
> >
> > Sure. I will add more details in v2.
> >
> > > > +&spi1 {
> > > > +       status = "okay";
> > > > +
> > > > +       /*
> > > > +        * Customize spi1 flash memory size to 32MB (maximum flash size on
> > > > +        * the bus) to save vmalloc space.
> > > > +        */
> > > > +       reg = < 0x1e630000 0xc4
> > > > +               0x30000000 0x2000000 >;
> > >
> > > Which driver supports this?
> > >
> > > It would be great to see Facebook work to get the SPI NOR driver for
> > > the ast2600 merged to mainline.
> > >
> > > I doubt the IBM team will get to this, as we are using eMMC instead.
> >
> > Ah, I just checked aspeed-g6.dtsi (ast2600-spi) in mainline and I thought
> > the driver patches were also upstreamed. Let me remove the entry for now,
> > and will add it back when the driver is ready.
> 
> If it helps you, I don't mind it staying in your dts. I would like to
> see some effort on the driver though.
> 
> >
> > >
> > > > +
> > > > +       flash@0 {
> > > > +               status = "okay";
> > > > +               m25p,fast-read;
> > > > +               label = "spi1.0";
> > > > +               spi-max-frequency = <5000000>;
> > > > +
> > > > +               partitions {
> > > > +                       compatible = "fixed-partitions";
> > > > +                       #address-cells = <1>;
> > > > +                       #size-cells = <1>;
> > > > +
> > > > +                       flash1@0 {
> > > > +                               reg = <0x0 0x2000000>;
> > > > +                               label = "system-flash";
> > > > +                       };
> > > > +               };
> > > > +       };
> > > > +};
> > >
> > > > +&ehci1 {
> > > > +       status = "okay";
> > > > +};
> > >
> > > Have you verified that USB works with mainline? I've had reports of it
> > > working on 5.8 but it seems to have regressed as of v5.10.
> >
> > It stopped working on ASPEED since commit 280a9045bb18 ("ehci: fix EHCI
> > host controller initialization sequence"): ehci_handshake() returns
> > error because HCHalted bit EHCI24[12] stays at 1.
> >
> > I have a dirty hack in my tree (ignoring the halt bit) and it "works" on
> > AST2500 and AST2600. Let me send an email to openbmc and aspeed email
> > groups to see if anyone has more context.
> 
> We discovered the same, except in my testing it wasn't actually
> "working" on my EVB. I have a A3 EVB on my desk and when plugging in a
> USB key nothing happened.

We have a non-removable USB device on Fuji (AST2600) BMC and it can be
enumerated successfully (after applying the hack). Let me vist the lab
and plug a USB key to CMM (AST2500) BMC sometime next week. Will collect
results and send out email then.

> 
> >
> > Meanwhile, should I delete the entry until the fix is ready in driver?
> 
> Again, leave it in I think.
> 
> >
> > > > +&mdio1 {
> > > > +       status = "okay";
> > > > +
> > > > +       ethphy3: ethernet-phy@13 {
> > > > +               compatible = "ethernet-phy-ieee802.3-c22";
> > > > +               reg = <0x0d>;
> > > > +       };
> > > > +};
> > > > +
> > > > +&mac3 {
> > > > +       phy-handle = <&ethphy3>;
> > >
> > > status = okay?
> > >
> > > You should specify the pinmux too I think, even if the default happens
> > > to work, so that other devices cannot claim the pins.
> >
> > status is set in ast2600 common dtsi, but let me set it here to avoid
> > confusion. Will update pinmux in v2. Thanks.
> 
> Are you looking at mainline? I think it's disabled by default there:
> 
> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/aspeed-g6.dtsi#L246

Sorry for the confusion, Joel. I mean the device is enabled in
"ast2600-facebook-netbmc-common.dtsi" (patch #3 in the series). Do we
still need to set status to "okay" explicitly in platform dts (to avoid
confusion)?

&mac3 {
        status = "okay";
        phy-mode = "rgmii";
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_rgmii4_default>;
};


> 
> >
> > >
> > > Cheers,
> > >
> > > Joel
> >
> > Cheers,
> >
> > Tao
