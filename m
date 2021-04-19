Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CBE364DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhDSWvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:51:40 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:36822 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhDSWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:51:32 -0400
Received: by mail-io1-f42.google.com with SMTP id g125so7890880iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nI/sf2GFd1c2CJZsuBv2RDNskXJ63yKFVzt6dmydqnk=;
        b=VfBz/RE5yvwO0tURvBK5cln/FIfyRLm1HY+adtOXiB1/M/cVsoczhwgf72O9zSSoKG
         4OdUtIOgdn5ResxOMpeNsKy9iM7eAzJ1QiL48v5mMs8gwVCozjlbDx6QZvk/0dJSyx4N
         cFiVRmj9yaBs1a+MSOOzKOscCS2a6sVoQjyzu6VC8kyqRrLyr2lVhwacuj5CPz4f4t9g
         CZ9ciMr+8gyNzd7Cd/6PyNwh5Xw5Wbp5dRFm3O85d7hv5qY0Awf5AcgGssIBIrkRY9/S
         TLlKDXMXO6g5zR8pLH/weH74q6XSdErMoQOdOKORRTFKacXCXJn1Q6uc5fluq79fz2n3
         qY4g==
X-Gm-Message-State: AOAM530N0BhNMUAx0ZfIYfweZ2tPBk8CfMrieqaDH71oRSnBMLSif7wA
        gOmG/27IyL8vC4Kh/K+W68kukL0SCGA=
X-Google-Smtp-Source: ABdhPJwHiqMbXFFz9DvteUWFxQ4QrPbviidm4+SfyZ5khw9l9uYMBXwYOHOdnIl+JU/MPIWV1prl3Q==
X-Received: by 2002:a02:340c:: with SMTP id x12mr2384853jae.64.1618872660640;
        Mon, 19 Apr 2021 15:51:00 -0700 (PDT)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d7sm7566967ion.39.2021.04.19.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:51:00 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 3/4] percpu: implement partial chunk depopulation
Date:   Mon, 19 Apr 2021 22:50:46 +0000
Message-Id: <20210419225047.3415425-4-dennis@kernel.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210419225047.3415425-1-dennis@kernel.org>
References: <20210419225047.3415425-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

This patch implements partial depopulation of percpu chunks.

As of now, a chunk can be depopulated only as a part of the final
destruction, if there are no more outstanding allocations. However
to minimize a memory waste it might be useful to depopulate a
partially filed chunk, if a small number of outstanding allocations
prevents the chunk from being fully reclaimed.

This patch implements the following depopulation process: it scans
over the chunk pages, looks for a range of empty and populated pages
and performs the depopulation. To avoid races with new allocations,
the chunk is previously isolated. After the depopulation the chunk is
sidelined to a special list or freed. New allocations prefer using
active chunks to sidelined chunks. If a sidelined chunk is used, it is
reintegrated to the active lists.

The depopulation is scheduled on the free path if the chunk is all of
the following:
  1) has more than 1/4 of total pages free and populated
  2) the system has enough free percpu pages aside of this chunk
  3) isn't the reserved chunk
  4) isn't the first chunk
If it's already depopulated but got free populated pages, it's a good
target too. The chunk is moved to a special slot,
pcpu_to_depopulate_slot, chunk->isolated is set, and the balance work
item is scheduled. On isolation, these pages are removed from the
pcpu_nr_empty_pop_pages. It is constantly replaced to the
to_depopulate_slot when it meets these qualifications.

pcpu_reclaim_populated() iterates over the to_depopulate_slot until it
becomes empty. The depopulation is performed in the reverse direction to
keep populated pages close to the beginning. Depopulated chunks are
sidelined to preferentially avoid them for new allocations. When no
active chunk can suffice a new allocation, sidelined chunks are first
checked before creating a new chunk.

Signed-off-by: Roman Gushchin <guro@fb.com>
Co-developed-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu-internal.h |   4 +
 mm/percpu-km.c       |   5 ++
 mm/percpu-stats.c    |  12 +--
 mm/percpu-vm.c       |  30 ++++++++
 mm/percpu.c          | 180 +++++++++++++++++++++++++++++++++++++++----
 5 files changed, 211 insertions(+), 20 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 095d7eaa0db4..10604dce806f 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -67,6 +67,8 @@ struct pcpu_chunk {
 
 	void			*data;		/* chunk data */
 	bool			immutable;	/* no [de]population allowed */
+	bool			isolated;	/* isolated from active chunk
+						   slots */
 	int			start_offset;	/* the overlap with the previous
 						   region to have a page aligned
 						   base_addr */
@@ -87,6 +89,8 @@ extern spinlock_t pcpu_lock;
 
 extern struct list_head *pcpu_chunk_lists;
 extern int pcpu_nr_slots;
+extern int pcpu_sidelined_slot;
+extern int pcpu_to_depopulate_slot;
 extern int pcpu_nr_empty_pop_pages[];
 
 extern struct pcpu_chunk *pcpu_first_chunk;
diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index 35c9941077ee..c84a9f781a6c 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -118,3 +118,8 @@ static int __init pcpu_verify_alloc_info(const struct pcpu_alloc_info *ai)
 
 	return 0;
 }
