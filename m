Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC44541FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhKQHmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234219AbhKQHmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:42:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD48B61350;
        Wed, 17 Nov 2021 07:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637134787;
        bh=Nuc5So84Q6X06+1/kB/0jh7ulGOlJ9+M3MfCyLkrdIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2j7O7MncDswDjEVTJk7ppmoVlWdlnm9m0HnK3MRlxM6jxPF4xn9NZg+RRKJAi59D
         oVrpVJSBQBYcS1MuTfvnJQvOiI6xT7/oh/246OkJ6TO9hOuLYpM+0a2DGIGpgAo8oU
         e8kFwb40FYPpgjGVxVzp454pIF2GQuFQRo7Go4nc=
Date:   Wed, 17 Nov 2021 08:39:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZSxwM8ucqGsY1hq@kroah.com>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
 <YZSk3DECnnknOu5T@kroah.com>
 <YZSu/HiHDZxo9Wpa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZSu/HiHDZxo9Wpa@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:27:56PM -0800, Minchan Kim wrote:
> On Wed, Nov 17, 2021 at 07:44:44AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 16, 2021 at 01:36:01PM -0800, Minchan Kim wrote:
> > > On Tue, Nov 16, 2021 at 08:49:46PM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Nov 16, 2021 at 11:43:17AM -0800, Minchan Kim wrote:
> > > > > The kernfs implementation has big lock granularity(kernfs_rwsem) so
> > > > > every kernfs-based(e.g., sysfs, cgroup, dmabuf) fs are able to compete
> > > > > the lock. Thus, if one of userspace goes the sleep under holding
> > > > > the lock for a long time, rest of them should wait it. A example is
> > > > > the holder goes direct reclaim with the lock since it needs memory
> > > > > allocation. Let's fix it at common technique that release the lock
> > > > > and then allocate the memory. Fortunately, kernfs looks like have
> > > > > an refcount so I hope it's fine.
> > > > > 
> > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > ---
> > > > >  fs/kernfs/dir.c             | 14 +++++++++++---
> > > > >  fs/kernfs/inode.c           |  2 +-
> > > > >  fs/kernfs/kernfs-internal.h |  1 +
> > > > >  3 files changed, 13 insertions(+), 4 deletions(-)
> > > > 
> > > > What workload hits this lock to cause it to be noticable?
> > > 
> > > A app launching since it was dropping the frame since the
> > > latency was too long.
> > 
> > How does running a program interact with kernfs filesystems?  Which
> > one(s)?
> 
> A app launching involves dma_buf exports which creates kobject
> and add it to the kernfs with down_write - kernfs_add_one.

I thought the "create a dma_buf kobject" kernel change was fixed up to
not do that anymore as that was a known performance issue.

Creating kobjects should NOT be on a fast path, if they are, that needs
to be fixed.

> At the same time in other CPU, a random process was accessing
> sysfs and the kernfs_iop_lookup was already hoding the kernfs_rwsem
> and ran under direct reclaim patch due to alloc_inode in
> kerfs_get_inode.

What program is constantly hitting sysfs?  sysfs is not for
performance-critical things, right?

> Therefore, the app is stuck on the lock and lose frames so enduser
> sees the jank.

But how does this patch work around it?  It seems like you are
special-casing the kobject creation path only.

And is this the case really on 5.15?  I thought the kernfs locks were
broken up again to not cause this problem in 5.14 or so.

thanks,

greg k-h
