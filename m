Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A313663D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhDUC5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:57:44 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:38246 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233874AbhDUC5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:57:42 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 22:57:42 EDT
Received: from localhost.localdomain (unknown [121.232.27.162])
        by APP-05 (Coremail) with SMTP id zQCowAD3_6NXkn9g_AOWAA--.62820S2;
        Wed, 21 Apr 2021 10:47:59 +0800 (CST)
From:   Wang Junqiang <wangjunqiang@iscas.ac.cn>
To:     guoren@kernel.org
Cc:     guoren@linux.alibaba.com, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Li Weiwei <liweiwei@iscas.ac.cn>
Subject: [PATCH 2/2] csky: add CONFIG_CPU_HAS_MATHEMU and use in traps
Date:   Wed, 21 Apr 2021 10:49:16 +0800
Message-Id: <20210421024916.13603-1-wangjunqiang@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAD3_6NXkn9g_AOWAA--.62820S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4xCF45WF1xWryrKFy5twb_yoWxWF1UpF
        ZxAas5GFW8Wr1UtrWfAw1kWa98JrZ3trs7Zrs7G343AF1UArWfXF18Kan8Zrs8AFykWw1x
        WFWS93W5CFnrJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojg4DUUUU
X-Originating-IP: [121.232.27.162]
X-CM-SenderInfo: pzdqwy5xqtxt1qj6x2xfdvhtffof0/1tbiBggSAF0TfKcJewAAs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the use of fpu instruction emulation by trap_c.
It defined _fcr, _fesr for user space in ptrace.h which is used in fpu.c
and instruction emulation. During initialization, all fpe are enabled,
and the configuration that read/write fcr and fesr in glibc library is captured
when privilege exception is triggerd by mfcr and mtcr < ,15>.

steps:
 1.enable all fpe interrupts
 2.mfcr/mtcr trigger privilege exception
 3.synchronize fcr and fesr of user app through fpu_libc_helper function
 4.fpe interrupt at runtime
 5.fpu instruction simulation is based on user_fcr and user_fesr
 6.clearing interrupts and synchronizing fcr fesr
 7.state restore and continue running

Signed-off-by: Wang Junqiang <wangjunqiang@iscas.ac.cn>
Signed-off-by: Li Weiwei <liweiwei@iscas.ac.cn>
---
 arch/csky/Kconfig                   |  8 ++++++++
 arch/csky/Makefile                  |  1 +
 arch/csky/abiv2/fpu.c               | 31 ++++++++++++++++++++++++-----
 arch/csky/abiv2/inc/abi/fpu.h       |  9 ++++++++-
 arch/csky/include/uapi/asm/ptrace.h |  6 ++++++
 arch/csky/kernel/traps.c            | 30 +++++++++++++++++++++++++---
 6 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 34e91224adc3..a414225570c1 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -97,6 +97,9 @@ config CPU_HAS_CACHEV2
 config CPU_HAS_FPUV2
 	bool
 
+config CPU_HAS_MATHEMU
+	bool
+
 config CPU_HAS_HILO
 	bool
 
@@ -281,6 +284,11 @@ config CPU_HAS_VDSP
 	bool "CPU has VDSP coprocessor"
 	depends on CPU_HAS_FPU && CPU_HAS_FPUV2
 
+config CPU_HAS_MATHEMU
+	bool "CPU has FPU Mathemu Instructions"
+	depends on CPU_CK810 || CPU_CK860
+	default n
+
 config CPU_HAS_FPU
 	bool "CPU has FPU coprocessor"
 	depends on CPU_CK807 || CPU_CK810 || CPU_CK860
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 37f593a4bf53..495f3a2fad6a 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -64,6 +64,7 @@ head-y := arch/csky/kernel/head.o
 core-y += arch/csky/kernel/
 core-y += arch/csky/mm/
 core-y += arch/csky/$(CSKYABI)/
