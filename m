Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4FB350B24
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 02:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhDAAbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 20:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhDAAak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 20:30:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2C546101E;
        Thu,  1 Apr 2021 00:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617237040;
        bh=62oBHtP8b4XwyEoNVJI6VmhrBZdgCYFCTbD8I+sP/zg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kW/E6LbgqWEEZAvhHiViofcw5zhxPQblmj3TNdcAS3uwY90IWH7VBOq8nCZPcsyBI
         WfGxVMo/O0WED0VA8ycLnreGZ5zQFUQEQ+otYNAxAIYhkwGMopGSPl8/VW7VPsNABl
         4iNicD4J2OkAAgUt5uET2fEDmtMlrvufR2/KJw81J6uIytfaR/hpg9x9pMvroVq3S9
         RRC+UbZ/Kr8dpzqeKOwVgb9Xvp1kg70kXuIwMHezmrrsq42DxMrIuduQJwFfzLXTZz
         9nfteii8VYEc6Bp1fpZZ4IE8V+zoZ4y1FLVA3DBXBE33AfdBOXX87VDtRRyeb+cag9
         VHqKnyOnshqhA==
Date:   Thu, 1 Apr 2021 09:30:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT
 exception
Message-Id: <20210401093036.037f2abbce7ed5d1e68466b7@kernel.org>
In-Reply-To: <20210331222244.45a5807c@xhacker>
References: <20210330021624.2b776386@xhacker>
        <20210330183316.942215efe8e6e8455ad14113@kernel.org>
        <20210331222244.45a5807c@xhacker>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Mar 2021 22:22:44 +0800
Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:

> On Tue, 30 Mar 2021 18:33:16 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Jisheng,
> 
> Hi Masami,
> 
> > 
> > On Tue, 30 Mar 2021 02:16:24 +0800
> > Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> > 
> > > From: Jisheng Zhang <jszhang@kernel.org>
> > > 
> > > Current riscv's kprobe handlers are run with both preemption and
> > > interrupt enabled, this violates kprobe requirements. Fix this issue
> > > by keeping interrupts disabled for BREAKPOINT exception.  
> > 
> > Not only while the breakpoint exception but also until the end of
> > the single step (maybe you are using __BUG_INSN_32 ??) need to be
> > disable interrupts. Can this do that?
> > 
> 
> interrupt is disabled during "single step" by kprobes_save_local_irqflag()
> and kprobes_restore_local_irqflag(). The code flow looks like: 
> 
> do_trap_break()   // for bp
>   kprobe_breakpoint_handler()
>     setup_singlestep()
>       kprobes_restore_local_irqflag()
> 
> do_trap_break()  // for ss
>   kprobe_single_step_handler()
>     kprobes_restore_local_irqflag()

OK, thanks for the confirmation!

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
