Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69E44FC84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 01:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhKOAIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 19:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhKOAHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 19:07:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B77E610F9;
        Mon, 15 Nov 2021 00:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636934688;
        bh=kGHwEfh+iU8ekhO1/iNjWkJAAb8UHw4s0jmhe2JdyUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mh61UXpvLJFxx9MPj3ZOb1HzFlcYTjW8QUbdqHKltuhXP7aRGHiXdlY285yUNEkVc
         Sk7mnzCqFiA8yyR1I6Lv5ZmbzmoDPIK3vmybzPV6iFAHY7JubPRbbBHh2qNwzrfjzW
         BnQrg9Xt6zAs9Mf7XZ8vSn64T68d6YDL8cHW1/9RdTzeRmNvHOygeho2rVv2Doi0IZ
         Ar7ggnJFTCfapiTScLZ9wQzZlk2O0q/jaAAHNOqCOVvYXunOnCb37sxDKVqxgpzxvg
         g9VFHVsNrCwuYgsbg56HpR57fQY61a8p2Yb3wVz/21mKUCLz3VIJwi+CnE5QrmDStX
         Ndb0dw/ANanuA==
Date:   Mon, 15 Nov 2021 09:04:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing: Add length protection to histogram string
 copies
Message-Id: <20211115090444.3e76b1e3a654d400e8bd9d5c@kernel.org>
In-Reply-To: <20211114132834.183429a4@rorschach.local.home>
References: <20211114132834.183429a4@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2021 13:28:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The string copies to the histogram storage has a max size of 256 bytes
> (defined by MAX_FILTER_STR_VAL). Only the string size of the event field
> needs to be copied to the event storage, but no more than what is in the
> event storage. Although nothing should be bigger than 256 bytes, there's
> no protection against overwriting of the storage if one day there is.
> 
> Copy no more than the destination size, and enforce it.
> 
> Also had to turn MAX_FILTER_STR_VAL into an unsigned int, to keep the
> min() comparison of the string sizes of comparable types.
> 
> Link: https://lore.kernel.org/all/CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com/
> 

Oops, right. The field size can be defined over the
MAX_FILTER_STR_VAL. This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>


> Cc: Tom Zanussi <zanussi@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 63f84ae6b82b ("tracing/histogram: Do not copy the fixed-size char array field over the field size")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/trace_events.h     | 2 +-
>  kernel/trace/trace_events_hist.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 50453b287615..2d167ac3452c 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -673,7 +673,7 @@ struct trace_event_file {
>  
>  #define PERF_MAX_TRACE_SIZE	8192
>  
> -#define MAX_FILTER_STR_VAL	256	/* Should handle KSYM_SYMBOL_LEN */
> +#define MAX_FILTER_STR_VAL	256U	/* Should handle KSYM_SYMBOL_LEN */
>  
>  enum event_trigger_type {
>  	ETT_NONE		= (0),
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 1475d7347fe0..34afcaebd0e5 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3026,8 +3026,10 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
>  		if (val->flags & HIST_FIELD_FL_STRING) {
>  			char *str = elt_data->field_var_str[j++];
>  			char *val_str = (char *)(uintptr_t)var_val;
> +			unsigned int size;
>  
> -			strscpy(str, val_str, val->size);
> +			size = min(val->size, STR_VAR_LEN_MAX);
> +			strscpy(str, val_str, size);
>  			var_val = (u64)(uintptr_t)str;
>  		}
>  		tracing_map_set_var(elt, var_idx, var_val);
> @@ -4914,6 +4916,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
>  			if (hist_field->flags & HIST_FIELD_FL_STRING) {
>  				unsigned int str_start, var_str_idx, idx;
>  				char *str, *val_str;
> +				unsigned int size;
>  
>  				str_start = hist_data->n_field_var_str +
>  					hist_data->n_save_var_str;
> @@ -4922,7 +4925,9 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
>  
>  				str = elt_data->field_var_str[idx];
>  				val_str = (char *)(uintptr_t)hist_val;
> -				strscpy(str, val_str, hist_field->size);
> +
> +				size = min(hist_field->size, STR_VAR_LEN_MAX);
> +				strscpy(str, val_str, size);
>  
>  				hist_val = (u64)(uintptr_t)str;
>  			}
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
