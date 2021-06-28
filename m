Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8DA3B6B51
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 01:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhF1XXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 19:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhF1XWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 19:22:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6257C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:20:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z4so525391plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mRUbf3KJA2d64vKTZ/FyrTly1jL2s60EVp6ODRb0q9Q=;
        b=uXOWQ+eB18empgtJVMYzzMwdBwxLEMq2W32P0eBwWcEwSQUzia+V/S8UP6EgC3kBJ1
         xxY9Mu0kbipBr7023piq8gZS7lglwBz6MHTSf8NQepDqOgQJUuKVFOEOFFz5k3aEVvR6
         fS2z13O8CYBnqa5ci3RlGU9XLg18OXDHkCSYPrcTBTTaJ68T89J+5KTaxLJbeq6QM8M5
         2lqzzHj9pUqDuJA3Yvkg9y9NVyXc0emYOOftoXBM86l0xJnmqWg6S4JtCKpl6LrTsIBa
         CjrQxMi4nA9a4zHjfMNq7CpYcwLuCOFfSzRlOjWF3SvVbw/ty0IReHyA1kWprbVUdWbj
         FU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mRUbf3KJA2d64vKTZ/FyrTly1jL2s60EVp6ODRb0q9Q=;
        b=NTzdnNNX1vSqC+08fagzFXaveWHgrgJanu5HgMgNFpE3XfoEv1J7vMyoZ6RoBnSQtV
         VglyVLQl5O5io34Pl51bY9xNC/teuuPGnZ71HFRYw6ES4oaYvTPNHIVQ3HzrPP+iYWTx
         jwnpT9QrgfrrWT0pc9CnAPGW7X9yLpttswNNI4aaXimYDe0xaJMZNlorHaf+EQcrV8PU
         3ALUjJHeKPN+ifZTsIXocf4BVCROkIq3CWStcjGYkHECldwejappAtOmMS+vcU01IIRg
         pDUN5yJSBAKh1rT8wurVepSrJy9SmSZwouTcC22yVPy8X+kyVxt4kdLQyI9e7/Bhm/Cm
         7AFw==
X-Gm-Message-State: AOAM530f57MNRC8DPMyJrvzBlxaWOCUoju0vySpuTyVVqsI+28kMMKUW
        xwWeD7ePPSjDKp0zipJuwU0=
X-Google-Smtp-Source: ABdhPJysNaqjkYn1H0Iwdtijp2+qlaPNrYNNPvI5VF7m7NFdeCk2r71nY6ITTL1zQwSyEQPKlBHEzg==
X-Received: by 2002:a17:90a:a29:: with SMTP id o38mr27617803pjo.228.1624922427442;
        Mon, 28 Jun 2021 16:20:27 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id i27sm15304030pgl.78.2021.06.28.16.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 16:20:26 -0700 (PDT)
Date:   Tue, 29 Jun 2021 07:20:23 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: stacktrace: fix dump_backtrace/walk_stackframe
 with NULL task
Message-ID: <20210628232023.l6o7k5eetvvz2ysm@mail.google.com>
References: <20210627092659.46193-1-changbin.du@gmail.com>
 <20210628134404.4c470112@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628134404.4c470112@xhacker.debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 01:44:04PM +0800, Jisheng Zhang wrote:
> On Sun, 27 Jun 2021 17:26:59 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> 
> > 
> > 
> > Some places try to show backtrace with NULL task, and expect the task is
> > 'current'. For example, dump_stack()->show_stack(NULL,...). So the
> > stacktrace code should take care of this case.
> 
> I fixed this issue one week ago:
> 
> http://lists.infradead.org/pipermail/linux-riscv/2021-June/007258.html
> 
Good to know. Thanks!

