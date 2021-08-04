Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FE3DFD8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhHDJAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:00:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:36037 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235699AbhHDJAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:00:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="193474872"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="193474872"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 01:59:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="511827656"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 01:59:47 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
References: <20210723080000.93953-1-ying.huang@intel.com>
        <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
        <CAC=cRTNby4GkSJ-pjs6utgHtrQYEdy3XZQ06Qsxgyf1MJSBjrw@mail.gmail.com>
        <3f91e0a9-7ba-c165-6231-b2bb38f7f63b@google.com>
Date:   Wed, 04 Aug 2021 16:59:45 +0800
In-Reply-To: <3f91e0a9-7ba-c165-6231-b2bb38f7f63b@google.com> (Hugh Dickins's
        message of "Tue, 3 Aug 2021 23:42:41 -0700 (PDT)")
Message-ID: <87h7g54mbi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hughd@google.com> writes:

> On Wed, 28 Jul 2021, huang ying wrote:
>> On Sat, Jul 24, 2021 at 4:23 AM Hugh Dickins <hughd@google.com> wrote:
>> >
>> > I was wary because, if the (never observed) race to be fixed is in
>> > swap_cluster_readahead(), why was shmem_swapin_page() being patched?
>> 
>> When we get a swap entry from the page table or shmem xarray, and no
>> necessary lock is held to prevent the swap device to be swapoff (e.g.
>> page table lock, page lock, etc.), it's possible that the swap device
>> has been swapoff when we operate on the swap entry (e.g. swapin).
>
> Yes.  And even without any swapoff, the swap entry may no longer be
> right by the time we go to swap it in, or after it has been swapped in.

Yes.

> Both mm/memory.c and mm/shmem.c have done an unlocked lookup to get
> the swap entry, and have to do a pte_same() or shmem_confirm_swap()
> later, to ensure that what they've got is still right.  That lockless
> lookup and raciness is intentional, and has been working for years.

Yes.

>> So we need to find a way to prevent the swap device to be swapoff,
>> get_swap_device() based on percpu_ref is used for that.
>
> To prevent swapoff, no, it would be bad if swapoff could be prevented
> indefinitely.  But I think you're saying to prevent swapoff from
> completing - reaching the point of freeing structures which might
> still be being examined.

Yes.

> Yes, though I thought that was already prevented.  But I may well have
> missed the inode_read_congested() case which came in two years ago
> (affecting shmem swapin only).  And I'll admit now to never(?) having
> studied or tested the SWP_SYNCHRONOUS_IO case in do_swap_page() (with
> suspiciously no equivalent in shmem swapin): I'd better start.
>
> I do dislike the way SWP_SYNCHRONOUS_IO imported low-level swap business
> into do_swap_page(): I'd love to try to move that into swap_state.c, and
> in doing so hopefully get to appreciate it better (and the suggested
> swapoff race: I presume it comes from skipping swapcache_prepare()).

Yes.  I think so too.

> But I have no time for that at present.
>
>> To avoid to
>> call get_swap_device() here and there (e.g. now it is called in many
>> different places), I think it's better to call get_swap_device() when
>> we just get a swap entry without holding the necessary lock, that is,
>> in do_swap_page() and shmem_swapin_page(), etc.  So that we can delete
>> the get_swap_device() call in lookup_swap_cache(),
>> __read_swap_cache_async(), etc.  This will make it easier to
>> understand when to use get_swap_device() and clean up the code.  Do
>> you agree?
>
> Offhand I'd say that I do not agree: but I can easily imagine coming to
> agree with you, once I have tried to do better and discovered I cannot.
>
> I dislike the way swap internals are being pushed out to the higher
> levels.  Particularly since those higher levels already have to deal
> with similar races which are not protected by get_swap_device().
>
> I'd forgotten how earlier you found you had to add get_swap_device()
> into lookup_swap_cache(), and friends: and can see the attraction of
> doing it once instead of here and there.  But it is still there in
> lookup_swap_cache() etc, so that's a poor argument for these commits.

