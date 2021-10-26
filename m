Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F343BC54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhJZV0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhJZV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:26:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D6AC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pUBzPUdB110mn7Gg7YEa/AEceHnmilwE6ZqD1nGsNeE=; b=pCLU+GwD18uZSwjeK6yLP2cDkq
        t/ZtBh4A0YFbwWF7EBY43+IYRtV1/zOvxH9pOlmDttZjN7BH3f6oZusgjoksYWzx3IGb5nVFqHrlL
        U3IhUBYiFEbS84zxuBBzJa4F01V8E/aO/yAEfqmm9YnixEFO3zRAi48Y7QqXU+7LoMZ1vMvEq5a6B
        9W/jxSFjDA1yEeYrehlhc/nhZoSNAYMJv3NnnkhWu0WbbRgRlufV2RWS5YXKPhggsR3tBygsfHa23
        FqliHuM2NSzvk4oGOYwo97fnJF56ncaivWHHmPuRgs1E3lN5nvlzmiY2E0hM4Jfhn2ISau4XbYTlC
        EEac3GRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfTuw-00CQjf-7x; Tue, 26 Oct 2021 21:23:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0175B3002AE;
        Tue, 26 Oct 2021 23:23:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF49F2C1D557D; Tue, 26 Oct 2021 23:23:32 +0200 (CEST)
Date:   Tue, 26 Oct 2021 23:23:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <YXhx1N1/xe/v3wrI@hirez.programming.kicks-ass.net>
References: <20210831043723.13481-1-robbat2@gentoo.org>
 <20210907212426.73ed81d1@rorschach.local.home>
 <20211007071151.GL174703@worktop.programming.kicks-ass.net>
 <20211007092358.65152792@gandalf.local.home>
 <20211026164343.2e1754bd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026164343.2e1754bd@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 04:43:43PM -0400, Steven Rostedt wrote:
> On Thu, 7 Oct 2021 09:23:58 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 7 Oct 2021 09:11:51 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > > +++ b/kernel/trace/trace_event_perf.c
> > > > > @@ -400,7 +400,8 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp)
> > > > >  	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(unsigned long));
> > > > >  
> > > > >  	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE,
> > > > > -		      "perf buffer not large enough"))
> > > > > +		      "perf buffer not large enough, wanted %d, have %d",
> > > > > +		      size, PERF_MAX_TRACE_SIZE))    
> > > 
> > > Priting a constant seems daft.. why is any of this important in any way?  
> > 
> > I see your point, but it can be useful if you changed it, and want to know
> > if you are running the kernel with the change or not.
> > 
> > I've done daft things were I changed a const and was running a kernel
> > without the change and couldn't understand why it wasn't working ;-)
> 
> Peter,
> 
> Do you have any real issue if I just take this patch set through my tree?

No real objections; just weary, huge events like that are fairly sucky
for performance.