+
+static bool pcpu_should_reclaim_chunk(struct pcpu_chunk *chunk)
+{
+	return false;
+}
diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
index f6026dbcdf6b..2125981acfb9 100644
--- a/mm/percpu-stats.c
+++ b/mm/percpu-stats.c
@@ -219,13 +219,15 @@ static int percpu_stats_show(struct seq_file *m, void *v)
 		for (slot = 0; slot < pcpu_nr_slots; slot++) {
 			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
 					    list) {
-				if (chunk == pcpu_first_chunk) {
+				if (chunk == pcpu_first_chunk)
 					seq_puts(m, "Chunk: <- First Chunk\n");
-					chunk_map_stats(m, chunk, buffer);
-				} else {
+				else if (slot == pcpu_to_depopulate_slot)
+					seq_puts(m, "Chunk (to_depopulate)\n");
+				else if (slot == pcpu_sidelined_slot)
+					seq_puts(m, "Chunk (sidelined):\n");
+				else
 					seq_puts(m, "Chunk:\n");
-					chunk_map_stats(m, chunk, buffer);
-				}
+				chunk_map_stats(m, chunk, buffer);
 			}
 		}
 	}
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index e46f7a6917f9..c75f6f24f2d5 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -377,3 +377,33 @@ static int __init pcpu_verify_alloc_info(const struct pcpu_alloc_info *ai)
 	/* no extra restriction */
 	return 0;
 }
+
+/**
+ * pcpu_should_reclaim_chunk - determine if a chunk should go into reclaim
+ * @chunk: chunk of interest
+ *
+ * This is the entry point for percpu reclaim.  If a chunk qualifies, it is then
+ * isolated and managed in separate lists at the back of pcpu_slot: sidelined
+ * and to_depopulate respectively.  The to_depopulate list holds chunks slated
+ * for depopulation.  They no longer contribute to pcpu_nr_empty_pop_pages once
+ * they are on this list.  Once depopulated, they are moved onto the sidelined
+ * list which enables them to be pulled back in for allocation if no other chunk
+ * can suffice the allocation.
+ */
+static bool pcpu_should_reclaim_chunk(struct pcpu_chunk *chunk)
+{
+	/* do not reclaim either the first chunk or reserved chunk */
+	if (chunk == pcpu_first_chunk || chunk == pcpu_reserved_chunk)
+		return false;
+
+	/*
+	 * If it is isolated, it may be on the sidelined list so move it back to
+	 * the to_depopulate list.  If we hit at least 1/4 pages empty pages AND
+	 * there is no system-wide shortage of empty pages aside from this
+	 * chunk, move it to the to_depopulate list.
+	 */
+	return ((chunk->isolated && chunk->nr_empty_pop_pages) ||
+		(pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
+		 PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages &&
+		chunk->nr_empty_pop_pages >= chunk->nr_pages / 4));
+}
diff --git a/mm/percpu.c b/mm/percpu.c
index d462222f4adc..79eebc80860d 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -136,6 +136,8 @@ static int pcpu_nr_units __ro_after_init;
 static int pcpu_atom_size __ro_after_init;
 int pcpu_nr_slots __ro_after_init;
 int pcpu_free_slot __ro_after_init;
+int pcpu_sidelined_slot __ro_after_init;
+int pcpu_to_depopulate_slot __ro_after_init;
 static size_t pcpu_chunk_struct_size __ro_after_init;
 
 /* cpus with the lowest and highest unit addresses */
@@ -562,10 +564,41 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *chunk, int oslot)
 {
 	int nslot = pcpu_chunk_slot(chunk);
 
+	/* leave isolated chunks in-place */
+	if (chunk->isolated)
+		return;
+
 	if (oslot != nslot)
 		__pcpu_chunk_move(chunk, nslot, oslot < nslot);
 }
 
