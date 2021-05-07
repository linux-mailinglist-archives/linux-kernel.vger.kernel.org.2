Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB143765EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhEGNRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhEGNR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:17:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5AB61468;
        Fri,  7 May 2021 13:16:27 +0000 (UTC)
Date:   Fri, 7 May 2021 09:16:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove redundant assignment to event_var
Message-ID: <20210507091625.0bcccf43@gandalf.local.home>
In-Reply-To: <1620383030-70462-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1620383030-70462-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 May 2021 18:23:50 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Variable event_var is set to 'ERR_PTR(-EINVAL)', but this value
> is never read as it is overwritten or not used later on, hence
> it is a redundant assignment and can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> kernel/trace/trace_events_hist.c:2437:21: warning: Value stored to
> 'event_var' during its initialization is never read
> [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c1abd63..b37342c 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2434,7 +2434,7 @@ static struct trace_event_file *event_file(struct trace_array *tr,
>  		      char *subsys_name, char *event_name, char *field_name)
>  {
>  	struct trace_array *tr = target_hist_data->event_file->tr;
> -	struct hist_field *event_var = ERR_PTR(-EINVAL);
> +	struct hist_field *event_var;
>  	struct hist_trigger_data *hist_data;
>  	unsigned int i, n, first = true;
>  	struct field_var_hist *var_hist;

Thanks, but if you are going to make this change, please move the
declaration of event_var below (or above) key_field, as their names are
both the same size in length and are of the same type. This keeps the
"upside-down x-mas tree" look of the declarations.

-- Steve
