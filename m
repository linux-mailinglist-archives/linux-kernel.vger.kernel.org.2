Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D53DCE4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 02:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhHBAjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 20:39:46 -0400
Received: from foss.arm.com ([217.140.110.172]:56984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhHBAjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 20:39:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB766D6E;
        Sun,  1 Aug 2021 17:39:36 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51C8A3F66F;
        Sun,  1 Aug 2021 17:39:35 -0700 (PDT)
Date:   Mon, 2 Aug 2021 01:38:51 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v8 00/11] arm64: sunxi: Initial Allwinner H616 SoC
 support
Message-ID: <20210802013851.13375f0f@slackpad.fritz.box>
In-Reply-To: <20210726145230.uevhinsrvo7gtuty@gilmour>
References: <20210723153838.6785-1-andre.przywara@arm.com>
        <20210726145230.uevhinsrvo7gtuty@gilmour>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 16:52:30 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

Hi,

> On Fri, Jul 23, 2021 at 04:38:27PM +0100, Andre Przywara wrote:
> > Hi,
> > 
> > another try on the basic Allwinner H616 support, now on top of 5.14-rc1.
> > 
> > This time I dropped the USB support from the basic series, to split off
> > the discussion, and simplify the core SoC support. I will post the USB
> > series soon, to be applied on top.
> > I kept the RTC support in, even though this is still under discussion,
> > because this is important to keep future DT files compatible with this
> > kernel.  
> 
> Honestly, I don't want to support something we don't guarantee if it's
> at the expense of making something we do guarantee more complicated.

I don't ask for or provide guarantees, but I think we can at least *try*
to keep this compatible. This version works at the moment, and should
also work with future DTs - within the limits of the current driver, so
only using the RC clock. It allows to later improve the accuracy by
adding better input clocks - and later DT/driver combinations can make
use of this.

> Delaying the clock tree description to sometime in the future will only
> further complicate the probe part of the driver, and there's far too
> many special cases already.

I don't see how this would complicate probing beyond what Allwinner
brought upon us already anyway: no LOSC crystal input in this package
version, but having this pin in some other SoC sharing this die
(according to some BSP) sources. We can't expect a super clean driver
with those HW design choices.

If we really cannot keep the DT compatible, fair enough: that's what
it is (there is no guarantee!), but at least we have tried.

Cheers,
Andre
