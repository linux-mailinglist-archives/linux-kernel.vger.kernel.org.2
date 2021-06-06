Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C839CD8B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 07:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFFGBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 02:01:16 -0400
Received: from muru.com ([72.249.23.125]:36958 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhFFGBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 02:01:15 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6A9FC80E5;
        Sun,  6 Jun 2021 05:59:31 +0000 (UTC)
Date:   Sun, 6 Jun 2021 08:59:20 +0300
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
Message-ID: <YLxkOIu7XAJJd0bN@atomide.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
 <YK32Mmiq9QXGkELF@atomide.com>
 <9ff6ec26-4b78-4684-9c23-16d5cbfef857@www.fastmail.com>
 <YLdOsA63GyMj4SgR@atomide.com>
 <1ff54382-7137-49d6-841d-318e400e956e@www.fastmail.com>
 <YLnZtJtUKdif47zE@atomide.com>
 <02176203-7f29-4ff4-933b-70235cf0dd22@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02176203-7f29-4ff4-933b-70235cf0dd22@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Peter <sven@svenpeter.dev> [210605 12:13]:
> Hi Tony,
> 
> On Fri, Jun 4, 2021, at 09:43, Tony Lindgren wrote:
> > Hi,
> > 
> > How about the following where you set up the gate clocks as separate 
> > child nodes:
> > 
> > pmgr0: clock-controller@23b700000 {
> > 	compatible = "apple,foo-clock-controller";
> > 	#clock-cells = <1>;
> > 	reg = <0x2 0x3b700000 0x0 0x4000>;
> > 
> > 	clk_uart0: clock@270 {
> > 		compatible = "apple,t8103-gate-clock";
> > 		#clock-cells = <0>;
> > 		assigned-clock-parents = <&pmgr0 APPLE_CLK_SIO>,
> > 					 <&pmgr0 APPLE_CLK_UART_P>;
> > 		// ...
> > 	};
> > 
> > };
> > 
> > Keep the clock controller still addressable by offset from base as discussed,
> > and additionally have the driver parse and set up the child node clocks.
>
> Nice, I like that one even better! We can keep the internal clocks "hidden"
> inside the parent node and only need to model the actual consumer clocks
> as separate nodes.

I guess the child nodes could also use just a clocks property above
instead of assigned-clock related properties if there are no configurable
source clock mux registers.

> Are you aware of any clock driver that implements something similar?
> I'd like to avoid reinventing the wheel if it's already been done before.

I'm only aware of a partial implementation so far :) The "offset from
clock controller base" approach has worked well for the TI clkctrl
clocks. The clkctrl gate clocks still have the SoC specific source
clock data build into the clock driver(s).

That's the Documentation/devicetree/bindings/clock/ti-clkctrl.txt
binding. For the clkctrl clocks, the SoC specific source clock data
is in drivers/clk/ti/clk-*.c files.

With the Apple dtb describing the gate clock parents, you might be
able to leave out most of the SoC specific built-in driver data
sounds like.

Regards,

Tony
