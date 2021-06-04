Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFDE39B454
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhFDHyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:54:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:9996 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhFDHyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:54:15 -0400
IronPort-SDR: 3kzK81DPjCGkBMYuPZWiSpxNzA8g3Wz8k+a7w3P6tH4R5u8o+WZ4iVyuyULewca8Spzntl5zhc
 OKOFfkSwrUwA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="184615520"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="184615520"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 00:52:29 -0700
IronPort-SDR: +xq2UExmjPPYDSb6/oppewP6p2DJeRgXrIYyyUaAxFB1oBFxU7z2tgUwBa3pAKc5a76i/VuhLm
 GbU+3B26Rihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="480550651"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2021 00:52:21 -0700
Date:   Fri, 4 Jun 2021 15:52:20 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2%
 regression
Message-ID: <20210604075220.GA40621@shbuild999.sh.intel.com>
References: <20210525031636.GB7744@xsang-OptiPlex-9020>
 <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
 <20210604070411.GA8221@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604070411.GA8221@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 03:04:11PM +0800, Feng Tang wrote:
> Hi Linus,
> 
> Sorry for the late response.
> 
> On Mon, May 24, 2021 at 05:11:37PM -1000, Linus Torvalds wrote:
> > On Mon, May 24, 2021 at 5:00 PM kernel test robot <oliver.sang@intel.com> wrote:
> > >
> > > FYI, we noticed a -9.2% regression of will-it-scale.per_thread_ops due to commit:
> > > commit: 57efa1fe5957694fa541c9062de0a127f0b9acb0 ("mm/gup: prevent gup_fast from racing with COW during fork")
> > 
> > Hmm. This looks like one of those "random fluctuations" things.
> > 
> > It would be good to hear if other test-cases also bisect to the same
> > thing, but this report already says:
> > 
> > > In addition to that, the commit also has significant impact on the following tests:
> > >
> > > +------------------+---------------------------------------------------------------------------------+
> > > | testcase: change | will-it-scale: will-it-scale.per_thread_ops 3.7% improvement                    |
> > 
> > which does kind of reinforce that "this benchmark gives unstable numbers".
> > 
> > The perf data doesn't even mention any of the GUP paths, and on the
> > pure fork path the biggest impact would be:
> > 
> >  (a) maybe "struct mm_struct" changed in size or had a different cache layout
> 
> Yes, this seems to be the cause of the regression.
> 
> The test case is many thread are doing map/unmap at the same time,
> so the process's rw_semaphore 'mmap_lock' is highly contended.
> 
> Before the patch (with 0day's kconfig), the mmap_lock is separated
> into 2 cachelines, the 'count' is in one line, and the other members
> sit in the next line, so it luckily avoid some cache bouncing. After
> the patch, the 'mmap_lock' is pushed into one cacheline, which may
> cause the regression.
> 
> Below is the pahole info:
> 
> - before the patch
> 
> 	spinlock_t         page_table_lock;      /*   116     4 */
> 	struct rw_semaphore mmap_lock;           /*   120    40 */
> 	/* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
> 	struct list_head   mmlist;               /*   160    16 */
> 	long unsigned int  hiwater_rss;          /*   176     8 */
> 
> - after the patch
> 
> 	spinlock_t         page_table_lock;      /*   124     4 */
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	struct rw_semaphore mmap_lock;           /*   128    40 */
> 	struct list_head   mmlist;               /*   168    16 */
> 	long unsigned int  hiwater_rss;          /*   184     8 */
> 
> perf c2c log can also confirm this.
 
We've tried some patch, which can restore the regerssion. As the
newly added member 'write_protect_seq' is 4 bytes long, and putting
it into an existing 4 bytes long hole can restore the regeression,
while not affecting most of other member's alignment. Please review
the following patch, thanks!

- Feng

From 85ddc2c3d0f2bdcbad4edc5c392c7bc90bb1667e Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Fri, 4 Jun 2021 15:20:57 +0800
Subject: [PATCH RFC] mm: relocate 'write_protect_seq' in struct mm_struct

Before commit 57efa1fe5957 ("mm/gup: prevent gup_fast from
racing with COW during fork), on 64bits system, the hot member
rw_semaphore 'mmap_lock' of 'mm_struct' could be separated into
2 cachelines, that its member 'count' sits in one cacheline while
all other members in next cacheline, this naturally reduces some
cache bouncing, and with the commit, the 'mmap_lock' is pushed
into one cacheline, as shown in the pahole info:

 - before the commit

	spinlock_t         page_table_lock;      /*   116     4 */
	struct rw_semaphore mmap_lock;           /*   120    40 */
	/* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
	struct list_head   mmlist;               /*   160    16 */
	long unsigned int  hiwater_rss;          /*   176     8 */

 - after the commit

	spinlock_t         page_table_lock;      /*   124     4 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	struct rw_semaphore mmap_lock;           /*   128    40 */
	struct list_head   mmlist;               /*   168    16 */
	long unsigned int  hiwater_rss;          /*   184     8 */

and it causes one 9.2% regression for 'mmap1' case of will-it-scale
benchmark[1], as in the case 'mmap_lock' is highly contented (occupies
90%+ cpu cycles).

Though relayouting a structure could be a double-edged sword, as it
helps some case, but may hurt other cases. So one solution is the
newly added 'seqcount_t' is 4 bytes long (when CONFIG_DEBUG_LOCK_ALLOC=n),
placing it into an existing 4 bytes hole in 'mm_struct' will not
affect most of other members's alignment, while restoring the
regression.

[1]. https://lore.kernel.org/lkml/20210525031636.GB7744@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/mm_types.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c..5b55f88 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -445,13 +445,6 @@ struct mm_struct {
 		 */
 		atomic_t has_pinned;
 
-		/**
-		 * @write_protect_seq: Locked when any thread is write
-		 * protecting pages mapped by this mm to enforce a later COW,
-		 * for instance during page table copying for fork().
-		 */
-		seqcount_t write_protect_seq;
-
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* PTE page table pages */
 #endif
@@ -480,7 +473,15 @@ struct mm_struct {
 		unsigned long stack_vm;	   /* VM_STACK */
 		unsigned long def_flags;
 
+		/**
+		 * @write_protect_seq: Locked when any thread is write
+		 * protecting pages mapped by this mm to enforce a later COW,
+		 * for instance during page table copying for fork().
+		 */
+		seqcount_t write_protect_seq;
+
 		spinlock_t arg_lock; /* protect the below fields */
+
 		unsigned long start_code, end_code, start_data, end_data;
 		unsigned long start_brk, brk, start_stack;
 		unsigned long arg_start, arg_end, env_start, env_end;
-- 
2.7.4



