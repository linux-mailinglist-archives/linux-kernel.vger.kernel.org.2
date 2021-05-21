Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876AA38C846
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhEUNip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhEUNih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:38:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38AC061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EYC/9ctrfQvAEBBAKsb7gJESMa1uCEoqi9UattPV9Xo=; b=m3FRsszyBLlzGEw05BO4uPMu9f
        PY8X+6lpkbRJKeAgtF6owyZ878nepODs1cMLYRRtzFmyCO1SwpTEbzutDeigngGMTyuImw1dZUsdB
        qzNjsA5h8kMlcLNt1AvdMB5SAFALh6rY0cIHQPE8fV56kgkQ++3iGZEJgs5fbcp4vEJjgznj9u8eU
        h4TeIi/aSYbyGml5bfIG27+x8IOAZf2vpjw6PHJdltTP3J0mgMe8wmC4hQVoxzVi4VpXVVZLJNk/Z
        D8TSse1HDs38bWF/HgVLrNVOhYoOmdYMDm2LBADXiv97xNWOtNWlx4Q3maipFI2FSPsHkaVy2cyPX
        yrzmvrCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lk5Hi-00GzXq-RY; Fri, 21 May 2021 13:34:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DE4930022A;
        Fri, 21 May 2021 15:33:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E90DB30BCEBEB; Fri, 21 May 2021 15:33:49 +0200 (CEST)
Date:   Fri, 21 May 2021 15:33:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: config SCHED_CORE
Message-ID: <YKe2vVvq9oSsNsTD@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
 <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
 <CAEXW_YRxOqQCF2FgXAjL3xkZhRD4rdFuxvyPd-ESXYQQ78cyfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRxOqQCF2FgXAjL3xkZhRD4rdFuxvyPd-ESXYQQ78cyfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 07:57:35AM -0400, Joel Fernandes wrote:

> > ---
> >  kernel/Kconfig.preempt | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> > index ea1e3331c0ba..3c4566cd20ef 100644
> > --- a/kernel/Kconfig.preempt
> > +++ b/kernel/Kconfig.preempt
> > @@ -104,4 +104,16 @@ config SCHED_CORE
> >         bool "Core Scheduling for SMT"
> >         default y
> >         depends on SCHED_SMT
> > -
> > +       help
> > +         This option enables Core scheduling, a means of coordinated task
> > +         selection across SMT siblings with the express purpose of creating a
> > +         Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)
> > +         -- task selection will ensure all SMT siblings will execute a task
> > +         from the same 'core group', forcing idle when no matching task is found.
> > +
> > +         This provides means of mitigation against a number of SMT side-channels;
> > +         but is, on its own, insufficient to mitigate all known side-channels.
> > +         Notable: the MDS class of attacks require more.
> > +
> > +         Default enabled for anything that has SCHED_SMT, when unused there should
> > +         be no impact on performance.
> 
> This description sort of makes it sound like security is the only
> usecase. Perhaps we can also add here that core-scheduling can help
> performance of workloads where hyperthreading is undesired, such as
> when VM providers don't want to share hyperthreads.
> 
> Thoughts?

You're right. And there's this whole class of people who want to use
this to eliminate SMT interference. I'll see if I can work that in
without turning the whole thing into a novella or so ;-/
