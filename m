Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A782398543
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFBJ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:29:56 -0400
Received: from muru.com ([72.249.23.125]:35376 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFBJ3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:29:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D0BED8027;
        Wed,  2 Jun 2021 09:28:16 +0000 (UTC)
Date:   Wed, 2 Jun 2021 12:28:06 +0300
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
Message-ID: <YLdPJk+RBNmw3zJz@atomide.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
 <6052f2f1-1e3f-474e-a767-e08ca19fbd43@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6052f2f1-1e3f-474e-a767-e08ca19fbd43@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Peter <sven@svenpeter.dev> [210530 11:11]:
> The problem with that approach is that to enable e.g. UART_0 we actually need
> to enable its parents as well, e.g. the Apple Device Tree for the M1 has the
> following clock topology:
> 
>     UART0  (0x23b700270), parent: UART_P
>     UART_P (0x23b700220), parent: SIO
>     SIO    (0x23b7001c0), parent: n/a
> 
> The offsets and the parent/child relationship for all of these three clocks
> change between SoCs. If I now use the offset as the clock id I still need
> to specify that if e.g. UART uses <&clk_controller 0x270> I first need
> to enable 0x1c0 and then 0x220 and only then 0x270.

Maybe take a look what I suggested on using assigned-clocks and related
properties in the clock controller node. That might solve the issue in
a generic way for other SoCs too.

Regards,

Tony
