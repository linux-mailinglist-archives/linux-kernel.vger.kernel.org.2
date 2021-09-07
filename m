Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9978F403034
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348122AbhIGVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347223AbhIGVZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:25:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE30AC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:24:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k17so6666205pls.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C80Moy0vM+aiXkXep0Savz554R1XBxbknOkAN+if4B4=;
        b=AVa0xvI77kvZwuvMQP3Xn3cpoxgvJ1ADEPo1F/5arKtCac/M8XU5wtFm47RUiEv39u
         XEKeyjB75rZOCE7Dk1wfDb2tIRni0tanat2isCdcwi8rFS+6Ny548t/AQQnM1PK3FNpU
         XUtcIo04cfr3VeIy+yaRLpNT1XjSyiQpXvpttKGx8jerf/LSY6nLlHfZkKCWc/6RKxae
         FK94pJNLSSZMJ25MDYTmWz6EA7PVdqL1gGmhrR/OrddQzpRc4wd5HOb06/eJ5+51s0VP
         MwlLSanODKUyOAgidOWBpjN7w3uI1i9pKM0lTeq8gu/5Z8RIRq4AVFtOKFTGOKvs1G7z
         q++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=C80Moy0vM+aiXkXep0Savz554R1XBxbknOkAN+if4B4=;
        b=m3T7z+UxACzGHYILV3kBhbXsNk1eRDiIlL3aOuaZGimFQsglBZ7TitAbfvqtUBcYqr
         mntvfToe3vypOyUUa4TOGat+e+xtgwXqnez8HTveXplCbGwEUbFQuMDlNY5iYMkSi6He
         KHsPB2eEXIlQi1lfUsMJGlUV9rftahvKGFqVZxp277KdORJIUocsBqhw8JLU5/bnG7m0
         EFblQ0xWyr0AfoHkphEJkrWY0HMWa5kOM9KFzV4PfIIHLUoFloiyx/BX9d7qr1mGWn4A
         +xb/K0dmBSbBgNmzDiIn2W9q+eD4Y0yXyDMC7zC2ZkkXa2CaGQ5tA+VFWZMRaFhktcUv
         BRzA==
X-Gm-Message-State: AOAM5302m5AM89/YDrFc0uk69jsCbDbj7OumMRfufFk55azWEsALBIUz
        3TGOtHAje+82Zg+srWLadC0=
X-Google-Smtp-Source: ABdhPJzkA7gpuRyUrMiu3+56SR1zYRuGO30BZ08jqN6jHakp3VlTvgC9Vp5xAkaVwvl1KYtdMCYRlw==
X-Received: by 2002:a17:90a:4498:: with SMTP id t24mr342930pjg.235.1631049843268;
        Tue, 07 Sep 2021 14:24:03 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:998a:2486:f524:8502])
        by smtp.gmail.com with ESMTPSA id o15sm102648pjr.0.2021.09.07.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:24:02 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        Oliver Sang <oliver.sang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: [PATCH v3] mm: fs: invalidate bh_lrus for only cold path
Date:   Tue,  7 Sep 2021 14:23:47 -0700
Message-Id: <20210907212347.1977686-1-minchan@kernel.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported the regression of fio.write_iops[1]
with [2].

Since lru_add_drain is called frequently, invalidate bh_lrus
there could increase bh_lrus cache miss ratio, which needs
more IO in the end.

This patch moves the bh_lrus invalidation from the hot path(
e.g., zap_page_range, pagevec_release) to cold path(i.e.,
lru_add_drain_all, lru_cache_disable).

[1] https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
[2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* v2: https://lore.kernel.org/lkml/20210601145425.1396981-1-minchan@kernel.org/
* v1: https://lore.kernel.org/lkml/YK0oQ76zX0uVZCwQ@google.com/
 fs/buffer.c                 |  8 ++++++--
 include/linux/buffer_head.h |  4 ++--
 mm/swap.c                   | 19 ++++++++++++++++---
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ab7573d72dd7..c615387aedca 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1425,12 +1425,16 @@ void invalidate_bh_lrus(void)
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
-void invalidate_bh_lrus_cpu(int cpu)
+/*
+ * It's called from workqueue context so we need a bh_lru_lock to close
+ * the race with preemption/irq.
+ */
+void invalidate_bh_lrus_cpu(void)
 {
 	struct bh_lru *b;
 
 	bh_lru_lock();
-	b = per_cpu_ptr(&bh_lrus, cpu);
+	b = this_cpu_ptr(&bh_lrus);
 	__invalidate_bh_lrus(b);
 	bh_lru_unlock();
 }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6486d3c19463..36f33685c8c0 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -194,7 +194,7 @@ void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
 void invalidate_bh_lrus(void);
-void invalidate_bh_lrus_cpu(int cpu);
+void invalidate_bh_lrus_cpu(void);
 bool has_bh_in_lru(int cpu, void *dummy);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
@@ -408,7 +408,7 @@ static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
-static inline void invalidate_bh_lrus_cpu(int cpu) {}
+static inline void invalidate_bh_lrus_cpu(void) {}
 static inline bool has_bh_in_lru(int cpu, void *dummy) { return false; }
 #define buffer_heads_over_limit 0
 
diff --git a/mm/swap.c b/mm/swap.c
index 897200d27dd0..af3cad4e5378 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -620,7 +620,6 @@ void lru_add_drain_cpu(int cpu)
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
-	invalidate_bh_lrus_cpu(cpu);
 }
 
 /**
@@ -703,6 +702,20 @@ void lru_add_drain(void)
 	local_unlock(&lru_pvecs.lock);
 }
 
+/*
+ * It's called from per-cpu workqueue context in SMP case so
+ * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
+ * the same cpu. It shouldn't be a problem in !SMP case since
+ * the core is only one and the locks will disable preemption.
+ */
+static void lru_add_and_bh_lrus_drain(void)
+{
+	local_lock(&lru_pvecs.lock);
+	lru_add_drain_cpu(smp_processor_id());
+	local_unlock(&lru_pvecs.lock);
+	invalidate_bh_lrus_cpu();
+}
+
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
 	local_lock(&lru_pvecs.lock);
@@ -717,7 +730,7 @@ static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
 
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
-	lru_add_drain();
+	lru_add_and_bh_lrus_drain();
 }
 
 /*
@@ -858,7 +871,7 @@ void lru_cache_disable(void)
 	 */
 	__lru_add_drain_all(true);
 #else
-	lru_add_drain();
+	lru_add_and_bh_lrus_drain();
 #endif
 }
 
-- 
2.33.0.309.g3052b89438-goog