+core-$(CONFIG_CPU_HAS_MATHEMU) += arch/csky/math-emu/
 
 libs-y += arch/csky/lib/ \
 	$(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
diff --git a/arch/csky/abiv2/fpu.c b/arch/csky/abiv2/fpu.c
index 5acc5c2e544e..3cd17cf9319e 100644
--- a/arch/csky/abiv2/fpu.c
+++ b/arch/csky/abiv2/fpu.c
@@ -38,8 +38,11 @@ int fpu_libc_helper(struct pt_regs *regs)
 		return 0;
 
 	tinstr = instr_hi | ((unsigned long)instr_low << 16);
-
+#ifdef CONFIG_CPU_HAS_MATHEMU
+	if (((tinstr >> 21) & 0x1F) != 15)
+#else
 	if (((tinstr >> 21) & 0x1F) != 2)
+#endif
 		return 0;
 
 	if ((tinstr & MTCR_MASK) == MTCR_DIST) {
@@ -53,10 +56,19 @@ int fpu_libc_helper(struct pt_regs *regs)
 
 		regx =  *(&regs->a0 + index);
 
-		if (tmp == 1)
+		if (tmp == 1) {
+#ifdef CONFIG_CPU_HAS_MATHEMU
+			mtcr("cr<1, 2>", regx | 0x3f);
+			current->thread.user_fp.user_fcr = regx;
+#else
 			mtcr("cr<1, 2>", regx);
-		else if (tmp == 2)
+#endif
+		} else if (tmp == 2) {
 			mtcr("cr<2, 2>", regx);
+#ifdef CONFIG_CPU_HAS_MATHEMU
+			current->thread.user_fp.user_fesr = regx;
+#endif
+		}
 		else
 			return 0;
 
@@ -73,10 +85,19 @@ int fpu_libc_helper(struct pt_regs *regs)
 		if (tmp > 2)
 			return 0;
 
-		if (tmp == 1)
+		if (tmp == 1) {
+#ifndef CONFIG_CPU_HAS_MATHEMU
 			regx = mfcr("cr<1, 2>");
-		else if (tmp == 2)
+#else
+			regx = current->thread.user_fp.user_fcr;
+#endif
+		} else if (tmp == 2) {
+#ifndef CONFIG_CPU_HAS_MATHEMU
 			regx = mfcr("cr<2, 2>");
+#else
+			regx = current->thread.user_fp.user_fesr;
+#endif
+		}
 		else
 			return 0;
 
diff --git a/arch/csky/abiv2/inc/abi/fpu.h b/arch/csky/abiv2/inc/abi/fpu.h
index aabb79355013..c3509ace542c 100644
--- a/arch/csky/abiv2/inc/abi/fpu.h
+++ b/arch/csky/abiv2/inc/abi/fpu.h
@@ -9,7 +9,14 @@
 int fpu_libc_helper(struct pt_regs *regs);
 void fpu_fpe(struct pt_regs *regs);
 
-static inline void init_fpu(void) { mtcr("cr<1, 2>", 0); }
+static inline void init_fpu(void)
+{
+#ifdef CONFIG_CPU_HAS_MATHEMU
+	mtcr("cr<1, 2>", 0x3f);
+#else
+	mtcr("cr<1, 2>", 0);
+#endif
+}
 
 void save_to_user_fp(struct user_fp *user_fp);
 void restore_from_user_fp(struct user_fp *user_fp);
diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
index 3be9c14334a6..1ffb6190686a 100644
--- a/arch/csky/include/uapi/asm/ptrace.h
+++ b/arch/csky/include/uapi/asm/ptrace.h
@@ -45,6 +45,12 @@ struct user_fp {
 	unsigned long	fesr;
 	unsigned long	fid;
 	unsigned long	reserved;
+#ifdef CONFIG_CPU_HAS_MATHEMU
+	unsigned long	user_fcr;
+	unsigned long	user_fesr;
+	unsigned long	reserved1;
+	unsigned long	reserved2;
+#endif
 };
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index e5fbf8653a21..053a4f7dff9e 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -27,6 +27,10 @@
 
 #ifdef CONFIG_CPU_HAS_FPU
 #include <abi/fpu.h>
+#ifdef CONFIG_CPU_HAS_MATHEMU
+extern inline unsigned int get_fpu_insn(struct pt_regs *regs);
+extern inline int do_fpu_insn(unsigned int inst, struct pt_regs *regs);
+#endif
 #endif
 
 int show_unhandled_signals = 1;
@@ -186,8 +190,19 @@ asmlinkage void do_trap_bkpt(struct pt_regs *regs)
 
 asmlinkage void do_trap_illinsn(struct pt_regs *regs)
 {
-	current->thread.trap_no = trap_no(regs);
+#ifdef CONFIG_CPU_HAS_FPU
+#ifdef CONFIG_CPU_HAS_MATHEMU
+	unsigned int inst;
+
+	inst = get_fpu_insn(regs);
+	if (inst && !do_fpu_insn(inst, regs)) {
+		regs->pc += 4;
+		return;
+	}
+#endif
+#endif
 
+	current->thread.trap_no = trap_no(regs);
 #ifdef CONFIG_KPROBES
 	if (kprobe_breakpoint_handler(regs))
 		return;
@@ -209,7 +224,16 @@ asmlinkage void do_trap_illinsn(struct pt_regs *regs)
 
 asmlinkage void do_trap_fpe(struct pt_regs *regs)
 {
-#ifdef CONFIG_CPU_HAS_FP
+#ifdef CONFIG_CPU_HAS_FPU
+#ifdef CONFIG_CPU_HAS_MATHEMU
+	unsigned int inst;
+
+	inst = get_fpu_insn(regs);
+	if (inst && !do_fpu_insn(inst, regs)) {
+		regs->pc += 4;
+		return;
+	}
+#endif
 	return fpu_fpe(regs);
 #else
 	do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->pc,
@@ -219,7 +243,7 @@ asmlinkage void do_trap_fpe(struct pt_regs *regs)
 
 asmlinkage void do_trap_priv(struct pt_regs *regs)
 {
-#ifdef CONFIG_CPU_HAS_FP
+#ifdef CONFIG_CPU_HAS_FPU
 	if (user_mode(regs) && fpu_libc_helper(regs))
 		return;
 #endif
-- 
2.17.1

