Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9639489E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhE1WWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 18:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhE1WWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 18:22:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27E761358;
        Fri, 28 May 2021 22:21:04 +0000 (UTC)
Date:   Fri, 28 May 2021 18:21:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, mingo@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        changbin.du@gmail.com
Subject: Re: [PATCH] RISC-V: Don't check text_mutex during stop_machine
Message-ID: <20210528182102.19319b1b@gandalf.local.home>
In-Reply-To: <mhng-edd9e8bd-e585-4b6b-8e40-797215bfdf75@palmerdabbelt-glaptop>
References: <20210506092550.6c2206b3@gandalf.local.home>
        <mhng-edd9e8bd-e585-4b6b-8e40-797215bfdf75@palmerdabbelt-glaptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 12:32:05 -0700 (PDT)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> we can then IPI to all the harts in order to get them on the same page 
> about that trap, which we can then skip over.  We'll need some way to 
> differentiate this from accidental executions of unimp, but we can just 
> build up a table somewhere (it wasn't immediately clear how x86 does 

It currently uses the same code as the text_poke does, which does a
"batching" and keeps track of the locations that were modified. But before
that change (768ae4406a x86/ftrace: Use text_poke()), it had:

int ftrace_int3_handler(struct pt_regs *regs)
{
        unsigned long ip;

        if (WARN_ON_ONCE(!regs))
                return 0;

        ip = regs->ip - INT3_INSN_SIZE;

        if (ftrace_location(ip)) {
                int3_emulate_call(regs, (unsigned long)ftrace_regs_caller);
                return 1;
        } else if (is_ftrace_caller(ip)) {
                if (!ftrace_update_func_call) {
                        int3_emulate_jmp(regs, ip + CALL_INSN_SIZE);
                        return 1;
                }
                int3_emulate_call(regs, ftrace_update_func_call);
                return 1;
        }

        return 0;
}

That "ftrace_location()" is the table you are looking for. It will return
true if the location is registered with ftrace or not (i.e. the mcount
call).

The "int3_emulate_jmp()" is needed to handle the case that we switch from
one trampoline to another trampoline. But that's also an architecture
specific feature, and RISC-V may not have that yet.


-- Steve


> this).  Then we have no ordering restrictions on converting the rest of 
> the stub into what's necessary to trace a function, which should look 
> the same as what we have now

