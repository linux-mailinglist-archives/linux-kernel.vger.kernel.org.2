Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4E3D4276
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhGWVOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGWVOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:14:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641D9C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kdgrmM/4B1zIITGzh1S8nGZIo69an1gVWYkQmjkwQuI=; b=GXDzwmUkiDX8PVhs4if4UKHl5V
        uKk2esXvWHiA3xZEXXRYOIpChTAvlSlDocPcMc1pQXYlD6xAxGnFLrH0BaIEbXYAV9n4ta+dGo4Wz
        bA2/UY6Gge6TL6rAaocs4FrJXTLDEraDWgLciHmCSnJxpimqd96N+ZbSfEgS3Xov5gY7fcRanKBmr
        PiUGPFwL5Bksbiq1zstJDS7wC1boPEJcJ9tX4Ddgk3IFm3uL/Q1h7hC7onVunWIAyRfY1X94NADZ5
        KtbERfyR3Hig5Uew6oNQ/RKGJZEAuuGDbjHVSQGRtYCnw+eX0pEc9q2sGbWfJqFp0rot6KwYM+/0N
        VQFH+0dA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m737B-00BmSR-6k; Fri, 23 Jul 2021 21:53:55 +0000
Date:   Fri, 23 Jul 2021 22:53:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
Message-ID: <YPs6cQo7iG1JcOn8@casper.infradead.org>
References: <20210723080000.93953-1-ying.huang@intel.com>
 <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 01:23:07PM -0700, Hugh Dickins wrote:
> I was wary because, if the (never observed) race to be fixed is in
> swap_cluster_readahead(), why was shmem_swapin_page() being patched?
> Not explained in its commit message, probably a misunderstanding of
> how mm/shmem.c already manages races (and prefers not to be involved
> in swap_info_struct stuff).
> 
> But why do I now say it's bad?  Because even if you correct the EINVAL
> to -EINVAL, that's an unexpected error: -EEXIST is common, -ENOMEM is
> not surprising, -ENOSPC can need consideration, but -EIO and anything
> else just end up as SIGBUS when faulting (or as error from syscall).
> So, 2efa33fc7f6e converts a race with swapoff to SIGBUS: not good,
> and I think much more likely than the race to be fixed (since
> swapoff's percpu_ref_kill() rightly comes before synchronize_rcu()).

Yes, I think a lot more thought was needed here.  And I would have
preferred to start with a reproducer instead of "hey, this could
happen".  Maybe something like booting a 1GB VM, adding two 2GB swap
partitions, swapon(partition A); run a 2GB memhog and then

loop:
	swapon(part B);
	swapoff(part A);
	swapon(part A);
	swapoff(part B);

to make this happen.

but if it does happen, why would returning EINVAL be the right thing
to do?  We've swapped it out.  It must be on swap somewhere, or we've
really messed up.  So I could see there being a race where we get
preempted between looking up the swap entry and calling get_swap_device().
But if that does happen, then the page gets brought in, and potentially
reswapped to the other swap device.

So returning -EEXIST here would actually work.  That forces a re-lookup
in the page cache, so we'll get the new swap entry that tells us which
swap device the page is now on.

But I REALLY REALLY REALLY want a reproducer.  Right now, I have a hard
time believing this, or any of the other races can really happen.

> 2efa33fc7f6e was intending to fix a race introduced by two-year-old
> 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested
> or not"), which added a call to inode_read_congested().  Certainly
> relying on si->swap_file->f_mapping->host there was new territory:
> whether actually racy I'm not sure offhand - I've forgotten whether
> synchronize_rcu() waits for preempted tasks or not.
> 
> But if it is racy, then I wonder if the right fix might be to revert
> 8fd2e0b505d1 too. Convincing numbers were offered for it, but I'm
> puzzled: because Matthew has in the past noted that the block layer
> broke and further broke bdi congestion tracking (I don't know the
> relevant release numbers), so I don't understand how checking
> inode_read_congested() is actually useful there nowadays.

It might be useful for NFS?  I don't think congestion is broken there
(except how does the NFS client have any idea whether the server is
congested or not?)
