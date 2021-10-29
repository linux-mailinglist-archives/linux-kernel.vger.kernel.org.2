Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF643FCFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhJ2NHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231823AbhJ2NGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3631460FC4;
        Fri, 29 Oct 2021 13:04:07 +0000 (UTC)
Date:   Fri, 29 Oct 2021 09:04:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] ftrace: Tidy up some false kernel-doc
 markings
Message-ID: <20211029090405.5e7f5c24@gandalf.local.home>
In-Reply-To: <1635489523-76132-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1635489523-76132-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 14:38:42 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> Deals with
> W=1 warning: This comment starts with '/**', but isn't a kernel-doc
> comment.
> W=1 warning: bad line.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

But are you a robot?

NACK!

-- Steve

> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/trace/ftrace.c            | 18 +++++++++---------
>  kernel/trace/trace_events_hist.c |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index feb1ea9..679db91 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2203,7 +2203,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
>  	return FTRACE_UPDATE_MAKE_NOP;
>  }
>  
> -/**
> +/*
>   * ftrace_update_record, set a record that now is tracing or not
>   * @rec: the record to update
>   * @enable: set to true if the record is tracing, false to force disable
> @@ -2216,7 +2216,7 @@ int ftrace_update_record(struct dyn_ftrace *rec, bool enable)
>  	return ftrace_check_record(rec, enable, true);
>  }
>  
> -/**
> +/*
>   * ftrace_test_record, check if the record has been enabled or not
>   * @rec: the record to test
>   * @enable: set to true to check if enabled, false if it is disabled
> @@ -2602,7 +2602,7 @@ struct ftrace_rec_iter {
>  	int			index;
>  };
>  
> -/**
> +/*
>   * ftrace_rec_iter_start, start up iterating over traced functions
>   *
>   * Returns an iterator handle that is used to iterate over all
> @@ -2633,7 +2633,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_start(void)
>  	return iter;
>  }
>  
> -/**
> +/*
>   * ftrace_rec_iter_next, get the next record to process.
>   * @iter: The handle to the iterator.
>   *
> @@ -2658,7 +2658,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_next(struct ftrace_rec_iter *iter)
>  	return iter;
>  }
>  
> -/**
> +/*
>   * ftrace_rec_iter_record, get the record at the iterator location
>   * @iter: The current iterator location
>   *
> @@ -2761,7 +2761,7 @@ static int __ftrace_modify_code(void *data)
>  	return 0;
>  }
>  
> -/**
> +/*
>   * ftrace_run_stop_machine, go back to the stop machine method
>   * @command: The command to tell ftrace what to do
>   *
> @@ -2773,7 +2773,7 @@ void ftrace_run_stop_machine(int command)
>  	stop_machine(__ftrace_modify_code, &command, NULL);
>  }
>  
> -/**
> +/*
>   * arch_ftrace_update_code, modify the code to trace or not trace
>   * @command: The command that needs to be done
>   *
> @@ -7742,7 +7742,7 @@ void ftrace_kill(void)
>  	ftrace_trace_function = ftrace_stub;
>  }
>  
> -/**
> +/*
>   * Test if ftrace is dead or not.
>   */
>  int ftrace_is_dead(void)
> @@ -7750,7 +7750,7 @@ int ftrace_is_dead(void)
>  	return ftrace_disabled;
>  }
>  
> -/**
> +/*
>   * register_ftrace_function - register a function for profiling
>   * @ops - ops structure that holds the function for profiling.
>   *
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index cddf6bf..aa93e87 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -836,7 +836,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
>   * A trigger can define one or more variables.  If any one of them is
>   * currently referenced by any other trigger, this function will
>   * determine that.
> -
> + *
>   * Typically used to determine whether or not a trigger can be removed
>   * - if there are any references to a trigger's variables, it cannot.
>   *
> @@ -3050,7 +3050,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
>   * events.  However, for convenience, users are allowed to directly
>   * specify an event field in an action, which will be automatically
>   * converted into a variable on their behalf.
> -
> + *
>   * This function creates a field variable with the name var_name on
>   * the hist trigger currently being defined on the target event.  If
>   * subsys_name and event_name are specified, this function simply

