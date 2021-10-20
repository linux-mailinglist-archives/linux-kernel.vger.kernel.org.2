Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0918E434F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhJTPiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTPiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:38:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C408861390;
        Wed, 20 Oct 2021 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634744153;
        bh=oIuL65+uPXKMdPAOUM5sdzWeR/pkE9Rf5eGtMDkAkEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJGsEEcbf3rFeDF4ZHq2C7GhNrjuJhVVDe7hKu8ZvWI1ogZu0tyjOnIJBKM1mnsnR
         qJ33ECYV8bioahbpYzrCFGiAJa5iNj4doAgcSKrN4RmbkX4xwUhWDP45mOD0zSk3gr
         OoM93fNLrIfIVBTIaq7tyZyps+QZfTam9VqNYsDMaokQgDs+9hCf/+j5nHx2DMMJ4R
         Rq8StK+OMqk0Sk4oAN85bmB1cQnOXvEO5cZqbvNo7FfncnBnSBjmd21nyeRmGsdJM3
         VlB153czKl3nUK/ygKbNNnbVYuZBDumW1N+4gPDkuWK/3Vti86K19dp6ZXixbgdsss
         2TsYWd6kSFjtA==
Date:   Wed, 20 Oct 2021 21:05:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, andrew@lunn.ch,
        alexandre.belloni@bootlin.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] phy: Add lan966x ethernet serdes PHY driver
Message-ID: <YXA3VVUGEjUR4HDC@matsya>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
 <20211015123920.176782-4-horatiu.vultur@microchip.com>
 <YW8HIHTCVgB+URJ5@matsya>
 <20211020091733.fxph2pq3xa3byvry@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020091733.fxph2pq3xa3byvry@soft-dev3-1.localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-21, 11:17, Horatiu Vultur wrote:
> The 10/19/2021 23:27, Vinod Koul wrote:
> > 
> > On 15-10-21, 14:39, Horatiu Vultur wrote:
> > > Add the Microchip lan966x ethernet serdes PHY driver for interfaces
> > > available in the lan966x SoC.
> > >
> > > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > > ---
> > >  drivers/phy/microchip/Kconfig               |   8 +
> > >  drivers/phy/microchip/Makefile              |   1 +
> > >  drivers/phy/microchip/lan966x_serdes.c      | 540 ++++++++++++++++++++
> > >  drivers/phy/microchip/lan966x_serdes_regs.h | 482 +++++++++++++++++
> > >  4 files changed, 1031 insertions(+)
> > >  create mode 100644 drivers/phy/microchip/lan966x_serdes.c
> > >  create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
> > >
> > > diff --git a/drivers/phy/microchip/Kconfig b/drivers/phy/microchip/Kconfig
> > > index 3728a284bf64..38039ed0754c 100644
> > > --- a/drivers/phy/microchip/Kconfig
> > > +++ b/drivers/phy/microchip/Kconfig
> > > @@ -11,3 +11,11 @@ config PHY_SPARX5_SERDES
> > >       depends on HAS_IOMEM
> > >       help
> > >         Enable this for support of the 10G/25G SerDes on Microchip Sparx5.
> > > +
> > > +config PHY_LAN966X_SERDES
> > > +     tristate "SerDes PHY driver for Microchip LAN966X"
> > > +     select GENERIC_PHY
> > > +     depends on OF
> > > +     depends on MFD_SYSCON
> > > +     help
> > > +       Enable this for supporting SerDes muxing with Microchip LAN966X
> > > diff --git a/drivers/phy/microchip/Makefile b/drivers/phy/microchip/Makefile
> > > index 7b98345712aa..fd73b87960a5 100644
> > > --- a/drivers/phy/microchip/Makefile
> > > +++ b/drivers/phy/microchip/Makefile
> > > @@ -4,3 +4,4 @@
> > >  #
> > >
> > >  obj-$(CONFIG_PHY_SPARX5_SERDES) := sparx5_serdes.o
> > > +obj-$(CONFIG_PHY_LAN966X_SERDES) := lan966x_serdes.o
> > > diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
> > > new file mode 100644
> > > index 000000000000..e663bb9186a8
> > > --- /dev/null
> > > +++ b/drivers/phy/microchip/lan966x_serdes.c
> > > @@ -0,0 +1,540 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > 
> > Any reason why this is dual licensed, why not GPL only?
> 
> No reason, I think I copy this from a different file.

Please have a chat with your lawyers on the correct license this should
have!

-- 
~Vinod
