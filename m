Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1A4428A85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhJKKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235695AbhJKKIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:08:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF935604AC;
        Mon, 11 Oct 2021 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633946815;
        bh=nbhaoewUxBw2RcQpIynWHpC9tTbzCt3dvQP/UabnayA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRszLcLPvKUueTWfHsgiwTH6cG3WH0G1X67ZtsFHbEErGyXXgL191R6PcjUDK5d1A
         4otpggu8V3C+07aE89x1ZJ7jFyDmGQE+NIjorqPkDPjBhLiT/mgarpE6h6j2txfLGO
         x+5eXs+LG4QodL/ogKP1KBcPdS6Sj+Vbu8F0/jXxwc9OAxzNuHSUfkImsBoq0Pi7L2
         w4vBNatL7Y3jCG+MMXyBar+9mBNUKCFjeN+2yh12eAZpwh0XPLyalqjObPfirELFO0
         S8cpHmaAsH9YCTuIis+50DzeT1k5/Zyzo1KsVlvcGdT5RiY+F1FFeloN401pzADlTA
         rt/ZUwQgcJejQ==
Date:   Mon, 11 Oct 2021 11:06:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Chen Lin <chen45464546@163.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chen.lin5@zte.com.cn
Subject: Re: Re: [PATCH] arm64: traps: add dump instr before BUG in kernel
Message-ID: <20211011100649.GB3681@willie-the-truck>
References: <20210930084247.GC23389@willie-the-truck>
 <1633012890-3118-1-git-send-email-chen45464546@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633012890-3118-1-git-send-email-chen45464546@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:41:30PM +0800, Chen Lin wrote:
> At 2021-09-30 15:42:47, "Will Deacon" <will@kernel.org> wrote:
> 
> >On Wed, Sep 29, 2021 at 09:29:46PM +0800, Chen Lin wrote:
> >> From: Chen Lin <chen.lin5@zte.com.cn>
> >> 
> >> we should dump the real instructions before BUG in kernel mode, and
> >> compare this to the instructions from objdump.
> >> 
> >> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> >> ---
> >>  arch/arm64/kernel/traps.c |    7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> >> index b03e383..621a9dd 100644
> >> --- a/arch/arm64/kernel/traps.c
> >> +++ b/arch/arm64/kernel/traps.c
> >> @@ -495,7 +495,12 @@ void do_undefinstr(struct pt_regs *regs)
> >>  	if (call_undef_hook(regs) == 0)
> >>  		return;
> >>  
> >> -	BUG_ON(!user_mode(regs));
> >> +	if (!user_mode(regs)) {
> >> +		pr_emerg("Undef instruction in kernel, dump instr:");
> >> +		dump_kernel_instr(KERN_EMERG, regs);
> >> +		BUG();
> >> +	}
> >
> >Hmm, I'm not completely convinced about this as the instruction in the
> >i-cache could be completely different. I think the PC value (for addr2line)
> >is a lot more useful, and we should be printing that already.
> >
> >Maybe you can elaborate on a situation where this information was helpful?
> >
> >Thanks,
> >
> >Will
> 
> Undef instruction occurs in some cases
> 
> 1. CPU do not have the permission to execute the instruction or the current CPU
>  version does not support the instruction. For example, execute 
>  'mrs x0, tcr_el3' under el1.

This really shouldn't happen, but if it did, the PC would surely be enough
to debug the problem?

> 2. The instruction is a normal instruction, but it is changed during board 
> running in some abnormal situation. eg: DDR bit flip, the normal instruction 
> will become an undefined one. By printing the instruction, we can see the 
> accurate instruction code and compare it with the instruction code from objdump
> to determine that it is a DDR issue.

Is this really something we should be designing our exception handlers for?
If we're getting DDR bit flips for kernel .text, then it sounds like we need
ECC and/or RAS features to deal with them.

So I'm not really sold on this change.

Will
