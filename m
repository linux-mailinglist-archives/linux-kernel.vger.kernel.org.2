Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143813F0212
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhHRK5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234748AbhHRK5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B6E960FBF;
        Wed, 18 Aug 2021 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629284233;
        bh=PNfci8wqXXfyvt5HEVXeoi84eP/5uRnbl3BCEVOedCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AG+3mdgzAWdBNZk3Lh2+8lQMgsajrP5NGbpDT46Y1xgu6DLxG4s0WX68TnFcvZL8d
         TV6LkuB6wYwUXxGxFw/bCPkYWmz7mSbOPe99zalmMpdaAFyvjyNEpJGoBy8uDIqpHZ
         ulEN1JgP+9tCYGI6EzGR/C7TYt63IdJ8KACoP/ITuH9nZnFn+/owPs8y1CW6nrXmFU
         zPOiFJrXzCx1ks50bG5qs9y+PDxll+qudQACgljhTMGw/O/f+tyOJ1E9XNWCVMMq7c
         2eNnf2ieckMZV1gPK9GGVI1uftE1g6BQ03QUijUh0yuG+tVtLWDMqok6HKJIQKXkxp
         wQMcTP8peQdsQ==
Date:   Wed, 18 Aug 2021 19:57:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] tracing/probes: Allow for dot delimiter as well
 as slash for system names
Message-Id: <20210818195709.0536722822090f737664d1d6@kernel.org>
In-Reply-To: <20210817035027.580493202@goodmis.org>
References: <20210817034255.421910614@goodmis.org>
        <20210817035027.580493202@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 23:42:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Kprobe and uprobe events can add a "system" to the events that are created
> via the kprobe_events and uprobe_events files respectively. If they do not
> include a "system" in the name, then the default "kprobes" or "uprobes" is
> used. The current notation to specify a system for one of these probe
> events is to add a '/' delimiter in the name, where the content before the
> '/' will be the system to use, and the content after will be the event
> name.
> 
>  echo 'p:my_system/my_event' > kprobe_events
> 
> But this is inconsistent with the way histogram triggers separate their
> system / event names. The histogram triggers use a '.' delimiter, which
> can be confusing.
> 
> To allow this to be more consistent, as well as keep backward
> compatibility, allow the kprobe and uprobe events to denote a system name
> with either a '/' or a '.'.
> 
> That is:
> 
>   echo 'p:my_system/my_event' > kprobe_events
> 
> is equivalent to:
> 
>   echo 'p:my_system.my_event' > kprobe_events
> 
> Link: https://lore.kernel.org/linux-trace-devel/20210813004448.51c7de69ce432d338f4d226b@kernel.org/
> 

Yes, this is what I suggested :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!


> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index ef717b373443..0916a9964719 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -233,6 +233,9 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  	int len;
>  
>  	slash = strchr(event, '/');
> +	if (!slash)
> +		slash = strchr(event, '.');
> +
>  	if (slash) {
>  		if (slash == event) {
>  			trace_probe_log_err(offset, NO_GROUP_NAME);
> -- 
> 2.30.2


-- 
Masami Hiramatsu <mhiramat@kernel.org>
