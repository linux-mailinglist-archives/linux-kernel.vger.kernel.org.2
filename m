Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24C3D0A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhGUHPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235427AbhGUHNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:13:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C54260FE9;
        Wed, 21 Jul 2021 07:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626854069;
        bh=r7maj2kuI2vO86xAHo4bhkYzsnBLjpZXw4i7HuI1fKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4+8tGxIJIsGfGI7MxKLPA5/acCyol3lQYiJMFk24n8hWJNiyOHP6JueaT8XE3kah
         y+ZR98MwkHWJJHvsLOPvdQEkloisxIv76OMm5TSaTLsXcbCNnN7t/TzsVGn0/J84oa
         uH9LRFB/t49zGMhWxfSH6TXADEMLXoj5QuekfqPA=
Date:   Wed, 21 Jul 2021 09:54:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Moritz Fischer <moritz.fischer.private@gmail.com>,
        Moritz Fischer <mdf@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: Renesas USB host broken after commit d143825baf15
Message-ID: <YPfSsx8p32w72OCB@kroah.com>
References: <s5h7dhkoaa2.wl-tiwai@suse.de>
 <YPdcUrR5J6vA2Glr@epycbox.lan>
 <s5h1r7snneh.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1r7snneh.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 09:20:38AM +0200, Takashi Iwai wrote:
> On Wed, 21 Jul 2021 01:29:22 +0200,
> Moritz Fischer wrote:
> > 
> > Hi Takashi,
> > 
> > On Wed, Jul 21, 2021 at 01:06:29AM +0200, Takashi Iwai wrote:
> > > Hi,
> > > 
> > > the recent patch landed in 5.13.2 stable tree from the upstream commit
> > > d143825baf15 ("usb: renesas-xhci: Fix handling of unknown ROM state")
> > > seems causing a regression on a few machines, as reported on openSUSE
> > > Bugzilla:
> > >   https://bugzilla.opensuse.org/show_bug.cgi?id=1188485
> > >   https://bugzilla.opensuse.org/show_bug.cgi?id=1188515
> > > 
> > > Reverting it on top of 5.13.3 fixed the problem, so it's likely the
> > > cause.  Could you guys take a look?
> > 
> > I've sent out a revert patch.
> > 
> > https://lore.kernel.org/linux-usb/20210719070519.41114-1-mdf@kernel.org/T/#u
> > 
> > I think the driver has more problems but I'll tackle that in a follow up
> > patch, lets get this unbricked, first.
> 
> OK, thank you for the information!

I've reverted this now, will get it to Linus for 5.14-rc3, sorry about
that.

thanks,

greg k-h
