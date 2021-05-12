Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4418F37BC43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhELMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:10:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhELMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:10:13 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620821344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=sHUtXkG9thyhtj6cgehddmu9xgZImut9Ww78zPA2qyw=;
        b=TLZrDR7+y+ZMCqGyjRS532KA18kD+hW6Cv0HNmmvbWXCzUKmxkL7+gIuu7hj2lj+eTuG/l
        j6RX7IpFHuRZKLspZzok8I/to7QvOxi4vipbMJX9mYigzP79SH7VOwWnDkIS+ENq2TkDki
        o8PYz+9lDdqXGNhXB55KiE2WPYnVJHL5oRuJKHZ8r9m0z5Jtuej67/sBgPSBs+6PD7DjLL
        i3vousRp1YTdQgAyfj0R1tL4mLKidUkVU5yOKSkzp4AZ531QhwPrGxXKNt3sOGUM3+X5y9
        6lKADU7k6rZp+bb9amLkE6r8/IbaoBHuF9zIByAmYLM4YbZ6X1QXER5+9osH4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620821344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=sHUtXkG9thyhtj6cgehddmu9xgZImut9Ww78zPA2qyw=;
        b=crnSZUQWNUa+IiDv6kqq3K+arh3+et09dSi5lgez0vPN1FzQu+mW8dticWhFuygkYeMVTW
        o6cV0VjIRCzAkSBw==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle all invalid syscall nrs
In-Reply-To: <20210510185316.3307264-8-hpa@zytor.com>
Date:   Wed, 12 May 2021 14:09:03 +0200
Message-ID: <871racf928.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10 2021 at 11:53, H. Peter Anvin wrote:
> Redefine the system call number consistently to be "int". The value -1
> is a non-system call (which can be poked in by ptrace/seccomp to
> indicate that no further processing should be done and that the return
> value should be the current value in regs->ax, default to -ENOSYS; any
> other value which does not correspond to a valid system call
> unconditionally calls sys_ni_syscall() and returns -ENOSYS just like
> any system call that corresponds to a hole in the system call table.

That sentence spawns 6 lines, has a unmatched ( inside and is confusing
at best. I know what you want to say, but heck...

> This is the defined semantics of syscall_get_nr(), so that is what all
> the architecture-independent code already expects.  As documented in
> <asm-generic/syscall.h> (which is simply the documentation file for
> <asm/syscall.h>):
>
> /**
>  * syscall_get_nr - find what system call a task is executing
>  * @task:       task of interest, must be blocked
>  * @regs:       task_pt_regs() of @task
>  *
>  * If @task is executing a system call or is at system call
>  * tracing about to attempt one, returns the system call number.
>  * If @task is not executing a system call, i.e. it's blocked
>  * inside the kernel for a fault or signal, returns -1.
>  *
>  * Note this returns int even on 64-bit machines.  Only 32 bits of
>  * system call number can be meaningful.  If the actual arch value
>  * is 64 bits, this truncates to 32 bits so 0xffffffff means -1.
>  *
>  * It's only valid to call this when @task is known to be blocked.
>  */
> int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);

No need for copying this comment. Something like this is sufficient:

The syscall number has to be an 'int' as defined by syscall_get_nr().

Aside of that the subject says:

      x86/entry: use int for syscall number; handle all invalid syscall nrs

which suggests that something is not handled correctly today. But the
changelog does not say anything about it.

>  
>  #ifdef CONFIG_X86_64
> -__visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
> +
> +static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
> +{
> +	unsigned long unr = nr;

What's the point of this cast? Turn -1 into something larger than
NR_SYSCALLS, right? Comments exist for a reason.

Also why unsigned long? unsigned int is sufficient

> +	if (likely(unr < NR_syscalls)) {
> +		unr = array_index_nospec(unr, NR_syscalls);
> +		regs->ax = sys_call_table[unr](regs);
> +		return true;
> +	}
> +	return false;
> +}

Something like this:

static __always_inline bool do_syscall_x64(struct pt_regs *regs, unsigned int nr)
{
        /* nr is unsigned so it catches 
	if (likely(nr < NR_syscalls)) {
		nr = array_index_nospec(nr, NR_syscalls);
		regs->ax = sys_call_table[nr](regs);
		return true;
	}
	return false;
}

static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigned int nr)
{
        /*
         * If nr < __X32_SYSCALL_BIT then the result will be > __X32_SYSCALL_BIT
         * due to unsigned math.
         */
	nr -= __X32_SYSCALL_BIT;

	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
        	nr = array_index_nospec(nr, X32_NR_syscalls);
		regs->ax = x32_sys_call_table[nr](regs);
		return true;
	}
	return false;
}

> index 1d9db15fdc69..85f04ea0e368 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -108,7 +108,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>  
>  	/* IRQs are off. */
>  	movq	%rsp, %rdi
> -	movq	%rax, %rsi
> +	movslq	%eax, %rsi

This is wrong.

  syscall(long number,...);

So the above turns syscall(UINT_MAX + N, ...) into syscall(N, ...).

Thanks,

        tglx


