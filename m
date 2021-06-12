Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645963A4CEE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 06:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFLE4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 00:56:02 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:38537 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFLE4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 00:56:01 -0400
Received: by mail-pg1-f182.google.com with SMTP id t17so4114007pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZpi/auc1uYGQ0mhRO9DGP7asmsg6AhH3/5v7rWbUt4=;
        b=ZcoSxJxrlysj6PmxQnN2feQVMjCpCIEOc0PRD1Sy26SkAFuPCIkNvoHoXBUGV6V/fS
         k5qMtgjMM2TwijnhyjtVu1R2L4EM0q3Jv/HavpMdsR7cNX6ycFqrPR+ur8B16H90oy7H
         7N7oWu9e/+X4X8j0zhHNEkCTbyLKw5BTGQnZw69UwWvYcQwPeT+H3qAV8sDiNhMln+rc
         yprxgiBbWL3nhvPbMzZDsSEGDP0OKrvl42wL1PswjXyDAn1zSpetFLFlGECSR2NUraLT
         TWzxV43BA2CliT+jrJBcI6a0PXkWUX8E+fvznOjgAPLj2vWm6jeZ/vsgB9RJGwrb40kX
         XCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZpi/auc1uYGQ0mhRO9DGP7asmsg6AhH3/5v7rWbUt4=;
        b=tKXZM11CXJRWV/3RJtjb8D3/czrpfwaQm2Ry8ol9jbFaUfWXCQ0z5GpmTG79hHO6z9
         Qq0G+Z0Ab0x+CBHazNB1K2LZ8A8y24tAXwTZke+ypgwFwbUUw/dLBQrGjJhC7nlIOsKB
         NZg2EpN1P8FQUGh9RNxRZTmjLAngPD1PycVJk6b2vS19lGl23mALnrOCWp3xornQM2QY
         CTT4B1gUadILKtEid5pqVbf4d2nKtUmmouQ6vWGaGJPW0IUTtLmuc9D17Hniv8dXeo6j
         pWq9pQv+OTxZtBxqFnJYa/rVHlLx3obkZ1CfAlYUxFLyXmLkU0CX9seoVicDXdXiGK2b
         8Izg==
X-Gm-Message-State: AOAM53160+7Ew03BlYECAMDZbQ2nn9XdVKe+YU9fWMIf67nDvx068QdK
        ckBdMO3J9ODZEVKrzZZmKUI=
X-Google-Smtp-Source: ABdhPJzYCxYEqyaz6ABWMOjtLQRlRP7Qef7aI/cIPnMZcc1dhVxo6XcVVu99GccmnKVrWEGv1SrlRg==
X-Received: by 2002:a63:7d2:: with SMTP id 201mr7032031pgh.14.1623473569284;
        Fri, 11 Jun 2021 21:52:49 -0700 (PDT)
Received: from lee-virtual-machine.localdomain (61-230-42-225.dynamic-ip.hinet.net. [61.230.42.225])
        by smtp.gmail.com with ESMTPSA id m1sm6076572pgd.78.2021.06.11.21.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:52:49 -0700 (PDT)
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kuan-Ying Lee <kylee0686026@gmail.com>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 2/3] kasan: integrate the common part of two KASAN tag-based modes
Date:   Sat, 12 Jun 2021 12:51:55 +0800
Message-Id: <20210612045156.44763-3-kylee0686026@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210612045156.44763-1-kylee0686026@gmail.com>
References: <20210612045156.44763-1-kylee0686026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Move kasan_get_free_track() and kasan_set_free_info()
   into tags.c
