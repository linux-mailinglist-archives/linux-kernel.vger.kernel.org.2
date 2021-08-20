Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC83F2C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbhHTMm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:42:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17996 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhHTMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:42:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Grh4S2z3PzbgCf;
        Fri, 20 Aug 2021 20:38:00 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 20:41:46 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 20:41:46 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tong Tiangen" <tongtiangen@huawei.com>
Subject: [PATCH -next v2 1/3] riscv/vdso: Refactor asm/vdso.h
Date:   Fri, 20 Aug 2021 12:50:40 +0000
Message-ID: <20210820125042.1844629-2-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210820125042.1844629-1-tongtiangen@huawei.com>
References: <20210820125042.1844629-1-tongtiangen@huawei.com>
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
 arch/riscv/include/asm/vdso.h     | 10 ++--------
 arch/riscv/kernel/syscall_table.c |  1 -
 arch/riscv/kernel/vdso.c          |  5 ++++-
 4 files changed, 7 insertions(+), 10 deletions(-)

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
index 1453a2f563bc..c1651589dd9b 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -8,13 +8,7 @@
 #ifndef _ASM_RISCV_VDSO_H
 #define _ASM_RISCV_VDSO_H
 
-#include <linux/types.h>
-
-#ifndef CONFIG_GENERIC_TIME_VSYSCALL
-struct vdso_data {
-};
-#endif
-
+#ifndef __ASSEMBLY__
 /*
  * The VDSO symbols are mapped into Linux so we can just use regular symbol
  * addressing to get their offsets in userspace.  The symbols are mapped at an
@@ -29,6 +23,6 @@ struct vdso_data {
 	(void __user *)((unsigned long)(base) + __vdso_##name);			\
 })
 
-asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
+#endif
 
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

