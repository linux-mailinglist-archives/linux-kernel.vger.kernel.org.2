Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8ED437ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhJVQR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233562AbhJVQR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:17:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F406112F;
        Fri, 22 Oct 2021 16:15:38 +0000 (UTC)
Date:   Fri, 22 Oct 2021 12:15:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/9] kprobes: Add a test case for stacktrace from
 kretprobe handler
Message-ID: <20211022121537.32821979@gandalf.local.home>
In-Reply-To: <163477767243.264901.10894979830215919916.stgit@devnote2>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
        <163477767243.264901.10894979830215919916.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 09:54:32 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a test case for stacktrace from kretprobe handler and
> nested kretprobe handlers.
> 
> This test checks both of stack trace inside kretprobe handler
> and stack trace from pt_regs. Those stack trace must include
> actual function return address instead of kretprobe trampoline.
> The nested kretprobe stacktrace test checks whether the unwinder
> can correctly unwind the call frame on the stack which has been
> modified by the kretprobe.
> 
> Since the stacktrace on kretprobe is correctly fixed only on x86,
> this introduces a meta kconfig ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> which tells user that the stacktrace on kretprobe is correct or not.
> 
> The test results will be shown like below;
> 
>  TAP version 14
>  1..1
>      # Subtest: kprobes_test
>      1..6
>      ok 1 - test_kprobe
>      ok 2 - test_kprobes
>      ok 3 - test_kretprobe
>      ok 4 - test_kretprobes
>      ok 5 - test_stacktrace_on_kretprobe
>      ok 6 - test_stacktrace_on_nested_kretprobe
>  # kprobes_test: pass:6 fail:0 skip:0 total:6
>  # Totals: pass:6 fail:0 skip:0 total:6
>  ok 1 - kprobes_test

So my allmodconfig test failed on this:

ERROR: modpost: "stack_trace_save_regs" [kernel/test_kprobes.ko] undefined!


> +	/*
> +	 * Test stacktrace from pt_regs at the return address. Thus the stack
> +	 * trace must start from the target return address.
> +	 */
> +	ret = stack_trace_save_regs(regs, stack_buf, STACK_BUF_SIZE, 0);
> +	KUNIT_EXPECT_NE(current_test, ret, 0);
> +	KUNIT_EXPECT_EQ(current_test, stack_buf[0], target_return_address[1]);
> +
> +	return 0;
> +}

It appears that that "stack_trace_save_regs" is not exported. And this code
can be compiled as a module.

I'm going to continue testing my code, as I have over 40 patches that need
to go into next. I'll just rebase removing this commit only (hopefully
nothing else breaks), and if everything then passes, I'll push to next.

-- Steve
