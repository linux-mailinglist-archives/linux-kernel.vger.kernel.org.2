Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF03FD16F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhIACjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:39:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15278 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241726AbhIACjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:39:08 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GzpBN4tycz8D5H;
        Wed,  1 Sep 2021 10:37:48 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 10:38:02 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 1 Sep 2021 10:38:01 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <abdulras@google.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v3 1/3] riscv/vdso: Refactor asm/vdso.h
Date:   Wed, 1 Sep 2021 02:46:19 +0000
Message-ID: <20210901024621.2528797-2-tongtiangen@huawei.com>
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

The asm/vdso.h will be included in vdso.lds.S in the next patch, the
following cleanup is needed to avoid syntax error:

 1.the declaration of sys_riscv_flush_icache() is moved into asm/syscall.h.
 2.the definition of struct vdso_data is moved into kernel/vdso.c.
 2.the definition of VDSO_SYMBOL is placed under "#ifndef __ASSEMBLY__".

Also remove the redundant linux/types.h include.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/riscv/include/asm/syscall.h  |  1 +
 arch/riscv/include/asm/vdso.h     | 13 ++++---------
 arch/riscv/kernel/syscall_table.c |  1 -
 arch/riscv/kernel/vdso.c          |  5 ++++-
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index b933b1583c9f..34fbb3ea21d5 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -82,4 +82,5 @@ static inline int syscall_get_arch(struct task_struct *task)
 #endif
 }
 
+asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 #endif	/* _ASM_RISCV_SYSCALL_H */
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 893e47195e30..8a49f8ecfb52 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -8,26 +8,21 @@
 #ifndef _ASM_RISCV_VDSO_H
 #define _ASM_RISCV_VDSO_H
 
-
 /*
  * All systems with an MMU have a VDSO, but systems without an MMU don't
  * support shared libraries and therefor don't have one.
  */
 #ifdef CONFIG_MMU
 
-#include <linux/types.h>
-#include <generated/vdso-offsets.h>
+#ifndef __ASSEMBLY__
 
-#ifndef CONFIG_GENERIC_TIME_VSYSCALL
-struct vdso_data {
-};
-#endif
+#include <generated/vdso-offsets.h>
 
 #define VDSO_SYMBOL(base, name)							\
 	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
 
-#endif /* CONFIG_MMU */
+#endif /* !__ASSEMBLY__ */
 
-asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
+#endif /* CONFIG_MMU */
 
 #endif /* _ASM_RISCV_VDSO_H */
diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
index a63c667c27b3..44b1420a2270 100644
--- a/arch/riscv/kernel/syscall_table.c
+++ b/arch/riscv/kernel/syscall_table.c
@@ -7,7 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/syscalls.h>
 #include <asm-generic/syscalls.h>
-#include <asm/vdso.h>
 #include <asm/syscall.h>
 
 #undef __SYSCALL
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 25a3b8849599..72e93d218335 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -12,10 +12,13 @@
 #include <linux/binfmts.h>
 #include <linux/err.h>
 #include <asm/page.h>
+#include <asm/vdso.h>
+
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
 #include <vdso/datapage.h>
 #else
-#include <asm/vdso.h>
+struct vdso_data {
+};
 #endif
 
 extern char vdso_start[], vdso_end[];
-- 
2.18.0.huawei.25