+static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
+{
+	enum pcpu_chunk_type type = pcpu_chunk_type(chunk);
+	struct list_head *pcpu_slot = pcpu_chunk_list(type);
+
+	lockdep_assert_held(&pcpu_lock);
+
+	if (!chunk->isolated) {
+		chunk->isolated = true;
+		pcpu_nr_empty_pop_pages[type] -= chunk->nr_empty_pop_pages;
+	}
+	list_move(&chunk->list, &pcpu_slot[pcpu_to_depopulate_slot]);
+}
+
+static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
+{
+	enum pcpu_chunk_type type = pcpu_chunk_type(chunk);
+
+	lockdep_assert_held(&pcpu_lock);
+
+	if (chunk->isolated) {
+		chunk->isolated = false;
+		pcpu_nr_empty_pop_pages[type] += chunk->nr_empty_pop_pages;
+		pcpu_chunk_relocate(chunk, -1);
+	}
+}
+
 /*
  * pcpu_update_empty_pages - update empty page counters
  * @chunk: chunk of interest
@@ -578,7 +611,7 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *chunk, int oslot)
 static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
 {
 	chunk->nr_empty_pop_pages += nr;
-	if (chunk != pcpu_reserved_chunk)
+	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
 		pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] += nr;
 }
 
@@ -1778,7 +1811,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 restart:
 	/* search through normal chunks */
-	for (slot = pcpu_size_to_slot(size); slot < pcpu_nr_slots; slot++) {
+	for (slot = pcpu_size_to_slot(size); slot <= pcpu_free_slot; slot++) {
 		list_for_each_entry_safe(chunk, next, &pcpu_slot[slot], list) {
 			off = pcpu_find_block_fit(chunk, bits, bit_align,
 						  is_atomic);
@@ -1789,9 +1822,10 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 			}
 
 			off = pcpu_alloc_area(chunk, bits, bit_align, off);
-			if (off >= 0)
+			if (off >= 0) {
+				pcpu_reintegrate_chunk(chunk);
 				goto area_found;
-
+			}
 		}
 	}
 
@@ -1952,10 +1986,13 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
 /**
  * pcpu_balance_free - manage the amount of free chunks
  * @type: chunk type
+ * @empty_only: free chunks only if there are no populated pages
  *
- * Reclaim all fully free chunks except for the first one.
+ * If empty_only is %false, reclaim all fully free chunks regardless of the
+ * number of populated pages.  Otherwise, only reclaim chunks that have no
+ * populated pages.
  */
-static void pcpu_balance_free(enum pcpu_chunk_type type)
+static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
 {
 	LIST_HEAD(to_free);
 	struct list_head *pcpu_slot = pcpu_chunk_list(type);
@@ -1975,7 +2012,8 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
 		if (chunk == list_first_entry(free_head, struct pcpu_chunk, list))
 			continue;
 
-		list_move(&chunk->list, &to_free);
+		if (!empty_only || chunk->nr_empty_pop_pages == 0)
+			list_move(&chunk->list, &to_free);
 	}
 
 	spin_unlock_irq(&pcpu_lock);
@@ -2083,20 +2121,121 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
 	}
 }
 
