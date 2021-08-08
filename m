Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C033E3AE0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 16:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhHHOnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 10:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhHHOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 10:43:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A5FF60560;
        Sun,  8 Aug 2021 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628433810;
        bh=hVGKMgsMy/zamnFEQCraJVSiNCfpKgxZd7kkoLlLgso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YkSsB7l1I1zpEs04HaYKgSyc8JoO9KK1XbRRJ9qto40bdy396h9LJgW6v2HI2ZQOQ
         x5hJxLsC/uQJbpzcO0q+df/5Xw/by/f8rSO+sSkhimmSXwRIfkcCAjZZD+1Wg3aEvI
         9EbppCPgVQkHODB7rQ4h7MNb2ZYi2NbnqhDNetuF0g0wE3SKQH7aihF+g3p8l8L+ZR
         If37NN8NE1zfaKKkKydDMA8M1wkamrzctsnBhCNTO+Xx4+FFtm4J7X09SIM7O5vYET
         lW5RS6v/gdDwx/SrWR62pc2HQSxdMZUL/MTEkKfCbqLsrn5i4XnA5Aa7d6N/6IKRaZ
         5QaLNJLj4IUww==
Date:   Sun, 8 Aug 2021 23:43:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 1/9] tracing/boot: Fix a hist trigger dependency for
 boot time tracing
Message-Id: <20210808234327.262621be9cc5fa66734f3f6b@kernel.org>
In-Reply-To: <20210806214710.015aa5d3@oasis.local.home>
References: <162818072104.226227.18088999222035270055.stgit@devnote2>
        <162818072887.226227.1489690774195740861.stgit@devnote2>
        <20210806214710.015aa5d3@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 21:47:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri,  6 Aug 2021 01:25:29 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fixes a build error when CONFIG_HIST_TRIGGERS=n with boot-time
> > tracing. Since the trigger_process_regex() is defined only
> > when CONFIG_HIST_TRIGGERS=y, if it is disabled, the 'actions'
> > event option also must be disabled.
> > 
> > Fixes: 81a59555ff15 ("tracing/boot: Add per-event settings")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  0 files changed
> > 
> > diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> > index 94ef2d099e32..e6dc9269ad75 100644
> > --- a/kernel/trace/trace_boot.c
> > +++ b/kernel/trace/trace_boot.c
> > @@ -204,13 +204,14 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
> >  		else if (apply_event_filter(file, buf) < 0)
> >  			pr_err("Failed to apply filter: %s\n", buf);
> >  	}
> > -
> > +#ifdef CONFIG_HIST_TRIGGERS
> 
> Hi Masamai,
> 
> Can we instead define trigger_process_regex() in trace.h to be:
> 
> static inline int trigger_process_regex(struct trace_event_file *file, char *buff)
> {
> 	return -1;
> }
> 
> When this config is not set?
> 
> This makes the code a bit cleaner, and you get the "Failed to apply an
> action" error as well.

Ah, OK.
But it seems that the error message should be changed a bit in that
case, because the actions string is correct, but the kernel
just doesn't support it. Moreover, it loops on the array, so, it will
show same error repeatedly.

I think it should be ignored, or just warn once with correct reason.
(for example, if the kernel supports hist-trigger, the error will
be shown in 'error_log' file.)

Thank you,


> 
> -- Steve
> 
> 
> 
> >  	xbc_node_for_each_array_value(enode, "actions", anode, p) {
> >  		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
> >  			pr_err("action string is too long: %s\n", p);
> >  		else if (trigger_process_regex(file, buf) < 0)
> >  			pr_err("Failed to apply an action: %s\n", buf);
> >  	}
> > +#endif
> >  
> >  	if (xbc_node_find_value(enode, "enable", NULL)) {
> >  		if (trace_event_enable_disable(file, 1, 0) < 0)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
