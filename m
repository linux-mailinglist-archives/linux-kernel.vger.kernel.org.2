Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A102316733
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBJMzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:55:50 -0500
Received: from muru.com ([72.249.23.125]:59866 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhBJMzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:55:43 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 589B880EB;
        Wed, 10 Feb 2021 12:55:17 +0000 (UTC)
Date:   Wed, 10 Feb 2021 14:54:56 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Hector Martin <marcan@marcan.st>, Arnd Bergmann <arnd@kernel.org>,
        DTML <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <YCPXoEKJQyVFdOHv@atomide.com>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <YCOzLSqdsr83xf0b@atomide.com>
 <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
 <YCPE2lPpBlhCi7TH@atomide.com>
 <4dd911d8-ce84-bf4d-3aae-95ef321b4a97@marcan.st>
 <CAFr9PXkLRKHguszidJX2Qit0QUJ0QxFi3H=Wp2HDqpfJQYZEVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXkLRKHguszidJX2Qit0QUJ0QxFi3H=Wp2HDqpfJQYZEVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Palmer <daniel@0x0f.com> [210210 12:24]:
> Hi Hector,
> 
> On Wed, 10 Feb 2021 at 20:49, Hector Martin <marcan@marcan.st> wrote:
> 
> > > Yeah, just don't use an imaginary dummy index for the reg. Use a real
> > > register offset from a clock controller instance base, and a register
> > > bit offset too if needed.
> >
> > I mean for fixed input clocks without any particular numbering, or for
> > temporary fake clocks while we figure out the clock controller. Once a
> > real clock controller is involved, if there are hardware indexes
> > involved that are consistent then of course I'll use those in some way
> > that makes sense.
> 
> This exact problem exists for MStar/SigmaStar too.
> As it stands there is no documentation to show what the actual clock
> tree looks like so everything is guess and I need to come up with numbers.
> I'm interested to see what the solution to this is as it will come up again
> when mainlining chips without documentation.
> 
> 
> > The purpose of the clock in this particular case is just to make the
> > uart driver work, since it wants to know its reference clock; there is
> > work to be done here to figure out the real clock tree
> 
> FWIW arm/boot/dts/mstar-v7.dtsi has the same issue: Needs uart,
> has no uart clock. In that instance the uart clock setup by u-boot
> is passed to the uart driver as a property instead of creating a fake
> clock.

Using more local dts nodes for the fixed clocks might help a bit with
the dummy numbering problem but is still not a nice solution.

How about using node names like "clock-foo" for the fixed clocks?
This would be along what we do for with regulator names.

Rob and Stephen might have some better suggestions here.

Regards,

Tony
