Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1080438FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhJYGsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:48:02 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26118 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJYGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:48:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hd55D4Kdmz1DHrQ;
        Mon, 25 Oct 2021 14:43:44 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (7.185.36.106) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 14:45:37 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 14:45:36 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mm/percpu: fix data-race with pcpu_nr_empty_pop_pages
Date:   Mon, 25 Oct 2021 07:00:15 +0000
Message-ID: <20211025070015.553813-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

To fix this issue, use READ_ONCE() and WRITE_ONCE() to
read and write the pcpu_nr_empty_pop_pages.

Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 mm/percpu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 293009cc03ef..e8ef92e698ab 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -574,7 +574,9 @@ static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
 
 	if (!chunk->isolated) {
 		chunk->isolated = true;
-		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
+		WRITE_ONCE(pcpu_nr_empty_pop_pages,
+			   READ_ONCE(pcpu_nr_empty_pop_pages) -
+			   chunk->nr_empty_pop_pages);
 	}
 	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
 }
@@ -585,7 +587,9 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
 
 	if (chunk->isolated) {
 		chunk->isolated = false;
-		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
+		WRITE_ONCE(pcpu_nr_empty_pop_pages,
+			   READ_ONCE(pcpu_nr_empty_pop_pages) +
+			   chunk->nr_empty_pop_pages);
 		pcpu_chunk_relocate(chunk, -1);
 	}
 }
@@ -603,7 +607,8 @@ static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
 {
 	chunk->nr_empty_pop_pages += nr;
 	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
-		pcpu_nr_empty_pop_pages += nr;
+		WRITE_ONCE(pcpu_nr_empty_pop_pages,
+			   READ_ONCE(pcpu_nr_empty_pop_pages) + nr);
 }
 
 /*
@@ -1874,7 +1879,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
 
-	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
+	if (READ_ONCE(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
 		pcpu_schedule_balance_work();
 
 	/* clear the areas and return address relative to base address */
@@ -2062,7 +2067,7 @@ static void pcpu_balance_populated(void)
 		pcpu_atomic_alloc_failed = false;
 	} else {
 		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
-				  pcpu_nr_empty_pop_pages,
+				  READ_ONCE(pcpu_nr_empty_pop_pages),
 				  0, PCPU_EMPTY_POP_PAGES_HIGH);
 	}
 
@@ -2163,7 +2168,8 @@ static void pcpu_reclaim_populated(void)
 				break;
 
 			/* reintegrate chunk to prevent atomic alloc failures */
-			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
+			if (READ_ONCE(pcpu_nr_empty_pop_pages) <
+			    PCPU_EMPTY_POP_PAGES_HIGH) {
 				reintegrate = true;
 				goto end_chunk;
 			}
-- 
2.25.1