> > 
> > Here is an oops caused by this issue when accessing the NULL task.
> > 
> > [   15.180813] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
> > [   15.182382] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc7-00111-g625acffd7ae2-dirty #18
> > [   15.183431] Hardware name: riscv-virtio,qemu (DT)
> > [   15.184253] Call Trace:
> > [   15.223617] Unable to handle kernel paging request at virtual address 0000000000001590
> > [   15.267378] Oops [#1]
> > [   15.268215] Modules linked in:
> > [   15.272027] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc7-00111-g625acffd7ae2-dirty #18
> > [   15.273997] Hardware name: riscv-virtio,qemu (DT)
> > [   15.275134] epc : walk_stackframe+0xc4/0xdc
> > [   15.280146]  ra : dump_backtrace+0x30/0x38
> > [   15.280799] epc : ffffffff8000597e ra : ffffffff800059c6 sp : ffffffe002383d60
> > [   15.281622]  gp : ffffffff8179ad18 tp : ffffffe002378000 t0 : ffffffff81bc1a3f
> > [   15.282574]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe002383dc0
> > [   15.283782]  s1 : ffffffff812b7d18 a0 : 0000000000001000 a1 : 0000000000000000
> > [   15.285115]  a2 : ffffffff807ec668 a3 : ffffffff812b7d18 a4 : c76c00cabf08b500
> > [   15.286213]  a5 : 0000000000001000 a6 : 000000001a9ef260 a7 : 0000000000000000
> > [   15.287317]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
> > [   15.288323]  s5 : ffffffff807ec668 s6 : ffffffff812b7d18 s7 : 0000000000000000
> > [   15.289530]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
> > [   15.290995]  s11: 0000000000000000 t3 : 0000000000000001 t4 : 0000000000000000
> > [   15.292465]  t5 : 206f74206e6f6974 t6 : ffffffe002383b28
> > [   15.293859] status: 0000000000000100 badaddr: 0000000000001590 cause: 000000000000000d
> > [   15.296035] [<ffffffff8000597e>] walk_stackframe+0xc4/0xdc
> > [   15.297342] [<ffffffff800059c6>] dump_backtrace+0x30/0x38
> > [   15.298333] [<ffffffff807ec6e0>] show_stack+0x40/0x4c
> > [   15.299765] [<ffffffff807f07ac>] dump_stack+0x7c/0x96
> > [   15.300553] [<ffffffff807ec8be>] panic+0x118/0x300
> > [   15.301147] [<ffffffff807f61e8>] kernel_init+0x12c/0x138
> > [   15.302056] [<ffffffff80003a22>] ret_from_exception+0x0/0xc
> > [   15.338628] ---[ end trace 0a3fa0cc7f3393cd ]---
> > [   15.339919] note: swapper/0[1] exited with preempt_count 1
> > [   15.341995] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > [   15.343889] SMP: stopping secondary CPUs
> > [   16.802836] SMP: failed to stop secondary CPUs 0-3
> > [   16.806264] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> > 
> > This patch fixes it by setting the task to current if it's NULL before
> > accessing it.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Fixes: 5d8544e2d0 ("RISC-V: Generic library routines and assembly")
> 
> Hmm, this fixes tag should be
> Fixes: eac2f3059e02 ("riscv: stacktrace: fix the riscv stacktrace when CONFIG_FRAME_POINTER enabled"
> 
> 
> > ---
> >  arch/riscv/kernel/stacktrace.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> > index bde85fc53357..788b65eba965 100644
> > --- a/arch/riscv/kernel/stacktrace.c
> > +++ b/arch/riscv/kernel/stacktrace.c
> > @@ -23,6 +23,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> >  {
> >         unsigned long fp, sp, pc;
> > 
> > +       if (!task)
> > +               task = current;
> > +
> >         if (regs) {
> >                 fp = frame_pointer(regs);
> >                 sp = user_stack_pointer(regs);
> > @@ -73,6 +76,9 @@ void notrace walk_stackframe(struct task_struct *task,
> >         unsigned long sp, pc;
> >         unsigned long *ksp;
> > 
> > +       if (!task)
> > +               task = current;
> > +
> >         if (regs) {
> >                 sp = user_stack_pointer(regs);
> >                 pc = instruction_pointer(regs);
> > --
> > 2.30.2
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> 

-- 
Cheers,
Changbin Du
