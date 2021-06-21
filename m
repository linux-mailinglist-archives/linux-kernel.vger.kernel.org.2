Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85753AE5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFUJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:17:11 -0400
Received: from foss.arm.com ([217.140.110.172]:59482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhFUJRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:17:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C3F1FB;
        Mon, 21 Jun 2021 02:14:55 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 530323F718;
        Mon, 21 Jun 2021 02:14:53 -0700 (PDT)
Date:   Mon, 21 Jun 2021 10:14:36 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v7 14/19] phy: sun4i-usb: Introduce port2 SIDDQ quirk
Message-ID: <20210621101436.3d1ce911@slackpad.fritz.box>
In-Reply-To: <YNAXT5lYVcJ309zJ@vkoul-mobl>
References: <20210615110636.23403-1-andre.przywara@arm.com>
        <20210615110636.23403-15-andre.przywara@arm.com>
        <YNAXT5lYVcJ309zJ@vkoul-mobl>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 10:06:31 +0530
Vinod Koul <vkoul@kernel.org> wrote:

Hi Vinod,

thanks for having a look!

> On 15-06-21, 12:06, Andre Przywara wrote:
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
> > ---
> >  drivers/phy/allwinner/phy-sun4i-usb.c | 59 +++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> > index 126ef74d013c..316ef5fca831 100644
> > --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> > +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> > @@ -120,6 +120,7 @@ struct sun4i_usb_phy_cfg {
> >  	u8 phyctl_offset;
> >  	bool dedicated_clocks;
> >  	bool phy0_dual_route;
> > +	bool needs_phy2_siddq;
> >  	int missing_phys;
> >  };
> >  
> > @@ -289,6 +290,50 @@ static int sun4i_usb_phy_init(struct phy *_phy)
> >  		return ret;
> >  	}
> >  
> > +	/* Some PHYs on some SoCs need the help of PHY2 to work. */
> > +	if (data->cfg->needs_phy2_siddq && phy->index != 2) {
> > +		struct sun4i_usb_phy *phy2 = &data->phys[2];
> > +
> > +		ret = clk_prepare_enable(phy2->clk);
> > +		if (ret) {
> > +			reset_control_assert(phy->reset);
> > +			clk_disable_unprepare(phy->clk2);
> > +			clk_disable_unprepare(phy->clk);
> > +			return ret;
> > +		}
> > +
> > +		ret = reset_control_deassert(phy2->reset);
> > +		if (ret) {
> > +			clk_disable_unprepare(phy2->clk);
> > +			reset_control_assert(phy->reset);
> > +			clk_disable_unprepare(phy->clk2);
> > +			clk_disable_unprepare(phy->clk);
> > +			return ret;
> > +		}  
> 
> no delay between deassert and assert... ?

Mmmh, not sure what you are after. This is just the clean-up path,
when the deassert failed, and we tear down what was brought up before.
And the assert is not for the same reset line that we tried to
deassert anyway, if that is what you mean?
Or do I miss something here?

Cheers,
Andre
