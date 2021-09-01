Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552303FD16E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbhIACjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:39:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8805 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbhIACjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:39:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gzp9t2S4jzYw2l;
        Wed,  1 Sep 2021 10:37:22 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 10:38:04 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 1 Sep 2021 10:38:03 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <abdulras@google.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v3 2/3] riscv/vdso: Move vdso data page up front
Date:   Wed, 1 Sep 2021 02:46:20 +0000
Message-ID: <20210901024621.2528797-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210901024621.2528797-1-tongtiangen@huawei.com>
References: <20210901024621.2528797-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 601255ae3c98 ("arm64: vdso: move data page before code pages"), the
same issue exists on riscv, testcase is shown below, make sure that vdso.so is
bigger than page size,

  struct timespec tp;
  clock_gettime(5, &tp);
  printf("tv_sec: %ld, tv_nsec: %ld\n", tp.tv_sec, tp.tv_nsec);

without this patch, test result : tv_sec: 0, tv_nsec: 0
   with this patch, test result : tv_sec: 1629271537, tv_nsec: 748000000

Move the vdso data page in front of the VDSO area to fix the issue.

Fixes: ad5d1122b82fb ("riscv: use vDSO common flow to reduce the latency of the time-related functions")
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/riscv/include/asm/vdso.h     |  2 ++
 arch/riscv/kernel/vdso.c          | 44 ++++++++++++++++++-------------
 arch/riscv/kernel/vdso/vdso.lds.S |  3 ++-
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 8a49f8ecfb52..34210b22ba91 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -14,6 +14,8 @@
  */
 #ifdef CONFIG_MMU
 
+#define __VVAR_PAGES    1
+
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 72e93d218335..e7bd92d8749b 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -23,6 +23,13 @@ struct vdso_data {
 
 extern char vdso_start[], vdso_end[];
 
+enum vvar_pages {
+	VVAR_DATA_PAGE_OFFSET,
+	VVAR_NR_PAGES,
+};
+
+#define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
+
 static unsigned int vdso_pages __ro_after_init;
 static struct page **vdso_pagelist __ro_after_init;
 
@@ -41,7 +48,7 @@ static int __init vdso_init(void)
 
 	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
 	vdso_pagelist =
-		kcalloc(vdso_pages + 1, sizeof(struct page *), GFP_KERNEL);
+		kcalloc(vdso_pages + VVAR_NR_PAGES, sizeof(struct page *), GFP_KERNEL);
 	if (unlikely(vdso_pagelist == NULL)) {
 		pr_err("vdso: pagelist allocation failed\n");
 		return -ENOMEM;
@@ -66,7 +73,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	unsigned long vdso_base, vdso_len;
 	int ret;
 
-	vdso_len = (vdso_pages + 1) << PAGE_SHIFT;
+	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
+
+	vdso_len = (vdso_pages + VVAR_NR_PAGES) << PAGE_SHIFT;
 
 	mmap_write_lock(mm);
 	vdso_base = get_unmapped_area(NULL, 0, vdso_len, 0, 0);
@@ -75,29 +84,28 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 		goto end;
 	}
 
-	/*
-	 * Put vDSO base into mm struct. We need to do this before calling
-	 * install_special_mapping or the perf counter mmap tracking code
-	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
-	 */
-	mm->context.vdso = (void *)vdso_base;
+	mm->context.vdso = NULL;
+	ret = install_special_mapping(mm, vdso_base, VVAR_SIZE,
+		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
+	if (unlikely(ret))
+		goto end;
 
 	ret =
-	   install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
+	   install_special_mapping(mm, vdso_base + VVAR_SIZE,
+		vdso_pages << PAGE_SHIFT,
 		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
 		vdso_pagelist);
 
-	if (unlikely(ret)) {
-		mm->context.vdso = NULL;
+	if (unlikely(ret))
 		goto end;
-	}
 
-	vdso_base += (vdso_pages << PAGE_SHIFT);
-	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
-		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
+	/*
+	 * Put vDSO base into mm struct. We need to do this before calling
+	 * install_special_mapping or the perf counter mmap tracking code
+	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
+	 */
+	mm->context.vdso = (void *)vdso_base + VVAR_SIZE;
 
-	if (unlikely(ret))
-		mm->context.vdso = NULL;
 end:
 	mmap_write_unlock(mm);
 	return ret;
@@ -108,7 +116,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 	if (vma->vm_mm && (vma->vm_start == (long)vma->vm_mm->context.vdso))
 		return "[vdso]";
 	if (vma->vm_mm && (vma->vm_start ==
-			   (long)vma->vm_mm->context.vdso + PAGE_SIZE))
+			   (long)vma->vm_mm->context.vdso - VVAR_SIZE))
 		return "[vdso_data]";
 	return NULL;
 }
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index e6f558bca71b..e9111f700af0 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -3,12 +3,13 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 #include <asm/page.h>
+#include <asm/vdso.h>
 
 OUTPUT_ARCH(riscv)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . + PAGE_SIZE);
+	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
-- 
2.18.0.huawei.25

