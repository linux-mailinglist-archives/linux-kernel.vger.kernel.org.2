Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D860545513A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbhKQXom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241656AbhKQXok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:44:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 780F461B3B;
        Wed, 17 Nov 2021 23:41:40 +0000 (UTC)
Date:   Wed, 17 Nov 2021 18:41:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@openvz.org
Subject: Re: [PATCH] tracing: fix va_list breakage in trace_check_vprintf()
Message-ID: <20211117184138.3bc7156e@gandalf.local.home>
In-Reply-To: <20211117183827.4989cfab@gandalf.local.home>
References: <20211117183720.15573-1-nikita.yushchenko@virtuozzo.com>
        <20211117183827.4989cfab@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 18:38:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> The real fix is:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f9139dc1262c..7aa5ea5ca912 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3654,6 +3654,10 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str)
>  	struct trace_event *trace_event;
>  	struct trace_event_call *event;
>  
> +	/* if seq is full, then we can't test it */
> +	if (iter->seq->full)
> +		return true;
> +
>  	/* OK if part of the event data */
>  	if ((addr >= (unsigned long)iter->ent) &&
>  	    (addr < (unsigned long)iter->ent + iter->ent_size))

BTW, feel free to respin the patch and send a v2 and just add:

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
