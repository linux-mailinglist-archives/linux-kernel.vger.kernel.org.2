Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB8424B96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 03:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJGBVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 21:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhJGBVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 21:21:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 033C660FE8;
        Thu,  7 Oct 2021 01:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633569594;
        bh=mAlcbkwLUu1GMNBclsHIHwCJroCIYt6S7isa3owuQmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ey8acv+oeE21F5mAwbUV1k9qrvuz/vx4jKjwHS6W6FNKAkentHTKqwtsTnh24Z7G8
         f53M+LIPHFZCp2f1fjUnsgv8HyynaPJB8z5aAPfGo5Os8hEcLbZrkIO+mSb6QaTTiW
         90TcFQhChrBcdYb4VIQoqEaVWiM8sRXkF32ErE0EKwskwhjstkdPIIXUNIl4ZwVRMr
         zKo7vVRblqpSZ8ML/8mq4ymFwXJOqi7C1LRHagSp0g/91MoCa4lKwuSiXhBvzdduLF
         KXnn85pck3Q6m2lbvvMaFT8B2lzMewWdlChMtZ6BtsynIrJjpzSlqZYelgJxVruiHI
         EAaQ1B//zrG2w==
Date:   Thu, 7 Oct 2021 10:19:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/synthetic_events: Fix use when created by
 dynamic_events file
Message-Id: <20211007101952.d9d282257b9c49fe699c0679@kernel.org>
In-Reply-To: <20211006115317.2cfcc742@gandalf.local.home>
References: <20211006115317.2cfcc742@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 11:53:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The dynamic_events file can create kprobe, uprobe, event probes as well as
> synthetic events. New dynamic events will also be created by this file.
> Each of these kinds of events register a "create" function, that gets
> called, and if the prefix does not match the type of event, the create
> function is to return -ECANCELED to tell the dynamic event code that the
> command does not belong to it, and other events should be tried.
> 
> The synthetic event does some format checking before it determines that it
> is the event that should be created, and if that format check does not
> match, it will return an error, telling the dynamic event code that it was
> the expected event to be created and that the input had an error. This
> returns an error code back to the user. But unfortunately, because it does
> the check before it determines that it is indeed the proper event to parse
> the input, it may fail the call even though the input is a proper syntax
> for another event type.
> 
> Have it confirm that the input is for the synthetic event before it
> returns an error due to parsing failure.
> 
> Fixes: c9e759b1e8456 ("tracing: Rework synthetic event command parsing")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_synth.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index d54094b7a9d7..feb87e5817e9 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -2045,11 +2045,17 @@ static int create_synth_event(const char *raw_command)
>  {
>  	char *fields, *p;
>  	const char *name;
> -	int len, ret = 0;
> +	int len, ret;
>  
>  	raw_command = skip_spaces(raw_command);
>  	if (raw_command[0] == '\0')
> -		return ret;
> +		return -ECANCELED;

Good catch! BTW, I thought trace_parse_run_command() skips such empty line.

Anyway,

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> +
> +	name = raw_command;
> +
> +	if (name[0] != 's' || name[1] != ':')
> +		return -ECANCELED;
> +	name += 2;
>  
>  	last_cmd_set(raw_command);
>  
> @@ -2061,12 +2067,6 @@ static int create_synth_event(const char *raw_command)
>  
>  	fields = skip_spaces(p);
>  
> -	name = raw_command;
> -
> -	if (name[0] != 's' || name[1] != ':')
> -		return -ECANCELED;
> -	name += 2;
> -
>  	/* This interface accepts group name prefix */
>  	if (strchr(name, '/')) {
>  		len = str_has_prefix(name, SYNTH_SYSTEM "/");
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
