Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6358B3823E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 07:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhEQF7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 01:59:30 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:34444 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231503AbhEQF7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 01:59:05 -0400
Received: from localhost.localdomain (unknown [121.232.13.213])
        by APP-01 (Coremail) with SMTP id qwCowAB3MIyuBaJgYcEJAA--.16203S3;
        Mon, 17 May 2021 13:57:04 +0800 (CST)
From:   Wang Junqiang <wangjunqiang@iscas.ac.cn>
To:     guoren@kernel.org
Cc:     guoren@linux.alibaba.com, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Li Weiwei <liweiwei@iscas.ac.cn>
Subject: [PATCH v3 2/2] csky: add CONFIG_CPU_HAS_MATHEMU and use in traps
Date:   Mon, 17 May 2021 13:57:16 +0800
Message-Id: <20210517055716.26144-2-wangjunqiang@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517055716.26144-1-wangjunqiang@iscas.ac.cn>
References: <20210517055716.26144-1-wangjunqiang@iscas.ac.cn>
X-CM-TRANSID: qwCowAB3MIyuBaJgYcEJAA--.16203S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4xGr47XryUWrWktF4xWFg_yoWxCry8pF
        Z8Aas3GFW8GF1jg3yfAw4kWa93trZ5KrsrZr4xG34YyF1UA397XF18tan8Zrs8ZFykWr1x
        XFWSkw17CFn7X3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GrWl42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO2-eDUUUU
X-Originating-IP: [121.232.13.213]
X-CM-SenderInfo: pzdqwy5xqtxt1qj6x2xfdvhtffof0/1tbiCQcEAF02aLurlwAAsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the use of fpu instruction emulation by trap_c.
It defined _fcr, _fesr for user space in processor.h which is used in fpu.c
and instruction emulation. During initialization, all fpe are enabled,
and the config that read/write fcr and fesr in glibc library is captured
when privilege exception is triggered by mfcr and mtcr < ,15>.

steps:
 1.enable all fpe interrupts
 2.mfcr/mtcr trigger privilege exception
 3.synchronize fcr and fesr of user app through fpu_libc_helper function
 4.fpe interrupt at runtime
 5.fpu instruction simulation is based on user_fcr and user_fesr
 6.clearing interrupts and synchronizing fcr fesr
 7.state restore and continue running

Change in v3:
 - update init_fpu by Guo Ren's review

Change in v2:
 - fixup Kconfig bug by Randy and Guo Ren
 - move CONFIG_CPU_HAS_MATHEMU to fpu.h by define macro
 - del usr_fcr usr_fesr in struct user_fp and define in processor.h
 - del mathemu use in do_trap_ and use in fpu_fpe

Signed-off-by: Wang Junqiang <wangjunqiang@iscas.ac.cn>
Signed-off-by: Li Weiwei <liweiwei@iscas.ac.cn>
---
 arch/csky/Kconfig                 |  7 +++++++
 arch/csky/Makefile                |  1 +
 arch/csky/abiv2/fpu.c             | 21 +++++++++++++++------
 arch/csky/abiv2/inc/abi/fpu.h     | 31 ++++++++++++++++++++++++++++---
 arch/csky/include/asm/processor.h | 11 +++++++++++
 arch/csky/kernel/traps.c          |  4 ++--
 6 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8de5b987edb9..82fd9d8b594d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -285,6 +285,13 @@ config CPU_HAS_FPU
 	bool "CPU has FPU coprocessor"
 	depends on CPU_CK807 || CPU_CK810 || CPU_CK860
 
+config CPU_HAS_MATHEMU
+	bool "CPU has FPU Mathemu Instructions"
+	depends on CPU_HAS_FPU
+	default y
+	help
+	  Say Y/N here to allow turning FPU Instructions simulation on/off.
+
 config CPU_HAS_ICACHE_INS
 	bool "CPU has Icache invalidate instructions"
 	depends on CPU_HAS_CACHEV2
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
index 5acc5c2e544e..a7f6f0bb8537 100644
--- a/arch/csky/abiv2/fpu.c
+++ b/arch/csky/abiv2/fpu.c
@@ -38,8 +38,7 @@ int fpu_libc_helper(struct pt_regs *regs)
 		return 0;
 
 	tinstr = instr_hi | ((unsigned long)instr_low << 16);
