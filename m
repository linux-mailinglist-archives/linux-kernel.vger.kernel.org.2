Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CBB45EE42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377698AbhKZMqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhKZMoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:44:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E29860E97;
        Fri, 26 Nov 2021 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637930460;
        bh=PtLFYszo+ndVAvYga2gEvJrizrI+bv8lmcpdPwOpDLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h+ATzUBxuvTjw8Q3nJ8qXTp9fhU7+bGemYx0AyqV8BEa7E003tEqzRlNZa3UFE1qM
         tI6/zsY4dW4udKXwezz4eTBMs26nNeLO56p5w5Bp5edIqLpZqX3MndWvWK+0dXMMVi
         bL6qd+OhfdseAgU60iYsuJ19oTP9DyfpVYZhHSWtEpjdsIn1QcYH18iBz69aUF1pJx
         O4alsITA5oHuoQqfiyV7avXdjKcMK2zIFLBY2Pu7aidWkQEWukdnS5tcvtdvPKZaFR
         vUpsAVXFhq1MHxFJmHoa5d2P850uE1mTpW+eGdGJ5l0VecqssiXyct2YYe5ObtpqOE
         URovcWxFH9cuw==
Date:   Fri, 26 Nov 2021 21:40:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tracing: Iterate trace_[ku]probe objects directly
Message-Id: <20211126214055.b6a84e8add8f7ae3deb9411b@kernel.org>
In-Reply-To: <20211125202852.406405-1-jolsa@kernel.org>
References: <20211125202852.406405-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 21:28:52 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> As suggested by Linus [1] using list_for_each_entry to iterate
> directly trace_[ku]probe objects so we can skip another call to
> container_of in these loops.
> 

This looks very good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> [1] https://lore.kernel.org/r/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c | 13 ++++---------
>  kernel/trace/trace_uprobe.c | 23 ++++++++---------------
>  2 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 33272a7b6912..1cddb42af20c 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -327,11 +327,9 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
>  
>  static void __disable_trace_kprobe(struct trace_probe *tp)
>  {
> -	struct trace_probe *pos;
>  	struct trace_kprobe *tk;
>  
> -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -		tk = container_of(pos, struct trace_kprobe, tp);
> +	list_for_each_entry(tk, trace_probe_probe_list(tp), tp.list) {
>  		if (!trace_kprobe_is_registered(tk))
>  			continue;
>  		if (trace_kprobe_is_return(tk))
> @@ -348,7 +346,7 @@ static void __disable_trace_kprobe(struct trace_probe *tp)
>  static int enable_trace_kprobe(struct trace_event_call *call,
>  				struct trace_event_file *file)
>  {
> -	struct trace_probe *pos, *tp;
> +	struct trace_probe *tp;
>  	struct trace_kprobe *tk;
>  	bool enabled;
>  	int ret = 0;
> @@ -369,8 +367,7 @@ static int enable_trace_kprobe(struct trace_event_call *call,
>  	if (enabled)
>  		return 0;
>  
> -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -		tk = container_of(pos, struct trace_kprobe, tp);
> +	list_for_each_entry(tk, trace_probe_probe_list(tp), tp.list) {
>  		if (trace_kprobe_has_gone(tk))
>  			continue;
>  		ret = __enable_trace_kprobe(tk);
> @@ -559,11 +556,9 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
>  					 struct trace_kprobe *comp)
>  {
>  	struct trace_probe_event *tpe = orig->tp.event;
> -	struct trace_probe *pos;
>  	int i;
>  
> -	list_for_each_entry(pos, &tpe->probes, list) {
> -		orig = container_of(pos, struct trace_kprobe, tp);
> +	list_for_each_entry(orig, &tpe->probes, tp.list) {
>  		if (strcmp(trace_kprobe_symbol(orig),
>  			   trace_kprobe_symbol(comp)) ||
>  		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index f5f0039d31e5..a9a294e6b183 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -409,12 +409,10 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
>  					 struct trace_uprobe *comp)
>  {
>  	struct trace_probe_event *tpe = orig->tp.event;
> -	struct trace_probe *pos;
>  	struct inode *comp_inode = d_real_inode(comp->path.dentry);
>  	int i;
>  
> -	list_for_each_entry(pos, &tpe->probes, list) {
> -		orig = container_of(pos, struct trace_uprobe, tp);
> +	list_for_each_entry(orig, &tpe->probes, tp.list) {
>  		if (comp_inode != d_real_inode(orig->path.dentry) ||
>  		    comp->offset != orig->offset)
>  			continue;
> @@ -1075,14 +1073,12 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
>  
>  static void __probe_event_disable(struct trace_probe *tp)
>  {
> -	struct trace_probe *pos;
>  	struct trace_uprobe *tu;
>  
>  	tu = container_of(tp, struct trace_uprobe, tp);
>  	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
>  
> -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -		tu = container_of(pos, struct trace_uprobe, tp);
> +	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
>  		if (!tu->inode)
>  			continue;
>  
> @@ -1094,7 +1090,7 @@ static void __probe_event_disable(struct trace_probe *tp)
>  static int probe_event_enable(struct trace_event_call *call,
>  			struct trace_event_file *file, filter_func_t filter)
>  {
> -	struct trace_probe *pos, *tp;
> +	struct trace_probe *tp;
>  	struct trace_uprobe *tu;
>  	bool enabled;
>  	int ret;
> @@ -1129,8 +1125,7 @@ static int probe_event_enable(struct trace_event_call *call,
>  	if (ret)
>  		goto err_flags;
>  
> -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -		tu = container_of(pos, struct trace_uprobe, tp);
> +	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
>  		ret = trace_uprobe_enable(tu, filter);
>  		if (ret) {
>  			__probe_event_disable(tp);
> @@ -1275,7 +1270,7 @@ static bool trace_uprobe_filter_add(struct trace_uprobe_filter *filter,
>  static int uprobe_perf_close(struct trace_event_call *call,
>  			     struct perf_event *event)
>  {
> -	struct trace_probe *pos, *tp;
> +	struct trace_probe *tp;
>  	struct trace_uprobe *tu;
>  	int ret = 0;
>  
> @@ -1287,8 +1282,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
>  	if (trace_uprobe_filter_remove(tu->tp.event->filter, event))
>  		return 0;
>  
> -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -		tu = container_of(pos, struct trace_uprobe, tp);
> +	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
>  		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
>  		if (ret)
>  			break;
> @@ -1300,7 +1294,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
>  static int uprobe_perf_open(struct trace_event_call *call,
>  			    struct perf_event *event)
>  {
> -	struct trace_probe *pos, *tp;
> +	struct trace_probe *tp;
>  	struct trace_uprobe *tu;
>  	int err = 0;
>  
> @@ -1312,8 +1306,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
>  	if (trace_uprobe_filter_add(tu->tp.event->filter, event))
>  		return 0;
>  
> -	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> -		tu = container_of(pos, struct trace_uprobe, tp);
> +	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
>  		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
>  		if (err) {
>  			uprobe_perf_close(call, event);
> -- 
> 2.33.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
