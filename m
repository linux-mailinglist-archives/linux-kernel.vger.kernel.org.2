Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60A7358FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhDHWjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232265AbhDHWjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E83F961106;
        Thu,  8 Apr 2021 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617921542;
        bh=T9Xmxojax6GIvmigkpUkfCNwyL8m2lnVcs8esdkHluU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZoU0pR6FdJu6NdPGeoNs5yO5cYoxyUs5bEwLhoirKPbQrjPHpWtA+GzKhw29LGl5r
         +sTOldiQ0OL/ST5SCFI0jkDveSexpBw0H8n/gorKyEk80ZGWY39TlpDhicZEMtfueJ
         RK7rLjeY7NEl9hyAZpceiuMOO+eZtYj0DrDiRLpUkqMBL40n1r/5caoi1xibNPVGlF
         TdInRWzsqMAGGrEP9lxyyxTGXVRLEd1RV3uaStHZmgwLGQo+AlCh87v4jeNa8iW8oz
         qeOstpHj1ppXnpMBid3KuC+uYJLqjF6y5MupJiorqVbC6iB3kkQE5V+f1WzFQTWpch
         O2C2IEeYapqDg==
Date:   Fri, 9 Apr 2021 07:38:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT
 exception
Message-Id: <20210409073858.e7b439e99e9e506f4f3847e2@kernel.org>
In-Reply-To: <20210408192348.1d50c588@xhacker.debian>
References: <20210330021624.2b776386@xhacker>
        <20210330183316.942215efe8e6e8455ad14113@kernel.org>
        <20210331222244.45a5807c@xhacker>
        <20210401093036.037f2abbce7ed5d1e68466b7@kernel.org>
        <alpine.DEB.2.21.2104032020100.65251@angie.orcam.me.uk>
        <20210408192348.1d50c588@xhacker.debian>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 19:23:48 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> On Sat, 3 Apr 2021 20:30:53 +0200 (CEST)
> "Maciej W. Rozycki" <macro@orcam.me.uk> wrote:
> 
> > CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > 
> > On Thu, 1 Apr 2021, Masami Hiramatsu wrote:
> > 
> > > > > > Current riscv's kprobe handlers are run with both preemption and
> > > > > > interrupt enabled, this violates kprobe requirements. Fix this issue
> > > > > > by keeping interrupts disabled for BREAKPOINT exception.  
> > > > >
> > > > > Not only while the breakpoint exception but also until the end of
> > > > > the single step (maybe you are using __BUG_INSN_32 ??) need to be
> > > > > disable interrupts. Can this do that?
> > > > >  
> > > >
> > > > interrupt is disabled during "single step" by kprobes_save_local_irqflag()
> > > > and kprobes_restore_local_irqflag(). The code flow looks like:
> > > >
> > > > do_trap_break()   // for bp
> > > >   kprobe_breakpoint_handler()
> > > >     setup_singlestep()
> > > >       kprobes_restore_local_irqflag()
> > > >
> > > > do_trap_break()  // for ss
> > > >   kprobe_single_step_handler()
> > > >     kprobes_restore_local_irqflag()  
> > >
> > > OK, thanks for the confirmation!  
> > 
> >  Is this approach guaranteed to keep interrupt handling latency low enough
> > for the system not to be negatively affected, e.g. for the purpose of NTP
> > timekeeping?
> 
> IMHO, interrupt latency can't be ensured if kprobes is triggered.

Indeed. The latency depends on what the kprobe user handler does. Of course
it must be as minimal as possible... On x86, it is less than a few microseconds.
Thus it may be a jitter on hard realtime system, but not a big issue on
usual system like NTP timekeeping.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
