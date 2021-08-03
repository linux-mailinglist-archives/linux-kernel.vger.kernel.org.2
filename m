Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67353DE81C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhHCIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:14:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:15803 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhHCIOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:14:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="211756699"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="211756699"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 01:14:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="521142332"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 01:14:40 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
References: <20210723080000.93953-1-ying.huang@intel.com>
        <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
        <YPs6cQo7iG1JcOn8@casper.infradead.org>
Date:   Tue, 03 Aug 2021 16:14:38 +0800
In-Reply-To: <YPs6cQo7iG1JcOn8@casper.infradead.org> (Matthew Wilcox's message
        of "Fri, 23 Jul 2021 22:53:53 +0100")
Message-ID: <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jul 23, 2021 at 01:23:07PM -0700, Hugh Dickins wrote:
>> I was wary because, if the (never observed) race to be fixed is in
>> swap_cluster_readahead(), why was shmem_swapin_page() being patched?
>> Not explained in its commit message, probably a misunderstanding of
>> how mm/shmem.c already manages races (and prefers not to be involved
>> in swap_info_struct stuff).
>> 
>> But why do I now say it's bad?  Because even if you correct the EINVAL
>> to -EINVAL, that's an unexpected error: -EEXIST is common, -ENOMEM is
>> not surprising, -ENOSPC can need consideration, but -EIO and anything
>> else just end up as SIGBUS when faulting (or as error from syscall).
>> So, 2efa33fc7f6e converts a race with swapoff to SIGBUS: not good,
>> and I think much more likely than the race to be fixed (since
>> swapoff's percpu_ref_kill() rightly comes before synchronize_rcu()).
>
> Yes, I think a lot more thought was needed here.  And I would have
> preferred to start with a reproducer instead of "hey, this could
> happen".  Maybe something like booting a 1GB VM, adding two 2GB swap
> partitions, swapon(partition A); run a 2GB memhog and then
>
> loop:
> 	swapon(part B);
> 	swapoff(part A);
> 	swapon(part A);
> 	swapoff(part B);
>
> to make this happen.
>
> but if it does happen, why would returning EINVAL be the right thing
> to do?  We've swapped it out.  It must be on swap somewhere, or we've
> really messed up.  So I could see there being a race where we get
> preempted between looking up the swap entry and calling get_swap_device().
> But if that does happen, then the page gets brought in, and potentially
> reswapped to the other swap device.
>
> So returning -EEXIST here would actually work.  That forces a re-lookup
> in the page cache, so we'll get the new swap entry that tells us which
> swap device the page is now on.

Yes.  -EEXIST is the right error code.  We use that in
shmem_swapin_page() to deal with race condition.

> But I REALLY REALLY REALLY want a reproducer.  Right now, I have a hard
> time believing this, or any of the other races can really happen.

I think the race is only theoretical too.  Firstly, swapoff is a rare
operations in practice; secondly, the race window is really small.

Best Regards,
Huang, Ying

>> 2efa33fc7f6e was intending to fix a race introduced by two-year-old
>> 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested
>> or not"), which added a call to inode_read_congested().  Certainly
>> relying on si->swap_file->f_mapping->host there was new territory:
>> whether actually racy I'm not sure offhand - I've forgotten whether
>> synchronize_rcu() waits for preempted tasks or not.
>> 
>> But if it is racy, then I wonder if the right fix might be to revert
>> 8fd2e0b505d1 too. Convincing numbers were offered for it, but I'm
>> puzzled: because Matthew has in the past noted that the block layer
>> broke and further broke bdi congestion tracking (I don't know the
>> relevant release numbers), so I don't understand how checking
>> inode_read_congested() is actually useful there nowadays.
>
> It might be useful for NFS?  I don't think congestion is broken there
> (except how does the NFS client have any idea whether the server is
> congested or not?)
