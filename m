Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53AB459F21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhKWJ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233911AbhKWJ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:27:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 256F560F5A;
        Tue, 23 Nov 2021 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637659476;
        bh=TcOX3OpXAltrDaStpPDLgGZ/tKmhAa1u2KV6VU8kNP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lA08b4BHKsIPCZkzF9STBxjVvMGSS7AZ9KIkfda2+ZFGGq3XDoJ5I31zhO3b+2BB3
         L58TSGZ6k0u1FKGJq1t1t8ZWChkMSsZ8daVytaY6guv0BwybHiXGWkYjKfHhGUBAy2
         A1YDdHSAdjMCvW+/nIYHDwZnL+zT0fKYf1Fo6O7tknS/uzbQlPwquiq7hLyGCtEJjT
         9gM3jV7gxCKOUzjY3zF8lWV7U6HNzvV2ZY8bhHH79qtj1Wg6JqqoQW/GoqiDyS/Ojw
         9zJL6seY7RE/3uHg5laFWH032/oOrCls5go5xZZ42ryY7QQRmtEq662LC/Wb9n9JKQ
         U6FrlWyWCNamA==
Date:   Tue, 23 Nov 2021 17:24:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: imx8mq: Disable noc dts node
Message-ID: <20211123092430.GY31998@dragon>
References: <1636629369-23988-1-git-send-email-abel.vesa@nxp.com>
 <20211123085841.GX31998@dragon>
 <9b9fe3a5b04179870d6ca0ece754fee9abb306b4.camel@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b9fe3a5b04179870d6ca0ece754fee9abb306b4.camel@posteo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:15:57AM +0000, Martin Kepplinger wrote:
> Am Dienstag, dem 23.11.2021 um 16:58 +0800 schrieb Shawn Guo:
> > On Thu, Nov 11, 2021 at 01:16:09PM +0200, Abel Vesa wrote:
> > > Adding interconnect properties to the consumer nodes creates
> > > a dependency on noc device. The imx-bus devfreq driver is not
> > > usable
> > > without the full interconnect support. The interconnect is not yet
> > > working on i.MX platforms. The devlink created on device_add makes
> > > the lcdif and other nodes that have the interconnect properties
> > > wait for the noc (imx-bus driver) to probe first.
> > > 
> > > To make sure the interconnect consumers (nodes that have
> > > interconnect
> > > properties already added) will still probe, lets disable the noc
> > > node
> > > for now. Once the interconnect on i.MX platforms is fully
> > > functional,
> > > the status of the noc node can be changed.
> > > 
> > > Fixes: ad1abc8a03fdbc05b ("arm64: dts: imx8mq: Add interconnect for
> > > lcdif")
> > 
> > Martin,
> > 
> > Do you have any comment?  So your commit added something untested?
> > 
> > Shawn
> 
> hi Shawn,
> 
> well, for imx8mq the only missing piece is the mxsfb icc bandwidth
> request. I posted a first version a year ago but that didn't make it
> in:
> https://lore.kernel.org/linux-arm-kernel/20201201103757.32165-1-martin.kepplinger@puri.sm/
> 
> So this should create a working state until the real fix in mxsfb is
> there (although I'd revert commit ad1abc8a03fd ("arm64: dts: imx8mq:
> Add interconnect for lcdif") instead).

Besides lcdif, the mipi-csi devices have interconnects property too.  Are
they already working?  If so, it makes more sense to revert ad1abc8a03fd
instead.

Shawn

> I am indeed to blame for this
> and I'm sorry I haven't yet taken the time to work on mxsfb again.
> 
> I can say I plan to do so soon, but without promise that I quickly find
> a solution that'll be merged...
> 
> If you merge this (or revert ad1abc8a03fd), I'll remember to revert
> with said update.
