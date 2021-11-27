Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D34601B9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 22:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356272AbhK0Vqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 16:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356268AbhK0Vol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 16:44:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C057C061574
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 13:41:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F20A60EC8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 21:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31144C53FBF;
        Sat, 27 Nov 2021 21:41:24 +0000 (UTC)
Date:   Sat, 27 Nov 2021 16:41:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [GIT PULL] tracing: Two event pid filtering bug fixes
Message-ID: <20211127164120.1eb79c1a@oasis.local.home>
In-Reply-To: <20211127132822.5d4d2a8b@gandalf.local.home>
References: <20211127132822.5d4d2a8b@gandalf.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021 13:28:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +	struct trace_pid_list *no_pid_list;
> +	struct trace_pid_list *pid_list;
>  	struct trace_event_file *file;
> +	unsigned int first;
>  
>  	file = kmem_cache_alloc(file_cachep, GFP_TRACE);
>  	if (!file)
>  		return NULL;
>  
> +	pid_list = rcu_dereference_protected(tr->filtered_pids,
> +					     lockdep_is_held(&event_mutex));
> +	no_pid_list = rcu_dereference_protected(tr->filtered_no_pids,
> +					     lockdep_is_held(&event_mutex));
> +
> +	if (!trace_pid_list_first(pid_list, &first) ||
> +	    !trace_pid_list_first(pid_list, &first))
> +		file->flags |= EVENT_FILE_FL_PID_FILTER;

And of course since I only tested "trace only this pid" case, and not
the "trace everything but this pid" case, the above has a bug (which
the ktest bot just told me about), and my tests missed it.

That should have been:

	if (!trace_pid_list_first(pid_list, &first) ||
	    !trace_pid_list_first(no_pid_list, &first))

I'll fix it, run it through my tests, and post another pull request :-/.

/me needs to add that case to his tests, even though it's extremely
rare (I never use it). Which is exactly why I should have a test for it!

-- Steve
