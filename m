Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9763F7195
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbhHYJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:18:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14416 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbhHYJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:18:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GvgJC0gzCzbdRJ;
        Wed, 25 Aug 2021 17:13:31 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:17:21 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:17:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/4] ARM: mm: Provide set_memory_valid()
Date:   Wed, 25 Aug 2021 17:21:13 +0800
Message-ID: <20210825092116.149975-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function validates and invalidates PTE entries.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/include/asm/set_memory.h |  5 ++++
 arch/arm/mm/pageattr.c            | 41 +++++++++++++++++++++++--------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/set_memory.h b/arch/arm/include/asm/set_memory.h
index ec17fc0fda7a..bf1728e1af1d 100644
--- a/arch/arm/include/asm/set_memory.h
+++ b/arch/arm/include/asm/set_memory.h
@@ -11,11 +11,16 @@ int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
+int set_memory_valid(unsigned long addr, int numpages, int enable);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_valid(unsigned long addr, int numpages, int enable)
+{
+	return 0;
+}
 #endif
 
 #endif
diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index 9790ae3a8c68..7612a1c6b614 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -31,6 +31,24 @@ static bool in_range(unsigned long start, unsigned long size,
 	return start >= range_start && start < range_end &&
 		size <= range_end - start;
 }
+/*
+ * This function assumes that the range is mapped with PAGE_SIZE pages.
+ */
+static int __change_memory_common(unsigned long start, unsigned long size,
+				pgprot_t set_mask, pgprot_t clear_mask)
+{
+	struct page_change_data data;
+	int ret;
+
+	data.set_mask = set_mask;
+	data.clear_mask = clear_mask;
+
+	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
+					&data);
+
+	flush_tlb_kernel_range(start, start + size);
+	return ret;
+}
 
 static int change_memory_common(unsigned long addr, int numpages,
 				pgprot_t set_mask, pgprot_t clear_mask)
@@ -38,8 +56,6 @@ static int change_memory_common(unsigned long addr, int numpages,
 	unsigned long start = addr & PAGE_MASK;
 	unsigned long end = PAGE_ALIGN(addr) + numpages * PAGE_SIZE;
 	unsigned long size = end - start;
-	int ret;
-	struct page_change_data data;
 
 	WARN_ON_ONCE(start != addr);
 
@@ -50,14 +66,7 @@ static int change_memory_common(unsigned long addr, int numpages,
 	    !in_range(start, size, VMALLOC_START, VMALLOC_END))
 		return -EINVAL;
 
-	data.set_mask = set_mask;
-	data.clear_mask = clear_mask;
-
-	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
-					&data);
-
-	flush_tlb_kernel_range(start, end);
-	return ret;
+	return __change_memory_common(start, size, set_mask, clear_mask);
 }
 
 int set_memory_ro(unsigned long addr, int numpages)
@@ -87,3 +96,15 @@ int set_memory_x(unsigned long addr, int numpages)
 					__pgprot(0),
 					__pgprot(L_PTE_XN));
 }
+
+int set_memory_valid(unsigned long addr, int numpages, int enable)
+{
+	if (enable)
+		return __change_memory_common(addr, PAGE_SIZE * numpages,
+					__pgprot(L_PTE_VALID),
+					__pgprot(0));
+	else
+		return __change_memory_common(addr, PAGE_SIZE * numpages,
+					__pgprot(0),
+					__pgprot(L_PTE_VALID));
+}
-- 
2.26.2

