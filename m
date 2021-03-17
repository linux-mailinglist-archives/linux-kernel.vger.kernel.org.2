Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3252F33F538
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhCQQN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhCQQNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:13:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A08D64F69;
        Wed, 17 Mar 2021 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615992928;
        bh=6x56BQwiCuKyvHSUTWbTvG2cvq4XP+bZqvITAcrVOp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aE0NotDFD5/0MpPuyJcc3xJ0zfOcrCqi9pyGNe8v2CUflJR0NKCgEbXHSMxlSpAqv
         g0nzes1bDfz6uR8Hfls0rJKktdE8uxjKvDGELVcpZ3bskfGGBFIHlzjyMGIYiMH70a
         FI6Baux86dhK5TnqtbhzGVb7yHykfbW4Cn+4Vsm92dS7H/GYxnyGHETpi0kKCH63Ch
         oQhXf/eux0ZLs5JJZY0yXDtic4PcfYQLndymzgCFdhTy33cEiytlb/4GJem/ZXnWqW
         bn5ZyZ22ujcGsGKIQZMPTRhCDbc899qsJ3ZQn1qeQaTlvpu9cQAm7VXELug5nr60kx
         HuW5M4ttmpgpg==
Date:   Wed, 17 Mar 2021 23:55:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip 0/3] x86/kprobes: Remoev single-step trap from x86
 kprobes
Message-Id: <20210317235522.f327f2a8f43af2e27e5bccea@kernel.org>
In-Reply-To: <161469871251.49483.9142858308048988638.stgit@devnote2>
References: <20210225112245.607c70ec13cf8d279390e89e@kernel.org>
        <161469871251.49483.9142858308048988638.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Would you think you still need this series to remove iret to kernel?

Thank you,

On Wed,  3 Mar 2021 00:25:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a series of patches to remove the single-step debug trap from the
> x86 kprobe.
> 
> The first 2 patches ([1/3][2/3]) are bugfixes which I've sent recently;
> 
>  https://lore.kernel.org/lkml/161425451732.93763.18329509061375062554.stgit@devnote2/
> 
> And [3/3] is actually the patch to remove single-step from kprobes. The RFC
> version is here;
> 
>  https://lore.kernel.org/lkml/161460768474.430263.18425867006584111900.stgit@devnote2/
> 
> This uses int3 as Andy suggested instead of the debug trap, for removing the
> IRET which returns to kernel.
> Some instructions must be emulated and some instructions becomes not able
> to be probed, but as far as I can see those are not rare case.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       x86/kprobes: Retrieve correct opcode for group instruction
>       x86/kprobes: Identify far indirect JMP correctly
>       x86/kprobes: Use int3 instead of debug trap for single-step
> 
> 
>  arch/x86/include/asm/kprobes.h |   21 +-
>  arch/x86/kernel/kprobes/core.c |  524 ++++++++++++++++++++++++++--------------
>  arch/x86/kernel/traps.c        |    3 
>  3 files changed, 358 insertions(+), 190 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
