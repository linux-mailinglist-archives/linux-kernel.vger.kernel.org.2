Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59713426BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhJHNsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhJHNsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:48:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76CC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AeZfY9f2iurPW1q+xtFtNI1W2I5709CG4W+EJzRCAMU=; b=VTz07ORtCuf5oVvGPCxrXR3kYL
        hwmjJl9K29frRONPa/BsiWpyaMYGbCj8lGBNv9ysywf1ucX6SrVnNGhrFg5RgVyv/jjMXTLyyxyzZ
        kTkRxUFEC8uUfV6+Gf1mdGDbFyqtbcj5Ye3WQTSWYPtT3/KG75H2K1G1sWa4KD5dG75i/LmJn68A9
        PVoR2JXECqp2Xs82wX3SO2vKHVGUJuXuQzLPhyHHKCT80ivuJ3ogjnSAE/Gk9ZwP/p0NzFK2uOzRv
        CZvdYdIu9dBjij2sqTcNQiv+vIexJ37P+rivNIgKccf58rTbEg8az7N4FTexM+Nonna16vd1ZYVto
        UOYsffRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYqCF-003Ene-QB; Fri, 08 Oct 2021 13:46:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B20530077A;
        Fri,  8 Oct 2021 15:45:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64C3A2007A037; Fri,  8 Oct 2021 15:45:59 +0200 (CEST)
Date:   Fri, 8 Oct 2021 15:45:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     keescook@chromium.org, jannh@google.com,
        linux-kernel@vger.kernel.org, vcaputo@pengaru.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: Re: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
Message-ID: <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008124052.GA976@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 01:40:52PM +0100, Mark Rutland wrote:
> [Adding Josh, since there might be a concern here from a livepatch pov]
> 

> > +static unsigned long __get_wchan(struct task_struct *p)
> > +{
> > +	unsigned long entry = 0;
> > +
> > +	stack_trace_save_tsk(p, &entry, 1, 0);
> 
> This assumes stack_trace_save_tsk() will skip sched functions, but I
> don't think that's ever been a requirement? It's certinaly not
> documented anywhere that I could find, and arm64 doesn't do so today,
> and this patch causes wchan to just log `__switch_to` for everything.

Confused, arm64 has arch_stack_walk() and should thus use
kernel/stacktrace.c's stack_trace_consume_entry_nosched.

> I realise you "fix" that for some arches in the next patch, but it's not
> clear to me that's the right thing to do -- I would expect that

I only actually change the behaviour on csky, both mips and nds32 have
this 'savesched = (task == current)' logic which ends up being a very
confusing way to write things, but for wchan we never call on current,
and hence don't save the __sched functions.

> stack_trace_save_tsk() *shouldn't* skip anything unless we've explicitly
> told it to via skipnr, because I'd expect that

It's what most archs happen to do today and is what
stack_trace_save_tsk() as implemented using arch_stack_walk() does.
Which is I think the closest to canonical we have.

> stack_trace_save_tsk_reliable() mustn't, in case we ever need to patch
> anything in the scheduler (or arch ctxsw code) with a livepatch, or if
> you ever *want* to have the sched functions in a trace.
> 
> So I have two big questions:
> 
> 1) Where precisely should stack_trace_save_tsk() and
>    stack_trace_save_tsk_reliable() start from?
> 
> 1) What should you do when you *do* want sched functions in a trace?
> 
> We could side-step the issue here by using arch_stack_walk(), which'd
> make it easy to skip sched functions in the core code.

arch_stack_walk() is the modern API and should be used going forward,
and I've gone with the stack_trace_save*() implementation as per that.
