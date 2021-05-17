Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC53822AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhEQCXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 22:23:10 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40968 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231249AbhEQCXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 22:23:08 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP+4k06FgP_cXAA--.20760S4;
        Mon, 17 May 2021 10:21:29 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jonathan Corbet <corbet@lwn.net>, Marc Koderer <marc@koderer.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v4 2/2] samples/kprobes: Fix typo in handler_post()
Date:   Mon, 17 May 2021 10:21:23 +0800
Message-Id: <1621218083-23519-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1621218083-23519-1-git-send-email-yangtiezhu@loongson.cn>
References: <1621218083-23519-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxP+4k06FgP_cXAA--.20760S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kJF47Xw17AF15CrykXwb_yoWrtFyDpa
        4Yyw1UJF4rtw4agay2vF4vgryqkr1akaykurZ7CryYyFyIgw45ZF1ru3W0vrWruryFqw4j
        qryFyFy7C3WjvrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0
        owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjfU55l1DUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should use post_handler instead of pre_handler in handler_post().

As Joe Perches suggested, it would be better to use pr_fmt and remove
all the embedded pre/post/fault strings. This would change the style of
the output through.

Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
Acked-by: Marc Koderer <marc@koderer.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 samples/kprobes/kprobe_example.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index d77a546..5f1eb8b 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -10,6 +10,8 @@
  * whenever kernel_clone() is invoked to create a new process.
  */
 
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
@@ -27,32 +29,31 @@ static struct kprobe kp = {
 static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86
-	pr_info("<%s> pre_handler: p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
 		p->symbol_name, p->addr, regs->ip, regs->flags);
 #endif
 #ifdef CONFIG_PPC
-	pr_info("<%s> pre_handler: p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
 		p->symbol_name, p->addr, regs->nip, regs->msr);
 #endif
 #ifdef CONFIG_MIPS
-	pr_info("<%s> pre_handler: p->addr = 0x%p, epc = 0x%lx, status = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, epc = 0x%lx, status = 0x%lx\n",
 		p->symbol_name, p->addr, regs->cp0_epc, regs->cp0_status);
 #endif
 #ifdef CONFIG_ARM64
-	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx,"
-			" pstate = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, pstate = 0x%lx\n",
 		p->symbol_name, p->addr, (long)regs->pc, (long)regs->pstate);
 #endif
 #ifdef CONFIG_ARM
-	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, cpsr = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, cpsr = 0x%lx\n",
 		p->symbol_name, p->addr, (long)regs->ARM_pc, (long)regs->ARM_cpsr);
 #endif
 #ifdef CONFIG_RISCV
-	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
 		p->symbol_name, p->addr, regs->epc, regs->status);
 #endif
 #ifdef CONFIG_S390
-	pr_info("<%s> pre_handler: p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
+	pr_info("<%s> p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
 		p->symbol_name, p->addr, regs->psw.addr, regs->flags);
 #endif
 
@@ -65,31 +66,31 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 				unsigned long flags)
 {
 #ifdef CONFIG_X86
-	pr_info("<%s> post_handler: p->addr = 0x%p, flags = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
 		p->symbol_name, p->addr, regs->flags);
 #endif
 #ifdef CONFIG_PPC
-	pr_info("<%s> post_handler: p->addr = 0x%p, msr = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",
 		p->symbol_name, p->addr, regs->msr);
 #endif
 #ifdef CONFIG_MIPS
-	pr_info("<%s> post_handler: p->addr = 0x%p, status = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, status = 0x%lx\n",
 		p->symbol_name, p->addr, regs->cp0_status);
 #endif
 #ifdef CONFIG_ARM64
-	pr_info("<%s> post_handler: p->addr = 0x%p, pstate = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, pstate = 0x%lx\n",
 		p->symbol_name, p->addr, (long)regs->pstate);
 #endif
 #ifdef CONFIG_ARM
-	pr_info("<%s> post_handler: p->addr = 0x%p, cpsr = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, cpsr = 0x%lx\n",
 		p->symbol_name, p->addr, (long)regs->ARM_cpsr);
 #endif
 #ifdef CONFIG_RISCV
-	pr_info("<%s> post_handler: p->addr = 0x%p, status = 0x%lx\n",
+	pr_info("<%s> p->addr = 0x%p, status = 0x%lx\n",
 		p->symbol_name, p->addr, regs->status);
 #endif
 #ifdef CONFIG_S390
-	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
+	pr_info("<%s> p->addr, 0x%p, flags = 0x%lx\n",
 		p->symbol_name, p->addr, regs->flags);
 #endif
 }
@@ -101,7 +102,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
  */
 static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
 {
-	pr_info("fault_handler: p->addr = 0x%p, trap #%d\n", p->addr, trapnr);
+	pr_info("p->addr = 0x%p, trap #%d\n", p->addr, trapnr);
 	/* Return 0 because we don't handle the fault. */
 	return 0;
 }
-- 
2.1.0

