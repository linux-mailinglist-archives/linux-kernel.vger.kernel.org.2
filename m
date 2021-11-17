Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE52945411D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhKQGrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233802AbhKQGrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:47:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D98361BD3;
        Wed, 17 Nov 2021 06:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637131495;
        bh=2BahWqz3SACprKDGz/OC1O6XlOxeqnKOL020Tfr3z1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1S0fcbtI2GAWgzc+qcslMmHuvtO93bC2iQZcVO2Ln8xL/7ryWFPpIFN1K0YWZbDF
         nXXGA+xnz8aAqOHBhmI8tjfdC0EAuh3DFXQmB2P9VvGa01e8VLHujCTzpyRtBrYcys
         7/7+IirOwjMb0Hz2CMrWazqNeAygJHp20lbHeAfw=
Date:   Wed, 17 Nov 2021 07:44:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZSk3DECnnknOu5T@kroah.com>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZQkQcrldGFwqV/r@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 01:36:01PM -0800, Minchan Kim wrote:
> On Tue, Nov 16, 2021 at 08:49:46PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 16, 2021 at 11:43:17AM -0800, Minchan Kim wrote:
> > > The kernfs implementation has big lock granularity(kernfs_rwsem) so
> > > every kernfs-based(e.g., sysfs, cgroup, dmabuf) fs are able to compete
> > > the lock. Thus, if one of userspace goes the sleep under holding
> > > the lock for a long time, rest of them should wait it. A example is
> > > the holder goes direct reclaim with the lock since it needs memory
> > > allocation. Let's fix it at common technique that release the lock
> > > and then allocate the memory. Fortunately, kernfs looks like have
> > > an refcount so I hope it's fine.
> > > 
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  fs/kernfs/dir.c             | 14 +++++++++++---
> > >  fs/kernfs/inode.c           |  2 +-
> > >  fs/kernfs/kernfs-internal.h |  1 +
> > >  3 files changed, 13 insertions(+), 4 deletions(-)
> > 
> > What workload hits this lock to cause it to be noticable?
> 
> A app launching since it was dropping the frame since the
> latency was too long.

How does running a program interact with kernfs filesystems?  Which
one(s)?

> > There was a bunch of recent work in this area to make this much more
> > fine-grained, and the theoritical benchmarks that people created (adding
> > 10s of thousands of scsi disks at boot time) have gotten better.
> > 
> > But in that work, no one could find a real benchmark or use case that
> > anyone could even notice this type of thing.  What do you have that
> > shows this?
> 
> https://developer.android.com/studio/command-line/perfetto
> https://perfetto.dev/docs/data-sources/cpu-scheduling

That is links to a tool, not a test we can run ourselves.

Or how about the output of that tool?

> Android has perfetto tracing system and can show where processes
> were stuck. This case was the lock since holder was in direct reclaim
> path.

Reclaim of what?  What is the interaction here with kernfs?  Normally
this filesystem is not on any "fast paths" that I know of.

More specifics would be nice :)

thanks,

greg k-h
