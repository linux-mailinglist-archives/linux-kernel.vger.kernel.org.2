Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAA33EADD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCQHy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhCQHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:54:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8066BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 00:54:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w34so23242476pga.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEdnb+OWQcwQMcrxWHWutKj4nLUntKHn3JOwrdxbgug=;
        b=ZhG789uVdwceX1cI4Oizx9Tyz0so076kCp/iJoVssOv1HSEkPwJOp9aFtYZiEaoP+J
         y5QUrEDZM7vOOaY+vCgpwMhiqv2AXUrBZnR2vxbwn8OhUj06UvwjL4PCnnagkiemzZhA
         vuZuLc4oWz0AEKELxTYE5o7XvNWDvycBLq6X1tFyMNcT76/Y3SidNizJPLrNeegRynl5
         rbs4C9krtvddEMAdnfDBpohiTZ8LbMorpsqiDz0ODNDz7sMkRQhaLXfAtFvj1c2IX+pk
         b1HzOpMGPHHzvcv1TF6L0EcesxZ2Kt5X7kGBV9ptxXPyDyFg0DGSzcOxbNdzhBT6G8th
         PRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEdnb+OWQcwQMcrxWHWutKj4nLUntKHn3JOwrdxbgug=;
        b=aE0RrzCEZh98baSRRm+kChhEUIS4gaOyFCxMHU+H+h0FAQ9awflLm9cq+yjOlHRuGp
         pDVn8wftDT8/PDi78e5ry7N99AGigNYHJuQX9K/IA1GnoQ3zNG+GlLtwW+bYohJQ1PbZ
         NFBvLT34GWB048SB4B7TUlsdFt88wO68gWa949hjFGjo1rFkLTremWM/upvM04eG3Mlb
         I0m8AdOIPETDOGn2QLKLdK99kfj06BPc3gHpzj+bFE66gkiGYII+WlBqUemNW1TfnPNd
         jIAVOlCsvEf1qqLPdZNpRCfjvtyb8tS1o7YxtMw19aH8n2uxIf1rAyp/UfC9Po2GOHmM
         mYSA==
X-Gm-Message-State: AOAM533kMiUKKDVLXn4N9ew8ktcy64Km2a5pE9lrkCyWLsJq3+2Lb+f2
        FjmOwmJm1jfoeji/KKvpjjeBASeqaBg=
X-Google-Smtp-Source: ABdhPJxod2E/PdH3pKA68HxlbApCQrL/MmUZMQTff39IUhR74cZzBqnDfdtOQNTWlst8qwLmQvsUiA==
X-Received: by 2002:a63:e715:: with SMTP id b21mr1579595pgi.300.1615967675586;
        Wed, 17 Mar 2021 00:54:35 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id z8sm1588187pjr.57.2021.03.17.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 00:54:34 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] Increase page and bit waitqueue hash size
Date:   Wed, 17 Mar 2021 17:54:27 +1000
Message-Id: <20210317075427.587806-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page waitqueue hash is a bit small (256 entries) on very big systems. A
16 socket 1536 thread POWER9 system was found to encounter hash collisions
and excessive time in waitqueue locking at times. This was intermittent and
hard to reproduce easily with the setup we had (very little real IO
capacity). The theory is that sometimes (depending on allocation luck)
important pages would happen to collide a lot in the hash, slowing down page
locking, causing the problem to snowball.

An small test case was made where threads would write and fsync different
pages, generating just a small amount of contention across many pages.

Increasing page waitqueue hash size to 262144 entries increased throughput
by 182% while also reducing standard deviation 3x. perf before the increase:

  36.23%  [k] _raw_spin_lock_irqsave                -      -
              |
              |--34.60%--wake_up_page_bit
              |          0
              |          iomap_write_end.isra.38
              |          iomap_write_actor
              |          iomap_apply
              |          iomap_file_buffered_write
              |          xfs_file_buffered_aio_write
              |          new_sync_write

  17.93%  [k] native_queued_spin_lock_slowpath      -      -
              |
              |--16.74%--_raw_spin_lock_irqsave
              |          |
              |           --16.44%--wake_up_page_bit
              |                     iomap_write_end.isra.38
              |                     iomap_write_actor
              |                     iomap_apply
              |                     iomap_file_buffered_write
              |                     xfs_file_buffered_aio_write

This patch uses alloc_large_system_hash to allocate a bigger system hash
that scales somewhat with memory size. The bit/var wait-queue is also
changed to keep code matching, albiet with a smaller scale factor.

