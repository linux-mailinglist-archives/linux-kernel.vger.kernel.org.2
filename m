Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7122C3167D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhBJNUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:20:48 -0500
Received: from muru.com ([72.249.23.125]:59894 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhBJNUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:20:32 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9040A80EB;
        Wed, 10 Feb 2021 13:20:07 +0000 (UTC)
Date:   Wed, 10 Feb 2021 15:19:46 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, soc@kernel.org, robh+dt@kernel.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <YCPdclQykSPx96hk@atomide.com>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <YCOzLSqdsr83xf0b@atomide.com>
 <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
 <YCPE2lPpBlhCi7TH@atomide.com>
 <20210210125548.sdeadc4ncoxu3ikj@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210125548.sdeadc4ncoxu3ikj@kozik-lap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Kozlowski <krzk@kernel.org> [210210 12:56]:
> On Wed, Feb 10, 2021 at 01:34:50PM +0200, Tony Lindgren wrote:
> > * Hector Martin <marcan@marcan.st> [210210 11:14]:
> > > On 10/02/2021 19.19, Tony Lindgren wrote:
> > > > * Hector Martin 'marcan' <marcan@marcan.st> [210208 12:05]:
> > > > > On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
> > > > ...
> > > > 
> > > > > > > +	clk24: clk24 {
> > > > > > 
> > > > > > Just "clock". Node names should be generic.
> > > > > 
> > > > > Really? Almost every other device device tree uses unique clock node names.
> > > > 
> > > > Yeah please just use generic node name "clock". FYI, we're still hurting
> > > > because of this for the TI clock node names years after because the drivers
> > > > got a chance to rely on the clock node name..
> > > > 
> > > > Using "clock" means your clock driver code won't get a chance to wrongly
> > > > use the node name and you avoid similar issues.
> > > 
> > > That means it'll end up like this (so that we can have more than one
> > > fixed-clock):
> > > 
> > > clocks {
> > >     #address-cells = <1>;
> > >     #size-cells = <0>;
> > > 
> > >     clk123: clock@0 {
> > >         ...
> > >         reg = <0>
> > >     }
> > > 
> > >     clk456: clock@1 {
> > >         ...
> > >         reg = <1>
> > >     }
> > > }
> > > 
> > > Correct?
> > 
> > Yeah, just don't use an imaginary dummy index for the reg. Use a real
> > register offset from a clock controller instance base, and a register
> > bit offset too if needed.
> 
> No, there is no need for fake "clocks" node with fake addresses. If you
> have multiple clocks, the rules are the same as for other similar cases,
> e.g. leds:
> 
> {
>     clock-0 {
>        ...
>     };
> 
>     clock-1 {
>         ..
>     };
> 
>     soc@0 {
>     };
> }
> 
> This should not generate any dtc W=1 warnings and work with dtschema
> (you need to check for both).

OK yeah so no need for the node name there after the "clock-" :)
Sounds good to me.

Regards,

Tony