-
-	if (((tinstr >> 21) & 0x1F) != 2)
+	if (((tinstr >> 21) & 0x1F) != CR_NUM)
 		return 0;
 
 	if ((tinstr & MTCR_MASK) == MTCR_DIST) {
@@ -54,9 +53,9 @@ int fpu_libc_helper(struct pt_regs *regs)
 		regx =  *(&regs->a0 + index);
 
 		if (tmp == 1)
-			mtcr("cr<1, 2>", regx);
+			MTCR_FCR(regx)
 		else if (tmp == 2)
-			mtcr("cr<2, 2>", regx);
+			MTCR_FESR(regx)
 		else
 			return 0;
 
@@ -74,9 +73,9 @@ int fpu_libc_helper(struct pt_regs *regs)
 			return 0;
 
 		if (tmp == 1)
-			regx = mfcr("cr<1, 2>");
+			regx = MFCR_FCR;
 		else if (tmp == 2)
-			regx = mfcr("cr<2, 2>");
+			regx = MFCR_FESR;
 		else
 			return 0;
 
@@ -94,6 +93,16 @@ void fpu_fpe(struct pt_regs *regs)
 	int sig, code;
 	unsigned int fesr;
 
+#ifdef CONFIG_CPU_HAS_MATHEMU
+	unsigned int inst;
+
+	inst = get_fpu_insn(regs);
+	if (inst && !do_fpu_insn(inst, regs)) {
+		regs->pc += 4;
+		return;
+	}
+#endif
+
 	fesr = mfcr("cr<2, 2>");
 
 	sig = SIGFPE;
diff --git a/arch/csky/abiv2/inc/abi/fpu.h b/arch/csky/abiv2/inc/abi/fpu.h
index aabb79355013..0ca8a258567b 100644
--- a/arch/csky/abiv2/inc/abi/fpu.h
+++ b/arch/csky/abiv2/inc/abi/fpu.h
@@ -6,14 +6,39 @@
 #include <asm/sigcontext.h>
 #include <asm/ptrace.h>
 
-int fpu_libc_helper(struct pt_regs *regs);
-void fpu_fpe(struct pt_regs *regs);
 
+#ifdef CONFIG_CPU_HAS_MATHEMU
+static inline void init_fpu(void) { mtcr("cr<1, 2>", 0x3f); }
+#define MFCR_FCR        current->thread.emul_fp.user_fcr
+#define MFCR_FESR       current->thread.emul_fp.user_fesr
+#define MTCR_FCR(regx)		\
+		{	\
+			mtcr("cr<1, 2>", regx | 0x3f);	\
+			current->thread.emul_fp.user_fcr = regx;	\
+		}
+#define MTCR_FESR(regx)		\
+		{	\
+			mtcr("cr<2, 2>", regx); \
+			current->thread.emul_fp.user_fesr = regx;	\
+		}
+#define CR_NUM          15
+
+inline unsigned int get_fpu_insn(struct pt_regs *regs);
+inline int do_fpu_insn(unsigned int inst, struct pt_regs *regs);
+#else
 static inline void init_fpu(void) { mtcr("cr<1, 2>", 0); }
+#define MFCR_FCR mfcr("cr<1, 2>")
+#define MFCR_FESR mfcr("cr<2, 2>")
+#define MTCR_FCR(regx)		{ mtcr("cr<1, 2>", regx); }
+#define MTCR_FESR(regx)		{ mtcr("cr<2, 2>", regx); }
+#define CR_NUM    2
+#endif
+
+int fpu_libc_helper(struct pt_regs *regs);
+void fpu_fpe(struct pt_regs *regs);
 
 void save_to_user_fp(struct user_fp *user_fp);
 void restore_from_user_fp(struct user_fp *user_fp);
-
 /*
  * Define the fesr bit for fpe handle.
  */
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 9e933021fe8e..645b6b27841d 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -21,6 +21,14 @@ struct cpuinfo_csky {
 
 extern struct cpuinfo_csky cpu_data[];
 
+#ifdef CONFIG_CPU_HAS_MATHEMU
+struct emul_fp {
+	unsigned long	user_fcr;
+	unsigned long	user_fesr;
+	unsigned long	reserved1;
+	unsigned long	reserved2;
+};
+#endif
 /*
  * User space process size: 2GB. This is hardcoded into a few places,
  * so don't change it unless you know what you are doing.  TASK_SIZE
@@ -45,6 +53,9 @@ struct thread_struct {
 
 	/* FPU regs */
 	struct user_fp __aligned(16) user_fp;
+#ifdef CONFIG_CPU_HAS_MATHEMU
+	struct emul_fp __aligned(16) emul_fp;
+#endif
 };
 
 #define INIT_THREAD  { \
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index e5fbf8653a21..2020af88b636 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -209,7 +209,7 @@ asmlinkage void do_trap_illinsn(struct pt_regs *regs)
 
 asmlinkage void do_trap_fpe(struct pt_regs *regs)
 {
-#ifdef CONFIG_CPU_HAS_FP
+#ifdef CONFIG_CPU_HAS_FPU
 	return fpu_fpe(regs);
 #else
 	do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->pc,
@@ -219,7 +219,7 @@ asmlinkage void do_trap_fpe(struct pt_regs *regs)
 
 asmlinkage void do_trap_priv(struct pt_regs *regs)
 {
-#ifdef CONFIG_CPU_HAS_FP
+#ifdef CONFIG_CPU_HAS_FPU
 	if (user_mode(regs) && fpu_libc_helper(regs))
 		return;
 #endif
-- 
2.17.1

