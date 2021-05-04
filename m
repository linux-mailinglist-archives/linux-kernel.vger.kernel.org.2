Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB1372481
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 04:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhEDCpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 22:45:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:58606 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhEDCpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 22:45:02 -0400
IronPort-SDR: sawiYbD0NsaUfrw73s3jfRXoJyDWK+hjp8d6C4AvczahBakfFphdpVtWhPOtkr+GmX3SRUylAC
 0ulPnXQdjwog==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="195829052"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="195829052"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 19:44:08 -0700
IronPort-SDR: HOQvrJNCq9x8o3EE+vjwtRb8UnLMt8z4ZiaBYlpl/Re9ws++wKu9BGlfVOS++acy5PGLDqdgFP
 4CjBmqso5/Ng==
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="433057486"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 19:44:07 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
        akpm@linux-foundation.org
Subject: [PATCH] stackdepot: Use a raw spinlock in stack depot
Date:   Mon,  3 May 2021 19:43:58 -0700
Message-Id: <20210504024358.894950-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases kasan with lockdep complains about its own use of the stack
depot lock. I think it happens when the kasan usage is nested inside a
raw spinlock and it happens to create a new stack depot.

Make the stackdepot lock raw too

Example trace:

[    1.156154] ACPI Error: No handler or method for GPE 01, disabling event (20210105/evgpe-839)
[    1.156235] =============================
[    1.156238] [ BUG: Invalid wait context ]
[    1.156242] 5.12.0-00071-gb34886074b65 #45 Not tainted
[    1.156249] -----------------------------
[    1.156252] swapper/0/1 is trying to lock:
[    1.156258] ffffffff8535e158 (depot_lock){..-.}-{3:3}, at: stack_depot_save+0x162/0x450
[    1.156288] other info that might help us debug this:
[    1.156292] context-{5:5}
[    1.156297] 3 locks held by swapper/0/1:
[    1.156304]  #0: ffff888100838658 (*(&acpi_gbl_gpe_lock)){....}-{3:3}, at: acpi_ev_detect_gpe+0xa8/0x3e6
[    1.156333]  #1: ffffffff85133dc0 (rcu_read_lock){....}-{1:3}, at: __queue_work+0xd5/0x1010
[    1.156363]  #2: ffff88815a04ec18 (&pool->lock){....}-{2:2}, at: __queue_work+0x258/0x1010
[    1.156391] stack backtrace:
[    1.156395] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-00071-gb34886074b65 #45
[    1.156407] Call Trace:
[    1.156413]  dump_stack+0xfa/0x151
[    1.156427]  __lock_acquire.cold+0x366/0x41f
[    1.156450]  ? orc_find+0x233/0x3c0
[    1.156462]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[    1.156476]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[    1.156491]  ? ret_from_fork+0x1f/0x30
[    1.156503]  ? deref_stack_reg+0x90/0x90
[    1.156516]  lock_acquire+0x194/0x690
[    1.156528]  ? stack_depot_save+0x162/0x450
[    1.156541]  ? rcu_read_unlock+0x40/0x40
[    1.156553]  ? arch_stack_walk+0x88/0xf0
[    1.156566]  ? ret_from_fork+0x1f/0x30
[    1.156579]  _raw_spin_lock_irqsave+0x3b/0x60
[    1.156591]  ? stack_depot_save+0x162/0x450
[    1.156603]  stack_depot_save+0x162/0x450
[    1.156616]  kasan_save_stack+0x32/0x40
[    1.156629]  ? kasan_save_stack+0x1b/0x40
[    1.156642]  ? kasan_record_aux_stack+0xbc/0xe0
[    1.156653]  ? insert_work+0x4b/0x2e0
[    1.156665]  ? __queue_work+0x4cf/0x1010
[    1.156677]  ? queue_work_on+0xb3/0xc0
[    1.156689]  ? acpi_os_execute+0x1ca/0x340
[    1.156701]  ? acpi_ev_gpe_dispatch+0x208/0x273
[    1.156713]  ? acpi_ev_detect_gpe+0x35e/0x3e6
[    1.156724]  ? acpi_ev_gpe_detect+0x269/0x334
[    1.156736]  ? acpi_update_all_gpes+0x1cf/0x206
[    1.156748]  ? acpi_scan_init+0x2a8/0x702
[    1.156761]  ? acpi_init+0x230/0x2ba
[    1.156773]  ? do_one_initcall+0xf0/0x540
[    1.156784]  ? kernel_init_freeable+0x38e/0x412
[    1.156796]  ? kernel_init+0x12/0x1cf
[    1.156807]  ? ret_from_fork+0x1f/0x30
[    1.156818]  ? kmem_cache_alloc_trace+0xf1/0x850
[    1.156831]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[    1.156844]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[    1.156858]  ? acpi_scan_init+0x2a8/0x702
[    1.156870]  ? do_one_initcall+0xf0/0x540
[    1.156881]  ? kernel_init+0x12/0x1cf
[    1.156892]  ? ret_from_fork+0x1f/0x30
[    1.156903]  ? _raw_spin_unlock+0x1f/0x30
[    1.156915]  ? lock_acquire+0x194/0x690
[    1.156927]  ? __queue_work+0x258/0x1010
[    1.156940]  ? rcu_read_unlock+0x40/0x40
[    1.156952]  ? lock_is_held_type+0x98/0x110
[    1.156964]  ? lock_is_held_type+0x98/0x110
[    1.156977]  ? rcu_read_lock_sched_held+0xa1/0xe0
[    1.156991]  kasan_record_aux_stack+0xbc/0xe0
[    1.157003]  insert_work+0x4b/0x2e0
[    1.157016]  __queue_work+0x4cf/0x1010
[    1.157031]  queue_work_on+0xb3/0xc0
[    1.157044]  acpi_os_execute+0x1ca/0x340
[    1.157056]  acpi_ev_gpe_dispatch+0x208/0x273
[    1.157069]  acpi_ev_detect_gpe+0x35e/0x3e6
[    1.157082]  ? acpi_ev_gpe_dispatch+0x273/0x273
[    1.157096]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[    1.157109]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
[    1.157122]  acpi_ev_gpe_detect+0x269/0x334
[    1.157136]  ? acpi_bus_init+0x7ee/0x7ee
[    1.157148]  acpi_update_all_gpes+0x1cf/0x206
[    1.157161]  ? acpi_get_gpe_device+0x182/0x182
[    1.157174]  ? acpi_get_table+0x11f/0x1f5
[    1.157186]  ? write_comp_data+0x2a/0x80
[    1.157199]  acpi_scan_init+0x2a8/0x702
[    1.157212]  ? acpi_match_madt+0xc4/0xc4
[    1.157225]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[    1.157239]  ? __pci_mmcfg_init+0x91/0x21f
[    1.157251]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[    1.157265]  acpi_init+0x230/0x2ba
[    1.157277]  ? acpi_bus_init+0x7ee/0x7ee
[    1.157290]  ? rcu_read_lock_bh_held+0xc0/0xc0
[    1.157304]  ? write_comp_data+0x2a/0x80
[    1.157332]  do_one_initcall+0xf0/0x540
[    1.157357]  ? perf_trace_initcall_level+0x3e0/0x3e0
[    1.157370]  ? rcu_read_lock_sched_held+0xa1/0xe0
[    1.157384]  ? rcu_read_lock_bh_held+0xc0/0xc0
[    1.157398]  ? __kmalloc+0x1ae/0x380
[    1.157410]  ? write_comp_data+0x2a/0x80
[    1.157424]  kernel_init_freeable+0x38e/0x412
[    1.157437]  ? rest_init+0x381/0x381
[    1.157462]  kernel_init+0x12/0x1cf
[    1.157474]  ret_from_fork+0x1f/0x30

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org
Cc: akpm@linux-foundation.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 lib/stackdepot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 49f67a0c6e5d..df9179f4f441 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -71,7 +71,7 @@ static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
 static int depot_index;
 static int next_slab_inited;
 static size_t depot_offset;
-static DEFINE_SPINLOCK(depot_lock);
+static DEFINE_RAW_SPINLOCK(depot_lock);
 
 static bool init_stack_slab(void **prealloc)
 {
@@ -305,7 +305,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	spin_lock_irqsave(&depot_lock, flags);
+	raw_spin_lock_irqsave(&depot_lock, flags);
 
 	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
@@ -329,7 +329,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 		WARN_ON(!init_stack_slab(&prealloc));
 	}
 
-	spin_unlock_irqrestore(&depot_lock, flags);
+	raw_spin_unlock_irqrestore(&depot_lock, flags);
 exit:
 	if (prealloc) {
 		/* Nobody used this memory, ok to free it. */
-- 
2.25.4

