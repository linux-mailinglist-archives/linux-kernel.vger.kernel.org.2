Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6036C990
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhD0QjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236449AbhD0Qio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:38:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC88261182;
        Tue, 27 Apr 2021 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541481;
        bh=8pdit4s5wZsshr5W24iZWFiKtXkUmXHMqCr6yeX4n/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrL0gN+ITl3qyDtTX7H0QJbOxIQxxfvxLyaV6WOQWGPNgVquZlgjEwtOUio7Km3y3
         W2VLfgjJBJMMNm3yJQyvXOTotCTN95jUV9bwjvJYp2WEG/vobFbLJJxH6TDvPwf39n
         cxF4pTQ5d5tZYnNk0uYZJHPQNBR3WxEIsE01Xtqg=
Date:   Tue, 27 Apr 2021 18:37:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        Qiushi Wu <wu000273@umn.edu>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH 036/190] Revert "vfio/mdev: Fix reference count leak in
 add_mdev_supported_type"
Message-ID: <YIg956FLPrswQr3p@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-37-gregkh@linuxfoundation.org>
 <20210421183634.GA2290758@nvidia.com>
 <20210421170359.1b8f481b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421170359.1b8f481b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:03:59PM -0600, Alex Williamson wrote:
> On Wed, 21 Apr 2021 15:36:34 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Apr 21, 2021 at 02:58:31PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit aa8ba13cae3134b8ef1c1b6879f66372531da738.
> > > 
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > 
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > > 
> > > Cc: Qiushi Wu <wu000273@umn.edu>
> > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)  
> > 
> > I recently audited all of this mdev stuff, the original patch is OK,
> > though I would have written it with a goto. Please don't revert it.
> 
> Agreed, the original commit looks correct.  Thanks,

Thanks to both of you for the review, I'll drop my revert from my tree.

greg k-h
