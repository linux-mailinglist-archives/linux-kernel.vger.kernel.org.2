Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029403D7879
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhG0O2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232385AbhG0O2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:28:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEE2B61A80;
        Tue, 27 Jul 2021 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627396115;
        bh=2DIRecdEi7hvzrqkcRwqbedy5NIT/w3FUP41eABf8w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIGq5srcnO/B53N91VtkTyKZQJ/s40Ra+/w/WFn3cGewaA/zUlXrzRb8+RGrDmTyP
         g+fPFq6ju800V/sDle3TX93XgAGYG3PSsPnU5I0LlidA4qkBNYbxBnVF8jrkDOzvfR
         RO9BQ6M6pxQWNVrf6UwTq2b/Ux5M0WaEMUB2j5jU=
Date:   Tue, 27 Jul 2021 16:28:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: Re: [PATCH v3 0/7] staging: rtl8188eu: replace driver with better
 version
Message-ID: <YQAYER8JxrXG0f+G@kroah.com>
References: <20210724001055.1613840-1-phil@philpotter.co.uk>
 <YQAE1q9ZWRPHqfK5@kroah.com>
 <CAA=Fs0nwOBUoCSbwzaE7TTQab_BZcCy2SL1RJby+Hmo=URw_Pg@mail.gmail.com>
 <YQAOdEz9GfhpCeBZ@kroah.com>
 <c42ded8d-8027-eee3-c1c5-54e0736a1758@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c42ded8d-8027-eee3-c1c5-54e0736a1758@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 09:13:09AM -0500, Larry Finger wrote:
> On 7/27/21 8:47 AM, Greg KH wrote:
> > On Tue, Jul 27, 2021 at 02:25:34PM +0100, Phillip Potter wrote:
> > > On Tue, 27 Jul 2021 at 14:06, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > On Sat, Jul 24, 2021 at 01:10:48AM +0100, Phillip Potter wrote:
> > > > > I had to break this patchset up a bit to get around the file size limits
> > > > > on the mailing list, and also I removed the hostapd stuff which is
> > > > > userspace related and therefore not required.
> > > > > 
> > > > > The driver currently in staging is older and less functional than the
> > > > > version on Larry Finger's GitHub account, based upon v4.1.4_6773.20130222.
> > > > > This series of patches therefore:
> > > > > 
> > > > > (1) Removes the current driver from staging.
> > > > > (2) Imports the GitHub version mentioned above in its place.
> > > > 
> > > > Let's do (2) first before worrying about (1), given that we can't get a
> > > > version of (2) that actually builds yet :)
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Dear Greg,
> > > 
> > > I'm confused - v3 patchset builds fine for me after applying in
> > > sequence from 1 to 7?
> > 
> > Why does kbuild report problems?
> > 
> > Anyway, please let's just add the new driver in a new directory, get it
> > building, and then we can remove the old one.  That way patches will
> > continue to work and there's no confusion when backporting patches as
> > the code bases are different.
> 
> I get no kbuild problems in the staging-next branch. I have no idea why the
> test robot is reporting errors.
> 
> Keeping the old rtl8188eu directory and builds will result in 3 drivers
> competing for the hardware including rtl8xxxu, rtl8188eu, and r8188eu.

I will only "keep" it around for a day at most.  I will delete the old
driver, I just do not want the "new" driver in the same directory as the
existing one to make it easier to handle changes over time.

thanks,

greg k-h
