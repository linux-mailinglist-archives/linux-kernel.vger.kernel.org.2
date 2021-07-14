Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332413C9369
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhGNV43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:56:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C189C06175F;
        Wed, 14 Jul 2021 14:53:36 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 31C89CC;
        Wed, 14 Jul 2021 23:53:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626299614;
        bh=pWKpxPOvoAW7FKSdGJi+ZdPivLsbxsmn5uEaNivCJZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxupBf46z7lsaydCKXHIGaIcqgX6jf/wgEJkDCEodah700UlwEICBYdBA2nFI7O//
         WfC95RiNsYHoVTcTx5m274S21CFjGuF/hOn8XODn0+G4k+EGOpNH3TSQFN5WIdkPC4
         PnTqUYo3Ta4cAjkCynTVR5QbaHEHe0kEh8tZ6Nmo=
Date:   Thu, 15 Jul 2021 00:53:32 +0300
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
        kieran.bingham@ideasonboard.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <YO9c3Aofj0UJ1c3f@pendragon.ideasonboard.com>
References: <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
 <YO6RTh8ngNKZxzj+@pendragon.ideasonboard.com>
 <20210714165948.GG4719@sirena.org.uk>
 <YO8cVWNmUvU/LKGi@pendragon.ideasonboard.com>
 <20210714172846.GI4719@sirena.org.uk>
 <YO8hxyrHqY7K43wp@pendragon.ideasonboard.com>
 <20210714191855.GJ4719@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714191855.GJ4719@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 08:18:55PM +0100, Mark Brown wrote:
> On Wed, Jul 14, 2021 at 08:41:27PM +0300, Laurent Pinchart wrote:
> > On Wed, Jul 14, 2021 at 06:28:46PM +0100, Mark Brown wrote:
> > > On Wed, Jul 14, 2021 at 08:18:13PM +0300, Laurent Pinchart wrote:
> > > > It's only one data point, but we're seeing adoption of the ACPI
> > > > DT-in-DSD for camera. It's still not pretty of course.
> > >
> > > By non-Linux system vendors?
> >
> > For Windows-based machines, yes. It's fairly new, and the information I
> > have is that those machines may ship DSDT containing both Windows-style
> > (read: crap) data and Linux-style data for the same nodes. My fear is
> > that only the former will be properly tested and the latter will thus be
> > incorrect. The future will tell (I'm as usual very hopeful).
> 
> Adding the Intel audio people - it'd be good if we could get some
> similar stuff started for the audio things.  Sadly in these sorts of
> cases AIUI the Windows thing is broadly to match DMI data and supply
> platform data so it's more a case of just not having essential
> information in firmware, a bad format would be better TBH (assuming it's
> accurate which also requires loads of quirks...).

On the camera side, the Windows-based machines I've worked with (Skylake
and Kabylak) have data in the DSDT. There's data we can use directly,
and there's a lot that is hardcoded in the Windows driver (including
what voltage to program on the different outputs of an I2C-controlled
regulator - you get that wrong, you fry your camera). I believe Intel
provides a small set of reference designs with several options to the
OEMs, and I wouldn't be surprised if some of the data present in ACPI
that we don't know how to interpret would identify these options. I
don't think the Windows driver has DMI-based quirks, the driver isn't
machine-specific as far as I can tell.

For newer devices, ACPI should contain Windows data in a format that the
Windows team decides on its own, and data that is actually usable in the
_DSD for Linux. I've also heard that the power management would be
saner, with PM actually implemented in the DSDT. I haven't seen those
DSDT yet though.

-- 
Regards,

Laurent Pinchart
