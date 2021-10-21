Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC34357D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJUAh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUAh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:37:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE452611C7;
        Thu, 21 Oct 2021 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634776543;
        bh=JjulVnKnfcyhqm1AclzaWAJN0iixWK5fGL0ZDEIvt8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M7mkuIIvuPPIqL3/k2zwOnJKP8jHxqbKYGrAHR3ao70UE3VbTA9nYo3aY70QpUbUh
         qO5ntbszsD9dKapJ4qZpVD3V0XAFPFyCBZjF+AV0SueZ9jS19zGAeJ4WJywe8Z0iOA
         cJR4vjKIK9YqwFqPjiES30HmDoyD+GJck/a1AU1STZZss80CIhk4Dsuc44JxbkMQim
         9Kcpxpb3Y19mlKSDqXmQdtLMVD3ua1zVoX6rp1Ve2+9lo8TAPDAPZE5lCg7NosytAg
         rQRArku5HNgImhxS/0oxTrHrZJim9LZcu9mn7HHAgYuUNu5LDGkOGcwg749J7Jijes
         Ea6qFwWREtZ1g==
Date:   Thu, 21 Oct 2021 09:35:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Tom Zanussi <zanussi@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [v3] tracing: use %ps format string to print symbols
Message-Id: <20211021093538.7250e3ecf780ad4c5a7d0f80@kernel.org>
In-Reply-To: <20211019153337.294790-1-arnd@kernel.org>
References: <20211019153337.294790-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 17:33:13 +0200
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
> 
> Rather than printing the symbol names into separate buffers, it
> seems we can simply use the special %ps format string modifier
> to print the pointers symbolically and get rid of both buffers.
> 
> Marking hist_trigger_stacktrace_print() would be a simpler
> way of avoiding the warning, but that would not address the
> excessive stack usage.
> 
> Fixes: 69a0200c2e25 ("tracing: Add hist trigger support for stacktraces as keys")
> Link: https://lore.kernel.org/all/20211015095704.49a99859@gandalf.local.home/
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> Tested-by: Tom Zanussi <zanussi@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, there are other functions under kernel/trace still allocating
"char str[KSYM_SYMBOL_LEN]". I guess those also should be changed if
this is the stack usage issue, right?

Thank you,

> ---
> Changes in v3:
>  - Fix 32-bit cast warning
> 
> Changes in v2:
>  - Use %pS instead of %ps to include offset in third string
>  - add (void*) cast to avoid compile-time warnings
> ---
>  kernel/trace/trace_events_hist.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index f01e442716e2..632386b73fc3 100644
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
> +		seq_printf(m, "%pS\n", (void*)stacktrace_entries[i]);
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
> +				   uval, (void *)(uintptr_t)uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
>  			uval = *(u64 *)(key + key_field->offset);
> -			sprint_symbol(str, uval);
> -			seq_printf(m, "%s: [%llx] %-55s", field_name,
> -				   uval, str);
> +			seq_printf(m, "%s: [%llx] %-55pS", field_name,
> +				   uval, (void *)(uintptr_t)uval);
>  		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
>  			struct hist_elt_data *elt_data = elt->private_data;
>  			char *comm;
> -- 
> 2.29.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
