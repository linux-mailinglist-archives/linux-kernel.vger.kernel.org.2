Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4049A3C8999
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhGNRVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:21:09 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhGNRVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:21:08 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D3FC8CC;
        Wed, 14 Jul 2021 19:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626283095;
        bh=ZGkMV8sDWIogo+fVef+xYu8TVBeuYIR2zPF/V59CSjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=go82Ez756GWFpyWT00c5spMYfJOmtnUfukPm4ZLdDiKOvOnpm9Tkop0iNqrgxZHJU
         KBHONmJDj9W+P2wc5QKBEkBNerVZbZl3G0+qYnjAHobS73E9aGNqnPudvN9o+uNC1L
         k300l/44mowdcYgFdBpaUmngm5cSlVsjod6gWZpI=
Date:   Wed, 14 Jul 2021 20:18:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <YO8cVWNmUvU/LKGi@pendragon.ideasonboard.com>
References: <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
 <YO6RTh8ngNKZxzj+@pendragon.ideasonboard.com>
 <20210714165948.GG4719@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714165948.GG4719@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 05:59:48PM +0100, Mark Brown wrote:
> On Wed, Jul 14, 2021 at 10:25:02AM +0300, Laurent Pinchart wrote:
> > On Tue, Jul 13, 2021 at 07:18:37PM +0100, Mark Brown wrote:
> 
> > > Like I said in the other mail fwnode is a nice hack for systems that are
> > > using ACPI but have hardware that's doing something totally outside the
> > > ACPI model to allow them to reuse work that's been done for DT, it's not
> > > a universal solution to the lack of appropriate support for describing
> > > modern systems in ACPI.
> 
> > fwnode, as an abstraction of ACPI and OF, is quite useful for camera
> > sensor drivers for instance. They need to read firmware properties (for
> > instance to identify whether a camera is located on the front or back of
> > the device, or to what port of the SoC it's connected), and being able
> > to do so without duplicating OF and ACPI code in drivers is useful.
> 
> I'd still say that's a bit of a hack, it's the sort of area where ACPI
> just has absolutely no handling at all and so picking up the DT bindings
> will work effectively although it results in something that's really not
> at all idiomatic for ACPI since idiomatic DT and idiomatic ACPI don't
> really look like each other and AIUI this stuff isn't getting adopted
> for actual firmware (as opposed to swnodes) outside of the embedded x86
> space.

It's only one data point, but we're seeing adoption of the ACPI
DT-in-DSD for camera. It's still not pretty of course.

> > swnode, on the other hand, is indeed more of a workaround for a
> > more-often-than-not broken ACPI implementation. It's ironic to think
> > that x86 ACPI-based systems, touted as being superior to ARM, are now in
> > a worst state than OF-based systems.
> 
> The unfortunate thing is that ACPI is super limited in what systems it
> models, making assumptions that only really work for fairly simple
> server class systems.  Outside of that the models it's offering just
> can't cope with actual hardware yet people still insist on building
> those systems with ACPI system descriptions so you end up with huge
> piles of platform quirks.  Audio support for modern x86 laptops is just
> an endless procession of quirks :(

I feel your pain. On the camera side, we have a case of an I2C
controller that has a PCI driver in the kernel used when dealing with
the camera sensor, and an AML "driver" used by an I2C GPIO expander,
completely modelled in the DSDT. Both poke the same PCI registers of the
I2C controller. I tried to get information from Intel on how this was
meant to be handled, but I think the people responsible for the design
have been exfiltrated to Guantanamo, or are expiating their sins in a
monastery lost in a mountain.

Once travel will be easier again, we'll plot a take over of the world in
a bar. Dealing with ACPI requires lots of whisky :-)

-- 
Regards,

Laurent Pinchart
