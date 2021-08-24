Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1C3F55A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhHXCKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXCKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:10:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BFAC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:09:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id r9so929344pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1KAwdPznmF5iwJT8z+BaZtEiLXVAoNkkWDqAyg+dT8=;
        b=J8573bnoH2qJxrhS/LlJl2n8wK1WZbxyHVdyIS9I34H2iBf3zzHMmKhLAMLE96j7Mk
         WCuymMsOCBANSDplp78CoW/lqFS3w6EtHQ5jg7bQ/jtxWAh6NXqXVbkGrscJeXV9i58d
         6pBri+1ip8kKQV8FZONByt8I44akwk2oSMNF2phZUTOgYUwQBAGOzx3cKA3/JajI3QCz
         GAtF3zh1Puf6BPq2N7nGQecn0SG5YhiEVqCmULm4XDkvVQeocSlLwTPpUNJJDy4aKGwB
         /o0MJYMyWD1SKvFk4gAlIB/Enlog7ikbiT9ke8bvn5gaPe0YHMyQewnlJqs/pzUwoE/z
         HV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1KAwdPznmF5iwJT8z+BaZtEiLXVAoNkkWDqAyg+dT8=;
        b=XjKi448GlZjISE6OxrGVdhNTulh0DGmjt6fLsWNTZid/CnarWcvOGPVEb/Lq344v2Y
         KdNzgdiZOlL8CaPScNmsZMtKnHxg5Aeew/h2bS6DZUt5/W8lfI6+kpAxFh2C/35AyDvg
         yseIAOjIQI/9aWlPrM1bln+Q2jnjnDGaoB53d18syUkPNnrMDTBUkIYtdCX1xm0lg9CP
         s5fXQYni/aaGlnE1xdhIbWRqrOaTf/r8Xx6u109++WHlW8RZZ3vy6nAm4iSwsaXA+JFp
         Qkgwgjcn9tpdpISzUWriMHob003DDZzBY1E7tlr7fpX1khQkNCHV1ZHBQzh+2BVRrA7A
         FjtQ==
X-Gm-Message-State: AOAM5302igA4vFCGX6bQvj51dhjKQ6zaSyD0JmWuacOxzuVWHxZJuGks
        qjNk+emvT5DCWYwVR2zZJ1k=
X-Google-Smtp-Source: ABdhPJz4TdbnavEcEqBV+jQY4FxZZqeI2TiKXy0247PorymKfILh9LMZLfSAha9goPl5bq8U5Fp71g==
X-Received: by 2002:a63:798f:: with SMTP id u137mr34487840pgc.321.1629770990052;
        Mon, 23 Aug 2021 19:09:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id h16sm16830958pfn.215.2021.08.23.19.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 19:09:48 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, osalvador@suse.de, tdmackey@twitter.com,
        david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/3] mm: hwpoison: don't drop slab caches for offlining non-LRU page
Date:   Mon, 23 Aug 2021 19:09:44 -0700
Message-Id: <20210824020946.195257-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current implementation of soft offline, if non-LRU page is met,
all the slab caches will be dropped to free the page then offline.  But
if the page is not slab page all the effort is wasted in vain.  Even
though it is a slab page, it is not guaranteed the page could be freed
at all.

However the side effect and cost is quite high.  It does not only drop
the slab caches, but also may drop a significant amount of page caches
which are associated with inode caches.  It could make the most
workingset gone in order to just offline a page.  And the offline is not
guaranteed to succeed at all, actually I really doubt the success rate
for real life workload.

Furthermore the worse consequence is the system may be locked up and
unusable since the page cache release may incur huge amount of works
queued for memcg release.

Actually we ran into such unpleasant case in our production environment.
Firstly, the workqueue of memory_failure_work_func is locked up as
below:

BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 53s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=14/256 refcnt=15
    in-flight: 409271:memory_failure_work_func
    pending: kfree_rcu_work, kfree_rcu_monitor, kfree_rcu_work, rht_deferred_worker, rht_deferred_worker, rht_deferred_worker, rht_deferred_worker, kfree_rcu_work, kfree_rcu_work, kfree_rcu_work, kfree_rcu_work, drain_local_stock, kfree_rcu_work
workqueue mm_percpu_wq: flags=0x8
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
  pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=12072
    pending: css_release_work_fn

There were over 12K css_release_work_fn queued, and this caused a few
lockups due to the contention of worker pool lock with IRQ disabled, for
example:

NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
Modules linked in: amd64_edac_mod edac_mce_amd crct10dif_pclmul crc32_pclmul ghash_clmulni_intel xt_DSCP iptable_mangle kvm_amd bpfilter vfat fat acpi_ipmi i2c_piix4 usb_storage ipmi_si k10temp i2c_core ipmi_devintf ipmi_msghandler acpi_cpufreq sch_fq_codel xfs libcrc32c crc32c_intel mlx5_core mlxfw nvme xhci_pci ptp nvme_core pps_core xhci_hcd
CPU: 1 PID: 205500 Comm: kworker/1:0 Tainted: G             L    5.10.32-t1.el7.twitter.x86_64 #1
Hardware name: TYAN F5AMT /z        /S8026GM2NRE-CGN, BIOS V8.030 03/30/2021
Workqueue: events memory_failure_work_func
RIP: 0010:queued_spin_lock_slowpath+0x41/0x1a0
Code: 41 f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 1b 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
RSP: 0018:ffff9b2ac278f900 EFLAGS: 00000002
RAX: 0000000000480101 RBX: ffff8ce98ce71800 RCX: 0000000000000084
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8ce98ce6a140
RBP: 00000000000284c8 R08: ffffd7248dcb6808 R09: 0000000000000000
R10: 0000000000000003 R11: ffff9b2ac278f9b0 R12: 0000000000000001
R13: ffff8cb44dab9c00 R14: ffffffffbd1ce6a0 R15: ffff8cacaa37f068
FS:  0000000000000000(0000) GS:ffff8ce98ce40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcf6e8cb000 CR3: 0000000a0c60a000 CR4: 0000000000350ee0
Call Trace:
 __queue_work+0xd6/0x3c0
 queue_work_on+0x1c/0x30
 uncharge_batch+0x10e/0x110
 mem_cgroup_uncharge_list+0x6d/0x80
 release_pages+0x37f/0x3f0
 __pagevec_release+0x1c/0x50
 __invalidate_mapping_pages+0x348/0x380
 ? xfs_alloc_buftarg+0xa4/0x120 [xfs]
 inode_lru_isolate+0x10a/0x160
 ? iput+0x1d0/0x1d0
 __list_lru_walk_one+0x7b/0x170
 ? iput+0x1d0/0x1d0
 list_lru_walk_one+0x4a/0x60
 prune_icache_sb+0x37/0x50
 super_cache_scan+0x123/0x1a0
 do_shrink_slab+0x10c/0x2c0
 shrink_slab+0x1f1/0x290
 drop_slab_node+0x4d/0x70
 soft_offline_page+0x1ac/0x5b0
 ? dev_mce_log+0xee/0x110
 ? notifier_call_chain+0x39/0x90
 memory_failure_work_func+0x6a/0x90
 process_one_work+0x19e/0x340
 ? process_one_work+0x340/0x340
 worker_thread+0x30/0x360
 ? process_one_work+0x340/0x340
 kthread+0x116/0x130

The lockup made the machine is quite unusable.  And it also made the
most workingset gone, the reclaimabled slab caches were reduced from 12G
to 300MB, the page caches were decreased from 17G to 4G.

But the most disappointing thing is all the effort doesn't make the page
offline, it just returns:

soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()

It seems the aggressive behavior for non-LRU page didn't pay back, so it
doesn't make too much sense to keep it considering the terrible side
effect.

Reported-by: David Mackey <tdmackey@twitter.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v3: * Collected acks
v2: * Rebased on top of https://lore.kernel.org/linux-mm/CAHbLzkpAEZRTmnOnjVHYHGJ7ApjdC8eDh53DAnTHsG185QGOfQ@mail.gmail.com/T/#t (Naoya Horiguchi)
    * Added comment about possible future optimization when handling
      slab page (David Hildenbrand)
    * Added patch #3 to call dump_page (Matthew Wilcox)

 include/linux/mm.h   |  2 +-
 mm/hwpoison-inject.c |  2 +-
 mm/memory-failure.c  | 18 ++++++++----------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7e43d1b01e0a..a3cc83d64564 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3203,7 +3203,7 @@ extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
-extern void shake_page(struct page *p, int access);
+extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 1ae1ebc2b9b1..aff4d27ec235 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -30,7 +30,7 @@ static int hwpoison_inject(void *data, u64 val)
 	if (!hwpoison_filter_enable)
 		goto inject;
 
-	shake_page(hpage, 0);
+	shake_page(hpage);
 	/*
 	 * This implies unable to support non-LRU pages.
 	 */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 665316c7ea40..7cfa134b1370 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -282,9 +282,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 
 /*
  * Unknown page type encountered. Try to check whether it can turn PageLRU by
- * lru_add_drain_all, or a free page by reclaiming slabs when possible.
+ * lru_add_drain_all.
  */
-void shake_page(struct page *p, int access)
+void shake_page(struct page *p)
 {
 	if (PageHuge(p))
 		return;
@@ -296,11 +296,9 @@ void shake_page(struct page *p, int access)
 	}
 
 	/*
-	 * Only call drop_slab_node here (which would also shrink
-	 * other caches) if access is not potentially fatal.
+	 * TODO: Could shrink slab caches here if a lightweight range-based
+	 * shrinker will be available.
 	 */
-	if (access)
-		drop_slab_node(page_to_nid(p));
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
@@ -1205,7 +1203,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 			 * page, retry.
 			 */
 			if (pass++ < 3) {
-				shake_page(p, 1);
+				shake_page(p);
 				goto try_again;
 			}
 			ret = -EIO;
@@ -1222,7 +1220,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 		 */
 		if (pass++ < 3) {
 			put_page(p);
-			shake_page(p, 1);
+			shake_page(p);
 			count_increased = false;
 			goto try_again;
 		}
@@ -1369,7 +1367,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * shake_page() again to ensure that it's flushed.
 	 */
 	if (mlocked)
-		shake_page(hpage, 0);
+		shake_page(hpage);
 
 	/*
 	 * Now that the dirty bit has been propagated to the
@@ -1723,7 +1721,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * The check (unnecessarily) ignores LRU pages being isolated and
 	 * walked by the page reclaim code, however that's not a big loss.
 	 */
-	shake_page(p, 0);
+	shake_page(p);
 
 	lock_page(p);
 
-- 
2.26.2

