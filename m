Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41242D5D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhJNJSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:18:20 -0400
Received: from foss.arm.com ([217.140.110.172]:51760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhJNJSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:18:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3316911D4;
        Thu, 14 Oct 2021 02:16:13 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629303F66F;
        Thu, 14 Oct 2021 02:16:09 -0700 (PDT)
Date:   Thu, 14 Oct 2021 10:13:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20211014091332.GA13770@C02TD0UTHF1T.local>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369611948.636038.11552166777773804729.stgit@devnote2>
 <20211013100126.GA3187@C02TD0UTHF1T.local>
 <20211014170405.f59d287b30086efe7dd7f4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014170405.f59d287b30086efe7dd7f4d9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 05:04:05PM +0900, Masami Hiramatsu wrote:
> On Wed, 13 Oct 2021 11:01:39 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Fri, Oct 08, 2021 at 09:28:39PM +0900, Masami Hiramatsu wrote:
> > > Record the frame pointer instead of stack address with kretprobe
> > > instance as the identifier on the instance list.
> > > Since arm64 always enable CONFIG_FRAME_POINTER, we can use the
> > > actual frame pointer (x29).
> > 
> > Just to check, why do we need to use the FP rather than SP? It wasn't
> > clear to me if that's necessary later in the series, or if I'm missing
> > something here.
> 
> Actually, this is for finding correct return address from the per-task
> kretprobe instruction list (suppose it as a shadow stack) when it will
> be searched in stack-backtracing. At that point, the framepointer will
> be a reliable key.

Sure, my question was more "why isn't the SP a reliable key?", because both
the SP and FP should be balanced at function-entry and function-return
time. I'm asking because I think I'm missing a subtlety.

I'm perfectly happy to use the FP even if they're equivalent; I just
want to make sure there's not some issue I'm unaware of that could
affect unwinding.

Thanks,
Mark.

> > FWIW, I plan to rework arm64's ftrace bits to use FP for
> > HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, so I'm happy to do likewise here.
> 
> Yes, I think you can use FP for that too.
> 
> > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Regardless of the above:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thank you!
> 
> > 
> > Mark.
> > 
> > > ---
> > >  arch/arm64/kernel/probes/kprobes.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > index e7ad6da980e8..d9dfa82c1f18 100644
> > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > @@ -401,14 +401,14 @@ int __init arch_populate_kprobe_blacklist(void)
> > >  
> > >  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> > >  {
> > > -	return (void *)kretprobe_trampoline_handler(regs, (void *)kernel_stack_pointer(regs));
> > > +	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->regs[29]);
> > >  }
> > >  
> > >  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> > >  				      struct pt_regs *regs)
> > >  {
> > >  	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
> > > -	ri->fp = (void *)kernel_stack_pointer(regs);
> > > +	ri->fp = (void *)regs->regs[29];
> > >  
> > >  	/* replace return addr (x30) with trampoline */
> > >  	regs->regs[30] = (long)&__kretprobe_trampoline;
> > > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
