Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF515426F8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJHRbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhJHRbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8D7960C4B;
        Fri,  8 Oct 2021 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633714190;
        bh=bSGggQj63KGrt2Kn1+h4ufJaXOF8u2nTO9GXID1cojc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ecjj162xpf30CfKEr+875wqw75PE8CkmDVZ3+Zf7UoU4GGwBI93AY3cFknjLR9cnJ
         wMJYJTa9hV/gXl6pTdP7ZY2rXQI/i/3VSkPDKuGsnt89HnFcHJhSBK0RGYroGig//a
         G3EfpP6IVonW9gL+xmmGkmLQJk2qLPR1DRb8TDaARsfsaTf6aS/T/YU9FJn4Bez8Cd
         6rrxmjSSE9pbNWFyVfiWrJcCRQMsVRcjUVJEBoElkK8xIWez41UpaPYNkfflAAbjeN
         zPKgO7WDzDW3jBbhF8rf0RnIL7Vzr2OXxyYiLEjR16wer12pZtcp50zl/sD+Y0KbzV
         Hlo47IcrVksmA==
Received: by pali.im (Postfix)
        id 4735C760; Fri,  8 Oct 2021 19:29:48 +0200 (CEST)
Date:   Fri, 8 Oct 2021 19:29:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: dts: marvell: add Globalscale MOCHAbin
Message-ID: <20211008172948.rpev5iptnczdofwi@pali>
References: <20211008114343.57920-1-robert.marko@sartura.hr>
 <20211008120855.46zbo2fl5edwf7ja@pali>
 <CA+HBbNGvFtws2GF7RLbznAbXfvjKx4rOJ=eMeuHOJ6s7iANtzw@mail.gmail.com>
 <20211008134347.lskm5pzt73pkf7oc@pali>
 <CA+HBbNEDxBDvNZPSWnBYJOUhqdwonBhFwD9P0xhSGccdvQJx3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNEDxBDvNZPSWnBYJOUhqdwonBhFwD9P0xhSGccdvQJx3Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2021 17:52:40 Robert Marko wrote:
> On Fri, Oct 8, 2021 at 3:43 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Friday 08 October 2021 15:28:38 Robert Marko wrote:
> > > > > +     cp0_pcie_reset_pins: cp0-pcie-reset-pins {
> > > > > +             marvell,pins = "mpp9";
> > > > > +             marvell,function = "gpio";
> > > >
> > > > Now I spotted this. Why is PERST# pin configured into gpio mode? Is
> > > > there some issue that this pin in pcie mode is not working properly,
> > > > that PCIe controller cannot handle it correctly? Or something else?
> > >
> > > Its because I have seen way too many broken controllers when it comes
> > > to PERST and
> > > other Armada 7k/8k devices are using it in GPIO mode as well.
> > > Just look at the number of conversions back to GPIO for other
> > > platforms as there is always some bug.
> >
> > I know that A3720 has broken PERST# control in PCIe block... or at least
> > I was not able to figure out how A3720 PCIe block can control PERST#. So
> > configuring it in gpio mode and let PERST# to be controlled manually via
> > gpio by the software is the workaround.
> >
> > I just wanted to know if A7k/A8k/CN913x is also broken in the same way
> > as A3720.
> >
> > Or it it just a configuration workaround for missing driver or missing
> > proper software setup.
> >
> > HW bugs like this should be properly documented and not hidden behind
> > some configuration in DTS file. And reported to HW vendors.
> 
> I have to agree, so I did some digging.
> I don't think that the Armada 8k PCI driver actually supports HW level PERST#.
> I then looked at the functional specs and the only thing that looks
> related to PERST#
> is PCIe Software Reset Register which has a SoftWarePERst bit.
> 
> Can you maybe look at it?

Some details are in "PCIe Reset" section in Hardware Specification. In
Software Functional Specification seems to be nothing useful. Just those
registers without description.

> Removed the reset-gpios and set the PERST pinmux to PCIe, and the
> QCA9377 card will
> show up, but I have no idea whether PERST# actually ever gets toggled.
> 
> Regards,
> Robert
> -- 
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura Ltd.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr
