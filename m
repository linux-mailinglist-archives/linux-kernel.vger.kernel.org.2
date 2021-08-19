Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC963F211D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhHSTym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbhHSTyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:54:36 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3701C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:53:59 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id j9so4277107qvt.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+UhPfvB4V7hB7D/Na/kzqHbrTzZZtUZNRqqvxGPOUU=;
        b=K0GYs6I/N/DQa4Q/WBxWRF15jR9c4tavLgSYprqqRx8sBXLmwecuXtr0ZktuI+aA56
         fRP3qbALBqYGJL1cNqigf9watu8Lky+IsjBKMPjmAKfmitE0ykqdFm3AtqU//7+01RVz
         F0l0xvl7/hdOt7vjIiLI6C7r5fk4g9Cf5KGx95pp2EMnTGNYVezI+8f2wQ/T1XRvrGHI
         CyvOnGgAbyhjouRzgIyOpv3qnJFnoDprs/RbZUvn123LJppNO2yO/RISOh1gOepQU2j0
         EuQqrVW8kd2yOVH90bTVnpOMDiPw1Dy8qBmaUYi7Di8/ZJygsovkDayuQCeZRRDnTnye
         Y6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+UhPfvB4V7hB7D/Na/kzqHbrTzZZtUZNRqqvxGPOUU=;
        b=UIxU7If62jgsm4z4WKpX4Bzl3q3SP6Q9tZS97VuK6NOMR1MXlPcSoXsmD3IQfSXj0i
         FDeJn+RXl2zayeDw8JVuZnohTKebcG8p6gTKAAUSH4Pj0ZCcIAolcsGIKVKbn6iaK6uK
         uXW94VeSy5knwyqdV9evv7IAPaiipYMo5t17eTrH0/aBEIdiqt3MHFz541qvYp9sS95I
         WkPOZdQLwG2xACf8aafFHD0BunPpXt3EJr+Gx+3oT0nLau8sEc5uRoqgvFbA8o7F9sHe
         Tf1GRiBQhFJdsuV8Z5TubS8mTbh2Lr1uaTtNuI1h1YaALgaQkas3AA80nwEKq5bkfKVZ
         oD/g==
X-Gm-Message-State: AOAM532DPJd9eKYwMMGBk8msD7RXSINLklJZcpvuWFk7xBZbqdq14Ui+
        o2ezKZAUaAdI4VH8zyJ6aY42ng==
X-Google-Smtp-Source: ABdhPJyGrl6h+vXHMzNA02B4FcCZPgSeu/NJ4nBm+YlvcMFckMlp5WMer3tqpLgdavYnAW1XKwWjlQ==
X-Received: by 2002:a05:6214:3ca:: with SMTP id ce10mr16219837qvb.42.1629402839186;
        Thu, 19 Aug 2021 12:53:59 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id a17sm1688738qtp.61.2021.08.19.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 12:53:58 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 4/4] mm: zswap: add basic meminfo and vmstat coverage
Date:   Thu, 19 Aug 2021 15:55:33 -0400
Message-Id: <20210819195533.211756-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819195533.211756-1-hannes@cmpxchg.org>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it requires poking at debugfs to figure out the size of the
zswap cache size on a host. There are no counters for reads and writes
against the cache. This makes it difficult to understand behavior on
production systems.

Print zswap memory consumption in /proc/meminfo, count zswapouts and
zswapins in /proc/vmstat.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/proc/meminfo.c             |  4 ++++
 include/linux/swap.h          |  4 ++++
 include/linux/vm_event_item.h |  4 ++++
 mm/vmstat.c                   |  4 ++++
 mm/zswap.c                    | 11 +++++------
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6fa761c9cc78..2dc474940691 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -86,6 +86,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	show_val_kb(m, "SwapTotal:      ", i.totalswap);
 	show_val_kb(m, "SwapFree:       ", i.freeswap);
+#ifdef CONFIG_ZSWAP
+	seq_printf(m,  "Zswap:          %8lu kB\n",
+		   (unsigned long)(zswap_pool_total_size >> 10));
+#endif
 	show_val_kb(m, "Dirty:          ",
 		    global_node_page_state(NR_FILE_DIRTY));
 	show_val_kb(m, "Writeback:      ",
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 144727041e78..3b23c88b6a8d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -696,6 +696,10 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 }
 #endif
 
+#ifdef CONFIG_ZSWAP
+extern u64 zswap_pool_total_size;
+#endif
+
 #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
 extern void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
 #else
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index ae0dd1948c2b..9dbebea09c69 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -125,6 +125,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		SWAP_RA,
 		SWAP_RA_HIT,
 #endif
+#ifdef CONFIG_ZSWAP
+		ZSWPIN,
+		ZSWPOUT,
+#endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index cccee36b289c..31aada15c571 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1369,6 +1369,10 @@ const char * const vmstat_text[] = {
 	"swap_ra",
 	"swap_ra_hit",
 #endif
+#ifdef CONFIG_ZSWAP
+	"zswpin",
+	"zswpout",
+#endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
diff --git a/mm/zswap.c b/mm/zswap.c
index 20763267a219..f93a7c715f76 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -40,7 +40,7 @@
 * statistics
 **********************************/
 /* Total bytes used by the compressed storage */
-static u64 zswap_pool_total_size;
+u64 zswap_pool_total_size;
 /* The number of compressed pages currently stored in zswap */
 static atomic_t zswap_stored_pages = ATOMIC_INIT(0);
 /* The number of same-value filled pages currently stored in zswap */
@@ -1231,6 +1231,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
 	zswap_update_total_size();
+	count_vm_event(ZSWAPOUT);
 
 	return 0;
 
@@ -1273,11 +1274,10 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		zswap_fill_page(dst, entry->value);
 		kunmap_atomic(dst);
 		ret = 0;
-		goto freeentry;
+		goto stats;
 	}
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
-
 		tmp = kmalloc(entry->length, GFP_ATOMIC);
 		if (!tmp) {
 			ret = -ENOMEM;
@@ -1292,10 +1292,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		src += sizeof(struct zswap_header);
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
-
 		memcpy(tmp, src, entry->length);
 		src = tmp;
-
 		zpool_unmap_handle(entry->pool->zpool, entry->handle);
 	}
 
@@ -1314,7 +1312,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		kfree(tmp);
 
 	BUG_ON(ret);
-
+stats:
+	count_vm_event(ZSWAPIN);
 freeentry:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
-- 
2.32.0

