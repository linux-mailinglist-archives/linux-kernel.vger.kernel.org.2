Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2746E375494
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhEFNVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231993AbhEFNVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:21:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42473610EA;
        Thu,  6 May 2021 13:20:02 +0000 (UTC)
Date:   Thu, 6 May 2021 09:20:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, mingo@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] RISC-V: Don't check text_mutex during stop_machine
Message-ID: <20210506092000.26fd392b@gandalf.local.home>
In-Reply-To: <20210506071041.417854-1-palmer@dabbelt.com>
References: <20210506071041.417854-1-palmer@dabbelt.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 May 2021 00:10:41 -0700
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 7f1e5203de88..da2405652f1d 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -11,6 +11,8 @@
>  #include <asm/cacheflush.h>
>  #include <asm/patch.h>
>  
> +int riscv_ftrace_in_stop_machine;
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
>  {
> @@ -232,3 +234,16 @@ int ftrace_disable_ftrace_graph_caller(void)
>  }
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> +
> +void arch_ftrace_update_code(int command)
> +{
> +	/*
> +	 * The code sequences we use for ftrace can't be patched while the
> +	 * kernel is running, so we need to use stop_machine() to modify them
> +	 * for now.  This doesn't play nice with text_mutex, we use this flag
> +	 * to elide the check.
> +	 */
> +	riscv_ftrace_in_stop_machine = true;
> +	ftrace_run_stop_machine(command);
> +	riscv_ftrace_in_stop_machine = false;
> +}
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b552873a577..7983dba477f0 100644

This would work, but my suggestion was to do it without having to add this
arch function. Because the caller of this is:

static void ftrace_run_update_code(int command)
{
	int ret;

	ret = ftrace_arch_code_modify_prepare();
	FTRACE_WARN_ON(ret);
	if (ret)
		return;

	/*
	 * By default we use stop_machine() to modify the code.
	 * But archs can do what ever they want as long as it
	 * is safe. The stop_machine() is the safest, but also
	 * produces the most overhead.
	 */
	arch_ftrace_update_code(command);

	ret = ftrace_arch_code_modify_post_process();
	FTRACE_WARN_ON(ret);
}


Where you already have two hooks that you use to take the text_mutex before
calling arch_ftrace_update_code().

In RISC-V those are:

int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
{
        mutex_lock(&text_mutex);
        return 0;
}

int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
{
        mutex_unlock(&text_mutex);
        return 0;
}

Where all you have to do is change them to:

int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
{
        mutex_lock(&text_mutex);
	riscv_ftrace_in_stop_machine = true;
        return 0;
}

int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
{
	riscv_ftrace_in_stop_machine = false;
        mutex_unlock(&text_mutex);
        return 0;
}

And you have the exact same affect. Those functions are only used before
calling the stop machine code you have.

-- Steve
