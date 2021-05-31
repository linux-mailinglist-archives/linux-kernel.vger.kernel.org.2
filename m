Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A5395438
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 05:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhEaDhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 23:37:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2477 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhEaDhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 23:37:40 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ftgq36wDGz68yZ;
        Mon, 31 May 2021 11:33:03 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 11:35:29 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 31 May
 2021 11:35:28 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, Bixuan Cui <cuibixuan@huawei.com>
Subject: [PATCH -next v2] mm/mmap_lock: fix warning when CONFIG_TRACING is not defined
Date:   Mon, 31 May 2021 11:34:26 +0800
Message-ID: <20210531033426.74031-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning: [-Wunused-function]
mm/mmap_lock.c:157:20: warning: ‘get_mm_memcg_path’ defined but not used
 static const char *get_mm_memcg_path(struct mm_struct *mm)
                    ^~~~~~~~~~~~~~~~~

Move get_mm_memcg_path() into #ifdef CONFIG_TRACING.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
Changes in v2:
Move get_mm_memcg_path() into #ifdef CONFIG_TRACING to fix the warning.

 mm/mmap_lock.c | 60 ++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 03ee85c696ef..29e99af73144 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -142,6 +142,37 @@ static inline void put_memcg_path_buf(void)
 	rcu_read_unlock();
 }
 
+#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
+	do {                                                                   \
+		const char *memcg_path;                                        \
+		preempt_disable();                                             \
+		memcg_path = get_mm_memcg_path(mm);                            \
+		trace_mmap_lock_##type(mm,                                     \
+				       memcg_path != NULL ? memcg_path : "",   \
+				       ##__VA_ARGS__);                         \
+		if (likely(memcg_path != NULL))                                \
+			put_memcg_path_buf();                                  \
+		preempt_enable();                                              \
+	} while (0)
+
+#else /* !CONFIG_MEMCG */
+
+int trace_mmap_lock_reg(void)
+{
+	return 0;
+}
+
+void trace_mmap_lock_unreg(void)
+{
+}
+
+#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
+	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
+
+#endif /* CONFIG_MEMCG */
+
+#ifdef CONFIG_TRACING
+#ifdef CONFIG_MEMCG
 /*
  * Write the given mm_struct's memcg path to a percpu buffer, and return a
  * pointer to it. If the path cannot be determined, or no buffer was available
@@ -175,37 +206,8 @@ static const char *get_mm_memcg_path(struct mm_struct *mm)
 out:
 	return buf;
 }
-
-#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
-	do {                                                                   \
-		const char *memcg_path;                                        \
-		preempt_disable();                                             \
-		memcg_path = get_mm_memcg_path(mm);                            \
-		trace_mmap_lock_##type(mm,                                     \
-				       memcg_path != NULL ? memcg_path : "",   \
-				       ##__VA_ARGS__);                         \
-		if (likely(memcg_path != NULL))                                \
-			put_memcg_path_buf();                                  \
-		preempt_enable();                                              \
-	} while (0)
-
-#else /* !CONFIG_MEMCG */
-
-int trace_mmap_lock_reg(void)
-{
-	return 0;
-}
-
-void trace_mmap_lock_unreg(void)
-{
-}
-
-#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
-	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
-
 #endif /* CONFIG_MEMCG */
 
-#ifdef CONFIG_TRACING
 /*
  * Trace calls must be in a separate file, as otherwise there's a circular
  * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
-- 
2.17.1

