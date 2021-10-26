Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A343BBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhJZUqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239267AbhJZUqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:46:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A19460F24;
        Tue, 26 Oct 2021 20:43:45 +0000 (UTC)
Date:   Tue, 26 Oct 2021 16:43:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <20211026164343.2e1754bd@gandalf.local.home>
In-Reply-To: <20211007092358.65152792@gandalf.local.home>
References: <20210831043723.13481-1-robbat2@gentoo.org>
        <20210907212426.73ed81d1@rorschach.local.home>
        <20211007071151.GL174703@worktop.programming.kicks-ass.net>
        <20211007092358.65152792@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 09:23:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 7 Oct 2021 09:11:51 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > > +++ b/kernel/trace/trace_event_perf.c
> > > > @@ -400,7 +400,8 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp)
> > > >  	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(unsigned long));
> > > >  
> > > >  	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE,
> > > > -		      "perf buffer not large enough"))
> > > > +		      "perf buffer not large enough, wanted %d, have %d",
> > > > +		      size, PERF_MAX_TRACE_SIZE))    
> > 
> > Priting a constant seems daft.. why is any of this important in any way?  
> 
> I see your point, but it can be useful if you changed it, and want to know
> if you are running the kernel with the change or not.
> 
> I've done daft things were I changed a const and was running a kernel
> without the change and couldn't understand why it wasn't working ;-)

Peter,

Do you have any real issue if I just take this patch set through my tree?

-- Steve