2. Move kasan_get_bug_type() to header file

Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>
Suggested-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kasan/Makefile         |  4 +--
 mm/kasan/hw_tags.c        | 22 ---------------
 mm/kasan/report_hw_tags.c |  6 +---
 mm/kasan/report_sw_tags.c | 46 +------------------------------
 mm/kasan/report_tags.h    | 56 +++++++++++++++++++++++++++++++++++++
 mm/kasan/sw_tags.c        | 41 ---------------------------
 mm/kasan/tags.c           | 58 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 118 insertions(+), 115 deletions(-)
 create mode 100644 mm/kasan/report_tags.h
 create mode 100644 mm/kasan/tags.c

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 9fe39a66388a..634de6c1da9b 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -37,5 +37,5 @@ CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 
 obj-$(CONFIG_KASAN) := common.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
-obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o
-obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o
+obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o tags.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index ed5e5b833d61..4ea8c368b5b8 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -216,28 +216,6 @@ void __init kasan_init_hw_tags(void)
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void kasan_set_free_info(struct kmem_cache *cache,
-				void *object, u8 tag)
-{
-	struct kasan_alloc_meta *alloc_meta;
-
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (alloc_meta)
-		kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
-}
-
-struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-				void *object, u8 tag)
-{
-	struct kasan_alloc_meta *alloc_meta;
-
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (!alloc_meta)
-		return NULL;
-
-	return &alloc_meta->free_track[0];
-}
-
 void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
 {
 	/*
diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
index 42b2168755d6..ef5e7378f3aa 100644
--- a/mm/kasan/report_hw_tags.c
+++ b/mm/kasan/report_hw_tags.c
@@ -14,11 +14,7 @@
 #include <linux/types.h>
 
 #include "kasan.h"
-
-const char *kasan_get_bug_type(struct kasan_access_info *info)
-{
-	return "invalid-access";
-}
+#include "report_tags.h"
 
 void *kasan_find_first_bad_addr(void *addr, size_t size)
 {
diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index 821a14a19a92..d965a170083e 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -26,51 +26,7 @@
 
 #include <asm/sections.h>
 
-#include "kasan.h"
-#include "../slab.h"
-
-const char *kasan_get_bug_type(struct kasan_access_info *info)
-{
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
-	struct kasan_alloc_meta *alloc_meta;
-	struct kmem_cache *cache;
-	struct page *page;
-	const void *addr;
-	void *object;
-	u8 tag;
-	int i;
-
-	tag = get_tag(info->access_addr);
-	addr = kasan_reset_tag(info->access_addr);
-	page = kasan_addr_to_page(addr);
-	if (page && PageSlab(page)) {
-		cache = page->slab_cache;
-		object = nearest_obj(cache, page, (void *)addr);
-		alloc_meta = kasan_get_alloc_meta(cache, object);
-
-		if (alloc_meta) {
-			for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
-				if (alloc_meta->free_pointer_tag[i] == tag)
-					return "use-after-free";
-			}
-		}
-		return "out-of-bounds";
-	}
-
-#endif
-	/*
-	 * If access_size is a negative number, then it has reason to be
-	 * defined as out-of-bounds bug type.
-	 *
-	 * Casting negative numbers to size_t would indeed turn up as
-	 * a large size_t and its value will be larger than ULONG_MAX/2,
-	 * so that this can qualify as out-of-bounds.
-	 */
-	if (info->access_addr + info->access_size < info->access_addr)
-		return "out-of-bounds";
-
-	return "invalid-access";
-}
+#include "report_tags.h"
 
 void *kasan_find_first_bad_addr(void *addr, size_t size)
 {
diff --git a/mm/kasan/report_tags.h b/mm/kasan/report_tags.h
new file mode 100644
index 000000000000..4f740d4d99ee
--- /dev/null
+++ b/mm/kasan/report_tags.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __MM_KASAN_REPORT_TAGS_H
+#define __MM_KASAN_REPORT_TAGS_H
+
+#include "kasan.h"
+#include "../slab.h"
+
+#ifdef CONFIG_KASAN_TAGS_IDENTIFY
+const char *kasan_get_bug_type(struct kasan_access_info *info)
+{
+	struct kasan_alloc_meta *alloc_meta;
+	struct kmem_cache *cache;
+	struct page *page;
+	const void *addr;
+	void *object;
+	u8 tag;
+	int i;
+
+	tag = get_tag(info->access_addr);
+	addr = kasan_reset_tag(info->access_addr);
+	page = kasan_addr_to_page(addr);
+	if (page && PageSlab(page)) {
+		cache = page->slab_cache;
+		object = nearest_obj(cache, page, (void *)addr);
+		alloc_meta = kasan_get_alloc_meta(cache, object);
+
+		if (alloc_meta) {
+			for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
+				if (alloc_meta->free_pointer_tag[i] == tag)
+					return "use-after-free";
+			}
+		}
+		return "out-of-bounds";
+	}
+
+	/*
+	 * If access_size is a negative number, then it has reason to be
+	 * defined as out-of-bounds bug type.
+	 *
+	 * Casting negative numbers to size_t would indeed turn up as
+	 * a large size_t and its value will be larger than ULONG_MAX/2,
+	 * so that this can qualify as out-of-bounds.
+	 */
+	if (info->access_addr + info->access_size < info->access_addr)
+		return "out-of-bounds";
+
+	return "invalid-access";
+}
+#else
+const char *kasan_get_bug_type(struct kasan_access_info *info)
+{
+	return "invalid-access";
+}
+#endif
+
+#endif
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index dd05e6c801fa..bd3f540feb47 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -167,47 +167,6 @@ void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
 }
 EXPORT_SYMBOL(__hwasan_tag_memory);
 
