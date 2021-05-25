Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9038FFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhEYLav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:30:51 -0400
Received: from foss.arm.com ([217.140.110.172]:54908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhEYLat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:30:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7187BD6E;
        Tue, 25 May 2021 04:29:19 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740C33F719;
        Tue, 25 May 2021 04:29:17 -0700 (PDT)
Date:   Tue, 25 May 2021 12:29:01 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 12/17] phy: sun4i-usb: Introduce port2 SIDDQ quirk
Message-ID: <20210525122901.778bfccd@slackpad.fritz.box>
In-Reply-To: <20210524115946.jwsasjbr3biyixhz@gilmour>
References: <20210519104152.21119-1-andre.przywara@arm.com>
        <20210519104152.21119-13-andre.przywara@arm.com>
        <20210524115946.jwsasjbr3biyixhz@gilmour>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 13:59:46 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

Hi Maxime,

> On Wed, May 19, 2021 at 11:41:47AM +0100, Andre Przywara wrote:
> > At least the Allwinner H616 SoC requires a weird quirk to make most
> > USB PHYs work: Only port2 works out of the box, but all other ports
> > need some help from this port2 to work correctly: The CLK_BUS_PHY2 and
> > RST_USB_PHY2 clock and reset need to be enabled, and the SIDDQ bit in
> > the PMU PHY control register needs to be cleared. For this register to
> > be accessible, CLK_BUS_ECHI2 needs to be ungated. Don't ask ....
> > 
> > Instead of disguising this as some generic feature, do exactly that
> > in our PHY init:
> > If the quirk bit is set, and we initialise a PHY other than PHY2, ungate
> > this one special clock, and clear the SIDDQ bit. We can pull in the
> > other required clocks via the DT.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>  
> 
> What is this SIDDQ bit doing exactly?

I probably know as much as you do, but as Jernej pointed out, in some
Rockchip code it's indeed documented as some analogue PHY supply switch:
($ git grep -i siddq drivers/phy/rockchip)

In fact we had this pin/bit for ages, it was just hidden as BIT(1) in
our infamous PMU_UNK1 register. Patch 10/17 drags that into the light.

> I guess we could also expose this using a power-domain if it's relevant?

Mmmh, interesting idea. So are you thinking about registering a genpd
provider in sun4i_usb_phy_probe(), then having a power-domains property
in the ehci/ohci nodes, pointing to the PHY node? And if yes, should
the provider be a subnode of the USB PHY node, with a separate
compatible? That sounds a bit more involved, but would have the
advantage of allowing us to specify the resets and clocks from PHY2
there, and would look a bit cleaner than hacking them into the
other EHCI/OHCI nodes.

I would not touch the existing SoCs (even though it seems to apply to
them as well, just not in the exact same way), but I can give it a
try for the H616. It seems like the other SIDDQ bits (in the other
PHYs) are still needed for operation, but the PD provide could actually
take care of this as well.

Does that make sense or is this a bit over the top for just clearing an
extra bit?

Cheers,
Andre
