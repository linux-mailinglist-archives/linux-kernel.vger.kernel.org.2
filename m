Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6E53949EF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 04:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhE2CYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 22:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhE2CYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 22:24:35 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9267E613F5;
        Sat, 29 May 2021 02:22:59 +0000 (UTC)
Date:   Fri, 28 May 2021 22:22:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Remove redundant variable ret
Message-ID: <20210528222257.7c5cb8b9@oasis.local.home>
In-Reply-To: <20210527171449.GA145584@hyeyoo>
References: <20210527171449.GA145584@hyeyoo>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 02:14:49 +0900
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> This variable saves return value of event_hist_trigger_func,
> but it's never read. So it's redundant.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  kernel/trace/trace_events_hist.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c1abd63f1d6c..414f2727d7a7 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5225,12 +5225,11 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
>  	struct trace_event_file *file;
>  	unsigned int i;
>  	char *cmd;
> -	int ret;
>  
>  	for (i = 0; i < hist_data->n_field_var_hists; i++) {
>  		file = hist_data->field_var_hists[i]->hist_data->event_file;
>  		cmd = hist_data->field_var_hists[i]->cmd;
> -		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
> +		event_hist_trigger_func(&trigger_hist_cmd, file,
>  					      "!hist", "hist", cmd);

I wonder if instead we should add:

		WARN_ON_ONCE(ret < 0);

-- Steve

>  	}
>  }

