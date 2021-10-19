Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A455843373E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhJSNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235739AbhJSNmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:42:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AA8D60FDA;
        Tue, 19 Oct 2021 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634650792;
        bh=nt2mCYefXWMIaMeljO6B+JG+TGSzgNhhr44Juy9MjH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pK7YqmUL0a3iT4HpsQCx5Ot8rkA9Yqhbrnwv6jo6ZElrRKYhQv9j4fPWpW1r8FMli
         5Lsz8CjwuVHiiiycxNhLQpl8GvJMI8RwgE/wUIMSc0wLxAnpdUQEo1jjznHaJ+fQQt
         JIj7yE5yeya9A1mOOe0gT1KvBEDPa8FmgnY0dTfoAmeIsedH/kWzwxjtvxC8crPo5z
         nJgW6slFeIQJhlqXo25qOsp0es4mmwMxcTEPq84O0EsgZ2NU4+sDyAbPGnRJqOIZZd
         r1gz9l8PfC3oh/e3mkrURmoV8TD+u34ZNgYynrINyntYBB5Bthm+dTop1ouzWsjFGj
         zmv9xK4EXC6oA==
Received: by mail-ed1-f50.google.com with SMTP id i20so12933501edj.10;
        Tue, 19 Oct 2021 06:39:52 -0700 (PDT)
X-Gm-Message-State: AOAM533lghX/ODQ05U1chP5xTsuhbPrWFnQhBuXR2/EUTnzgQE+wKcbE
        8y3OBAEEUx0eqAAw2aXDnD+Vcj6Nc5j6J4ALnA==
X-Google-Smtp-Source: ABdhPJw785YAft9kOCJXRejGGvZ/JDL+mkBm+lWkw83KlfrIebtxU9BzrRRTN4EOU5p2crXDoSahLOKz0M3l0GoGLxg=
X-Received: by 2002:aa7:c357:: with SMTP id j23mr56462688edr.145.1634650742754;
 Tue, 19 Oct 2021 06:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
 <20211015123920.176782-3-horatiu.vultur@microchip.com> <YW3K2GX+hmkwt3EE@robh.at.kernel.org>
 <20211019091258.3uet6lp3mxaoliqt@soft-dev3-1.localhost>
In-Reply-To: <20211019091258.3uet6lp3mxaoliqt@soft-dev3-1.localhost>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Oct 2021 08:38:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLemN4jU32-5UvPBGUb7G6jxxKwD5oetJWkoBLANuyTsw@mail.gmail.com>
Message-ID: <CAL_JsqLemN4jU32-5UvPBGUb7G6jxxKwD5oetJWkoBLANuyTsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: Add constants for lan966x serdes
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, Vinod <vkoul@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 4:11 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 10/18/2021 14:28, Rob Herring wrote:
> >
> > On Fri, Oct 15, 2021 at 02:39:19PM +0200, Horatiu Vultur wrote:
> > > Lan966x has: 2 integrated PHYs, 3 SerDes and 2 RGMII interfaces. Which
> > > requires to be muxed based on the HW representation.
> > >
> > > So add constants for each interface to be able to distinguish them.
> > >
> > > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > > ---
> > >  include/dt-bindings/phy/phy-lan966x-serdes.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >  create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h
> > >
> > > diff --git a/include/dt-bindings/phy/phy-lan966x-serdes.h b/include/dt-bindings/phy/phy-lan966x-serdes.h
> > > new file mode 100644
> > > index 000000000000..8a05f93ecf41
> > > --- /dev/null
> > > +++ b/include/dt-bindings/phy/phy-lan966x-serdes.h
> > > @@ -0,0 +1,14 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > > +
> > > +#ifndef __PHY_LAN966X_SERDES_H__
> > > +#define __PHY_LAN966X_SERDES_H__
> > > +
> > > +#define PHY(x)               (x)
> > > +#define PHY_MAX              PHY(2)
> > > +#define SERDES6G(x)  (PHY_MAX + 1 + (x))
> > > +#define SERDES6G_MAX SERDES6G(3)
> > > +#define RGMII(x)     (SERDES6G_MAX + 1 + (x))
> > > +#define RGMII_MAX    RGMII(2)
> > > +#define SERDES_MAX   (RGMII_MAX + 1)
> >
> > I still don't understand. #phy-cells description says we have:
> >
> > <port idx> <serdes idx>
> >
> > But here it's 3 numbers. How are these defines used to fill in the 2
> > cells?
>
> Actually they are still only a number. Or maybe I am missing something.

So all the defines apply to the 2nd cell? That's what's missing. The
cell description needs to spell all this out. 3 different modes or
whatever. Explain what the h/w is comprised of in the top level
'description'.

>
> Maybe an example will help:
>
> ---
> serdes: serdes@e2004010 {
>     compatible = "microchip,lan966x-serdes";
>     reg = <0xe202c000 0x9c>, <0xe2004010 0x4>;
>     #phy-cells = <2>;
> };
>
> &port0 {
>     ...
>     phys = <&serdes 0 SERDES6G(1)>;
>     ...
> };
>
> &port1 {
>     ...
>     phys = <&serdes 1 PHY(0)>;

I think CU was better, just needed some comments. PHY is pretty vague.

>     ...
> }
>
> ...
> ---
>
> Here are some existing examples based on which I have created this patch
> series:
> https://elixir.bootlin.com/linux/v5.15-rc6/source/arch/mips/boot/dts/mscc/ocelot_pcb120.dts#L99

None of which use PHY() or RGMII()...


> https://elixir.bootlin.com/linux/v5.15-rc6/source/arch/mips/boot/dts/mscc/ocelot.dtsi#L274
>
> >
> > Rob
>
> --
> /Horatiu
