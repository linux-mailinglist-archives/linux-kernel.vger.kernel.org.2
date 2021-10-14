Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7242D6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhJNKEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhJNKED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 661C76101E;
        Thu, 14 Oct 2021 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634205719;
        bh=LQXws2m2KNS8oaYOQqJFpw4WI2EHw9lQOWuJTqzRGng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dhva+lcu+iWoZoHCwkWrlrYDu7Y9TiJQGtgip+8YkQhgdedHZLJRj8cp9TsdCt5LI
         u8YOMwMLQO2Wm8AqytfUrPT+6Z5TOLeEfkxclXonNmsC29jG4IcqfNLSOipJePYT8P
         xgEd/xPuBRiNeqWi6BpniWwfVoGK+AZW/SsxMeDRn/1g60vFkAW+jmwu9Wzouul/It
         s8QzrruJyeWjXdHL3JxeVEB0uuTrs3vtGAhcigYPnSKWVh7u44y8qWb7Sq560sjniP
         DPizE6uchDG0u5KeQ8X9EauoT4be8DuE6G1Typ1+Y6MtNtJlTgf0XYGZBCazvZ3K2E
         uaymTzQJaMz3w==
Date:   Thu, 14 Oct 2021 19:01:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/8] arm64: kprobes: Record frame pointer with kretprobe
 instance
Message-Id: <20211014190155.3fdc7cf7c42e44ee75c43a9d@kernel.org>
In-Reply-To: <20211014091332.GA13770@C02TD0UTHF1T.local>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
        <163369611948.636038.11552166777773804729.stgit@devnote2>
        <20211013100126.GA3187@C02TD0UTHF1T.local>
        <20211014170405.f59d287b30086efe7dd7f4d9@kernel.org>
        <20211014091332.GA13770@C02TD0UTHF1T.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 10:13:32 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Oct 14, 2021 at 05:04:05PM +0900, Masami Hiramatsu wrote:
> > On Wed, 13 Oct 2021 11:01:39 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > On Fri, Oct 08, 2021 at 09:28:39PM +0900, Masami Hiramatsu wrote:
> > > > Record the frame pointer instead of stack address with kretprobe
> > > > instance as the identifier on the instance list.
> > > > Since arm64 always enable CONFIG_FRAME_POINTER, we can use the
> > > > actual frame pointer (x29).
> > > 
> > > Just to check, why do we need to use the FP rather than SP? It wasn't
> > > clear to me if that's necessary later in the series, or if I'm missing
> > > something here.
> > 
> > Actually, this is for finding correct return address from the per-task
> > kretprobe instruction list (suppose it as a shadow stack) when it will
> > be searched in stack-backtracing. At that point, the framepointer will
> > be a reliable key.
> 
> Sure, my question was more "why isn't the SP a reliable key?", because both
> the SP and FP should be balanced at function-entry and function-return
> time. I'm asking because I think I'm missing a subtlety.

Ah, because SP is not used while unwinding frame. For the kretprobe,
either FP or SP is OK. But for the stacktrace.c, I can not use SP
and is easy to change to use FP. :)

So, when we introduce ORC unwinder on arm64, I think I have to reconsider
using SP based on the configuration.

Thank you,

> 
> I'm perfectly happy to use the FP even if they're equivalent; I just
> want to make sure there's not some issue I'm unaware of that could
> affect unwinding.
> 
> Thanks,
> Mark.
> 
> > > FWIW, I plan to rework arm64's ftrace bits to use FP for
> > > HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, so I'm happy to do likewise here.
> > 
> > Yes, I think you can use FP for that too.
> > 
> > > 
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Regardless of the above:
> > > 
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Thank you!
> > 
> > > 
> > > Mark.
> > > 
> > > > ---
> > > >  arch/arm64/kernel/probes/kprobes.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > > index e7ad6da980e8..d9dfa82c1f18 100644
> > > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > > @@ -401,14 +401,14 @@ int __init arch_populate_kprobe_blacklist(void)
> > > >  
> > > >  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> > > >  {
> > > > -	return (void *)kretprobe_trampoline_handler(regs, (void *)kernel_stack_pointer(regs));
> > > > +	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->regs[29]);
> > > >  }
> > > >  
> > > >  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> > > >  				      struct pt_regs *regs)
> > > >  {
> > > >  	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
> > > > -	ri->fp = (void *)kernel_stack_pointer(regs);
> > > > +	ri->fp = (void *)regs->regs[29];
> > > >  
> > > >  	/* replace return addr (x30) with trampoline */
> > > >  	regs->regs[30] = (long)&__kretprobe_trampoline;
> > > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