-void kasan_set_free_info(struct kmem_cache *cache,
-				void *object, u8 tag)
-{
-	struct kasan_alloc_meta *alloc_meta;
-	u8 idx = 0;
-
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (!alloc_meta)
-		return;
-
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
-	idx = alloc_meta->free_track_idx;
-	alloc_meta->free_pointer_tag[idx] = tag;
-	alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
-#endif
-
-	kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
-}
-
-struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-				void *object, u8 tag)
-{
-	struct kasan_alloc_meta *alloc_meta;
-	int i = 0;
-
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (!alloc_meta)
-		return NULL;
-
-#ifdef CONFIG_KASAN_TAGS_IDENTIFY
-	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
-		if (alloc_meta->free_pointer_tag[i] == tag)
-			break;
-	}
-	if (i == KASAN_NR_FREE_STACKS)
-		i = alloc_meta->free_track_idx;
-#endif
-
-	return &alloc_meta->free_track[i];
-}
-
 void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
 			unsigned long ret_ip)
 {
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
new file mode 100644
index 000000000000..9c33c0ebe1d1
--- /dev/null
+++ b/mm/kasan/tags.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains common tag-based KASAN code.
+ *
+ * Author: Kuan-Ying Lee <kylee0686026@gmail.com>
+ */
+
+#include <linux/init.h>
+#include <linux/kasan.h>
+#include <linux/kernel.h>
+#include <linux/memory.h>
+#include <linux/mm.h>
+#include <linux/static_key.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "kasan.h"
+
+void kasan_set_free_info(struct kmem_cache *cache,
+				void *object, u8 tag)
+{
+	struct kasan_alloc_meta *alloc_meta;
+	u8 idx = 0;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return;
+
+#ifdef CONFIG_KASAN_TAGS_IDENTIFY
+	idx = alloc_meta->free_track_idx;
+	alloc_meta->free_pointer_tag[idx] = tag;
+	alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
+#endif
+
+	kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
+}
+
+struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
+				void *object, u8 tag)
+{
+	struct kasan_alloc_meta *alloc_meta;
+	int i = 0;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return NULL;
+
+#ifdef CONFIG_KASAN_TAGS_IDENTIFY
+	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
+		if (alloc_meta->free_pointer_tag[i] == tag)
+			break;
+	}
+	if (i == KASAN_NR_FREE_STACKS)
+		i = alloc_meta->free_track_idx;
+#endif
+
+	return &alloc_meta->free_track[i];
+}
-- 
2.25.1

