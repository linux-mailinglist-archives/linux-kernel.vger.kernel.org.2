Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250BF42A737
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhJLOdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237299AbhJLOdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:33:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE8186109E;
        Tue, 12 Oct 2021 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634049070;
        bh=njzTc3xqmkP7t9RJnxc+gu8i4Cm7MWiWADSxg9Kw7tg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kaIZ952nJrulRT853/2b4BfKnsyV7Y1vw4hDwFsg+EeDS6fxS44ottY5CRU6ZnF8Y
         3KThAS7KnOS4ZYFdiFCVT5nuSllIpeVlLaaOI8rlZ0EKaxbZw1BtLLj6ttMau5harB
         e4UQnAGUJ5Jk0NHrPzFKoI38heZRLAl7xuoILCuA4dMoPQdOYbNaw3FVtbjvNSnDQE
         oW//u/WkUnM+LSJrxlOcYRGOb1o+Z2CPbjUQLIVQ3VPGBRAjbd3q1fdQOu8iXiF5PD
         cfXGxsdo/JwLaN/qvprSgKnwabLfOgM6fXaBSXpzlPw2W11qKgNtUxktgHH0nVY//I
         prnGijcD1iOSQ==
Date:   Tue, 12 Oct 2021 23:31:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-Id: <20211012233107.671725f6ec0316b3d0a9dd85@kernel.org>
In-Reply-To: <20211012081925.0e19cc4f@gandalf.local.home>
References: <20211012081925.0e19cc4f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 08:19:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> When an event probe is to be removed via the API to remove dynamic events,
> an -EBUSY error is returned.
> 
> This is because the removal of the event probe does not expect to see the
> event system and name that the event probe is attached to, even though
> that's part of the API to create it. As the removal of probes is to use
> the same API as they are created, fix it by first testing if the first
> parameter of the event probe to be removed matches the system and event
> that the probe is attached to, and then adjust the argc and argv of the
> parameters to match the rest of the syntax.

Hmm, this seems something wrong. Via dynamic_events interface, all the
events must be parsed equaly. If you have to pass the attached "system/event"
that's something wrong. The dynamic_events interface will accept 

-:[GROUP/]EVENT [optional arguments]

Or

!e:[GROUP/]EVENT [optional arguments]

What did you expect other that these syntax?

Thank you,

> 
> Link: https://lkml.kernel.org/r/20211011211105.48b6a5fd@oasis.local.home
> 
> Fixes: 7491e2c442781 ("tracing: Add a probe that attaches to trace events")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Changes since v1:
>    - amended the commit with the definition of "slash"
> 
>  kernel/trace/trace_eprobe.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 570d081929fb..2bcfa8da5cef 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -119,6 +119,26 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
>  			int argc, const char **argv, struct dyn_event *ev)
>  {
>  	struct trace_eprobe *ep = to_trace_eprobe(ev);
> +	const char *slash;
> +
> +	/* First argument is the system/event the probe is attached to */
> +
> +	if (argc < 1)
> +		return false;
> +
> +	slash = strchr(argv[0], '/');
> +	if (!slash)
> +		slash = strchr(argv[0], '.');
> +	if (!slash)
> +		return false;
> +
> +	if (strncmp(ep->event_system, argv[0], slash - argv[0]))
> +		return false;
> +	if (strcmp(ep->event_name, slash + 1))
> +		return false;
> +
> +	argc--;
> +	argv++;
>  
>  	return strcmp(trace_probe_name(&ep->tp), event) == 0 &&
>  	    (!system || strcmp(trace_probe_group_name(&ep->tp), system) == 0) &&
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
