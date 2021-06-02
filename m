Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D475139853A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFBJ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:27:58 -0400
Received: from muru.com ([72.249.23.125]:35350 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231283AbhFBJ14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:27:56 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D2C858027;
        Wed,  2 Jun 2021 09:26:18 +0000 (UTC)
Date:   Wed, 2 Jun 2021 12:26:08 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 0/3] Apple M1 clock gate driver
Message-ID: <YLdOsA63GyMj4SgR@atomide.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
 <YK32Mmiq9QXGkELF@atomide.com>
 <9ff6ec26-4b78-4684-9c23-16d5cbfef857@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff6ec26-4b78-4684-9c23-16d5cbfef857@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Peter <sven@svenpeter.dev> [210530 11:09]:
> Hi,
> 
> On Wed, May 26, 2021, at 09:18, Tony Lindgren wrote:
> > Hi,
> > 
> > * Rob Herring <robh+dt@kernel.org> [210525 18:09]:
> > > I would do a single node per mmio region with the register offset (or
> > > offset / 4) being the clock id. This can still support new SoCs easily
> > > if you have a fallback compatible. If you want/need to get all the
> > > clocks, just walk the DT 'clocks' properties and extract all the IDs.
> > 
> > I mostly agree.. Except I'd also leave out the artificial clock ID and
> > just use real register offsets from the clock controller base instead.
> 
> Sure, I'll do that.
> 
> > 
> > So a single clock controller node for each MMIO range, then set
> > #clock=cells = <1>. Then the binding follows what we have for the
> > interrupts-extended binding for example.
> > 
> > If the clock controller optionally needs some data in the dts,
> > that can be added to the clock controller node. Or it can be driver
> > internal built-in data. If the data for dts can be described in a
> > generic way, even better :)
> 
> Now the big question is *how* to describe this additional data in the
> dts. Essentially I need to specify that e.g. to enable clock 0x270
> I first need to enable the (internal) clocks 0x1c0 and then 0x220.
> Are you aware of any generic way to describe this? I'm not even sure
> how a sane non-generic way would look like when I just have a single
> clock controller node.

To me it seems you might be able to recycle the assigned-clocks and
assigned-clock-parents etc properties in the clock controller node.

Sure the assigned-clocks property will point to clocks in the
clock controller itself, and will have tens of entries, but should
work :)

And sounds like you can generate that list with some script from the
Apple dtb.

Regards,

Tony
