Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7842A36C9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhD0Qox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236169AbhD0Qov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:44:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F614613D9;
        Tue, 27 Apr 2021 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541847;
        bh=EmmnL/cy7W84WTRcqLXm2uxSDfTW0ua9r1rfSq1Aq6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAAew465q1zNbOIv5oXwKeRmW9zGqf1JlX5pZhfOCMUooW7okigb3cRTrycTzOyPf
         Nocm9zmvgRskRed73ZoDvtERnnBow6ReHbL6yel2EtH0GCo6r6TAtO1Jk0e1loX2c1
         pfEmW/UtbLIIW6ifGyqh4Ml0S3UT3a4qForr8gis=
Date:   Tue, 27 Apr 2021 18:44:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "Anholt, Eric" <eric@anholt.net>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <YIg/Vc0QdIIP4Nxv@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <CAKMK7uFONR-12CZEGJLrjgS0N-kF_v7_cXJEiSBPFoBbyRHn0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFONR-12CZEGJLrjgS0N-kF_v7_cXJEiSBPFoBbyRHn0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 07:35:44PM +0200, Daniel Vetter wrote:
> On Wed, Apr 21, 2021 at 3:01 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > I have been meaning to do this for a while, but recent events have
> > finally forced me to do so.
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
> > This patchset has the "easy" reverts, there are 68 remaining ones that
> > need to be manually reviewed.  Some of them are not able to be reverted
> > as they already have been reverted, or fixed up with follow-on patches
> > as they were determined to be invalid.  Proof that these submissions
> > were almost universally wrong.
> 
> Will you take care of these remaining ones in subsequent patches too?

Yes I will.

> > I will be working with some other kernel developers to determine if any
> > of these reverts were actually valid changes, were actually valid, and
> > if so, will resubmit them properly later.  For now, it's better to be
> > safe.
> >
> > I'll take this through my tree, so no need for any maintainer to worry
> > about this, but they should be aware that future submissions from anyone
> > with a umn.edu address should be by default-rejected unless otherwise
> > determined to actually be a valid fix (i.e. they provide proof and you
> > can verify it, but really, why waste your time doing that extra work?)
> >
> > thanks,
> >
> > greg k-h
> >
> > Greg Kroah-Hartman (190):
> >   Revert "net/rds: Avoid potential use after free in
> >     rds_send_remove_from_sock"
> >   Revert "media: st-delta: Fix reference count leak in delta_run_work"
> >   Revert "media: sti: Fix reference count leaks"
> >   Revert "media: exynos4-is: Fix several reference count leaks due to
> >     pm_runtime_get_sync"
> >   Revert "media: exynos4-is: Fix a reference count leak due to
> >     pm_runtime_get_sync"
> >   Revert "media: exynos4-is: Fix a reference count leak"
> >   Revert "media: ti-vpe: Fix a missing check and reference count leak"
> >   Revert "media: stm32-dcmi: Fix a reference count leak"
> >   Revert "media: s5p-mfc: Fix a reference count leak"
> >   Revert "media: camss: Fix a reference count leak."
> >   Revert "media: platform: fcp: Fix a reference count leak."
> >   Revert "media: rockchip/rga: Fix a reference count leak."
> >   Revert "media: rcar-vin: Fix a reference count leak."
> >   Revert "media: rcar-vin: Fix a reference count leak."
> >   Revert "firmware: Fix a reference count leak."
> >   Revert "drm/nouveau: fix reference count leak in
> >     nouveau_debugfs_strap_peek"
> >   Revert "drm/nouveau: fix reference count leak in
> >     nv50_disp_atomic_commit"
> >   Revert "drm/nouveau: fix multiple instances of reference count leaks"
> >   Revert "drm/nouveau/drm/noveau: fix reference count leak in
> >     nouveau_fbcon_open"
> >   Revert "PCI: Fix pci_create_slot() reference count leak"
> >   Revert "omapfb: fix multiple reference count leaks due to
> >     pm_runtime_get_sync"
> >   Revert "drm/radeon: Fix reference count leaks caused by
> >     pm_runtime_get_sync"
> >   Revert "drm/radeon: fix multiple reference count leak"
> >   Revert "drm/amdkfd: Fix reference count leaks."
> 
> I didn't review these carefully, but from a quick look they all seem
> rather inconsequental. Either error paths that are very unlikely, or
> drivers which are very dead (looking at the entire list, not just what
> you reverted here).
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks for the quick review, I'm now going over them all again to see if
they are valid or not, some of the pm reference count stuff all looks
correct.  Others not at all.

> Also adding drm maintainers/lists, those aren't all on your cc it
> seems. I will also forward this to fd.o sitewranglers as abuse of our
> infrastructure, it's for community collaboration, not for inflicting
> experiments on unconsenting subjects.

Much appreciated.

greg k-h
