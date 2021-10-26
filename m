Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D087E43ADF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhJZIav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:30:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29937 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhJZIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:30:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HdlGB6Md8zbn9y;
        Tue, 26 Oct 2021 16:23:46 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (7.185.36.106) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 26 Oct 2021 16:28:24 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 26 Oct 2021 16:28:24 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <akpm@linux-foundation.org>, <dennis@kernel.org>, <tj@kernel.org>,
        <cl@linux.com>, <cl@gentwo.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] mm/percpu: fix data-race with pcpu_nr_empty_pop_pages
Date:   Tue, 26 Oct 2021 08:43:12 +0000
Message-ID: <20211026084312.2138852-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the pcpu_nr_empty_pop_pages in pcpu_alloc()
and writing the pcpu_nr_empty_pop_pages in
pcpu_update_empty_pages() at the same time,
the data-race occurs.

===========
read-write to 0xffffffff882fdd4c of 4 bytes by task 9424 on cpu 0:
 pcpu_update_empty_pages
 pcpu_chunk_populated
 pcpu_balance_populated
 pcpu_balance_workfn
 process_one_work
 worker_thread
 kthread
 ret_from_fork

read to 0xffffffff882fdd4c of 4 bytes by task 9386 on cpu 3:
 pcpu_alloc
 __alloc_percpu_gfp
 fib_nh_common_init
 fib_nh_init
 fib_create_info
 fib_table_insert
 fib_magic
 ......
 sock_sendmsg_nosec
 sock_sendmsg
 __sys_sendto
 __do_sys_sendto
 __se_sys_sendto
 __x64_sys_sendto
 do_syscall_64
 entry_SYSCALL_64_after_hwframe
============

The same problem will occur in these functions:
pcpu_reclaim_populated(), pcpu_update_empty_pages(),
pcpu_isolate_chunk().

Using atomic variable operations to slove this
concurrent access problem.

Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
Changes since v1:
- Change the pcpu_nr_empty_pop_pages to atomic variable
  suggested by Christoph Lameter

 mm/percpu-internal.h |  2 +-
 mm/percpu-stats.c    |  2 +-
 mm/percpu-vm.c       |  2 +-
 mm/percpu.c          | 18 ++++++++++--------
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 639662c20c82..02fbc11ef68a 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -72,7 +72,7 @@ extern struct list_head *pcpu_chunk_lists;
 extern int pcpu_nr_slots;
 extern int pcpu_sidelined_slot;
 extern int pcpu_to_depopulate_slot;
-extern int pcpu_nr_empty_pop_pages;
+extern atomic_t pcpu_nr_empty_pop_pages;
 
 extern struct pcpu_chunk *pcpu_first_chunk;
 extern struct pcpu_chunk *pcpu_reserved_chunk;
diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
index c6bd092ff7a3..7bd601fd3b6b 100644
--- a/mm/percpu-stats.c
+++ b/mm/percpu-stats.c
@@ -188,7 +188,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
 	PU(nr_max_chunks);
 	PU(min_alloc_size);
 	PU(max_alloc_size);
-	P("empty_pop_pages", pcpu_nr_empty_pop_pages);
+	P("empty_pop_pages", atomic_read(&pcpu_nr_empty_pop_pages));
 	seq_putc(m, '\n');
 
 #undef PU
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 2054c9213c43..12b2342448f4 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -404,7 +404,7 @@ static bool pcpu_should_reclaim_chunk(struct pcpu_chunk *chunk)
 	 * chunk, move it to the to_depopulate list.
 	 */
 	return ((chunk->isolated && chunk->nr_empty_pop_pages) ||
-		(pcpu_nr_empty_pop_pages >
+		(atomic_read(&pcpu_nr_empty_pop_pages) >
 		 (PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages) &&
 		 chunk->nr_empty_pop_pages >= chunk->nr_pages / 4));
 }
diff --git a/mm/percpu.c b/mm/percpu.c
index 293009cc03ef..0c55a25059a2 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -181,7 +181,7 @@ static LIST_HEAD(pcpu_map_extend_chunks);
  * The number of empty populated pages, protected by pcpu_lock.
  * The reserved chunk doesn't contribute to the count.
  */
-int pcpu_nr_empty_pop_pages;
+atomic_t pcpu_nr_empty_pop_pages = ATOMIC_INIT(0);
 
 /*
  * The number of populated pages in use by the allocator, protected by
@@ -574,7 +574,7 @@ static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
 
 	if (!chunk->isolated) {
 		chunk->isolated = true;
-		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
+		atomic_sub(chunk->nr_empty_pop_pages, &pcpu_nr_empty_pop_pages);
 	}
 	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
 }
@@ -585,7 +585,7 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
 
 	if (chunk->isolated) {
 		chunk->isolated = false;
-		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
+		atomic_add(chunk->nr_empty_pop_pages, &pcpu_nr_empty_pop_pages);
 		pcpu_chunk_relocate(chunk, -1);
 	}
 }
@@ -603,7 +603,7 @@ static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
 {
 	chunk->nr_empty_pop_pages += nr;
 	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
-		pcpu_nr_empty_pop_pages += nr;
+		atomic_add(nr, &pcpu_nr_empty_pop_pages);
 }
 
 /*
@@ -1874,7 +1874,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
 
-	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
+	if (atomic_read(&pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
 		pcpu_schedule_balance_work();
 
 	/* clear the areas and return address relative to base address */
@@ -2062,7 +2062,7 @@ static void pcpu_balance_populated(void)
 		pcpu_atomic_alloc_failed = false;
 	} else {
 		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
-				  pcpu_nr_empty_pop_pages,
+				  atomic_read(&pcpu_nr_empty_pop_pages),
 				  0, PCPU_EMPTY_POP_PAGES_HIGH);
 	}
 
@@ -2163,7 +2163,8 @@ static void pcpu_reclaim_populated(void)
 				break;
 
 			/* reintegrate chunk to prevent atomic alloc failures */
-			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
+			if (atomic_read(&pcpu_nr_empty_pop_pages) <
+			    PCPU_EMPTY_POP_PAGES_HIGH) {
 				reintegrate = true;
 				goto end_chunk;
 			}
@@ -2765,7 +2766,8 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 
 	/* link the first chunk in */
 	pcpu_first_chunk = chunk;
-	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
+	atomic_set(&pcpu_nr_empty_pop_pages,
+		   pcpu_first_chunk->nr_empty_pop_pages);
 	pcpu_chunk_relocate(pcpu_first_chunk, -1);
 
 	/* include all regions of the first chunk */
-- 
2.25.1