A very small CONFIG_BASE_SMALL option is also added because these are two
of the biggest static objects in the image on very small systems.

This hash could be made per-node, which may help reduce remote accesses
on well localised workloads, but that adds some complexity with indexing
and hotplug, so until we get a less artificial workload to test with,
keep it simple.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/wait_bit.c | 30 +++++++++++++++++++++++-------
 mm/filemap.c            | 24 +++++++++++++++++++++---
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 02ce292b9bc0..dba73dec17c4 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -2,19 +2,24 @@
 /*
  * The implementation of the wait_bit*() and related waiting APIs:
  */
+#include <linux/memblock.h>
 #include "sched.h"
 
-#define WAIT_TABLE_BITS 8
-#define WAIT_TABLE_SIZE (1 << WAIT_TABLE_BITS)
-
-static wait_queue_head_t bit_wait_table[WAIT_TABLE_SIZE] __cacheline_aligned;
+#define BIT_WAIT_TABLE_SIZE (1 << bit_wait_table_bits)
+#if CONFIG_BASE_SMALL
+static const unsigned int bit_wait_table_bits = 3;
+static wait_queue_head_t bit_wait_table[BIT_WAIT_TABLE_SIZE] __cacheline_aligned;
+#else
+static unsigned int bit_wait_table_bits __ro_after_init;
+static wait_queue_head_t *bit_wait_table __ro_after_init;
+#endif
 
 wait_queue_head_t *bit_waitqueue(void *word, int bit)
 {
 	const int shift = BITS_PER_LONG == 32 ? 5 : 6;
 	unsigned long val = (unsigned long)word << shift | bit;
 
-	return bit_wait_table + hash_long(val, WAIT_TABLE_BITS);
+	return bit_wait_table + hash_long(val, bit_wait_table_bits);
 }
 EXPORT_SYMBOL(bit_waitqueue);
 
@@ -152,7 +157,7 @@ EXPORT_SYMBOL(wake_up_bit);
 
 wait_queue_head_t *__var_waitqueue(void *p)
 {
-	return bit_wait_table + hash_ptr(p, WAIT_TABLE_BITS);
+	return bit_wait_table + hash_ptr(p, bit_wait_table_bits);
 }
 EXPORT_SYMBOL(__var_waitqueue);
 
@@ -246,6 +251,17 @@ void __init wait_bit_init(void)
 {
 	int i;
 
-	for (i = 0; i < WAIT_TABLE_SIZE; i++)
+	if (!CONFIG_BASE_SMALL) {
+		bit_wait_table = alloc_large_system_hash("bit waitqueue hash",
+							sizeof(wait_queue_head_t),
+							0,
+							22,
+							0,
+							&bit_wait_table_bits,
+							NULL,
+							0,
+							0);
+	}
+	for (i = 0; i < BIT_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(bit_wait_table + i);
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 43700480d897..dbbb5b9d951d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -34,6 +34,7 @@
 #include <linux/security.h>
 #include <linux/cpuset.h>
 #include <linux/hugetlb.h>
+#include <linux/memblock.h>
 #include <linux/memcontrol.h>
 #include <linux/cleancache.h>
 #include <linux/shmem_fs.h>
@@ -990,19 +991,36 @@ EXPORT_SYMBOL(__page_cache_alloc);
  * at a cost of "thundering herd" phenomena during rare hash
  * collisions.
  */
-#define PAGE_WAIT_TABLE_BITS 8
-#define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
+#define PAGE_WAIT_TABLE_SIZE (1 << page_wait_table_bits)
+#if CONFIG_BASE_SMALL
+static const unsigned int page_wait_table_bits = 4;
 static wait_queue_head_t page_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline_aligned;
+#else
+static unsigned int page_wait_table_bits __ro_after_init;
+static wait_queue_head_t *page_wait_table __ro_after_init;
+#endif
 
 static wait_queue_head_t *page_waitqueue(struct page *page)
 {
-	return &page_wait_table[hash_ptr(page, PAGE_WAIT_TABLE_BITS)];
+	return &page_wait_table[hash_ptr(page, page_wait_table_bits)];
 }
 
 void __init pagecache_init(void)
 {
 	int i;
 
+	if (!CONFIG_BASE_SMALL) {
+		page_wait_table = alloc_large_system_hash("page waitqueue hash",
+							sizeof(wait_queue_head_t),
+							0,
+							21,
+							0,
+							&page_wait_table_bits,
+							NULL,
+							0,
+							0);
+	}
+
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(&page_wait_table[i]);
 
-- 
2.23.0

