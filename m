Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7261C348A55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCYHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhCYHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:43:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xjBNfcp6p4BIctZomY46PzWOaEWIxfJHX1EGfm570g8=; b=T3GrczZhiQuFC0e3oq+Tcc90+K
        QQHpl5LbAAiCPkJjBI1ilV2UIK8whc/ioMMfaCjgr/kMKpRNlIPZrtwCo41fwMBCd/yOqY1blrAQF
        esGgP0bu3CjFgrfgm0WaNVVHhXLSXNlUhZSu3kF+NqIK566CSErxzlJu4tRurChgPgVATOtI5aP6a
        m3hzqhx0kL1CyjD88xtFrnmqVmCo3Q42jPTEM45+x6YCEWxiWDs/ahfVGf3/N3lFvfsNy06ozcGMs
        nlzUwcYaKoinyExMSVj6LdBsHlcpDjv8FsUbm25BLfnFr1hQ8Ssk2/JDJFySRKetTDj4DFkPFTx/h
        6f7cdHBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPKdN-00CTwE-St; Thu, 25 Mar 2021 07:42:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 814CC301A7A;
        Thu, 25 Mar 2021 08:42:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69D2D29D50698; Thu, 25 Mar 2021 08:42:24 +0100 (CET)
Date:   Thu, 25 Mar 2021 08:42:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] static_call: fix function type mismatch
Message-ID: <YFw+4Ba5ci/Bmg0k@hirez.programming.kicks-ass.net>
References: <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk>
 <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
 <b2d77e78-751e-283c-8cff-e9c4f16e27ef@prevas.dk>
 <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
 <a758cace-99ed-5c60-e59c-9f4f6b3a39c7@rasmusvillemoes.dk>
 <CABCJKuek8Set48v5wa2sbCN1fN7DYSczJ9MdH4BcQBdky1YNaA@mail.gmail.com>
 <2b38d13f-9f90-b94b-7de4-c924696e6a9f@rasmusvillemoes.dk>
 <CABCJKudx9bkvkOsAVi7Wzgr3AVFGwa64Kre1d59v0tTr6GOgcA@mail.gmail.com>
 <170687fb-13ef-e9b8-ac69-032202b344fe@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170687fb-13ef-e9b8-ac69-032202b344fe@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 01:42:41AM +0100, Rasmus Villemoes wrote:
> > Actually, it looks like I can't select PREEMPT_DYNAMIC> and tweaking Kconfig
> 
> Ah, there's no prompt on the "bool" line, so it doesn't show up. That
> seems to be a mistake, since there's an elaborate help text which says
> 
>           The runtime overhead is negligible with
> HAVE_STATIC_CALL_INLINE enabled
>           but if runtime patching is not available for the specific
> architecture
>           then the potential overhead should be considered.
> 
> So it seems that it was meant to be "you can enable this if you really
> want".
> 
> to force enable it on arm64 results in a build error

Right, PREEMPT_DYNAMIC really hard relies on HAVE_STATIC_CALL

There's an implicit dependency in the select:

config PREEMPT
	...
	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC

> > ("implicit declaration of function 'static_call_mod'").
> 
> Seems to be an omission in the last !HAVE_STATIC_CALL branch in
> static_call_types.h, and there's also no
> EXPORT_STATIC_CALL_TRAMP{,_GPL} in static_call.h for that case.

That interface doesn't make sense for !HAVE_STATIC_CALL. It's impossible
to not export the function pointer itself but still call it for
!HAVE_STATIC_CALL.
