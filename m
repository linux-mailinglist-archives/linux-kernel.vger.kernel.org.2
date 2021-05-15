Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1E381998
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhEOPi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 11:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhEOPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 11:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3103B613BB;
        Sat, 15 May 2021 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621093033;
        bh=8/QO4u/vqn1utbmDvC5Dk0J1P3vf4/FSXWmJ911+OJ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rcsJSHoYxUwZio9OcKWQ+EVRvxCL3JBJ5GQjnjzNLLpl3UOc6YTQzT40uo0rbDTkL
         KB1q1ZrJnvceAEhqPzS5rv2eHyypHCusjbTOS2rmPDdwlRpbEjZubQLlKBrVcVzr9s
         8M1BzdOH54UkYt+BgO9m3eXACRlbZNdOBl4gWaEpop6rd8nCxW8BqZdf3LXVdZ2Kvd
         McDBYa8MHVFaVFIHR4nrIjpaGJr9fRGyqfNPRWSA7GLqBV0gr3rh6gqfV1opJenDDS
         XH47PC0FvS2xNPVJz8LSSDGW7EXzZQavm/c0NQdXfg/g1cFE0Gartst6hCJCNSUco+
         p4kIo8XecVbkg==
Subject: Re: [PATCH v3 4/4] x86/syscall: use int everywhere for system call
 numbers
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210515011015.2707542-1-hpa@zytor.com>
 <20210515011015.2707542-5-hpa@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <f2e4c3c3-08c3-eae1-803a-aa85d7e75ca0@kernel.org>
Date:   Sat, 15 May 2021 08:37:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515011015.2707542-5-hpa@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 6:10 PM, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> System call numbers are defined as int, so use int everywhere for
> system call numbers. This patch is strictly a cleanup; it should not
> change anything user visible; all ABI changes have been done in the
> preceeding patches.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>  arch/x86/entry/common.c        | 93 ++++++++++++++++++++++++----------
>  arch/x86/include/asm/syscall.h |  2 +-
>  2 files changed, 66 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index f51bc17262db..714804f0970c 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -36,49 +36,87 @@
>  #include <asm/irq_stack.h>
>  
>  #ifdef CONFIG_X86_64
> -__visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
> +
> +static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
> +{
> +	/*
> +	 * Convert negative numbers to very high and thus out of range
> +	 * numbers for comparisons. Use unsigned long to slightly
> +	 * improve the array_index_nospec() generated code.
> +	 */
> +	unsigned long unr = nr;
> +
> +	if (likely(unr < NR_syscalls)) {
> +		unr = array_index_nospec(unr, NR_syscalls);
> +		regs->ax = sys_call_table[unr](regs);
> +		return true;
> +	}
> +	return false;
> +}

How much do you like micro-optimization?  You could be silly^Wclever and
add a new syscall handler:

long skip_syscall(struct pt_regs *regs)
{
	return regs->ax;
}

and prepend this to the syscall tables -- it would be a sort-of-real
syscall -1.  Then the call sequence becomes:

int adjusted_nr = nr + 1 (or nr - x32bit + 1);

if (likely(nr < NR_adjusted_syscalls)) {
   unr = array_index_nospec...;
   regs->ax = sys_call_table[unr](regs);  /* might be a no-op! */
} else {
    regs->ax = -ENOSYS;
}

which removes a branch from the fast path.
