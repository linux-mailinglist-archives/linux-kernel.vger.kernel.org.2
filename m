Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA93E93BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhHKOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232298AbhHKOfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:35:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F227604AC;
        Wed, 11 Aug 2021 14:35:24 +0000 (UTC)
Date:   Wed, 11 Aug 2021 10:35:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing / histogram: Fix NULL pointer dereference on
 strcmp() on NULL event name
Message-ID: <20210811103522.0cac5f1a@oasis.local.home>
In-Reply-To: <20210808003011.4037f8d0@oasis.local.home>
References: <20210808003011.4037f8d0@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2021 00:30:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 949ef09dc537..a48aa2a2875b 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3430,6 +3430,8 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
>  			event = data->match_data.event;
>  		}
>  
> +		if (!event)
> +			goto free;
>  		/*
>  		 * At this point, we're looking at a field on another
>  		 * event.  Because we can't modify a hist trigger on
> -- 

Tom,

Is this OK? I'm going to start running this through my tests and when
it's done, I'm going to send it off to Linus.

-- Steve
