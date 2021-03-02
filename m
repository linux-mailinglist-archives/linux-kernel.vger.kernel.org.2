Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77D32A395
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835938AbhCBJIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382106AbhCBIz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:55:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18B4C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B2uxy1bwNxSU4n2K73C/8k0RDLVwTozVSoB5orcja+U=; b=RNCajY9Lj/jTQ3z+PlaeR9KoeE
        EzLWwamI7RjsGTrEEmGgmDAz0rrgqnOEhXAfT7aARIA4IHYByFM2ItLBw+E2oF6kyk7NdVqlreGrz
        m+YdWmmMCVmk+MT/34sIOayuS8fT87pjvr1vhE5wg/JtvOps/qnez9kb+78fkX8Rax3zUUHnI8qUP
        R74G0nyMNkaqA2gB7JQ4dhKS5kA+t2wf6aWuHrNS11Hv3tfoEQG6bXSMLPGHWCOzQwCEEBLEm8h9x
        eCa2uugkqw+KkZSOBomPPn4IEUZfbuZxEnGEMgZt6zgLYs95VNmSjQ5KVr7kmCSIHB8hSJZSBZBpG
        QWWa3inw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH0nk-00GqPJ-Kt; Tue, 02 Mar 2021 08:54:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FF1F30011C;
        Tue,  2 Mar 2021 09:54:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B34B2BCE3622; Tue,  2 Mar 2021 09:54:43 +0100 (CET)
Date:   Tue, 2 Mar 2021 09:54:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 1/1] x86/kprobes: Use int3 instead of debug trap for
 single-step
Message-ID: <YD39U0sz+IjV60VE@hirez.programming.kicks-ass.net>
References: <161460768474.430263.18425867006584111900.stgit@devnote2>
 <161460769556.430263.12936080446789384938.stgit@devnote2>
 <YD36O5wCpSElA9Fi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD36O5wCpSElA9Fi@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:41:32AM +0100, Peter Zijlstra wrote:

> Aside of a few nits:

something like so..

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -457,13 +457,20 @@ static void kprobe_emulate_call(struct k
 }
 NOKPROBE_SYMBOL(kprobe_emulate_call);
 
-static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
+static __always_inline 
+void __kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs, bool cond)
 {
 	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
 
-	ip += p->ainsn.rel32;
+	if (cond)
+		ip += p->ainsn.rel32;
 	int3_emulate_jmp(regs, ip);
 }
+
+static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
+{
+	__kprobe_emulate_jmp(p, regs, true);
+}
 NOKPROBE_SYMBOL(kprobe_emulate_jmp);
 
 static const unsigned long jcc_mask[6] = {
@@ -488,10 +495,7 @@ static void kprobe_emulate_jcc(struct kp
 		if (p->ainsn.jcc.type >= 0xe)
 			match = match && (regs->flags & X86_EFLAGS_ZF);
 	}
-	if ((match && !invert) || (!match && invert))
-		kprobe_emulate_jmp(p, regs);
-	else
-		regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+	__kprobe_emulate_jmp(p, regs, (match && !invert) || (!match && invert));
 }
 NOKPROBE_SYMBOL(kprobe_emulate_jcc);
 
@@ -524,10 +528,7 @@ static void kprobe_emulate_loop(struct k
 	else if (p->ainsn.loop.type == 1)	/* LOOPE */
 		match = match && (regs->flags & X86_EFLAGS_ZF);
 
-	if (match)
-		kprobe_emulate_jmp(p, regs);
-	else
-		regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+	__kprobe_emulate_jmp(p, regs, match);
 }
 NOKPROBE_SYMBOL(kprobe_emulate_loop);
 
@@ -613,6 +614,12 @@ static int prepare_emulation(struct kpro
 		else
 			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
 		break;
+	case 0x70 ... 0x7f:
+		/* 1 byte conditional jump */
+		p->ainsn.emulate_op = kprobe_emulate_jcc;
+		p->ainsn.jcc.type = opcode & 0xf;
+		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
+		break;
 	case 0x0f:
 		opcode = insn->opcode.bytes[1];
 		if ((opcode & 0xf0) == 0x80) {
@@ -667,12 +674,7 @@ static int prepare_emulation(struct kpro
 #endif
 		break;
 	default:
-		if ((opcode & 0xf0) == 0x70) {
-			/* 1 byte conditional jump */
-			p->ainsn.emulate_op = kprobe_emulate_jcc;
-			p->ainsn.jcc.type = opcode & 0xf;
-			p->ainsn.rel32 = *(char *)insn->immediate.bytes;
-		}
+		break;
 	}
 	p->ainsn.size = insn->length;
 
