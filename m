Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC40E364DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhDSWvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:51:35 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:35371 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhDSWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:51:32 -0400
Received: by mail-io1-f41.google.com with SMTP id h141so28176034iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GNFIHP80fNCogSwOfcX0+4hG2Pb9oNldIslTinwQoQ=;
        b=pCRNvfff2UiK6jJZHWi0+di4nB2boZXrEbVD9UMnUMhITmTRldp6WPHeOdqwnxAIrP
         /B/7zlsLQcQd1ZfvtHdDX91LXaztYZOhH2dgprIxkBeG2xLl4k8ke6WzGW/abVFz4n3m
         4b4EryPeKHmVXtkqoYDOehRK0mwkfkqs62/yhSHACgnBBv47CUnXRlfQNcYloQ/T2QoO
         j8LBW9g9bo+VxdYhrgFUvAzlLEm2dV+pPDPFYxSSWJ1vQs1RNT+pzKALcNuv2OFsLt6A
         lIGGloEGCdPl/lcVzPqPdXENs0lX6loY9mRuhmPIRiPlGv84PNs1U2ZuNKil8twpWfMG
         3POA==
X-Gm-Message-State: AOAM530pFlOAcHVTkN/w4g1ZNMM3A9qG5zNpHzUMp17VyxklvozuUxmB
        lTGzIfjxdyovUCzVe3f/BOboYlDapZs=
X-Google-Smtp-Source: ABdhPJxL+9T0xG3f9jYuWBMPpKiKUicCW4XZWajxCO9GaM5jyuV5v0yFTEHY7wG0dHzSdk0RznmhhQ==
X-Received: by 2002:a5e:930d:: with SMTP id k13mr16297940iom.61.1618872661109;
        Mon, 19 Apr 2021 15:51:01 -0700 (PDT)
Received: from abasin.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d7sm7566967ion.39.2021.04.19.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:51:00 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 4/4] percpu: use reclaim threshold instead of running for every page
Date:   Mon, 19 Apr 2021 22:50:47 +0000
Message-Id: <20210419225047.3415425-5-dennis@kernel.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210419225047.3415425-1-dennis@kernel.org>
References: <20210419225047.3415425-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last patch implements reclaim by adding 2 additional lists where a
chunk's lifecycle is:
  active_slot -> to_depopulate_slot -> sidelined_slot

This worked great because we're able to nicely converge paths into
isolation. However, it's a bit aggressive to run for every free page.
Let's accumulate a few free pages before we do this. To do this, the new
lifecycle is:
  active_slot -> sidelined_slot -> to_depopulate_slot -> sidelined_slot

The transition from sidelined_slot -> to_depopulate_slot occurs on a
threshold instead of before where it directly went to the
to_depopulate_slot. pcpu_nr_isolated_empty_pop_pages[] is introduced to
aid with this.

Suggested-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu-internal.h |  1 +
 mm/percpu-stats.c    |  8 ++++++--
 mm/percpu.c          | 44 +++++++++++++++++++++++++++++++++++++-------
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 10604dce806f..b3e43b016276 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -92,6 +92,7 @@ extern int pcpu_nr_slots;
 extern int pcpu_sidelined_slot;
 extern int pcpu_to_depopulate_slot;
 extern int pcpu_nr_empty_pop_pages[];
+extern int pcpu_nr_isolated_empty_pop_pages[];
 
 extern struct pcpu_chunk *pcpu_first_chunk;
 extern struct pcpu_chunk *pcpu_reserved_chunk;
diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
index 2125981acfb9..facc804eb86c 100644
--- a/mm/percpu-stats.c
+++ b/mm/percpu-stats.c
@@ -145,7 +145,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
 	int slot, max_nr_alloc;
 	int *buffer;
 	enum pcpu_chunk_type type;
-	int nr_empty_pop_pages;
+	int nr_empty_pop_pages, nr_isolated_empty_pop_pages;
 
 alloc_buffer:
 	spin_lock_irq(&pcpu_lock);
@@ -167,8 +167,11 @@ static int percpu_stats_show(struct seq_file *m, void *v)
 	}
 
 	nr_empty_pop_pages = 0;
-	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
+	nr_isolated_empty_pop_pages = 0;
+	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
 		nr_empty_pop_pages += pcpu_nr_empty_pop_pages[type];
