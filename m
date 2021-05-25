Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2339043C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhEYOqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232939AbhEYOqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:46:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B958A6141C;
        Tue, 25 May 2021 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621953911;
        bh=jfWp5vialmXhYcXsdvLggfVIv1bcNp7z6bzNnIfhMJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lyU0XUfjokFn6Duv+OPmiSjb1JOVme62avzrZz2hHvx1oFvh07TXcqjNc7vTtydze
         9GU04pIGPwo1dv0rmUZZaX068G8FEAM+YtGrLHhYLfsvEwTrP8DWcmSaHoZff6IH3a
         qKhyCIxNvROpdTzWZeJdKieBQj0EFkzeAmOYmvxmnMeesMpvQV2AuJ3ci3i3JVmMLU
         VrpviY6aghQ2FKhDrEXVejZQ4kPEJOr9f6OrUwWz7Zlzm40CXnnouGPHqLE5tQx2BB
         te+qUNejwrTWcjIPdEHR2BPVyDZmBtyB/j4Ra11amW2TL4jCbYm437zf/Mlkn3YAXD
         WQZ9fr5DvMEqQ==
Date:   Tue, 25 May 2021 23:45:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kprobes: Remove redundant kprobe_step_ctx
Message-Id: <20210525234507.2a576f91d157eba18eb4306a@kernel.org>
In-Reply-To: <20210512225819.6756c0b0@xhacker>
References: <20210419002919.1a0a539d@xhacker>
        <20210512225819.6756c0b0@xhacker>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Wed, 12 May 2021 22:58:19 +0800
Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:

> On Mon, 19 Apr 2021 00:29:19 +0800
> Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> 
> > From: Jisheng Zhang <jszhang@kernel.org>
> > 
> > Inspired by commit ba090f9cafd5 ("arm64: kprobes: Remove redundant
> > kprobe_step_ctx"), the ss_pending and match_addr of kprobe_step_ctx
> > are redundant because those can be replaced by KPROBE_HIT_SS and
> > &cur_kprobe->ainsn.api.insn[0] + GET_INSN_LENGTH(cur->opcode)
> > respectively.
> > 
> > Remove the kprobe_step_ctx to simplify the code.
> 
> Hi all,
> 
> This patch can still be applied to 5.13-rc1, could you please review? Let me
> know if a rebase on 5.13-rc1 is needed.

As far as I compared with arm64 code, this looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> Thanks
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/include/asm/kprobes.h   |  7 ------
> >  arch/riscv/kernel/probes/kprobes.c | 40 +++++++-----------------------
> >  2 files changed, 9 insertions(+), 38 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
> > index 4647d38018f6..9ea9b5ec3113 100644
> > --- a/arch/riscv/include/asm/kprobes.h
> > +++ b/arch/riscv/include/asm/kprobes.h
> > @@ -29,18 +29,11 @@ struct prev_kprobe {
> >  	unsigned int status;
> >  };
> >  
> > -/* Single step context for kprobe */
> > -struct kprobe_step_ctx {
> > -	unsigned long ss_pending;
> > -	unsigned long match_addr;
> > -};
> > -
> >  /* per-cpu kprobe control block */
> >  struct kprobe_ctlblk {
> >  	unsigned int kprobe_status;
> >  	unsigned long saved_status;
> >  	struct prev_kprobe prev_kprobe;
> > -	struct kprobe_step_ctx ss_ctx;
> >  };
> >  
> >  void arch_remove_kprobe(struct kprobe *p);
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> > index 8c1f7a30aeed..4c1ad5536748 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -17,7 +17,7 @@ DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
> >  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> >  
> >  static void __kprobes
> > -post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
> > +post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
> >  
> >  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> >  {
> > @@ -43,7 +43,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
> >  		p->ainsn.api.handler((u32)p->opcode,
> >  					(unsigned long)p->addr, regs);
> >  
> > -	post_kprobe_handler(kcb, regs);
> > +	post_kprobe_handler(p, kcb, regs);
> >  }
> >  
> >  int __kprobes arch_prepare_kprobe(struct kprobe *p)
> > @@ -149,21 +149,6 @@ static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
> >  	regs->status = kcb->saved_status;
> >  }
> >  
> > -static void __kprobes
> > -set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr, struct kprobe *p)
> > -{
> > -	unsigned long offset = GET_INSN_LENGTH(p->opcode);
> > -
> > -	kcb->ss_ctx.ss_pending = true;
> > -	kcb->ss_ctx.match_addr = addr + offset;
> > -}
> > -
> > -static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
> > -{
> > -	kcb->ss_ctx.ss_pending = false;
> > -	kcb->ss_ctx.match_addr = 0;
> > -}
> > -
> >  static void __kprobes setup_singlestep(struct kprobe *p,
> >  				       struct pt_regs *regs,
> >  				       struct kprobe_ctlblk *kcb, int reenter)
> > @@ -182,8 +167,6 @@ static void __kprobes setup_singlestep(struct kprobe *p,
> >  		/* prepare for single stepping */
> >  		slot = (unsigned long)p->ainsn.api.insn;
> >  
> > -		set_ss_context(kcb, slot, p);	/* mark pending ss */
> > -
> >  		/* IRQs and single stepping do not mix well. */
> >  		kprobes_save_local_irqflag(kcb, regs);
> >  
> > @@ -219,13 +202,8 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
> >  }
> >  
> >  static void __kprobes
> > -post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
> > +post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb, struct pt_regs *regs)
> >  {
> > -	struct kprobe *cur = kprobe_running();
> > -
> > -	if (!cur)
> > -		return;
> > -
> >  	/* return addr restore if non-branching insn */
> >  	if (cur->ainsn.api.restore != 0)
> >  		regs->epc = cur->ainsn.api.restore;
> > @@ -355,16 +333,16 @@ bool __kprobes
> >  kprobe_single_step_handler(struct pt_regs *regs)
> >  {
> >  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> > +	unsigned long addr = instruction_pointer(regs);
> > +	struct kprobe *cur = kprobe_running();
> >  
> > -	if ((kcb->ss_ctx.ss_pending)
> > -	    && (kcb->ss_ctx.match_addr == instruction_pointer(regs))) {
> > -		clear_ss_context(kcb);	/* clear pending ss */
> > -
> > +	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
> > +	    ((unsigned long)&cur->ainsn.api.insn[0] + GET_INSN_LENGTH(cur->opcode) == addr)) {
> >  		kprobes_restore_local_irqflag(kcb, regs);
> > -
> > -		post_kprobe_handler(kcb, regs);
> > +		post_kprobe_handler(cur, kcb, regs);
> >  		return true;
> >  	}
> > +	/* not ours, kprobes should ignore it */
> >  	return false;
> >  }
> >  
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
