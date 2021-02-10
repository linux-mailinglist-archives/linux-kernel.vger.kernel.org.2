Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62D316551
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBJLgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:36:51 -0500
Received: from muru.com ([72.249.23.125]:59812 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhBJLfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:35:43 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3301280EB;
        Wed, 10 Feb 2021 11:35:16 +0000 (UTC)
Date:   Wed, 10 Feb 2021 13:34:50 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, soc@kernel.org,
        robh+dt@kernel.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <YCPE2lPpBlhCi7TH@atomide.com>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <YCOzLSqdsr83xf0b@atomide.com>
 <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hector Martin <marcan@marcan.st> [210210 11:14]:
> On 10/02/2021 19.19, Tony Lindgren wrote:
> > * Hector Martin 'marcan' <marcan@marcan.st> [210208 12:05]:
> > > On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
> > ...
> > 
> > > > > +	clk24: clk24 {
> > > > 
> > > > Just "clock". Node names should be generic.
> > > 
> > > Really? Almost every other device device tree uses unique clock node names.
> > 
> > Yeah please just use generic node name "clock". FYI, we're still hurting
> > because of this for the TI clock node names years after because the drivers
> > got a chance to rely on the clock node name..
> > 
> > Using "clock" means your clock driver code won't get a chance to wrongly
> > use the node name and you avoid similar issues.
> 
> That means it'll end up like this (so that we can have more than one
> fixed-clock):
> 
> clocks {
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     clk123: clock@0 {
>         ...
>         reg = <0>
>     }
> 
>     clk456: clock@1 {
>         ...
>         reg = <1>
>     }
> }
> 
> Correct?

Yeah, just don't use an imaginary dummy index for the reg. Use a real
register offset from a clock controller instance base, and a register
bit offset too if needed.

That way if you discover a new clock inbetween somewhere, you don't have
renumber any imaginary lists in the driver or device tree. So try to
follow sort of what the standard interrupts binding is doing only
describing the hardware.

> Incidentally, there is just one example in the kernel tree of doing this
> right (in arch/arm/boot/dts/imx6qdl-tx6.dtsi). All the others that use
> non-mmio clocks called `clock`, including the various tegra devicetrees,
> violate the DT spec by not including a dummy reg property matching the
> unit-address.

Doing it right will save you tons of time later on ;)

FYI, for the TI clocks, we ended up redoing most of the clocks as
documented in Documentation/devicetree/bindings/clock/ti-clkctrl.txt.

Regards,

Tony
