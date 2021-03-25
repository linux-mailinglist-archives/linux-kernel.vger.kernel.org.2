Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405FD348620
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhCYA5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232856AbhCYA4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:56:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC54619F8;
        Thu, 25 Mar 2021 00:56:44 +0000 (UTC)
Date:   Wed, 24 Mar 2021 20:56:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Update create_system_filter() kernel-doc
 comment
Message-ID: <20210324205642.65e03248@oasis.local.home>
In-Reply-To: <20210320113916.22175-1-hqjagain@gmail.com>
References: <20210320113916.22175-1-hqjagain@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 11:39:16 +0000
Qiujun Huang <hqjagain@gmail.com> wrote:

> commit f306cc82a93d ("tracing: Update event filters for multibuffer")
> added the parameter @tr for create_system_filter().
> 
> commit bb9ef1cb7d86 ("tracing: Change apply_subsystem_event_filter() paths to
> check file->system == dir")
> changed the parameter from @system to @dir.
> 
> commit 1e144d73f729 ("tracing: Add trace_array parameter to
> create_event_filter()")
> added the parameter @tr for create_filter().
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  kernel/trace/trace_events_filter.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index e91259f6a722..00e78a012de9 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1693,6 +1693,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
>  
>  /**
>   * create_filter - create a filter for a trace_event_call
> + * @tr: the trace array associated with these events

This looks fine.

>   * @call: trace_event_call to create a filter for
>   * @filter_str: filter string
>   * @set_str: remember @filter_str and enable detailed error in filter
> @@ -1741,8 +1742,9 @@ int create_event_filter(struct trace_array *tr,
>  }
>  
>  /**
> - * create_system_filter - create a filter for an event_subsystem
> - * @system: event_subsystem to create a filter for
> + * create_system_filter - create a filter for an event_subsystem_dir

Do you know what a "event_subsystem_dir" is? I don't.

In fact, the original text makes much more sense. You could remove the
"_" and have it say "event subsystem".


> + * @dir: event_subsystem_dir to create a filter for

I have no idea what the above text even means. @dir is the descriptor
for the system directory.

> + * @tr: the trace array associated with these events
>   * @filter_str: filter string
>   * @filterp: out param for created filter (always updated on return)
>   *

Looking at the code I think it should have another clean up, as where
both @dir and @tr as passed it, it should just pass in @dir, because
@tr is simply @dir->tr.

-- Steve
