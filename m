Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80303BAA4B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhGCVIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 17:08:02 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:44788 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhGCVIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 17:08:01 -0400
Received: by mail-io1-f47.google.com with SMTP id q2so1064649iot.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 14:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XE2GMksrM6rMi9AMMfF+ayFY49SMifYCVs0ytnLO6NA=;
        b=R3u1Pc/1pbLOPYlWRxbYH17NG0Q9vjBdd9t06InbUILYpfxfQxM1qx9pJA4T7M+nxs
         rorGp/sFFn56AwQC44NGFup758pSoi9HTSj0fRU0ZR8Xb/lD8lAWcvSaEf7vP13W2aO8
         TUS3J0mK8PBnT6N4JLvK06sb92gST41/ZgimBqhToEa2L1kL530fn92c8nRrRLht+0EE
         XVW8kDFJYA/EHjtppwku4CuxQEyz2rjMRSzG5A+BHYNdi23dMe/LUm1hDlfgRhkXGOBl
         Qm/lLNJn7AB61O3FP2CI8yMib7po68ZBc8J+gLPchDZuhkjl/k0uQxpUZ7LWfIZXYl/r
         Q4Cw==
X-Gm-Message-State: AOAM532lLHUW7ajEWaQScxou/e9PXU8NRHar7eK9/CIW4+HQ6bbg9926
        vNPtlPAywGeI9Ta0V4rm9Oo=
X-Google-Smtp-Source: ABdhPJxINEXy6VygXv/m66r7IQce0E4kEGG+HxWgO4uYjL+6hSMcVhiz05lcFvmt8HANInqxTnZt2g==
X-Received: by 2002:a5d:9acd:: with SMTP id x13mr5324985ion.134.1625346326562;
        Sat, 03 Jul 2021 14:05:26 -0700 (PDT)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id l5sm4189775ion.44.2021.07.03.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:05:26 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] percpu: flush tlb in pcpu_reclaim_populated()
Date:   Sat,  3 Jul 2021 21:05:23 +0000
Message-Id: <20210703210523.118589-1-dennis@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to "percpu: implement partial chunk depopulation",
pcpu_depopulate_chunk() was called only on the destruction path. This
meant the virtual address range was on its way back to vmalloc which
will handle flushing the tlbs for us.

However, with pcpu_reclaim_populated(), we are now calling
pcpu_depopulate_chunk() during the active lifecycle of a chunk.
Therefore, we need to flush the tlb as well otherwise we can end up
accessing the wrong page through an invalid tlb mapping as reported in
[1].

[1] https://lore.kernel.org/lkml/20210702191140.GA3166599@roeck-us.net/

Fixes: f183324133ea ("percpu: implement partial chunk depopulation")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
I think I'm happier with this. It does the same thing as [2] but moves
the flush to the caller so we can batch per chunk.

[2] https://lore.kernel.org/lkml/20210703040449.3213210-1-dennis@kernel.org/

 mm/percpu-km.c |  6 ++++++
 mm/percpu-vm.c |  5 +++--
 mm/percpu.c    | 29 +++++++++++++++++++++++------
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index c9d529dc7651..fe31aa19db81 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -32,6 +32,12 @@
 
 #include <linux/log2.h>
 
+static void pcpu_post_unmap_tlb_flush(struct pcpu_chunk *chunk,
+				      int page_start, int page_end)
+{
+	/* nothing */
+}
+
 static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
 			       int page_start, int page_end, gfp_t gfp)
 {
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index ee5d89fcd66f..2054c9213c43 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -303,6 +303,9 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
  * For each cpu, depopulate and unmap pages [@page_start,@page_end)
  * from @chunk.
  *
+ * Caller is required to call pcpu_post_unmap_tlb_flush() if not returning the
+ * region back to vmalloc() which will lazily flush the tlb.
+ *
  * CONTEXT:
  * pcpu_alloc_mutex.
  */
@@ -324,8 +327,6 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
 
 	pcpu_unmap_pages(chunk, pages, page_start, page_end);
 
-	/* no need to flush tlb, vmalloc will handle it lazily */
-
 	pcpu_free_pages(chunk, pages, page_start, page_end);
 }
 
