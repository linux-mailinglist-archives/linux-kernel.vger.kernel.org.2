Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422DB3C36B5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 22:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhGJUFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 16:05:30 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37455 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhGJUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 16:05:29 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8E70CFF805;
        Sat, 10 Jul 2021 20:02:40 +0000 (UTC)
Date:   Sat, 10 Jul 2021 22:02:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Colin Foster <colin.foster@in-advantage.com>, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org,
        claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 net-next 2/8] net: dsa: ocelot: felix: move MDIO
 access to a common location
Message-ID: <YOn84MsXpILIlrxo@piout.net>
References: <20210710192602.2186370-1-colin.foster@in-advantage.com>
 <20210710192602.2186370-3-colin.foster@in-advantage.com>
 <20210710195913.owqvc7llnya74axl@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710195913.owqvc7llnya74axl@skbuf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2021 22:59:13+0300, Vladimir Oltean wrote:
> On Sat, Jul 10, 2021 at 12:25:56PM -0700, Colin Foster wrote:
> > Indirect MDIO access is a feature that doesn't need to be specific to the
> > Seville driver. Separate the feature to a common file so it can be shared.
> > 
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > ---
> 
> In fact, this same piece of hardware has a dedicated driver inside
> drivers/net/mdio/mdio-mscc-miim.c. The only problem is that it doesn't
> work with regmap, and especially not with a caller-supplied regmap. I
> was too lazy to do that, but it is probably what should have been done.
> 
> By comparison, felix_vsc9959.c was coded up to work with an internal
> MDIO bus whose ops are implemented by another driver (enetc_mdio). Maybe
> you could take that as an example and have mdio-mscc-miim.c drive both
> seville and ocelot.

That was indeed going to be my comment.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
