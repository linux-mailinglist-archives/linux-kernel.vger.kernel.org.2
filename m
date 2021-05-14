Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C7D380B85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhENOS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234505AbhENORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:17:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F3AF61404;
        Fri, 14 May 2021 14:16:11 +0000 (UTC)
Date:   Fri, 14 May 2021 10:16:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@godmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] tracing: events_hist: avoid using excessive stack space
Message-ID: <20210514101610.4392adbc@gandalf.local.home>
In-Reply-To: <20210514140429.3334181-1-arnd@kernel.org>
References: <20210514140429.3334181-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 16:04:25 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some configurations, clang produces a warning about an overly large
> amount of stack space used in hist_trigger_print_key():
> 
> kernel/trace/trace_events_hist.c:4594:13: error: stack frame size of 1248 bytes in function 'hist_trigger_print_key' [-Werror,-Wframe-larger-than=]
> static void hist_trigger_print_key(struct seq_file *m,
> 
> Moving the 'str' variable into a more local scope in the two places
> where it gets used actually reduces the the used stack space here
> and gets it below the warning limit, because the compiler can now
> assume that it is safe to use the same stack slot that it has for
> the stack of any inline function.

Thanks Arnd for the nice explanation of the rationale for this change.

But I still find it too subtle to my liking that we need to move the
declaration like this (and duplicate it twice) for internal behavior of the
compiler (where it can't figure out itself by the use cases if it can
optimize the stack).

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/trace/trace_events_hist.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c1abd63f1d6c..e3fe84f017a8 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4597,7 +4597,6 @@ static void hist_trigger_print_key(struct seq_file *m,
>  				   struct tracing_map_elt *elt)
>  {
>  	struct hist_field *key_field;
> -	char str[KSYM_SYMBOL_LEN];

Instead, I think we should just make str static, as this should only be
called under the event_mutex. To be sure, we can also add:

	/* To protect the static str variable */
	lockdep_assert_held(&event_mutex);

-- Steve

>  	bool multiline = false;
>  	const char *field_name;
>  	unsigned int i;
> @@ -4617,11 +4616,13 @@ static void hist_trigger_print_key(struct seq_file *m,
>  			uval = *(u64 *)(key + key_field->offset);
>  			seq_printf(m, "%s: %llx", field_name, uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM) {
> +			char str[KSYM_SYMBOL_LEN];
>  			uval = *(u64 *)(key + key_field->offset);
>  			sprint_symbol_no_offset(str, uval);
>  			seq_printf(m, "%s: [%llx] %-45s", field_name,
>  				   uval, str);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
> +			char str[KSYM_SYMBOL_LEN];
>  			uval = *(u64 *)(key + key_field->offset);
>  			sprint_symbol(str, uval);
>  			seq_printf(m, "%s: [%llx] %-55s", field_name,

