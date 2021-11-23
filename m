Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A83459F41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhKWJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:33:18 -0500
Received: from mout01.posteo.de ([185.67.36.65]:60581 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234948AbhKWJdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:33:17 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 42CCB24002A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1637659808; bh=Lpz92Y5P37IX2vYM57a1J6CDi46ceuRnVsDwtJDVzcA=;
        h=Subject:From:To:Cc:Date:From;
        b=hCnzNSCK00+wRmCZBKWXs9vYbJ7pcqGBbvP+ToYfiUQy2iSj0XHIoK0PacY8ArVU9
         16d0MeezPnPU7rzPmUE5TSnTlqfH/Iqjp/gJCic9UaXCH9sMixPfY71H9pUXT4jgQe
         /Q8lPZBh7N/ZqavNKx1M3HynmCfThqYDh17CoFekv3gQZgBIYlmetIMgC8H4aCi0nn
         sV1Aqivcm2fBYK80QFUwwi+3XmScf/dk99ywUHxJoF2Gt9cgKqvNtLwfwamifkbK7C
         0ZXqn+OywN+YBFbYT4HvNzjQ7OH2oDEhCploNQBVZf4urvuagR8UgcNzauZ0/E2XkM
         z5K5fwokvHvsg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HyzPl1Ywdz6tn4;
        Tue, 23 Nov 2021 10:30:03 +0100 (CET)
Message-ID: <c139110dc0b2096a51d1b3c344c3d597cf24093b.camel@posteo.de>
Subject: Re: [PATCH] arm64: dts: freescale: imx8mq: Disable noc dts node
From:   Martin Kepplinger <martink@posteo.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Date:   Tue, 23 Nov 2021 09:30:02 +0000
In-Reply-To: <20211123092430.GY31998@dragon>
References: <1636629369-23988-1-git-send-email-abel.vesa@nxp.com>
         <20211123085841.GX31998@dragon>
         <9b9fe3a5b04179870d6ca0ece754fee9abb306b4.camel@posteo.de>
         <20211123092430.GY31998@dragon>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 23.11.2021 um 17:24 +0800 schrieb Shawn Guo:
> On Tue, Nov 23, 2021 at 09:15:57AM +0000, Martin Kepplinger wrote:
> > Am Dienstag, dem 23.11.2021 um 16:58 +0800 schrieb Shawn Guo:
> > > On Thu, Nov 11, 2021 at 01:16:09PM +0200, Abel Vesa wrote:
> > > > Adding interconnect properties to the consumer nodes creates
> > > > a dependency on noc device. The imx-bus devfreq driver is not
> > > > usable
> > > > without the full interconnect support. The interconnect is not
> > > > yet
> > > > working on i.MX platforms. The devlink created on device_add
> > > > makes
> > > > the lcdif and other nodes that have the interconnect properties
> > > > wait for the noc (imx-bus driver) to probe first.
> > > > 
> > > > To make sure the interconnect consumers (nodes that have
> > > > interconnect
> > > > properties already added) will still probe, lets disable the
> > > > noc
> > > > node
> > > > for now. Once the interconnect on i.MX platforms is fully
> > > > functional,
> > > > the status of the noc node can be changed.
> > > > 
> > > > Fixes: ad1abc8a03fdbc05b ("arm64: dts: imx8mq: Add interconnect
> > > > for
> > > > lcdif")
> > > 
> > > Martin,
> > > 
> > > Do you have any comment?  So your commit added something
> > > untested?
> > > 
> > > Shawn
> > 
> > hi Shawn,
> > 
> > well, for imx8mq the only missing piece is the mxsfb icc bandwidth
> > request. I posted a first version a year ago but that didn't make
> > it
> > in:
> > https://lore.kernel.org/linux-arm-kernel/20201201103757.32165-1-martin.kepplinger@puri.sm/
> > 
> > So this should create a working state until the real fix in mxsfb
> > is
> > there (although I'd revert commit ad1abc8a03fd ("arm64: dts:
> > imx8mq:
> > Add interconnect for lcdif") instead).
> 
> Besides lcdif, the mipi-csi devices have interconnects property too. 
> Are
> they already working?  If so, it makes more sense to revert
> ad1abc8a03fd
> instead.

imx8mq-mipi-csi.c request the bandwidth, yes. we use that and the
preliminary mxsfb request above so that works.

do you want me to send the revert?

                     martin

> 
> Shawn
> 
> > I am indeed to blame for this
> > and I'm sorry I haven't yet taken the time to work on mxsfb again.
> > 
> > I can say I plan to do so soon, but without promise that I quickly
> > find
> > a solution that'll be merged...
> > 
> > If you merge this (or revert ad1abc8a03fd), I'll remember to revert
> > with said update.


