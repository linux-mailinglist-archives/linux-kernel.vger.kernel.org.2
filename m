Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39C454F89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbhKQVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhKQVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:46:57 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:43:58 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 200so3449510pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5T2nom9Esjej6HKGPgAWyV4F4hvg29G5YwUNx6pcuos=;
        b=cOPUYrifftIgrAwzA/Pr9dYvgKGDx/5dsgFXRW4/nW0bmc/fy41txA+SxulvOmYSrB
         5I+FghIzYLF7uOCpGMGykxOLanc00IB05MAmo193mlZjSB6oELkbf9QNXgOtn0lofE7S
         P/9xErveQCYoHm4hpWZ7ao21FMSM4GOH/1ecTT+Ii9BgztfPG/Bd3393gncwag29s7/Z
         m0gWlxjGHQ4RMeFr4fKr/2XUSm59aIHadWtCdeaVvtD22N1TOSKoa6uIwrWOv0nIa6GJ
         qRW8wnwl/RsjX2gzRxbca1OMhVPfiV8CxjnDcABvALEZNKtLPrxp+nlQHAhrjLi4MXKL
         YGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5T2nom9Esjej6HKGPgAWyV4F4hvg29G5YwUNx6pcuos=;
        b=qSSAuINJxxz4mEbLj4bselVP/+ogYIDLjpsy0gT8VNK+5jzY9YI2q517FpxN/lpljG
         bA2gVlx5skbI+oHxamuMszCTSMIAjqSPT1DIdQTvg2wALeBACaYGSN6MbIePJwhRh2cJ
         MANAzHHOVvSpqqBriy/QGOcOZ6r1BJ3DwCJLjMEEHK+42qTXw5pJhNKj5WLnphJJpgH3
         nbHIqAlbYfob+SvDQU4uADfZSmAxrbrjs5rkRGQHp8k+FxmZ0RnrEgASskT+TmBfwCfi
         AgYBc5F70a5Xa58zePDVC1pUdHj2Fc64de79YtrHz4D62unIi2SCjjBr/7oVyq8AnmU4
         TNFg==
X-Gm-Message-State: AOAM533jm6KrU4tmHOnI6psmkOdGofNkhhrVkzcz5aq1WM5+oYq+CG9f
        R4UAKjHNX5XVpriDWUkTHReZFNSZwpc=
X-Google-Smtp-Source: ABdhPJyiN5++DPsVLunMTWbpJ/vhK+J9kl6cIDiBIDVUFnD/I7s3gg6QeK1Muf/x/u8xhWdPXEBoLg==
X-Received: by 2002:a65:6a56:: with SMTP id o22mr7730067pgu.249.1637185437553;
        Wed, 17 Nov 2021 13:43:57 -0800 (PST)
Received: from google.com ([2620:15c:211:201:ac60:a5b:b800:3af7])
        by smtp.gmail.com with ESMTPSA id a12sm5994549pjq.16.2021.11.17.13.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 13:43:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Nov 2021 13:43:55 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        hridya@google.com
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZV3m1O6x3yQk/DZ@google.com>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
 <YZSk3DECnnknOu5T@kroah.com>
 <YZSu/HiHDZxo9Wpa@google.com>
 <YZSxwM8ucqGsY1hq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZSxwM8ucqGsY1hq@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 08:39:44AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 16, 2021 at 11:27:56PM -0800, Minchan Kim wrote:
> > On Wed, Nov 17, 2021 at 07:44:44AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Nov 16, 2021 at 01:36:01PM -0800, Minchan Kim wrote:
> > > > On Tue, Nov 16, 2021 at 08:49:46PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Tue, Nov 16, 2021 at 11:43:17AM -0800, Minchan Kim wrote:
> > > > > > The kernfs implementation has big lock granularity(kernfs_rwsem) so
> > > > > > every kernfs-based(e.g., sysfs, cgroup, dmabuf) fs are able to compete
> > > > > > the lock. Thus, if one of userspace goes the sleep under holding
> > > > > > the lock for a long time, rest of them should wait it. A example is
> > > > > > the holder goes direct reclaim with the lock since it needs memory
> > > > > > allocation. Let's fix it at common technique that release the lock
> > > > > > and then allocate the memory. Fortunately, kernfs looks like have
> > > > > > an refcount so I hope it's fine.
> > > > > > 
> > > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > > ---
> > > > > >  fs/kernfs/dir.c             | 14 +++++++++++---
> > > > > >  fs/kernfs/inode.c           |  2 +-
> > > > > >  fs/kernfs/kernfs-internal.h |  1 +
> > > > > >  3 files changed, 13 insertions(+), 4 deletions(-)
> > > > > 
> > > > > What workload hits this lock to cause it to be noticable?
> > > > 
> > > > A app launching since it was dropping the frame since the
> > > > latency was too long.
> > > 
> > > How does running a program interact with kernfs filesystems?  Which
> > > one(s)?
> > 
> > A app launching involves dma_buf exports which creates kobject
> > and add it to the kernfs with down_write - kernfs_add_one.
> 
> I thought the "create a dma_buf kobject" kernel change was fixed up to
> not do that anymore as that was a known performance issue.
> 
> Creating kobjects should NOT be on a fast path, if they are, that needs
> to be fixed.

Ccing Hridya
I also already mentioned before but it's the as-is.
It would be great to be fixed but kernfs still has the problem
regardless of the dmabuf.

For example, process A hold the lock as read-side and try to
allocate memory and entered the reclaim. process B try to
hold the lock as writes-side(e.g., kernfs_iop_setattr) but
he should wait until process A completes. Next, processs C is
also stuck on the lock as read-side when it tries to access
sysfs since the process B spent a threahold timeout in rwsem.
Here, process C could be critical role to contribute the jank.
What it was doing is just access sysfs but was stuck.

> 
> > At the same time in other CPU, a random process was accessing
> > sysfs and the kernfs_iop_lookup was already hoding the kernfs_rwsem
> > and ran under direct reclaim patch due to alloc_inode in
> > kerfs_get_inode.
> 
> What program is constantly hitting sysfs?  sysfs is not for
> performance-critical things, right?

Constantly hitting sysfs itself is no problem since they need
to read telemetry data from sysfs and it's not latency sensitive.
Here, problem is the reading kernfs could make trouble others who
want to access once the rwsem is involved with exclusive lock mode.
Please look at above scenario.

> 
> > Therefore, the app is stuck on the lock and lose frames so enduser
> > sees the jank.
> 
> But how does this patch work around it?  It seems like you are
> special-casing the kobject creation path only.

It's true. If other path also has the memory allocation with holding
kernfs_rwsem, it could make trouble.

> 
> And is this the case really on 5.15?  I thought the kernfs locks were
> broken up again to not cause this problem in 5.14 or so.

It happened on 5.10 but the path I mentioned were still vulnerable path
with rwsem so it could happen on 5.15, too.
