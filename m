Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC63F32E6EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCELDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:03:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13474 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhCELCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:02:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DsPt94q38zjV5X;
        Fri,  5 Mar 2021 19:01:05 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Mar 2021
 19:02:41 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH 1/9] riscv: traps: Fix no prototype warnings
Date:   Fri, 5 Mar 2021 19:33:24 +0800
Message-ID: <20210305113332.428048-2-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305113332.428048-1-sunnanyong@huawei.com>
References: <20210305113332.428048-1-sunnanyong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all W=1 compilation warnings:'no previous prototype for' in arch/riscv/kernel/traps.c:
arch/riscv/kernel/traps.c:96:15: warning: no previous prototype for ‘do_trap_unknown’ [-Wmissing-prototypes]
   96 | DO_ERROR_INFO(do_trap_unknown,
      |               ^~~~~~~~~~~~~~~
arch/riscv/kernel/traps.c:91:27: note: in definition of macro ‘DO_ERROR_INFO’
   91 | asmlinkage __visible void name(struct pt_regs *regs)   \
      |                           ^~~~
arch/riscv/kernel/traps.c:98:15: warning: no previous prototype for ‘do_trap_insn_misaligned’ [-Wmissing-prototypes]
   98 | DO_ERROR_INFO(do_trap_insn_misaligned,
      |               ^~~~~~~~~~~~~~~~~~~~~~~
arch/riscv/kernel/traps.c:91:27: note: in definition of macro ‘DO_ERROR_INFO’
   91 | asmlinkage __visible void name(struct pt_regs *regs)   \
      |                           ^~~~
arch/riscv/kernel/traps.c:100:15: warning: no previous prototype for ‘do_trap_insn_fault’ [-Wmissing-prototypes]
...

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/riscv/include/asm/asm-prototypes.h | 16 ++++++++++++++++
 arch/riscv/kernel/traps.c               |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index 27e005fca584..6d81abf5d9f8 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -9,4 +9,20 @@ long long __lshrti3(long long a, int b);
 long long __ashrti3(long long a, int b);
 long long __ashlti3(long long a, int b);
 
+
+#define DECLARE_DO_ERROR_INFO(name)	asmlinkage void name(struct pt_regs *regs);
+
+DECLARE_DO_ERROR_INFO(do_trap_unknown)
+DECLARE_DO_ERROR_INFO(do_trap_insn_misaligned)
+DECLARE_DO_ERROR_INFO(do_trap_insn_fault)
+DECLARE_DO_ERROR_INFO(do_trap_insn_illegal)
+DECLARE_DO_ERROR_INFO(do_trap_load_fault)
+DECLARE_DO_ERROR_INFO(do_trap_load_misaligned)
+DECLARE_DO_ERROR_INFO(do_trap_store_misaligned)
+DECLARE_DO_ERROR_INFO(do_trap_store_fault)
+DECLARE_DO_ERROR_INFO(do_trap_ecall_u)
+DECLARE_DO_ERROR_INFO(do_trap_ecall_s)
+DECLARE_DO_ERROR_INFO(do_trap_ecall_m)
+DECLARE_DO_ERROR_INFO(do_trap_break)
+
 #endif /* _ASM_RISCV_PROTOTYPES_H */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3ed2c23601a0..0879b5df11b9 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/irq.h>
 
+#include <asm/asm-prototypes.h>
 #include <asm/bug.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
-- 
2.25.1