diff --git a/mm/percpu.c b/mm/percpu.c
index b4cebeca4c0c..8d8efd668f76 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1572,6 +1572,7 @@ static void pcpu_chunk_depopulated(struct pcpu_chunk *chunk,
  *
  * pcpu_populate_chunk		- populate the specified range of a chunk
  * pcpu_depopulate_chunk	- depopulate the specified range of a chunk
+ * pcpu_post_unmap_tlb_flush	- flush tlb for the specified range of a chunk
  * pcpu_create_chunk		- create a new chunk
  * pcpu_destroy_chunk		- destroy a chunk, always preceded by full depop
  * pcpu_addr_to_page		- translate address to physical address
@@ -1581,6 +1582,8 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
 			       int page_start, int page_end, gfp_t gfp);
 static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
 				  int page_start, int page_end);
+static void pcpu_post_unmap_tlb_flush(struct pcpu_chunk *chunk,
+				      int page_start, int page_end);
 static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
 static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
 static struct page *pcpu_addr_to_page(void *addr);
@@ -2137,11 +2140,12 @@ static void pcpu_reclaim_populated(void)
 {
 	struct pcpu_chunk *chunk;
 	struct pcpu_block_md *block;
+	int freed_page_start, freed_page_end;
 	int i, end;
+	bool reintegrate;
 
 	lockdep_assert_held(&pcpu_lock);
 
-restart:
 	/*
 	 * Once a chunk is isolated to the to_depopulate list, the chunk is no
 	 * longer discoverable to allocations whom may populate pages.  The only
@@ -2157,6 +2161,9 @@ static void pcpu_reclaim_populated(void)
 		 * Scan chunk's pages in the reverse order to keep populated
 		 * pages close to the beginning of the chunk.
 		 */
+		freed_page_start = chunk->nr_pages;
+		freed_page_end = 0;
+		reintegrate = false;
 		for (i = chunk->nr_pages - 1, end = -1; i >= 0; i--) {
 			/* no more work to do */
 			if (chunk->nr_empty_pop_pages == 0)
@@ -2164,8 +2171,8 @@ static void pcpu_reclaim_populated(void)
 
 			/* reintegrate chunk to prevent atomic alloc failures */
 			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
-				pcpu_reintegrate_chunk(chunk);
-				goto restart;
+				reintegrate = true;
+				goto end_chunk;
 			}
 
 			/*
@@ -2194,16 +2201,26 @@ static void pcpu_reclaim_populated(void)
 			spin_lock_irq(&pcpu_lock);
 
 			pcpu_chunk_depopulated(chunk, i + 1, end + 1);
+			freed_page_start = min(freed_page_start, i + 1);
+			freed_page_end = max(freed_page_end, end + 1);
 
 			/* reset the range and continue */
 			end = -1;
 		}
 
-		if (chunk->free_bytes == pcpu_unit_size)
+end_chunk:
+		/* batch tlb flush per chunk to amortize cost */
+		if (freed_page_start < freed_page_end) {
+			pcpu_post_unmap_tlb_flush(chunk,
+						  freed_page_start,
+						  freed_page_end);
+		}
+
+		if (reintegrate || chunk->free_bytes == pcpu_unit_size)
 			pcpu_reintegrate_chunk(chunk);
 		else
-			list_move(&chunk->list,
-				  &pcpu_chunk_lists[pcpu_sidelined_slot]);
+			list_move_tail(&chunk->list,
+				       &pcpu_chunk_lists[pcpu_sidelined_slot]);
 	}
 }
 
-- 
2.32.0.93.g670b81a890-goog

