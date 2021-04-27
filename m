Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBE36C5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhD0L7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhD0L7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:59:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F93661168;
        Tue, 27 Apr 2021 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524698;
        bh=m0kncE+t/ZL2QRGLa5VbuKBcSzNWkkZAIDiDY7bGZog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKrq6dPrtCgp6/+Izi0VoDWDAQXYKPel8z68WlN03vGqDsY795jh3lQ6gkAkHYjtx
         6IeNSfD9Kfr9HWROjT2Bj+2MLRv+Lo2UuR/IiL9Ap9cVJvL3wvUwj/vl32BipA95c6
         rfyCX+b9GlhH7S2186jLYbt0yW4Z4Yx7Pe2D7fI0=
Date:   Tue, 27 Apr 2021 13:58:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 029/190] Revert "EDAC: Fix reference count leaks"
Message-ID: <YIf8V9Q9FEWEPTsp@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-30-gregkh@linuxfoundation.org>
 <20210421185555.GA24470@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421185555.GA24470@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 08:55:55PM +0200, Borislav Petkov wrote:
> On Wed, Apr 21, 2021 at 02:58:24PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 17ed808ad243192fb923e4e653c1338d3ba06207.
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
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: https
> > Cc: https
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/edac/edac_device_sysfs.c | 1 -
> >  drivers/edac/edac_pci_sysfs.c    | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
> > index 5e7593753799..0e7ea3591b78 100644
> > --- a/drivers/edac/edac_device_sysfs.c
> > +++ b/drivers/edac/edac_device_sysfs.c
> > @@ -275,7 +275,6 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
> >  
> >  	/* Error exit stack */
> >  err_kobj_reg:
> > -	kobject_put(&edac_dev->kobj);
> >  	module_put(edac_dev->owner);
> >  
> >  err_out:
> > diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
> > index 53042af7262e..72c9eb9fdffb 100644
> > --- a/drivers/edac/edac_pci_sysfs.c
> > +++ b/drivers/edac/edac_pci_sysfs.c
> > @@ -386,7 +386,7 @@ static int edac_pci_main_kobj_setup(void)
> >  
> >  	/* Error unwind statck */
> >  kobject_init_and_add_fail:
> > -	kobject_put(edac_pci_top_main_kobj);
> > +	kfree(edac_pci_top_main_kobj);
> >  
> >  kzalloc_fail:
> >  	module_put(THIS_MODULE);
> > -- 
> 
> That one is actually correct. 
> 
> AFAIR, that was a reaction to kobject_init_and_add()'s comment saying
> users should do kobject_put() when that function fails.
> 
> So the added kobject_put() would make sure the ->release method is
> called which will kfree the kobject and drop the module reference. And
> both ->release methods don't do anything else so there are no side
> effects from it like with other cases earlier today.
> 
> So yeah, that one could stay in.

Thanks for the review, now dropping.

greg k-h
