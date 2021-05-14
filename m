Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF06380CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhENP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:27:44 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:53380 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231590AbhENP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:27:41 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9ED16181200E3;
        Fri, 14 May 2021 15:26:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 9FB5A1727A;
        Fri, 14 May 2021 15:26:26 +0000 (UTC)
Message-ID: <cdf1a6fd7d1cbdd19e1c50b280e95b10a9114f6d.camel@perches.com>
Subject: Re: [PATCH v2] samples/kprobes: Fix typo in handler_post()
From:   Joe Perches <joe@perches.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Koderer <marc@koderer.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 14 May 2021 08:26:25 -0700
In-Reply-To: <1620979810-12779-1-git-send-email-yangtiezhu@loongson.cn>
References: <1620979810-12779-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9FB5A1727A
X-Spam-Status: No, score=1.45
X-Stat-Signature: uurdij7k7ick1pw8dajqj5knxdnu44hi
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/S/4qS4P2aojwMF+Vk9sUXKHzDou9prls=
X-HE-Tag: 1621005986-821007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-05-14 at 16:10 +0800, Tiezhu Yang wrote:
> It should use post_handler instead of pre_handler in handler_post().
> 
> Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2: rebase on the latest mainline kernel
> 
>  samples/kprobes/kprobe_example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index c495664..602db3f 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -89,7 +89,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>  		p->symbol_name, p->addr, regs->status);
>  #endif
>  #ifdef CONFIG_S390
> -	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
> +	pr_info("<%s> post_handler: p->addr, 0x%p, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->flags);
>  #endif
>  }

Perhaps better would be to use pr_fmt and remove all the
embedded pre/post strings.

This would change the style of the output through.

Also fix a defective format in handler_fault ending with
an 'n' that should be '\n'
---
 samples/kprobes/kprobe_example.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index c495664c0a9b..5f1eb8b53c11 100644
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

