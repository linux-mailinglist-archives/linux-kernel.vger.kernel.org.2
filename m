Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D914541D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhKQHa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhKQHa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:30:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B4BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:27:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u17so1369394plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bvVM0VRGyXNywwTqJkoAaqLdyP5DIuf8h6hfMEfXkKw=;
        b=jzXhiFdowtTzwnKXY3HZsYkpia3yMk+0VJCkIKqQZySYiPiW7nT2SJ5AB4ZUMr0X4U
         k/+tUcVDK+SnEtlbkG0JpvPZQBcYOAhHcEWENSXRJo3bExpeCzSWnMb7gCf7c7Nkm33O
         YJRhwd5mw59q/3D511XjKCyieL126di0isQ0XYZ7afmgSGtOVtVLRTZaz285+HVntd7n
         sKL6wFu2/GI/l6LG6AJz4tjB5OZV1IVKrfm/vDcZh8ot0hw3QlYo1zpW6fgGKfjp0IIx
         dAoTj9nd6UdMPWCY0TUf5U8vJihYEx2BpL/1ctkPdnAvR4QavvsSv4J/Tv7LOFijXgC4
         PQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bvVM0VRGyXNywwTqJkoAaqLdyP5DIuf8h6hfMEfXkKw=;
        b=h9LoOYNMXQLVVe5nDacYQsFc8U8YlPxs9XdOiBVQPmzFRdTEpxZhsm1P813Ed+L7Fv
         WWc3F42L5Mqreywh+OqQx3PaYNHAI1hyF8Vk4++bbaH4C0hvJK8924QDPpCI8Bvsx+n3
         qXDEmkrElUjOSJEZeaQAZDnLo18yrl5HXwQI9lLt3VF67q7mIVfgzFstawaaH9K214x4
         y1M2bZVIe2LvQKW2IJc1Je9ZLbJWfYmmKr2nnbQVRPHMQgUs5mRhK1O45O9Dg6mBlyxI
         h8SpPQyBUR+A9Na7lpfV0L6MToEjgI8QpnyTGdgLUmSU5ulKcf9INP15j7xnVhYptZFK
         GfXQ==
X-Gm-Message-State: AOAM533PHKd14kyHxE62+lPrkZoCmEIiJA6gOIW29uXiitslFJgtnwmr
        CdNVp5gyiKJ44KQXPaNDni1qvO4zeLU=
X-Google-Smtp-Source: ABdhPJwwxube4clIVn9f3PZyPIeTzp/7atdqahBBkxdxvN+KPIWzcjGcccnykAPzevP7yqsfl3Ai+w==
X-Received: by 2002:a17:90b:1c87:: with SMTP id oo7mr6895947pjb.159.1637134078408;
        Tue, 16 Nov 2021 23:27:58 -0800 (PST)
Received: from google.com ([2620:15c:211:201:3a93:19e8:b5b5:97fd])
        by smtp.gmail.com with ESMTPSA id t67sm1854316pfd.24.2021.11.16.23.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 23:27:57 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 16 Nov 2021 23:27:56 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZSu/HiHDZxo9Wpa@google.com>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
 <YZSk3DECnnknOu5T@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZSk3DECnnknOu5T@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 07:44:44AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 16, 2021 at 01:36:01PM -0800, Minchan Kim wrote:
> > On Tue, Nov 16, 2021 at 08:49:46PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Nov 16, 2021 at 11:43:17AM -0800, Minchan Kim wrote:
> > > > The kernfs implementation has big lock granularity(kernfs_rwsem) so
> > > > every kernfs-based(e.g., sysfs, cgroup, dmabuf) fs are able to compete
> > > > the lock. Thus, if one of userspace goes the sleep under holding
> > > > the lock for a long time, rest of them should wait it. A example is
> > > > the holder goes direct reclaim with the lock since it needs memory
> > > > allocation. Let's fix it at common technique that release the lock
> > > > and then allocate the memory. Fortunately, kernfs looks like have
> > > > an refcount so I hope it's fine.
> > > > 
> > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > ---
> > > >  fs/kernfs/dir.c             | 14 +++++++++++---
> > > >  fs/kernfs/inode.c           |  2 +-
> > > >  fs/kernfs/kernfs-internal.h |  1 +
> > > >  3 files changed, 13 insertions(+), 4 deletions(-)
> > > 
> > > What workload hits this lock to cause it to be noticable?
> > 
> > A app launching since it was dropping the frame since the
> > latency was too long.
> 
> How does running a program interact with kernfs filesystems?  Which
> one(s)?

A app launching involves dma_buf exports which creates kobject
and add it to the kernfs with down_write - kernfs_add_one.

At the same time in other CPU, a random process was accessing
sysfs and the kernfs_iop_lookup was already hoding the kernfs_rwsem
and ran under direct reclaim patch due to alloc_inode in
kerfs_get_inode.

Therefore, the app is stuck on the lock and lose frames so enduser
sees the jank.

> 
> > > There was a bunch of recent work in this area to make this much more
> > > fine-grained, and the theoritical benchmarks that people created (adding
> > > 10s of thousands of scsi disks at boot time) have gotten better.
> > > 
> > > But in that work, no one could find a real benchmark or use case that
> > > anyone could even notice this type of thing.  What do you have that
> > > shows this?
> > 
> > https://developer.android.com/studio/command-line/perfetto
> > https://perfetto.dev/docs/data-sources/cpu-scheduling
> 
> That is links to a tool, not a test we can run ourselves.
> 
> Or how about the output of that tool?
> 
> > Android has perfetto tracing system and can show where processes
> > were stuck. This case was the lock since holder was in direct reclaim
> > path.
> 
> Reclaim of what?  What is the interaction here with kernfs?  Normally
> this filesystem is not on any "fast paths" that I know of.
> 
> More specifics would be nice :)

I hope it's enough above.
