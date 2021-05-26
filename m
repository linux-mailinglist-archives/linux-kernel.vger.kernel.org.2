Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6280A391933
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhEZNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233462AbhEZNwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:52:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22562610A6;
        Wed, 26 May 2021 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622037075;
        bh=hijXBetczd8X+Zgt80YzJ2knOCvsPukmZp4yi+jziAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QHFHcZLvGUYtR5QVT3uAD2jxZDfh6h3wfC3KjiCD+4vBgfqdBW4Gkpqg1J1c3x4Ce
         /OurulEdx99p9CJMQlxnq2EemhsbBXSpzSNHdxXIIMoDpzg0Ku7gJ14GiIu8rfa7Pr
         I5NTVuaOPWY+DATq0NXppFzyCjxn3j+tcQuk8hBypWXkxNV8sHKjsf+NI40SUdF3x5
         tvJoxJJGtryeaEmMXTHz427+R+bSipxlr7vzV4ci/l8/sh3Go3w5535/304KPGZ9Xb
         kQXxHlQBJQ+6qirkdJxPdqMKm+/g4MiKuPTpoUKec/7Ye8CllxxREHHDfKpShz6UEu
         WYX5tPk0vICFg==
Date:   Wed, 26 May 2021 22:51:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        ananth@linux.ibm.com, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        rostedt@goodmis.org, x86@kernel.org
Subject: Re: [PATCH 1/2] kprobes: Remove kprobe::fault_handler
Message-Id: <20210526225111.216cb37d0c5bb606fcc305f1@kernel.org>
In-Reply-To: <1622025445.6q8nl3t4ap.naveen@linux.ibm.com>
References: <20210525072518.791889911@infradead.org>
        <20210525073213.561116662@infradead.org>
        <1622025445.6q8nl3t4ap.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 16:20:25 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Peter Zijlstra wrote:
> > The reason for kprobe::fault_handler(), as given by their comment:
> > 
> >  * We come here because instructions in the pre/post
> >  * handler caused the page_fault, this could happen
> >  * if handler tries to access user space by
> >  * copy_from_user(), get_user() etc. Let the
> >  * user-specified handler try to fix it first.
> > 
> > Is just plain bad. Those other handlers are ran from non-preemptible
> > context and had better use _nofault() functions. Also, there is no
> > upstream usage of this.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  Documentation/trace/kprobes.rst    |   24 +++++-------------------
> >  arch/arc/kernel/kprobes.c          |   10 ----------
> >  arch/arm/probes/kprobes/core.c     |    9 ---------
> >  arch/arm64/kernel/probes/kprobes.c |   10 ----------
> >  arch/csky/kernel/probes/kprobes.c  |   10 ----------
> >  arch/ia64/kernel/kprobes.c         |    9 ---------
> >  arch/mips/kernel/kprobes.c         |    3 ---
> >  arch/powerpc/kernel/kprobes.c      |   10 ----------
> >  arch/riscv/kernel/probes/kprobes.c |   10 ----------
> >  arch/s390/kernel/kprobes.c         |   10 ----------
> >  arch/sh/kernel/kprobes.c           |   10 ----------
> >  arch/sparc/kernel/kprobes.c        |   10 ----------
> >  arch/x86/kernel/kprobes/core.c     |   10 ----------
> >  include/linux/kprobes.h            |    8 --------
> >  kernel/kprobes.c                   |   19 -------------------
> >  samples/kprobes/kprobe_example.c   |   15 ---------------
> >  16 files changed, 5 insertions(+), 172 deletions(-)
> > 
> 
> <snip>
> 
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -947,16 +947,6 @@ int kprobe_fault_handler(struct pt_regs
> >  		 * these specific fault cases.
> >  		 */
> >  		kprobes_inc_nmissed_count(cur);
> 
> Not necessarily related, but I'm wondering why we're incrementing the 
> probe miss count here. Unlike what the comment above indicates, this is 
> not a 'fault' counter, but just a count of the number of times the probe 
> handler wasn't called.

Good catch! Indeed, we have no ned to count these fault because
it anyway gets back to the user handler. (so no user_handler is skipped)
Hmm, we need to clean up these countings too.

Thank you,

> 
> > -
> > -		/*
> > -		 * We come here because instructions in the pre/post
> > -		 * handler caused the page_fault, this could happen
> > -		 * if handler tries to access user space by
> > -		 * copy_from_user(), get_user() etc. Let the
> > -		 * user-specified handler try to fix it first.
> > -		 */
> > -		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
> > -			return 1;
> >  	}
> 
> 
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
