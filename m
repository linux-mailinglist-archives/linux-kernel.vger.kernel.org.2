Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FF443201B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhJROpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhJROpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:45:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0630261074;
        Mon, 18 Oct 2021 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634568170;
        bh=b0WcO9MLJWpHZ4FmInErqJ+VF0uqpa3q8Gmuc8BEwqg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vMKSptpSWm3jG2Jbu4Mu98RM+UEjrg/gy5ej5svl6D1WBsABkJ1D+9sXvQH8Yfyy3
         Ys722y3ig5Z1mD7v/LsbJ78lpQSycqQuwcYDaaleVFGAd1GS3PYuaScpq0el5IV195
         nIMmTPaKenbFEEW7LElg2e/5trw0CO/U/j092mg7RQV0E0Rx8yiTUDJeZD946YSfPJ
         6K6x75XhYZkfv7ofpS9CjlNg7eYWBcFsOm8PlvSxEwaQ1+s1y35BFDJvgVMSWavHND
         GvCONDYtW7fA4Tc+VcmgQGjHnoJFAQpJJZndEaK31nrIpSkxHl20TupqjQ96PtHpB6
         zN7T3vgX5z5KA==
Message-ID: <d4ad897585ddc815c188bbf0b3b8cec1cb40b7a4.camel@kernel.org>
Subject: Re: [PATCH] [v2] tracing: use %ps format string to print symbols
From:   Tom Zanussi <zanussi@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Qiujun Huang <hqjagain@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Mon, 18 Oct 2021 09:42:47 -0500
In-Reply-To: <20211018132538.2468989-1-arnd@kernel.org>
References: <20211018132538.2468989-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 2021-10-18 at 15:25 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang started warning about excessive stack usage in
> hist_trigger_print_key()
> 
> kernel/trace/trace_events_hist.c:4723:13: error: stack frame size
> (1336) exceeds limit (1024) in function 'hist_trigger_print_key' [-
> Werror,-Wframe-larger-than]
> 
> The problem is that there are two 512-byte arrays on the stack if
> hist_trigger_stacktrace_print() gets inlined. I don't think this has
> changed in the past five years, but something probably changed the
> inlining decisions made by the compiler, so the problem is now made
> more obvious.
> 
> Rather than printing the symbol names into separate buffers, it
> seems we can simply use the special %ps format string modifier
> to print the pointers symbolically and get rid of both buffers.
> 
> Marking hist_trigger_stacktrace_print() would be a simpler
> way of avoiding the warning, but that would not address the
> excessive stack usage.
> 
> Fixes: 69a0200c2e25 ("tracing: Add hist trigger support for
> stacktraces as keys")
> Link: 
> https://lore.kernel.org/all/20211015095704.49a99859@gandalf.local.home/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes in v2:
>  - Use %pS instead of %ps to include offset in third string
>  - add (void*) cast to avoid compile-time warnings
> 
> This is still only compile-tested to ensure that the warning
> goes away, I have not validated what it does to the formatting.


This looks fine to me, thanks for the patch!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>


> ---
>  kernel/trace/trace_events_hist.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index a6061a69aa84..d6d4362c273c 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4706,7 +4706,6 @@ static void
> hist_trigger_stacktrace_print(struct seq_file *m,
>  					  unsigned long
> *stacktrace_entries,
>  					  unsigned int max_entries)
>  {
> -	char str[KSYM_SYMBOL_LEN];
>  	unsigned int spaces = 8;
>  	unsigned int i;
>  
> @@ -4715,8 +4714,7 @@ static void
> hist_trigger_stacktrace_print(struct seq_file *m,
>  			return;
>  
>  		seq_printf(m, "%*c", 1 + spaces, ' ');
> -		sprint_symbol(str, stacktrace_entries[i]);
> -		seq_printf(m, "%s\n", str);
> +		seq_printf(m, "%pS\n", (void*)stacktrace_entries[i]);
>  	}
>  }
>  
> @@ -4726,7 +4724,6 @@ static void hist_trigger_print_key(struct
> seq_file *m,
>  				   struct tracing_map_elt *elt)
>  {
>  	struct hist_field *key_field;
> -	char str[KSYM_SYMBOL_LEN];
>  	bool multiline = false;
>  	const char *field_name;
>  	unsigned int i;
> @@ -4747,14 +4744,12 @@ static void hist_trigger_print_key(struct
> seq_file *m,
>  			seq_printf(m, "%s: %llx", field_name, uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM) {
>  			uval = *(u64 *)(key + key_field->offset);
> -			sprint_symbol_no_offset(str, uval);
> -			seq_printf(m, "%s: [%llx] %-45s", field_name,
> -				   uval, str);
> +			seq_printf(m, "%s: [%llx] %-45ps", field_name,
> +				   uval, (void *)uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET)
> {
>  			uval = *(u64 *)(key + key_field->offset);
> -			sprint_symbol(str, uval);
> -			seq_printf(m, "%s: [%llx] %-55s", field_name,
> -				   uval, str);
> +			seq_printf(m, "%s: [%llx] %-55pS", field_name,
> +				   uval, (void *)uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
>  			struct hist_elt_data *elt_data = elt-
> >private_data;
>  			char *comm;

