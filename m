Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C842F480
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbhJON7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236490AbhJON7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:59:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 090C56115C;
        Fri, 15 Oct 2021 13:57:09 +0000 (UTC)
Date:   Fri, 15 Oct 2021 09:57:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tracing: use %ps format string to print symbols
Message-ID: <20211015095704.49a99859@gandalf.local.home>
In-Reply-To: <20211015083447.760448-1-arnd@kernel.org>
References: <20211015083447.760448-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 10:34:31 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang started warning about excessive stack usage in
> hist_trigger_print_key()
> 
> kernel/trace/trace_events_hist.c:4723:13: error: stack frame size (1336) exceeds limit (1024) in function 'hist_trigger_print_key' [-Werror,-Wframe-larger-than]
> 
> The problem is that there are two 512-byte arrays on the stack if
> hist_trigger_stacktrace_print() gets inlined. I don't think this has
> changed in the past five years, but something probably changed the
> inlining decisions made by the compiler, so the problem is now made
> more obvious.

Could we just add "noinline" attribute to that function?

> 
> Rather than printing the symbol names into separate buffers, it
> seems we can simply use the special %ps format string modifier
> to print the pointers symbolically and get rid of both buffers.
> 
> Fixes: 69a0200c2e25 ("tracing: Add hist trigger support for stacktraces as keys")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm not sure if the %ps format string actually works as intended
> with the explicit length modifier, it would be good if someone
> could try this out before applying. Would it be ok to remove the
> length modifier otherwise?

I believe that shows a "table" format. So the length modifier is required.

> ---
>  kernel/trace/trace_events_hist.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index a6061a69aa84..640c79898b51 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4706,7 +4706,6 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  					  unsigned long *stacktrace_entries,
>  					  unsigned int max_entries)
>  {
> -	char str[KSYM_SYMBOL_LEN];
>  	unsigned int spaces = 8;
>  	unsigned int i;
>  
> @@ -4715,8 +4714,7 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  			return;
>  
>  		seq_printf(m, "%*c", 1 + spaces, ' ');
> -		sprint_symbol(str, stacktrace_entries[i]);
> -		seq_printf(m, "%s\n", str);
> +		seq_printf(m, "%pS\n", stacktrace_entries[i]);
>  	}
>  }
>  
> @@ -4726,7 +4724,6 @@ static void hist_trigger_print_key(struct seq_file *m,
>  				   struct tracing_map_elt *elt)
>  {
>  	struct hist_field *key_field;
> -	char str[KSYM_SYMBOL_LEN];
>  	bool multiline = false;
>  	const char *field_name;
>  	unsigned int i;
> @@ -4747,14 +4744,12 @@ static void hist_trigger_print_key(struct seq_file *m,
>  			seq_printf(m, "%s: %llx", field_name, uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM) {
>  			uval = *(u64 *)(key + key_field->offset);
> -			sprint_symbol_no_offset(str, uval);
> -			seq_printf(m, "%s: [%llx] %-45s", field_name,
> -				   uval, str);
> +			seq_printf(m, "%s: [%llx] %-45ps", field_name,
> +				   uval, (void *)uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
>  			uval = *(u64 *)(key + key_field->offset);
> -			sprint_symbol(str, uval);
> -			seq_printf(m, "%s: [%llx] %-55s", field_name,
> -				   uval, str);
> +			seq_printf(m, "%s: [%llx] %-55ps", field_name,
> +				   uval, (void *)uval);

The above requires "Ps" not "ps".

But other than that, I could test if this doesn't change the formatting and
functionality at all.

-- Steve


>  		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
>  			struct hist_elt_data *elt_data = elt->private_data;
>  			char *comm;

