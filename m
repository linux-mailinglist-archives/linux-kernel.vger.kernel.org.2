Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1C3DE7E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhHCIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:07:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:3408 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234440AbhHCIHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:07:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="274682761"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="274682761"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 01:06:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="510938473"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 01:06:49 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
References: <20210723080000.93953-1-ying.huang@intel.com>
        <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
        <CAC=cRTNby4GkSJ-pjs6utgHtrQYEdy3XZQ06Qsxgyf1MJSBjrw@mail.gmail.com>
Date:   Tue, 03 Aug 2021 16:06:47 +0800
In-Reply-To: <CAC=cRTNby4GkSJ-pjs6utgHtrQYEdy3XZQ06Qsxgyf1MJSBjrw@mail.gmail.com>
        (huang ying's message of "Wed, 28 Jul 2021 21:03:50 +0800")
Message-ID: <877dh354vc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

huang ying <huang.ying.caritas@gmail.com> writes:
>>
>> Thanks for catching that; and as David says, it's worse than a typo.
>>
>> But this is not the right fix:
>> 2efa33fc7f6e ("mm/shmem: fix shmem_swapin() race with swapoff")
>> needs to be reverted.
>>
>> It's been on my pile to look at for weeks: now I look at it and see
>> it's just a bad patch.  Over-enthusiastic stablehands already rushed
>> it out, I was wary, and reverts are already in -rc for 5.13 and 5.10,
>> phew, but 5.12.19 EOL is stuck with it unfortunately, oh well.
>>
>> I was wary because, if the (never observed) race to be fixed is in
>> swap_cluster_readahead(), why was shmem_swapin_page() being patched?
>
> When we get a swap entry from the page table or shmem xarray, and no
> necessary lock is held to prevent the swap device to be swapoff (e.g.
> page table lock, page lock, etc.), it's possible that the swap device
> has been swapoff when we operate on the swap entry (e.g. swapin).  So
> we need to find a way to prevent the swap device to be swapoff,
> get_swap_device() based on percpu_ref is used for that.  To avoid to
> call get_swap_device() here and there (e.g. now it is called in many
> different places), I think it's better to call get_swap_device() when
> we just get a swap entry without holding the necessary lock, that is,
> in do_swap_page() and shmem_swapin_page(), etc.  So that we can delete
> the get_swap_device() call in lookup_swap_cache(),
> __read_swap_cache_async(), etc.  This will make it easier to
> understand when to use get_swap_device() and clean up the code.  Do
> you agree?
>
>> Not explained in its commit message, probably a misunderstanding of
>> how mm/shmem.c already manages races (and prefers not to be involved
>> in swap_info_struct stuff).
>
> Yes.  The commit message isn't clean enough about why we do that.
>
>> But why do I now say it's bad?  Because even if you correct the EINVAL
>> to -EINVAL, that's an unexpected error: -EEXIST is common, -ENOMEM is
>> not surprising, -ENOSPC can need consideration, but -EIO and anything
>> else just end up as SIGBUS when faulting (or as error from syscall).
>
> Yes.  -EINVAL isn't a good choice.  If it's the swapoff race, then
> retrying can fix the race, so -EAGAIN may be a choice.  But if the
> swap entry is really invalid (almost impossible in theory), we may
> need something else, for example, WARN_ON_ONCE() and SIGBUS?  This
> reminds me that we may need to distinguish the two possibilities in
> get_swap_device()?

As Hugh pointed out, EINVAL isn't an appropriate error code for race
condition.  After checking the code, I found that EEXIST is the error
code used for race condition.  So I revise the patch as below.  If Hugh
doesn't object, can you help to replace the patch with the below one?

Best Regards,
Huang, Ying

-----------------------------8<---------------------------------------
From e2b281a0b09d34d6463942e214e577ed9357c213 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Tue, 3 Aug 2021 10:51:16 +0800
Subject: [PATCH] shmem_swapin_page(): fix error processing for
 get_swap_device()

Firstly, "-" is missing before the error code.  Secondly, EINVAL isn't
the proper error code for the race condition.  EEXIST is used in
shmem_swapin_page() for that.  So the error code is changed to EEXIST
too.

Link: https://lkml.kernel.org/r/20210723080000.93953-1-ying.huang@intel.com
Fixes: 2efa33fc7f6e ("mm/shmem: fix shmem_swapin() race with swapoff")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index dcc07d14162e..ba925baa4404 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1711,8 +1711,8 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	/* Prevent swapoff from happening to us. */
 	si = get_swap_device(swap);
 	if (!si) {
-		error = EINVAL;
-		goto failed;
+		error = -EEXIST;
+		goto unlock;
 	}
 	/* Look it up and read it in.. */
 	page = lookup_swap_cache(swap, NULL, 0);
-- 
2.30.2

