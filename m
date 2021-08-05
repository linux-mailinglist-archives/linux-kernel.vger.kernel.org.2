Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4073E0C08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhHEBUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHEBUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:20:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FEC061765;
        Wed,  4 Aug 2021 18:19:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so11612863pjr.1;
        Wed, 04 Aug 2021 18:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e3XwsW9dcpK2inuw4CP3wWTFfrJpkqjKUp1ALe4OcSw=;
        b=czFhfxgAUEDaFdM3Hcun5CUGzve9qBhEHhdgHBmOX7olliuFKN8DXgEe+rmKmWat+L
         9mJyEreTCcY9wJOpkumioORcnXgQzD2mgUmfb8cHczaZku6gWfEFHyDULFrbZ1Qkc2Fb
         w63Puypnh8M8XBOv2KOl5W9ml8QulLssN8QoK10Wjo+2Y386UtpiMhlLjuhbVj4TdOuB
         pvqKjUhBeZHINJCJM53M/eymo4U+UKhmtE5VcRQ+hQFyt9j6QvVl0xQWmwI7zrDcM1sm
         tFrqNxnw9BmxW3fhzyQMf8dW7uptS6+uWujOdhQ9442difFXq0vS6iTGzqqcdk7ixPDW
         IKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3XwsW9dcpK2inuw4CP3wWTFfrJpkqjKUp1ALe4OcSw=;
        b=uB/nbMJb/9dFMl2poOLPL9PWZOv/gHibgXOV4n3MA9FOn5DZ8T4Kjk4NoJ4xYJTTq4
         pCwAAelo8e6a6RSSEgif3y2JGoVdZGY0FhJ39bVq95stMe3ReorA+uAlVKfZmOTOmWCP
         5p0IMGNXCS8zUllcSQll1iA3V/9ZVZOzlSdOhRdO9lf+w2kjqLOYGndpD/y6j3E0tQIb
         Gy19wSjrmmU0IWsI4+MSn+HjtmQKN3n/d3Hv6v9LAyX31k1J7/EagQSsBjowVZyhfFDk
         /n2ID7xKHwzoNp144gBQkJKH+o08U0Hja50DbLjgYWcdCPpP2nDNesLiXMVUoMNIpyLs
         8zgg==
X-Gm-Message-State: AOAM533Rs7h60ybIjkmIOvCoojhjc9JNJ5fRXO1wlBEQf7iytBweiY3h
        0cKLWzpFeOWR1bjXsFGtwjc=
X-Google-Smtp-Source: ABdhPJwslt4nxz+RxhRYj1bs+nrlsiTP9TyPu0faSLQ6tV7d4GwOgf/ab8jE0Nsc/c/E4gjD42jt7w==
X-Received: by 2002:a65:6088:: with SMTP id t8mr1796538pgu.371.1628126397724;
        Wed, 04 Aug 2021 18:19:57 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id g11sm3775073pju.13.2021.08.04.18.19.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Aug 2021 18:19:57 -0700 (PDT)
Date:   Wed, 4 Aug 2021 18:19:51 -0700
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
Message-ID: <20210805011951.GA28444@taoren-ubuntu-R90MNF91>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
 <20210728233755.17963-7-rentao.bupt@gmail.com>
 <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 12:28:02AM +0000, Joel Stanley wrote:
> On Wed, 28 Jul 2021 at 23:38, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Add initial version of device tree for Facebook Fuji (AST2600) BMC.
> 
> I like to read what kind of platform the BMC is going into if you can
> add that detail, but it's not essential.

Sure. I will add more details in v2.
 
> > +&spi1 {
> > +       status = "okay";
> > +
> > +       /*
> > +        * Customize spi1 flash memory size to 32MB (maximum flash size on
> > +        * the bus) to save vmalloc space.
> > +        */
> > +       reg = < 0x1e630000 0xc4
> > +               0x30000000 0x2000000 >;
> 
> Which driver supports this?
> 
> It would be great to see Facebook work to get the SPI NOR driver for
> the ast2600 merged to mainline.
> 
> I doubt the IBM team will get to this, as we are using eMMC instead.

Ah, I just checked aspeed-g6.dtsi (ast2600-spi) in mainline and I thought
the driver patches were also upstreamed. Let me remove the entry for now,
and will add it back when the driver is ready.

> 
> > +
> > +       flash@0 {
> > +               status = "okay";
> > +               m25p,fast-read;
> > +               label = "spi1.0";
> > +               spi-max-frequency = <5000000>;
> > +
> > +               partitions {
> > +                       compatible = "fixed-partitions";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +
> > +                       flash1@0 {
> > +                               reg = <0x0 0x2000000>;
> > +                               label = "system-flash";
> > +                       };
> > +               };
> > +       };
> > +};
> 
> > +&ehci1 {
> > +       status = "okay";
> > +};
> 
> Have you verified that USB works with mainline? I've had reports of it
> working on 5.8 but it seems to have regressed as of v5.10.

It stopped working on ASPEED since commit 280a9045bb18 ("ehci: fix EHCI
host controller initialization sequence"): ehci_handshake() returns
error because HCHalted bit EHCI24[12] stays at 1.

I have a dirty hack in my tree (ignoring the halt bit) and it "works" on
AST2500 and AST2600. Let me send an email to openbmc and aspeed email
groups to see if anyone has more context.

Meanwhile, should I delete the entry until the fix is ready in driver?
 
> > +&mdio1 {
> > +       status = "okay";
> > +
> > +       ethphy3: ethernet-phy@13 {
> > +               compatible = "ethernet-phy-ieee802.3-c22";
> > +               reg = <0x0d>;
> > +       };
> > +};
> > +
> > +&mac3 {
> > +       phy-handle = <&ethphy3>;
> 
> status = okay?
> 
> You should specify the pinmux too I think, even if the default happens
> to work, so that other devices cannot claim the pins.

status is set in ast2600 common dtsi, but let me set it here to avoid
confusion. Will update pinmux in v2. Thanks.

> 
> Cheers,
> 
> Joel

Cheers,

Tao
