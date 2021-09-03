Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F7F3FF939
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 06:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhICEDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 00:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhICEDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:03:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F3960E77;
        Fri,  3 Sep 2021 04:02:48 +0000 (UTC)
Date:   Fri, 3 Sep 2021 00:02:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiang Jiasheng <jiasheng@iscas.ac.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: Add trace_trigger_soft_disabled() in front
 of trace_event_buffer_reserve() in trace_inject_entry()
Message-ID: <20210903000246.425731d5@oasis.local.home>
In-Reply-To: <1630639834-767471-1-git-send-email-jiasheng@iscas.ac.cn>
References: <1630639834-767471-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Sep 2021 03:30:34 +0000
Jiang Jiasheng <jiasheng@iscas.ac.cn> wrote:

> Directly use trace_event_buffer_reserve() might be unsafe,

How can it be unsafe?

> as we can see from the trace_trigger_soft_disabled() of
> 'include/linux/trace_events.h' that if the value of
> file->flags is 256, the check in the trace_trigger_soft_disabled()
> will be passed but actually shouldn't have.
> Therefore, we suggest that trace_trigger_soft_disabled()
> should be added in front of the trace_event_buffer_reserve()
> in trace_inject_entry().

Do you understand what the trace_inject_entry() does?

I'm not sure it makes sense to "soft disable" it.

> 
> Signed-off-by: Jiang Jiasheng <jiasheng@iscas.ac.cn>
> ---
>  kernel/trace/trace_events_inject.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
> index c188045..6dfd3cd 100644
> --- a/kernel/trace/trace_events_inject.c
> +++ b/kernel/trace/trace_events_inject.c
> @@ -21,6 +21,8 @@ trace_inject_entry(struct trace_event_file *file, void *rec, int len)
>  	void *entry;
>  
>  	rcu_read_lock_sched();
> +	if (trace_trigger_soft_disabled(file))
> +		return written;

NACK!

The above introduces a major bug. Bonus points if you can figure out
what that is yourself.

-- Steve

>  	entry = trace_event_buffer_reserve(&fbuffer, file, len);
>  	if (entry) {
>  		memcpy(entry, rec, len);

