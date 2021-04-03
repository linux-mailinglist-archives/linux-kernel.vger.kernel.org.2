Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3482353542
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhDCSa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:30:59 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38372 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDCSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:30:58 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D1DEC92009C; Sat,  3 Apr 2021 20:30:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C2E5592009B;
        Sat,  3 Apr 2021 20:30:53 +0200 (CEST)
Date:   Sat, 3 Apr 2021 20:30:53 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Masami Hiramatsu <mhiramat@kernel.org>
cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT
 exception
In-Reply-To: <20210401093036.037f2abbce7ed5d1e68466b7@kernel.org>
Message-ID: <alpine.DEB.2.21.2104032020100.65251@angie.orcam.me.uk>
References: <20210330021624.2b776386@xhacker> <20210330183316.942215efe8e6e8455ad14113@kernel.org> <20210331222244.45a5807c@xhacker> <20210401093036.037f2abbce7ed5d1e68466b7@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021, Masami Hiramatsu wrote:

> > > > Current riscv's kprobe handlers are run with both preemption and
> > > > interrupt enabled, this violates kprobe requirements. Fix this issue
> > > > by keeping interrupts disabled for BREAKPOINT exception.  
> > > 
> > > Not only while the breakpoint exception but also until the end of
> > > the single step (maybe you are using __BUG_INSN_32 ??) need to be
> > > disable interrupts. Can this do that?
> > > 
> > 
> > interrupt is disabled during "single step" by kprobes_save_local_irqflag()
> > and kprobes_restore_local_irqflag(). The code flow looks like: 
> > 
> > do_trap_break()   // for bp
> >   kprobe_breakpoint_handler()
> >     setup_singlestep()
> >       kprobes_restore_local_irqflag()
> > 
> > do_trap_break()  // for ss
> >   kprobe_single_step_handler()
> >     kprobes_restore_local_irqflag()
> 
> OK, thanks for the confirmation!

 Is this approach guaranteed to keep interrupt handling latency low enough 
for the system not to be negatively affected, e.g. for the purpose of NTP 
timekeeping?

  Maciej
