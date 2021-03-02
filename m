Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FA932A682
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574264AbhCBPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:14:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447312AbhCBMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:52:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A196261606;
        Tue,  2 Mar 2021 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614689488;
        bh=cLGqDIf77u6TyKAWg+j9rtHNr24QDQWpZ4UWpzj0/s0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kN9VxKlKEhMJKdpj3QsdnfktbriGFjxGvJWL2oIJ5yVYt3tZD6sR/ilWHwrRGDP0f
         c3ICCpKgrmU78gp6ZaGYiibLWCTug3xsm21cgpJSx2yEu+2U7HVGN7G7Uqx3ksSB/7
         gDWpZjmVpuDIKLC5mkkkbPE3fDmTgF9cEym++ozXnmxJhLu6SbUa4/0c0TCWpxWqEt
         99SRz1r3udcrkRzZRA0ZzVGQboa/gmZb6GVRER3r4buCh+Xhl0DGCSLpxvmXjSm8Fu
         DilgBmCVt/YUPfoXr+V082BaQmIpc7wVaIwPpoLm5naq+0pc1Bs6VzwB4TBVOrocsI
         tMgOR+PpZJcxA==
Date:   Tue, 2 Mar 2021 21:51:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 1/1] x86/kprobes: Use int3 instead of debug trap for
 single-step
Message-Id: <20210302215124.2614a36fdf084d514dabfc4d@kernel.org>
In-Reply-To: <YD39U0sz+IjV60VE@hirez.programming.kicks-ass.net>
References: <161460768474.430263.18425867006584111900.stgit@devnote2>
        <161460769556.430263.12936080446789384938.stgit@devnote2>
        <YD36O5wCpSElA9Fi@hirez.programming.kicks-ass.net>
        <YD39U0sz+IjV60VE@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 09:54:43 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 02, 2021 at 09:41:32AM +0100, Peter Zijlstra wrote:
> 
> > Aside of a few nits:
> 
> something like so..

Thanks Peter,
I completely agree with that change!
Let me update the patch.


> 
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -457,13 +457,20 @@ static void kprobe_emulate_call(struct k
>  }
>  NOKPROBE_SYMBOL(kprobe_emulate_call);
>  
> -static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
> +static __always_inline 
> +void __kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs, bool cond)
>  {
>  	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
>  
> -	ip += p->ainsn.rel32;
> +	if (cond)
> +		ip += p->ainsn.rel32;
>  	int3_emulate_jmp(regs, ip);
>  }
> +
> +static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
> +{
> +	__kprobe_emulate_jmp(p, regs, true);
> +}
>  NOKPROBE_SYMBOL(kprobe_emulate_jmp);
>  
>  static const unsigned long jcc_mask[6] = {
> @@ -488,10 +495,7 @@ static void kprobe_emulate_jcc(struct kp
>  		if (p->ainsn.jcc.type >= 0xe)
>  			match = match && (regs->flags & X86_EFLAGS_ZF);
>  	}
> -	if ((match && !invert) || (!match && invert))
> -		kprobe_emulate_jmp(p, regs);
> -	else
> -		regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
> +	__kprobe_emulate_jmp(p, regs, (match && !invert) || (!match && invert));
>  }
>  NOKPROBE_SYMBOL(kprobe_emulate_jcc);
>  
> @@ -524,10 +528,7 @@ static void kprobe_emulate_loop(struct k
>  	else if (p->ainsn.loop.type == 1)	/* LOOPE */
>  		match = match && (regs->flags & X86_EFLAGS_ZF);
>  
> -	if (match)
> -		kprobe_emulate_jmp(p, regs);
> -	else
> -		regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
> +	__kprobe_emulate_jmp(p, regs, match);
>  }
>  NOKPROBE_SYMBOL(kprobe_emulate_loop);
>  
> @@ -613,6 +614,12 @@ static int prepare_emulation(struct kpro
>  		else
>  			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
>  		break;
> +	case 0x70 ... 0x7f:
> +		/* 1 byte conditional jump */
> +		p->ainsn.emulate_op = kprobe_emulate_jcc;
> +		p->ainsn.jcc.type = opcode & 0xf;
> +		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
> +		break;
>  	case 0x0f:
>  		opcode = insn->opcode.bytes[1];
>  		if ((opcode & 0xf0) == 0x80) {
> @@ -667,12 +674,7 @@ static int prepare_emulation(struct kpro
>  #endif
>  		break;
>  	default:
> -		if ((opcode & 0xf0) == 0x70) {
> -			/* 1 byte conditional jump */
> -			p->ainsn.emulate_op = kprobe_emulate_jcc;
> -			p->ainsn.jcc.type = opcode & 0xf;
> -			p->ainsn.rel32 = *(char *)insn->immediate.bytes;
> -		}
> +		break;
>  	}
>  	p->ainsn.size = insn->length;
>  


-- 
Masami Hiramatsu <mhiramat@kernel.org>