+		nr_isolated_empty_pop_pages += pcpu_nr_isolated_empty_pop_pages[type];
+	}
 
 #define PL(X)								\
 	seq_printf(m, "  %-20s: %12lld\n", #X, (long long int)pcpu_stats_ai.X)
@@ -202,6 +205,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
 	PU(min_alloc_size);
 	PU(max_alloc_size);
 	P("empty_pop_pages", nr_empty_pop_pages);
+	P("iso_empty_pop_pages", nr_isolated_empty_pop_pages);
 	seq_putc(m, '\n');
 
 #undef PU
diff --git a/mm/percpu.c b/mm/percpu.c
index 79eebc80860d..ba13e683d022 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -110,6 +110,9 @@
 #define PCPU_EMPTY_POP_PAGES_LOW	2
 #define PCPU_EMPTY_POP_PAGES_HIGH	4
 
+/* only schedule reclaim if there are at least N empty pop pages sidelined */
+#define PCPU_EMPTY_POP_RECLAIM_THRESHOLD	4
+
 #ifdef CONFIG_SMP
 /* default addr <-> pcpu_ptr mapping, override in asm/percpu.h if necessary */
 #ifndef __addr_to_pcpu_ptr
@@ -183,6 +186,7 @@ static LIST_HEAD(pcpu_map_extend_chunks);
  * The reserved chunk doesn't contribute to the count.
  */
 int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
+int pcpu_nr_isolated_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
 
 /*
  * The number of populated pages in use by the allocator, protected by
@@ -582,8 +586,10 @@ static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
 	if (!chunk->isolated) {
 		chunk->isolated = true;
 		pcpu_nr_empty_pop_pages[type] -= chunk->nr_empty_pop_pages;
+		pcpu_nr_isolated_empty_pop_pages[type] +=
+			chunk->nr_empty_pop_pages;
+		list_move(&chunk->list, &pcpu_slot[pcpu_sidelined_slot]);
 	}
-	list_move(&chunk->list, &pcpu_slot[pcpu_to_depopulate_slot]);
 }
 
 static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
@@ -595,6 +601,8 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
 	if (chunk->isolated) {
 		chunk->isolated = false;
 		pcpu_nr_empty_pop_pages[type] += chunk->nr_empty_pop_pages;
+		pcpu_nr_isolated_empty_pop_pages[type] -=
+			chunk->nr_empty_pop_pages;
 		pcpu_chunk_relocate(chunk, -1);
 	}
 }
@@ -610,9 +618,15 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
  */
 static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
 {
+	enum pcpu_chunk_type type = pcpu_chunk_type(chunk);
+
 	chunk->nr_empty_pop_pages += nr;
-	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
-		pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] += nr;
+	if (chunk != pcpu_reserved_chunk) {
+		if (chunk->isolated)
+			pcpu_nr_isolated_empty_pop_pages[type] += nr;
+		else
+			pcpu_nr_empty_pop_pages[type] += nr;
+	}
 }
 
 /*
@@ -2138,10 +2152,13 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
 	struct list_head *pcpu_slot = pcpu_chunk_list(type);
 	struct pcpu_chunk *chunk;
 	struct pcpu_block_md *block;
+	LIST_HEAD(to_depopulate);
 	int i, end;
 
 	spin_lock_irq(&pcpu_lock);
 
+	list_splice_init(&pcpu_slot[pcpu_to_depopulate_slot], &to_depopulate);
+
 restart:
 	/*
 	 * Once a chunk is isolated to the to_depopulate list, the chunk is no
@@ -2149,9 +2166,9 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
 	 * other accessor is the free path which only returns area back to the
 	 * allocator not touching the populated bitmap.
 	 */
-	while (!list_empty(&pcpu_slot[pcpu_to_depopulate_slot])) {
-		chunk = list_first_entry(&pcpu_slot[pcpu_to_depopulate_slot],
-					 struct pcpu_chunk, list);
+	while (!list_empty(&to_depopulate)) {
+		chunk = list_first_entry(&to_depopulate, struct pcpu_chunk,
+					 list);
 		WARN_ON(chunk->immutable);
 
 		/*
@@ -2208,6 +2225,13 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
 				  &pcpu_slot[pcpu_sidelined_slot]);
 	}
 
+	if (pcpu_nr_isolated_empty_pop_pages[type] >=
+	    PCPU_EMPTY_POP_RECLAIM_THRESHOLD) {
+		list_splice_tail_init(&pcpu_slot[pcpu_sidelined_slot],
+				      &pcpu_slot[pcpu_to_depopulate_slot]);
+		pcpu_schedule_balance_work();
+	}
+
 	spin_unlock_irq(&pcpu_lock);
 }
 
@@ -2291,7 +2315,13 @@ void free_percpu(void __percpu *ptr)
 			}
 	} else if (pcpu_should_reclaim_chunk(chunk)) {
 		pcpu_isolate_chunk(chunk);
-		need_balance = true;
+		if (chunk->free_bytes == pcpu_unit_size ||
+		    pcpu_nr_isolated_empty_pop_pages[pcpu_chunk_type(chunk)] >=
+		    PCPU_EMPTY_POP_RECLAIM_THRESHOLD) {
+			list_splice_tail_init(&pcpu_slot[pcpu_sidelined_slot],
+					      &pcpu_slot[pcpu_to_depopulate_slot]);
+			need_balance = true;
+		}
 	}
 
 	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
-- 
2.31.1.368.gbe11c130af-goog

