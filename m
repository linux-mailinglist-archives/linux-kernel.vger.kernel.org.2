Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD2426BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhJHNpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhJHNpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:45:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF65160F5B;
        Fri,  8 Oct 2021 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633700629;
        bh=1o9q1XcL0I+ROV0ip9arNCr7TM35n15Zzw1snvEtGcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGnWbO0Mzk+jd1zPqtfu0npWY10dB4OeJnTuFb6RA3BkXr9+Oek/joN9GpIRNYitX
         xJiJs8+lL6jUhWRKkJPiLmgbXaSmad9ISbNq1w+nm/bLQz6erKUx8mZkdbkODZ8jV4
         Y6ukTvxxsstcHhBHqgnPE9dLP+mzAdX/QrWMv932mWSTtnmK14Pa3x+F9YnycdifJJ
         MHsuTfMZsUPIHe5alopFMUxQRYJoiyVxqNci3z1S0jF2ULemwVsSkuAnVSicbpzhiv
         vsF0pOklNqVJkgX2DvJgwzmbD+qs0j+v6pviv9XSUdy5alB5XzoWnRtGY1Y7CzsvtP
         PynHQzujJGUeA==
Received: by pali.im (Postfix)
        id 76DD3760; Fri,  8 Oct 2021 15:43:47 +0200 (CEST)
Date:   Fri, 8 Oct 2021 15:43:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: dts: marvell: add Globalscale MOCHAbin
Message-ID: <20211008134347.lskm5pzt73pkf7oc@pali>
References: <20211008114343.57920-1-robert.marko@sartura.hr>
 <20211008120855.46zbo2fl5edwf7ja@pali>
 <CA+HBbNGvFtws2GF7RLbznAbXfvjKx4rOJ=eMeuHOJ6s7iANtzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNGvFtws2GF7RLbznAbXfvjKx4rOJ=eMeuHOJ6s7iANtzw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2021 15:28:38 Robert Marko wrote:
> > > +     cp0_pcie_reset_pins: cp0-pcie-reset-pins {
> > > +             marvell,pins = "mpp9";
> > > +             marvell,function = "gpio";
> >
> > Now I spotted this. Why is PERST# pin configured into gpio mode? Is
> > there some issue that this pin in pcie mode is not working properly,
> > that PCIe controller cannot handle it correctly? Or something else?
> 
> Its because I have seen way too many broken controllers when it comes
> to PERST and
> other Armada 7k/8k devices are using it in GPIO mode as well.
> Just look at the number of conversions back to GPIO for other
> platforms as there is always some bug.

I know that A3720 has broken PERST# control in PCIe block... or at least
I was not able to figure out how A3720 PCIe block can control PERST#. So
configuring it in gpio mode and let PERST# to be controlled manually via
gpio by the software is the workaround.

I just wanted to know if A7k/A8k/CN913x is also broken in the same way
as A3720.

Or it it just a configuration workaround for missing driver or missing
proper software setup.

HW bugs like this should be properly documented and not hidden behind
some configuration in DTS file. And reported to HW vendors.