+/**
+ * pcpu_reclaim_populated - scan over to_depopulate chunks and free empty pages
+ * @type: chunk type
+ *
+ * Scan over chunks in the depopulate list and try to release unused populated
+ * pages back to the system.  Depopulated chunks are sidelined to prevent
+ * repopulating these pages unless required.  Fully free chunks are reintegrated
+ * and freed accordingly (1 is kept around).  If we drop below the empty
+ * populated pages threshold, reintegrate the chunk if it has empty free pages.
+ * Each chunk is scanned in the reverse order to keep populated pages close to
+ * the beginning of the chunk.
+ */
+static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
+{
+	struct list_head *pcpu_slot = pcpu_chunk_list(type);
+	struct pcpu_chunk *chunk;
+	struct pcpu_block_md *block;
+	int i, end;
+
+	spin_lock_irq(&pcpu_lock);
+
+restart:
+	/*
+	 * Once a chunk is isolated to the to_depopulate list, the chunk is no
+	 * longer discoverable to allocations whom may populate pages.  The only
+	 * other accessor is the free path which only returns area back to the
+	 * allocator not touching the populated bitmap.
+	 */
+	while (!list_empty(&pcpu_slot[pcpu_to_depopulate_slot])) {
+		chunk = list_first_entry(&pcpu_slot[pcpu_to_depopulate_slot],
+					 struct pcpu_chunk, list);
+		WARN_ON(chunk->immutable);
+
+		/*
+		 * Scan chunk's pages in the reverse order to keep populated
+		 * pages close to the beginning of the chunk.
+		 */
+		for (i = chunk->nr_pages - 1, end = -1; i >= 0; i--) {
+			/* no more work to do */
+			if (chunk->nr_empty_pop_pages == 0)
+				break;
+
+			/* reintegrate chunk to prevent atomic alloc failures */
+			if (pcpu_nr_empty_pop_pages[type] <
+			    PCPU_EMPTY_POP_PAGES_HIGH) {
+				pcpu_reintegrate_chunk(chunk);
+				goto restart;
+			}
+
+			/*
+			 * If the page is empty and populated, start or
+			 * extend the (i, end) range.  If i == 0, decrease
+			 * i and perform the depopulation to cover the last
+			 * (first) page in the chunk.
+			 */
+			block = chunk->md_blocks + i;
+			if (block->contig_hint == PCPU_BITMAP_BLOCK_BITS &&
+			    test_bit(i, chunk->populated)) {
+				if (end == -1)
+					end = i;
+				if (i > 0)
+					continue;
+				i--;
+			}
+
+			/* depopulate if there is an active range */
+			if (end == -1)
+				continue;
+
+			spin_unlock_irq(&pcpu_lock);
+			pcpu_depopulate_chunk(chunk, i + 1, end + 1);
+			cond_resched();
+			spin_lock_irq(&pcpu_lock);
+
+			pcpu_chunk_depopulated(chunk, i + 1, end + 1);
+
+			/* reset the range and continue */
+			end = -1;
+		}
+
+		if (chunk->free_bytes == pcpu_unit_size)
+			pcpu_reintegrate_chunk(chunk);
+		else
+			list_move(&chunk->list,
+				  &pcpu_slot[pcpu_sidelined_slot]);
+	}
+
+	spin_unlock_irq(&pcpu_lock);
+}
+
 /**
  * pcpu_balance_workfn - manage the amount of free chunks and populated pages
  * @work: unused
  *
- * Call pcpu_balance_free() and pcpu_balance_populated() for each chunk type.
+ * For each chunk type, manage the number of fully free chunks and the number of
+ * populated pages.  An important thing to consider is when pages are freed and
+ * how they contribute to the global counts.
  */
 static void pcpu_balance_workfn(struct work_struct *work)
 {
 	enum pcpu_chunk_type type;
 
+	/*
+	 * pcpu_balance_free() is called twice because the first time we may
+	 * trim pages in the active pcpu_nr_empty_pop_pages which may cause us
+	 * to grow other chunks.  This then gives pcpu_reclaim_populated() time
+	 * to move fully free chunks to the active list to be freed if
+	 * appropriate.
+	 */
 	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
 		mutex_lock(&pcpu_alloc_mutex);
-		pcpu_balance_free(type);
+		pcpu_balance_free(type, false);
+		pcpu_reclaim_populated(type);
 		pcpu_balance_populated(type);
+		pcpu_balance_free(type, true);
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
 }
@@ -2137,8 +2276,12 @@ void free_percpu(void __percpu *ptr)
 
 	pcpu_memcg_free_hook(chunk, off, size);
 
-	/* if there are more than one fully free chunks, wake up grim reaper */
-	if (chunk->free_bytes == pcpu_unit_size) {
+	/*
+	 * If there are more than one fully free chunks, wake up grim reaper.
+	 * If the chunk is isolated, it may be in the process of being
+	 * reclaimed.  Let reclaim manage cleaning up of that chunk.
+	 */
+	if (!chunk->isolated && chunk->free_bytes == pcpu_unit_size) {
 		struct pcpu_chunk *pos;
 
 		list_for_each_entry(pos, &pcpu_slot[pcpu_free_slot], list)
@@ -2146,6 +2289,9 @@ void free_percpu(void __percpu *ptr)
 				need_balance = true;
 				break;
 			}
+	} else if (pcpu_should_reclaim_chunk(chunk)) {
+		pcpu_isolate_chunk(chunk);
+		need_balance = true;
 	}
 
 	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
@@ -2560,11 +2706,15 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	pcpu_stats_save_ai(ai);
 
 	/*
-	 * Allocate chunk slots.  The additional last slot is for
-	 * empty chunks.
+	 * Allocate chunk slots.  The slots after the active slots are:
+	 *   sidelined_slot - isolated, depopulated chunks
+	 *   free_slot - fully free chunks
+	 *   to_depopulate_slot - isolated, chunks to depopulate
 	 */
-	pcpu_free_slot = __pcpu_size_to_slot(pcpu_unit_size) + 1;
-	pcpu_nr_slots = pcpu_free_slot + 1;
+	pcpu_sidelined_slot = __pcpu_size_to_slot(pcpu_unit_size) + 1;
+	pcpu_free_slot = pcpu_sidelined_slot + 1;
+	pcpu_to_depopulate_slot = pcpu_free_slot + 1;
+	pcpu_nr_slots = pcpu_to_depopulate_slot + 1;
 	pcpu_chunk_lists = memblock_alloc(pcpu_nr_slots *
 					  sizeof(pcpu_chunk_lists[0]) *
 					  PCPU_NR_CHUNK_TYPES,
-- 
2.31.1.368.gbe11c130af-goog

