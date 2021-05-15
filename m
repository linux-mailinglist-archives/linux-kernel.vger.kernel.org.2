Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28942381531
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 04:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhEOCki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 22:40:38 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53158 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231388AbhEOCkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 22:40:35 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxbchLNJ9gBq0WAA--.1351S2;
        Sat, 15 May 2021 10:39:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jonathan Corbet <corbet@lwn.net>, Marc Koderer <marc@koderer.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Randy Dunlap <randy.dunlap@oracle.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v3] samples/kprobes: Fix typo in handler_{post,fault}()
Date:   Sat, 15 May 2021 10:39:06 +0800
Message-Id: <1621046346-7855-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxbchLNJ9gBq0WAA--.1351S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kJF43uF48AF4xuF18AFb_yoW7Jw1xpa
        4Yy3WUJF48tw4agay2vF4vgryqkr1akaykZrZ7CryYyFyIgw45ZF1ru3W0vrWrWryFqr4j
        qryFyFy7C3WUZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should use post_handler instead of pre_handler in handler_post().

As Joe Perches suggested, it would be better to use pr_fmt and remove
all the embedded pre/post strings. This would change the style of the
output through.

Also fix a defective format in handler_fault() ending with an 'n' that
should be '\n'.

Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
Fixes: 804defea1c02 ("Kprobes: move kprobe examples to samples/")
Acked-by: Marc Koderer <marc@koderer.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v3: use pr_fmt and fix typo in handler_fault() suggested by Joe Perches

v2: rebase on the latest mainline kernel

 samples/kprobes/kprobe_example.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index c495664..5f1eb8b 100644
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
-	pr_info("fault_handler: p->addr = 0x%p, trap #%dn", p->addr, trapnr);
+	pr_info("p->addr = 0x%p, trap #%d\n", p->addr, trapnr);
 	/* Return 0 because we don't handle the fault. */
 	return 0;
 }
-- 
2.1.0

