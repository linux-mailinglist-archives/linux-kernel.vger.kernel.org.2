Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47E939B439
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFDHpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:45:40 -0400
Received: from muru.com ([72.249.23.125]:36152 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhFDHpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:45:39 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E17AE8167;
        Fri,  4 Jun 2021 07:43:58 +0000 (UTC)
Date:   Fri, 4 Jun 2021 10:43:48 +0300
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
Message-ID: <YLnZtJtUKdif47zE@atomide.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
 <YK32Mmiq9QXGkELF@atomide.com>
 <9ff6ec26-4b78-4684-9c23-16d5cbfef857@www.fastmail.com>
 <YLdOsA63GyMj4SgR@atomide.com>
 <1ff54382-7137-49d6-841d-318e400e956e@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff54382-7137-49d6-841d-318e400e956e@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Sven Peter <sven@svenpeter.dev> [210603 12:56]:
> Another possibility this made me think of is to instead just use the clocks
> property the way it's usually used and simply refer to the controller itself, e.g.
> 
> #define APPLE_CLK_UART0  0x270
> #define APPLE_CLK_UART_P 0x220
> #define APPLE_CLK_SIO    0x1c0
> 
> pmgr0: clock-controller@23b700000 {
>         compatible = "apple,t8103-gate-clock";
>         #clock-cells = <1>;
>         reg = <0x2 0x3b700000 0x0 0x4000>;
>         clock-indices = <APPLE_CLK_SIO>, <APPLE_CLK_UART_P>, <APPLE_CLK_UART0>;
>         clock-output-names = "clock-sio", "clock-uart-", "clock-uart0";
>         clocks = <&some_dummy_root_clock>, <&pmgr0 APPLE_CLK_SIO>,
>                  <&pmgr0 APPLE_CLK_UART_P>;
> };

How about the following where you set up the gate clocks as separate child nodes:

pmgr0: clock-controller@23b700000 {
	compatible = "apple,foo-clock-controller";
	#clock-cells = <1>;
	reg = <0x2 0x3b700000 0x0 0x4000>;

	clk_uart0: clock@270 {
		compatible = "apple,t8103-gate-clock";
		#clock-cells = <0>;
		assigned-clock-parents = <&pmgr0 APPLE_CLK_SIO>,
					 <&pmgr0 APPLE_CLK_UART_P>;
		// ...
	};

};

Keep the clock controller still addressable by offset from base as discussed,
and additionally have the driver parse and set up the child node clocks.

Then I think the consumer driver can just do:

serial0: serial@235200000 {
	// ...
	clocks = <&clk_uart0>, <&clk24>;
	clock-names = "uart", "clk_uart_baud0";
	// ...
};

Regards,

Tony
