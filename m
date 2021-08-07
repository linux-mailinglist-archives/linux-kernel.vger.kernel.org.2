Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCA3E329D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 03:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhHGBrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 21:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhHGBre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 21:47:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C041161186;
        Sat,  7 Aug 2021 01:47:17 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:47:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 1/9] tracing/boot: Fix a hist trigger dependency for
 boot time tracing
Message-ID: <20210806214710.015aa5d3@oasis.local.home>
In-Reply-To: <162818072887.226227.1489690774195740861.stgit@devnote2>
References: <162818072104.226227.18088999222035270055.stgit@devnote2>
        <162818072887.226227.1489690774195740861.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Aug 2021 01:25:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fixes a build error when CONFIG_HIST_TRIGGERS=n with boot-time
> tracing. Since the trigger_process_regex() is defined only
> when CONFIG_HIST_TRIGGERS=y, if it is disabled, the 'actions'
> event option also must be disabled.
> 
> Fixes: 81a59555ff15 ("tracing/boot: Add per-event settings")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  0 files changed
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 94ef2d099e32..e6dc9269ad75 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -204,13 +204,14 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  		else if (apply_event_filter(file, buf) < 0)
>  			pr_err("Failed to apply filter: %s\n", buf);
>  	}
> -
> +#ifdef CONFIG_HIST_TRIGGERS

Hi Masamai,

Can we instead define trigger_process_regex() in trace.h to be:

static inline int trigger_process_regex(struct trace_event_file *file, char *buff)
{
	return -1;
}

When this config is not set?

This makes the code a bit cleaner, and you get the "Failed to apply an
action" error as well.

-- Steve



>  	xbc_node_for_each_array_value(enode, "actions", anode, p) {
>  		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
>  			pr_err("action string is too long: %s\n", p);
>  		else if (trigger_process_regex(file, buf) < 0)
>  			pr_err("Failed to apply an action: %s\n", buf);
>  	}
> +#endif
>  
>  	if (xbc_node_find_value(enode, "enable", NULL)) {
>  		if (trace_event_enable_disable(file, 1, 0) < 0)

