Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41831BBFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhBOPMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:12:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhBOPAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:00:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C73564E5E;
        Mon, 15 Feb 2021 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613401100;
        bh=FopL1IYoHmDoFqbJ/8lmEQvW0M+Rlw3UECAlahEn3ZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZDn8p7lTEjieXiYq5ZXxg/RZ2XYSEfmh/1AfIpAqAf9xWxMCU8Fhxrkxl/ex8Mejz
         I2lNufj/YLAYYJaduI/IJzY5QzNy8oplIzSh8Q4qkbKVA8p1pkrCW3FP76GzKZMWRg
         vWqiRmT1SZosP+GaQ+mc82Yub40410fEzFU1TO5kF1W5nPJkD6tSRhWOT83oEe6iS/
         CSslpVm6Rl52gU+b079exnP/QSvNCSbHmKPj5JrkKqiiVPsMPDwLG/booNujddfX1P
         NS80Jcre2qW8dgfW0Dee41ciN9ospkSNwQS/5FvXYcpMgVytr2HD/2BpqGgM7tDTht
         HxKTrl+b3bTqg==
Date:   Mon, 15 Feb 2021 23:58:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 3/3] tracing: Add ptr-hash option to show the hashed
 pointer value
Message-Id: <20210215235815.003b9bcece1d8de59d3e546b@kernel.org>
In-Reply-To: <20210212103310.791c1f48@gandalf.local.home>
References: <160277369795.29307.6792451054602907237.stgit@devnote2>
        <160277372504.29307.14909828808982012211.stgit@devnote2>
        <20210212103310.791c1f48@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021 10:33:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Hi Masami,
> 
> I noticed theses sitting in my patchwork and I said I was going to hold off
> to the next merge window, and these got pushed down in my stack :-/

Yeah, managing random topics is a hard task ;)

> 
> 
> On Thu, 15 Oct 2020 23:55:25 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add tracefs/options/hash-ptr option to show hashed pointer
> > value by %p in event printk format string.
> > 
> > For the security reason, normal printk will show the hashed
> > pointer value (encrypted by random number) with %p to printk
> > buffer to hide the real address. But the tracefs/trace always
> > shows real address for debug. To bridge those outputs, add an
> > option to switch the output format. Ftrace users can use it
> > to find the hashed value corresponding to the real address
> > in trace log.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Documentation/trace/ftrace.rst |    6 ++++++
> >  kernel/trace/trace.c           |    3 +++
> >  kernel/trace/trace.h           |    1 +
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 87cf5c010d5d..62c98e9bbdd9 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -1159,6 +1159,12 @@ Here are the available options:
> >  	This simulates the original behavior of the trace file.
> >  	When the file is closed, tracing will be enabled again.
> >  
> > +  hash-ptr
> > +        When set, "%p" in the event printk format displays the
> > +        hashed pointer value instead of real address.
> > +        This will be useful if you want to find out which hashed
> > +        value is corresponding to the real value in trace log.
> > +
> 
> I'm thinking of making this the default. I'll add a patch to make it
> enabled by default "for security reasons", but still allow people to clear
> it this value.
> 
> Are you OK with that?

Yes, I agreed. It will be good for both security and debug reasons. :)

Thank you,

> 
> -- Steve
> 
> 
> 
> >    record-cmd
> >  	When any event or tracer is enabled, a hook is enabled
> >  	in the sched_switch trace point to fill comm cache
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 75395293d8df..b88cccf224cd 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -3543,6 +3543,9 @@ const char *trace_event_format(struct trace_iterator *iter, const char *fmt)
> >  	if (WARN_ON_ONCE(!fmt))
> >  		return fmt;
> >  
> > +	if (iter->tr->trace_flags & TRACE_ITER_HASH_PTR)
> > +		return fmt;
> > +
> >  	p = fmt;
> >  	new_fmt = q = iter->fmt;
> >  	while (*p) {
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 524502d1f60a..c34187bd22a9 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -1347,6 +1347,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
> >  		C(MARKERS,		"markers"),		\
> >  		C(EVENT_FORK,		"event-fork"),		\
> >  		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
> > +		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
> >  		FUNCTION_FLAGS					\
> >  		FGRAPH_FLAGS					\
> >  		STACK_FLAGS					\
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
