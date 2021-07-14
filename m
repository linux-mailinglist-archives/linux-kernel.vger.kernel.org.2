Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9773C89EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbhGNRoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhGNRoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:44:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A4C06175F;
        Wed, 14 Jul 2021 10:41:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5787BCC;
        Wed, 14 Jul 2021 19:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626284488;
        bh=mO8N+B/iHyg8PhJT0Ov+6j+X77k5KOjgU3MVEamebX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=taPSFyeVCgKD+NKlY5NCh5DNc+7BaKJpbG7P/TFPIaNnnp0LAlTY8f0Z7RV8DQuNC
         NAcacbDqJVNW3pnF00+tBLuhHnnsDoyukNguf1LNGEbUrCFxWqMiP/n+YLtXZEUOkb
         CduFcgC0zSRSIlpROQgWYxpX1IXCumte/5oN5Zi8=
Date:   Wed, 14 Jul 2021 20:41:27 +0300
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
Message-ID: <YO8hxyrHqY7K43wp@pendragon.ideasonboard.com>
References: <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
 <YO6RTh8ngNKZxzj+@pendragon.ideasonboard.com>
 <20210714165948.GG4719@sirena.org.uk>
 <YO8cVWNmUvU/LKGi@pendragon.ideasonboard.com>
 <20210714172846.GI4719@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714172846.GI4719@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 06:28:46PM +0100, Mark Brown wrote:
> On Wed, Jul 14, 2021 at 08:18:13PM +0300, Laurent Pinchart wrote:
> > On Wed, Jul 14, 2021 at 05:59:48PM +0100, Mark Brown wrote:
> 
> > > really look like each other and AIUI this stuff isn't getting adopted
> > > for actual firmware (as opposed to swnodes) outside of the embedded x86
> > > space.
> 
> > It's only one data point, but we're seeing adoption of the ACPI
> > DT-in-DSD for camera. It's still not pretty of course.
> 
> By non-Linux system vendors?

For Windows-based machines, yes. It's fairly new, and the information I
have is that those machines may ship DSDT containing both Windows-style
(read: crap) data and Linux-style data for the same nodes. My fear is
that only the former will be properly tested and the latter will thus be
incorrect. The future will tell (I'm as usual very hopeful).

> My understanding has been that for audio people are just unwilling to
> provide the level of firmware description required to avoid quirks,
> there was some limited stuff with the NHLT table but it still required
> system software to quirk things.  If there's progress elsewhere
> perhaps the relevant people can be persuaded to have another go...
> 
> > Once travel will be easier again, we'll plot a take over of the world in
> > a bar. Dealing with ACPI requires lots of whisky :-)
> 
> Indeed!

-- 
Regards,

Laurent Pinchart