I have a patch in hand to delete get_swap_device() in
lookup_swap_cache() and other places.  In fact, the bug fixed in this
patch is found when developing that patch.

An untested initial version of that cleanup patch is as below, I am
still working on it.  In that patch, 6 get_swap_device() are deleted,
while 4 get_swap_device() are added.  What matters more is that it's
more clear about when to call get_swap_device().  That is, when you get
a swap entry without necessary lock and want to operate on it.

>> > Not explained in its commit message, probably a misunderstanding of
>> > how mm/shmem.c already manages races (and prefers not to be involved
>> > in swap_info_struct stuff).
>> 
>> Yes.  The commit message isn't clean enough about why we do that.
>
> Thanks for clearing that up.  In intervening days I did read about 50
> of the ~100 mails on these commits, April and later (yes, I was Cc'ed
> throughout, thanks, but that didn't give me the time).  I've not yet
> reached any that explain the get_swap_device() placement, perhaps
> I'll change my mind when eventually I read those.

I will write about that in the patch to cleanup get_swap_device() calling.

>> 
>> > But why do I now say it's bad?  Because even if you correct the EINVAL
>> > to -EINVAL, that's an unexpected error: -EEXIST is common, -ENOMEM is
>> > not surprising, -ENOSPC can need consideration, but -EIO and anything
>> > else just end up as SIGBUS when faulting (or as error from syscall).
>> 
>> Yes.  -EINVAL isn't a good choice.  If it's the swapoff race, then
>> retrying can fix the race, so -EAGAIN may be a choice.  But if the
>> swap entry is really invalid (almost impossible in theory), we may
>> need something else, for example, WARN_ON_ONCE() and SIGBUS?  This
>> reminds me that we may need to distinguish the two possibilities in
>> get_swap_device()?
>
> Ah, I guess in that last sentence you're thinking of what I realized
> in writing previous mail, behaviour when given a corrupted swap entry.

Yes.  But because that should be impossible even in theory, I think we
can ignore it for now to avoid to make the code even more complicated?
Now, some corrupted swap entry can be identified and a error message can
be printed in get_swap_device().

Best Regards,
Huang, Ying

----------------------------------8<--------------------------------------
From 8c83cf945436b98222b72903b4bd3063ad41e51a Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Fri, 23 Jul 2021 15:56:26 +0800
Subject: [PATCH] swap: cleanup get/_put_swap_device()

---
 mm/madvise.c    | 10 ++++++++++
 mm/memory.c     | 12 +++++++++++-
 mm/swap_state.c | 11 -----------
 mm/swapfile.c   | 36 ++++++------------------------------
 mm/zswap.c      |  5 +++++
 5 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 012129fbfaf8..5e38e888645d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -199,6 +199,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		swp_entry_t entry;
 		struct page *page;
 		spinlock_t *ptl;
+		struct swap_info_struct *si;
 
 		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
@@ -209,11 +210,15 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		entry = pte_to_swp_entry(pte);
 		if (unlikely(non_swap_entry(entry)))
 			continue;
+		si = get_swap_device(entry);
+		if (!si)
+			continue;
 
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
 							vma, index, false);
 		if (page)
 			put_page(page);
+		put_swap_device(si);
 	}
 
 	return 0;
@@ -234,6 +239,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_index) {
 		swp_entry_t swap;
+		struct swap_info_struct *si;
 
 		if (!xa_is_value(page))
 			continue;
@@ -241,10 +247,14 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 		rcu_read_unlock();
 
 		swap = radix_to_swp_entry(page);
+		si = get_swap_device(swap);
+		if (!si)
+			continue;
 		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
 							NULL, 0, false);
 		if (page)
 			put_page(page);
