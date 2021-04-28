Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2B36D731
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhD1MY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhD1MY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:24:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1985E6141B;
        Wed, 28 Apr 2021 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619612623;
        bh=qDz6ioW7WdzfW3Xn914Til56FirhiQ5wMoqh1SYnEtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ijtb5chXB71uA7ryrjCS+bIv2W4ArCibiy3aV30eTdysF0Ni0H9Xyan23dc1r/uDy
         lP8bsIvI/54C2w/oOG+liMMSmJo+nWb/qrREkXfTzzkpwIt4d28p3aqwzJ+dmXSuag
         QsLJNJ620IjvZyIt0aOem9pvQyphApgUnKEbOvlk=
Date:   Wed, 28 Apr 2021 14:23:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 037/190] Revert "RDMA/core: Fix several reference count
 leaks."
Message-ID: <YIlTzGLpbRj3rh/R@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-38-gregkh@linuxfoundation.org>
 <20210421141444.GL1370958@nvidia.com>
 <YIgfbZDo9eQ2tKvc@kroah.com>
 <20210427161235.GB1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427161235.GB1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:12:35PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 27, 2021 at 04:27:57PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 21, 2021 at 11:14:44AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 21, 2021 at 02:58:32PM +0200, Greg Kroah-Hartman wrote:
> > > > This reverts commit 0b8e125e213204508e1b3c4bdfe69713280b7abd.
> > > > 
> > > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > > faith" to try to test the kernel community's ability to review "known
> > > > malicious" changes.  The result of these submissions can be found in a
> > > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > > 
> > > > Because of this, all submissions from this group must be reverted from
> > > > the kernel tree and will need to be re-reviewed again to determine if
> > > > they actually are a valid fix.  Until that work is complete, remove this
> > > > change to ensure that no problems are being introduced into the
> > > > codebase.
> > > > 
> > > > Cc: https
> > > > Cc: Qiushi Wu <wu000273@umn.edu>
> > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >  drivers/infiniband/core/sysfs.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > The original commit is certainly moving things closer to being correct
> > > but I'm concerned the entire area is still not bug free, it will take
> > > me some time to check the whole code. Reverting seems reasonable for
> > > now
> > 
> > I just re-reviewed it, and it looks like the original commit is ok, so I
> > will drop this.
> 
> This was what I thought too when I originally applied it..
> 
> > But ugh, this is horrid code, you should NOT be dealing with "raw"
> > kobjects here at all, just to try to make a subdirectory tree.  That
> > causes a total mess as this function shows and probably should be
> > cleaned up sometime as obviously userspace tools are not properly seeing
> > the objects you are creating here (hint, you can not put a kobject below
> > a 'struct device' in the device tree and have udev and others see it
> > properly...)
> 
> We've talked about this specifically before:
> 
> http://lore.kernel.org/r/20210331170720.GY2710221@ziepe.ca
> 
> I still don't understand what you mean by "udev sees it properly", as
> above, all the tests I thought of look OK.

Can you query the udev database to see the attribute values?

> It is uABI at this point that real userspace software relies on, so we
> can't change the sysfs paths. If there is a more right way to code it
> then let me know I can have a go - Kees also recently found some bad
> stuff here I hope to get to soon.

It's on my long "list of things to get to eventually"...

As you say, it's uABI for now, so odds are nothing can be changed.  It's
just no fun for when other subsystems want to do this same thing, they
point at this code and say "see, they did it!" :)

thanks,

greg k-h
