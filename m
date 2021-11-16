Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C779F453A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 20:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbhKPTwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhKPTwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:52:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A759861A3A;
        Tue, 16 Nov 2021 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637092189;
        bh=0xPsIHGAGn2xqyjHE7056U7s5RR16eW3bnL05KsI6oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LURxECjESsJAp/D7kPqchHD+QqlbKiPcSg/NbKG2H5abGY+EAT0icf3pRV5DQ0ijj
         cfB5mRyRtoDKbbLDuoOlMXdYmmTwPGcUNxXtitXvqvjQ9APyFjOyTXLlIiyRP2sEI5
         gbpGTD3eHWW/JjZQ5lwYrD+lSE6qMzxNZdihRErs=
Date:   Tue, 16 Nov 2021 20:49:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZQLWq7WMSRF2xCM@kroah.com>
References: <20211116194317.1430399-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116194317.1430399-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:43:17AM -0800, Minchan Kim wrote:
> The kernfs implementation has big lock granularity(kernfs_rwsem) so
> every kernfs-based(e.g., sysfs, cgroup, dmabuf) fs are able to compete
> the lock. Thus, if one of userspace goes the sleep under holding
> the lock for a long time, rest of them should wait it. A example is
> the holder goes direct reclaim with the lock since it needs memory
> allocation. Let's fix it at common technique that release the lock
> and then allocate the memory. Fortunately, kernfs looks like have
> an refcount so I hope it's fine.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  fs/kernfs/dir.c             | 14 +++++++++++---
>  fs/kernfs/inode.c           |  2 +-
>  fs/kernfs/kernfs-internal.h |  1 +
>  3 files changed, 13 insertions(+), 4 deletions(-)

What workload hits this lock to cause it to be noticable?

There was a bunch of recent work in this area to make this much more
fine-grained, and the theoritical benchmarks that people created (adding
10s of thousands of scsi disks at boot time) have gotten better.

But in that work, no one could find a real benchmark or use case that
anyone could even notice this type of thing.  What do you have that
shows this?
thanks,

greg k-h
