Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2F32A9DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835271AbhCBSvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1445780AbhCBQHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:07:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E7961494;
        Tue,  2 Mar 2021 15:58:29 +0000 (UTC)
Date:   Tue, 2 Mar 2021 10:58:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [x86, build] 6dafca9780:
 WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
Message-ID: <20210302105827.3403656c@gandalf.local.home>
In-Reply-To: <YD4DM6uAETid7j4l@hirez.programming.kicks-ass.net>
References: <20210301074027.GD12822@xsang-OptiPlex-9020>
        <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
        <20210301184524.7aa05ac1@gandalf.local.home>
        <CABCJKudQme=bcNJtNCORUpBnVA_Pkr2Zk_3Nu2EsfnuoE7LJ3g@mail.gmail.com>
        <20210301201526.65ce7f1c@oasis.local.home>
        <YD4DM6uAETid7j4l@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 10:19:47 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 01, 2021 at 08:15:26PM -0500, Steven Rostedt wrote:
> > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > index 7edbd5ee5ed4..e8afc765e00a 100644
> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -36,6 +36,7 @@
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >  
> >  static int ftrace_poke_late = 0;
> > +static const char p6_nop[] = { P6_NOP5 };  
> 
> I don't understand this approach, why not simply rewrite all the nops at
> boot and not worry about it when modifying the code later?

That was one of the suggestions I made in the first reply. But it's more
complex than that. Because the CC_USING_NOP_MCOUNT was added for other
architectures (currently only s390 and parisc uses it), it simply skips the
process of initializing the mcount/fentry into nops if the compiler had
already done it.

But because x86 is the only architecture daft enough to have different nops
with different "performance" depending on what hardware it's booted on, it's
a bit "special".

If we have to convert nops at boot up in case the compiler gets it wrong,
than why bother having the compiler try in the first place?

In other words, the only changes I see is the one I just made, or we rip
out CC_USING_NOP_MCOUNT for x86 completely.

-- Steve
