Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCCB36C830
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhD0PBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236534AbhD0PB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:01:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26DF261131;
        Tue, 27 Apr 2021 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619535641;
        bh=bZSDzIrPnzA88AECriBmOcbuFWjzIAAagpJSP19FlSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDFj5qfvg/9wVwukdmeHn5UQU/CW+i0Si8WSQyGAB7TKpadEhbwqo6S72APC6w+nq
         5ITXqOev0/OM0H4Vjm3L5ZaRU45bZrnj5p1KOMM71gX0tuGYkDoSXRnYsqRaHu5ezb
         ATFVLDNlklutTjxNQZToETuCJ7qF/lcHQ3S/Gjik=
Date:   Tue, 27 Apr 2021 17:00:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>, Aditya Pakki <pakki001@umn.edu>,
        Finn Thain <fthain@telegraphics.com.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 097/190] Revert "video: imsttfb: fix potential NULL
 pointer dereferences"
Message-ID: <YIgnFyk3DP8xq1Q2@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-98-gregkh@linuxfoundation.org>
 <CAL_JsqKoqh=-8UHk9JkCgK1fC7bVjVLNehHUM=R_g6fDan3dHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKoqh=-8UHk9JkCgK1fC7bVjVLNehHUM=R_g6fDan3dHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:13:29PM -0500, Rob Herring wrote:
> On Wed, Apr 21, 2021 at 8:05 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This reverts commit 1d84353d205a953e2381044953b7fa31c8c9702d.
> >
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> >
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> >
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Finn Thain <fthain@telegraphics.com.au>
> > Cc: Rob Herring <robh@kernel.org>
> 
> Sigh, get_maintainers.pl likes to punish people for treewide clean-ups...
> 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/video/fbdev/imsttfb.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
> > index 3ac053b88495..e04411701ec8 100644
> > --- a/drivers/video/fbdev/imsttfb.c
> > +++ b/drivers/video/fbdev/imsttfb.c
> > @@ -1512,11 +1512,6 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >         info->fix.smem_start = addr;
> >         info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
> >                                             0x400000 : 0x800000);
> > -       if (!info->screen_base) {
> > -               release_mem_region(addr, size);
> > -               framebuffer_release(info);
> > -               return -ENOMEM;
> > -       }
> 
> The original change appears to be valid, but incomplete...
> 
> >         info->fix.mmio_start = addr + 0x800000;
> >         par->dc_regs = ioremap(addr + 0x800000, 0x1000);
> 
> ...because what about cleanup when this ioremap fails.
> 
> >         par->cmap_regs_phys = addr + 0x840000;
> 
> Then again, if anyone really cared about this driver and h/w (a
> PowerMac era PCI display card), it would not still be using fbdev and
> would use devm_* apis.

Thanks for the review, I've updated the changelog to reflect this mess :)

greg k-h