+		put_swap_device(si);
 
 		rcu_read_lock();
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 39e7a1495c3c..b150d1d577cd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1096,8 +1096,18 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	cond_resched();
 
 	if (ret == -EIO) {
+		int err;
+		struct swap_info_struct *si;
+
 		VM_WARN_ON_ONCE(!entry.val);
-		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0) {
+		si = get_swap_device(entry);
+		if (!si) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		err = add_swap_count_continuation(entry, GFP_KERNEL);
+		put_swap_device(si);
+		if (err < 0) {
 			ret = -ENOMEM;
 			goto out;
 		}
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1a29b4f98208..7a800f6783fc 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -335,14 +335,8 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 			       unsigned long addr)
 {
 	struct page *page;
-	struct swap_info_struct *si;
 
-	si = get_swap_device(entry);
-	if (!si)
-		return NULL;
 	page = find_get_page(swap_address_space(entry), swp_offset(entry));
-	put_swap_device(si);
-
 	INC_CACHE_INFO(find_total);
 	if (page) {
 		bool vma_ra = swap_use_vma_readahead();
@@ -418,7 +412,6 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			struct vm_area_struct *vma, unsigned long addr,
 			bool *new_page_allocated)
 {
-	struct swap_info_struct *si;
 	struct page *page;
 	void *shadow = NULL;
 
@@ -431,12 +424,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * called after lookup_swap_cache() failed, re-calling
 		 * that would confuse statistics.
 		 */
-		si = get_swap_device(entry);
-		if (!si)
-			return NULL;
 		page = find_get_page(swap_address_space(entry),
 				     swp_offset(entry));
-		put_swap_device(si);
 		if (page)
 			return page;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3dcaeecc50f..d7cd7fe2eaf9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1472,14 +1472,9 @@ int __swap_count(swp_entry_t entry)
 {
 	struct swap_info_struct *si;
 	pgoff_t offset = swp_offset(entry);
-	int count = 0;
 
-	si = get_swap_device(entry);
-	if (si) {
-		count = swap_count(si->swap_map[offset]);
-		put_swap_device(si);
-	}
-	return count;
+	si = swp_swap_info(entry);
+	return swap_count(si->swap_map[offset]);
 }
 
 static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
@@ -1501,15 +1496,10 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
  */
 int __swp_swapcount(swp_entry_t entry)
 {
-	int count = 0;
 	struct swap_info_struct *si;
 
-	si = get_swap_device(entry);
-	if (si) {
-		count = swap_swapcount(si, entry);
-		put_swap_device(si);
-	}
-	return count;
+	si = swp_swap_info(entry);
+	return swap_swapcount(si, entry);
 }
 
 /*
@@ -3430,10 +3420,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	unsigned char has_cache;
 	int err;
 
-	p = get_swap_device(entry);
-	if (!p)
-		return -EINVAL;
-
+	p = swp_swap_info(entry);
 	offset = swp_offset(entry);
 	ci = lock_cluster_or_swap_info(p, offset);
 
@@ -3479,8 +3466,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
-	if (p)
-		put_swap_device(p);
 	return err;
 }
 
@@ -3581,14 +3566,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	 */
 	page = alloc_page(gfp_mask | __GFP_HIGHMEM);
 
-	si = get_swap_device(entry);
-	if (!si) {
-		/*
-		 * An acceptable race has occurred since the failing
-		 * __swap_duplicate(): the swap device may be swapoff
-		 */
-		goto outer;
-	}
+	si = swp_swap_info(entry);
 	spin_lock(&si->lock);
 
 	offset = swp_offset(entry);
@@ -3660,8 +3638,6 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 out:
 	unlock_cluster(ci);
 	spin_unlock(&si->lock);
-	put_swap_device(si);
-outer:
 	if (page)
 		__free_page(page);
 	return ret;
diff --git a/mm/zswap.c b/mm/zswap.c
index 7944e3e57e78..f707a73e35aa 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -902,9 +902,14 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
 				struct page **retpage)
 {
 	bool page_was_allocated;
+	struct swap_info_struct *si;
 
+	si = get_swap_device(entry);
+	if (!si)
+		return ZSWAP_SWAPCACHE_FAIL;
 	*retpage = __read_swap_cache_async(entry, GFP_KERNEL,
 			NULL, 0, &page_was_allocated);
+	put_swap_device(si);
 	if (page_was_allocated)
 		return ZSWAP_SWAPCACHE_NEW;
 	if (!*retpage)
-- 
2.30.2

