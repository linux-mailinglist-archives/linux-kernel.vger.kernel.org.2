Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12A53C7F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhGNH2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:28:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48938 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbhGNH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:28:42 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EA3B1CC;
        Wed, 14 Jul 2021 09:25:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626247550;
        bh=FHaK7LCeXm0ddcvm28KKclM3BYOn8V6Kc/4KTd3HnCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o99QVmzYx8nDU2Dm5COxoFpycb5t4qxu1X79lRGg49EOuVn//0UqJ6TZXCQniJcK4
         2ti0s8FNiwe8UcDldx8/r0AFuWrKoGKgdodAB6z16JPg1WPnMv7AWQMXK2hItFcQ3Y
         uRYxfUvZHH/z8j+2ESdsHOamXQgVnH6W9YTOX4VM=
Date:   Wed, 14 Jul 2021 10:25:02 +0300
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
Message-ID: <YO6RTh8ngNKZxzj+@pendragon.ideasonboard.com>
References: <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210713181837.GE4098@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jul 13, 2021 at 07:18:37PM +0100, Mark Brown wrote:
> On Tue, Jul 13, 2021 at 06:55:59PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 13, 2021 at 6:25 PM Mark Brown <broonie@kernel.org> wrote:
> 
> > > The driver code is trivial boilerplate, assuming someone doesn't go and
> > > implement a helper to register stuff separately like I suggested.  The
> > > proposed swnode stuff would involve duplicating the DT parsing code.
> > > This seems like a whole lot of effort for something that provides a
> > > worse result than either of the existing things.
> 
> > I'm not sure I follow. Where did you see the duplication when I saw
> > the other way around?
> 
> The current patch consists entirely of additions, it does not remove any
> existing code at all, the diffstat is:
> 
>  5 files changed, 174 insertions(+)
> 
> > Converting code from OF to fwnode APIs in most cases is smooth and
> > doesn't add any overhead to the codebase,
> 
> We explicitly do not want to attempt to parse regulator properties out
> of ACPI platform descriptions because using the regulator binding on
> ACPI platforms conflicts with the ACPI model for power management and
> we really don't want to encourage platforms to attempt to mix and match
> here, it's not going to lead to anything robust.  System integrators
> that need this sort of OS visible low level power management really
> should be working with the UEFI forum to get an ACPI specification for
> it, or if they don't really need it fixing up their AML to DTRT.
> 
> If you were to say that we could bodge around that by somehow forcing
> this binding to exist only for swnodes when running on ACPI systems then
> we'd still have the problems with creating something with worse tooling
> than what's there already.
> 
> Like I said in the other mail fwnode is a nice hack for systems that are
> using ACPI but have hardware that's doing something totally outside the
> ACPI model to allow them to reuse work that's been done for DT, it's not
> a universal solution to the lack of appropriate support for describing
> modern systems in ACPI.

fwnode, as an abstraction of ACPI and OF, is quite useful for camera
sensor drivers for instance. They need to read firmware properties (for
instance to identify whether a camera is located on the front or back of
the device, or to what port of the SoC it's connected), and being able
to do so without duplicating OF and ACPI code in drivers is useful.

swnode, on the other hand, is indeed more of a workaround for a
more-often-than-not broken ACPI implementation. It's ironic to think
that x86 ACPI-based systems, touted as being superior to ARM, are now in
a worst state than OF-based systems.

-- 
Regards,

Laurent Pinchart
