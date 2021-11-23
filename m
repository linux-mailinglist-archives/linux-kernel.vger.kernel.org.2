Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C10E45A0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhKWLKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhKWLKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:10:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00BF060F6E;
        Tue, 23 Nov 2021 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637665635;
        bh=Y2aF8NehTeFLD0SRj7EQpJxU1Gt3tByySijjlwPJ1O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srbWZ8TZU5kBczOGVecdutu30YShnz+ySbarO2Am3Z8O8DNX+1+cEiPK+2mqcsJC+
         LGlamASOKwrUJJsEWCfG5mY1GA01XJskd++YF4oYw7Cv8+ZIC262XS7L8pGFtyj3Lx
         x2pu9J94AI/ZWC+7jUJzrgAUEF60Xg5kyhxYj5H0BLhR/hTmclDEkMgygjdcjTze2h
         81ycMTTnxGeA3IxQ/fhu43gBWkDgiQVhcATS1dHe3uKM1yLPfGB/K9A7RpuMHbe2ry
         FjI7Zfs5nH0vAtbGq1c8Ll1bS1pG4zxYkYCZ8cN6+WS/39eQtccPYjGLwOqOfT7aE+
         X5/9fjPfjTP+A==
Date:   Tue, 23 Nov 2021 19:07:10 +0800
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
Message-ID: <20211123110709.GA31998@dragon>
References: <1636629369-23988-1-git-send-email-abel.vesa@nxp.com>
 <20211123085841.GX31998@dragon>
 <9b9fe3a5b04179870d6ca0ece754fee9abb306b4.camel@posteo.de>
 <20211123092430.GY31998@dragon>
 <c139110dc0b2096a51d1b3c344c3d597cf24093b.camel@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c139110dc0b2096a51d1b3c344c3d597cf24093b.camel@posteo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:30:02AM +0000, Martin Kepplinger wrote:
> Am Dienstag, dem 23.11.2021 um 17:24 +0800 schrieb Shawn Guo:
> > On Tue, Nov 23, 2021 at 09:15:57AM +0000, Martin Kepplinger wrote:
> > > Am Dienstag, dem 23.11.2021 um 16:58 +0800 schrieb Shawn Guo:
> > > > On Thu, Nov 11, 2021 at 01:16:09PM +0200, Abel Vesa wrote:
> > > > > Adding interconnect properties to the consumer nodes creates
> > > > > a dependency on noc device. The imx-bus devfreq driver is not
> > > > > usable
> > > > > without the full interconnect support. The interconnect is not
> > > > > yet
> > > > > working on i.MX platforms. The devlink created on device_add
> > > > > makes
> > > > > the lcdif and other nodes that have the interconnect properties
> > > > > wait for the noc (imx-bus driver) to probe first.
> > > > > 
> > > > > To make sure the interconnect consumers (nodes that have
> > > > > interconnect
> > > > > properties already added) will still probe, lets disable the
> > > > > noc
> > > > > node
> > > > > for now. Once the interconnect on i.MX platforms is fully
> > > > > functional,
> > > > > the status of the noc node can be changed.
> > > > > 
> > > > > Fixes: ad1abc8a03fdbc05b ("arm64: dts: imx8mq: Add interconnect
> > > > > for
> > > > > lcdif")
> > > > 
> > > > Martin,
> > > > 
> > > > Do you have any comment?  So your commit added something
> > > > untested?
> > > > 
> > > > Shawn
> > > 
> > > hi Shawn,
> > > 
> > > well, for imx8mq the only missing piece is the mxsfb icc bandwidth
> > > request. I posted a first version a year ago but that didn't make
> > > it
> > > in:
> > > https://lore.kernel.org/linux-arm-kernel/20201201103757.32165-1-martin.kepplinger@puri.sm/
> > > 
> > > So this should create a working state until the real fix in mxsfb
> > > is
> > > there (although I'd revert commit ad1abc8a03fd ("arm64: dts:
> > > imx8mq:
> > > Add interconnect for lcdif") instead).
> > 
> > Besides lcdif, the mipi-csi devices have interconnects property too. 
> > Are
> > they already working?  If so, it makes more sense to revert
> > ad1abc8a03fd
> > instead.
> 
> imx8mq-mipi-csi.c request the bandwidth, yes. we use that and the
> preliminary mxsfb request above so that works.
> 
> do you want me to send the revert?

Yes, please.

Shawn
