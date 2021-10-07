Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97E9424DEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbhJGHOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbhJGHOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:14:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB37C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I0RekFPu+w8TOs1ZgfP4To4EFLErVU1H2sFalOTk1VQ=; b=hjgI9XiySnczm9jj8/vZ4epWv0
        0ADQXxpNQXWBnRAfhO5SpxuadnVGlUTmQ0esYzMfW9bfVrqSm0iy5ZAM85qGe+n4NGhSNIN6ZtxpP
        oB5Vq5qd54CnpWOVtb+VmuACM7GeKKP78tKKWNK0OSCNJqZ3r58O09GQIvaL+H7mpj7cEdabHvxvF
        y3Wf5G8vLlZ+HAjmGJTTnRHS8FTgSeIRBZd/fbT2mAVkcMr5NAB6yTK6qPY8dx/Adn2tIrR1PQDDD
        xzOzZXUg09mc8Y8MadECX7M9NRzHiy9SMY3Ls+QiE6vZZ7xxnHustsPrRWbX/eVduL6vFaqyLlq8F
        PjJh5w7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYNZI-008QjF-7f; Thu, 07 Oct 2021 07:11:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64DDE98623A; Thu,  7 Oct 2021 09:11:51 +0200 (CEST)
Date:   Thu, 7 Oct 2021 09:11:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <20211007071151.GL174703@worktop.programming.kicks-ass.net>
References: <20210831043723.13481-1-robbat2@gentoo.org>
 <20210907212426.73ed81d1@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907212426.73ed81d1@rorschach.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 09:24:26PM -0400, Steven Rostedt wrote:
> 
> I'll need Acks for these patches from the Perf maintainers.
> 
> -- Steve
> 
> 
> On Mon, 30 Aug 2021 21:37:22 -0700
> "Robin H. Johnson" <robbat2@gentoo.org> wrote:
> 
> > If the perf buffer isn't large enough, provide a hint about how large it
> > needs to be for whatever is running.

Is that an actual reason?

> > Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> > ---
> >  kernel/trace/trace_event_perf.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> > index 03be4435d103..26eed4b89100 100644
> > --- a/kernel/trace/trace_event_perf.c
> > +++ b/kernel/trace/trace_event_perf.c
> > @@ -400,7 +400,8 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp)
> >  	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(unsigned long));
> >  
> >  	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE,
> > -		      "perf buffer not large enough"))
> > +		      "perf buffer not large enough, wanted %d, have %d",
> > +		      size, PERF_MAX_TRACE_SIZE))

Priting a constant seems daft.. why is any of this important in any way?
