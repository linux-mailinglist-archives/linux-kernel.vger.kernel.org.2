Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420793DF206
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhHCQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhHCQBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:01:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6B9460F46;
        Tue,  3 Aug 2021 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628006499;
        bh=iId+jcd+Lb5NqerVcNUHfB7V9rsOw1s5kqlWUWaOjBc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=isRNP0G8hK6pSZrXnFgDk0Oji763HeVqdnOlO4f69eQLoM9sgjU24jJq+tf69mWPI
         qw9OTeJ2ZdtHJ0W7AL7mEP8c7b5UHvCBqcYHTixCMMthb7We3aRhhdtxNRAxDF7bn8
         UQFjHA+x77v2Ao88LFRmhRDPqMSEL40ns2eFXYHxwhfVZVQAMAZfJo/rBpGx8dWado
         yanY44MK5+VZuvlgNre+1UWTXM1/Qnt7Zbw54kXVRAYovy5gkMy9+mqD5DT0KW50UJ
         U+Sa3yld+HeZ4YshTXHgvAJSXNqEDZ7QRS4FzA/aqGS84aULe6Ecyjw+I3J+KlnxfC
         XqXpGKnGryO2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8E5425C04D4; Tue,  3 Aug 2021 09:01:39 -0700 (PDT)
Date:   Tue, 3 Aug 2021 09:01:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        boqun.feng@gmail.com, bp@alien8.de, catalin.marinas@arm.com,
        dvyukov@google.com, elver@google.com, ink@jurassic.park.msu.ru,
        jonas@southpole.se, juri.lelli@redhat.com, linux@armlinux.org.uk,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulus@samba.org,
        peterz@infradead.org, rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: Re: [PATCH v4 00/10] thread_info: use helpers to snapshot thread
 flags
Message-ID: <20210803160139.GS4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210803095428.17009-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803095428.17009-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 10:54:18AM +0100, Mark Rutland wrote:
> As thread_info::flags scan be manipulated by remote threads, it is
> necessary to use atomics or READ_ONCE() to ensure that code manipulates
> a consistent snapshot, but we open-code plain accesses to
> thread_info::flags across the kernel tree.
> 
> Generally we get away with this, but tools like KCSAN legitimately warn
> that there is a data-race, and this is potentially fragile with compiler
> optimizations, LTO, etc.
> 
> These patches introduce new helpers to snahpshot the thread flags, with
> the intent being that these should replace all plain accesses.

For the series:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Since v1 [1]:
> * Drop RFC
> * Make read_ti_thread_flags() __always_inline
> * Clarify commit messages
> * Fix typo in arm64 patch
> * Accumulate Reviewed-by / Acked-by tags
> * Drop powerpc patch to avoid potential conflicts (per [2])
> 
> Since v2 [3]:
> * Rebase to v5.14-rc1
> * Reinstate powerpc patch
> 
> Since v3 [4]:
> * Rebase to v5.14-rc4
> 
> [1] https://lore.kernel.org/r/20210609122001.18277-1-mark.rutland@arm.com
> [2] https://lore.kernel.org/r/87k0mvtgeb.fsf@mpe.ellerman.id.au
> [3] https://lore.kernel.org/r/20210621090602.16883-1-mark.rutland@arm.com
> [4] https://lore.kernel.org/r/20210713113842.2106-1-mark.rutland@arm.com
> 
> Thanks,
> Mark.
> 
> Mark Rutland (10):
>   thread_info: add helpers to snapshot thread flags
>   entry: snapshot thread flags
>   sched: snapshot thread flags
>   alpha: snapshot thread flags
>   arm: snapshot thread flags
>   arm64: snapshot thread flags
>   microblaze: snapshot thread flags
>   openrisc: snapshot thread flags
>   powerpc: snapshot thread flags
>   x86: snapshot thread flags
> 
>  arch/alpha/kernel/signal.c          |  2 +-
>  arch/arm/kernel/signal.c            |  2 +-
>  arch/arm/mm/alignment.c             |  2 +-
>  arch/arm64/kernel/ptrace.c          |  4 ++--
>  arch/arm64/kernel/signal.c          |  2 +-
>  arch/arm64/kernel/syscall.c         |  4 ++--
>  arch/microblaze/kernel/signal.c     |  2 +-
>  arch/openrisc/kernel/signal.c       |  2 +-
>  arch/powerpc/kernel/interrupt.c     | 13 ++++++-------
>  arch/powerpc/kernel/ptrace/ptrace.c |  3 +--
>  arch/x86/kernel/process.c           |  8 ++++----
>  arch/x86/kernel/process.h           |  6 +++---
>  arch/x86/mm/tlb.c                   |  2 +-
>  include/linux/entry-kvm.h           |  2 +-
>  include/linux/thread_info.h         | 14 ++++++++++++++
>  kernel/entry/common.c               |  4 ++--
>  kernel/entry/kvm.c                  |  4 ++--
>  kernel/sched/core.c                 |  2 +-
>  18 files changed, 45 insertions(+), 33 deletions(-)
> 
> -- 
> 2.11.0
> 
