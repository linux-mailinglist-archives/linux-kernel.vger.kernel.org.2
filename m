Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D45035C91A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbhDLOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237806AbhDLOrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:47:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D2DE61352;
        Mon, 12 Apr 2021 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618238807;
        bh=3gfDcxeacAXXyz6lAWhNAkYUSGR6A53k3reCsT6Fy2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ToYYimUBhVqYQOoLpK5Zx8bV45GJSLDZHHo8sYw9hJ1rWlfHGxJiXV2QV5UgAwdUP
         FsI6OlfR4vPcRz/cDmwWdqn5e+nAzBw60afxfXLiTyM1AiHKWzrsS4QbQIuQcxE42/
         o15ZQ6rbBOry6hQqgCzbwhWubGSomNJVVAeZ6k21pYJui1jDzEZeYvaEDkKZD04DZt
         6nsTDs4nx9KJWSS0dRDmqQh3P0Kv+i7DJa0drtJjNZWEoNgh1+NEeMrTOSxNllt2YR
         W62cTWKHCq+alSgWsSZ3hliKm7ufCElo+5+loC5uBpPgEuJKAt/kgoOZquerr+ttQl
         VmGXE91ySJP3Q==
Date:   Mon, 12 Apr 2021 23:46:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liao Chang <liaochang1@huawei.com>
Subject: Re: [PATCH] arm64: kprobes: Restore local irqflag if kprobes is
 cancelled
Message-Id: <20210412234643.08a0a8578fb456190c50bc70@kernel.org>
In-Reply-To: <20210412221144.2da50e902df14cda0d86eeaa@kernel.org>
References: <20210412174101.6bfb0594@xhacker.debian>
        <20210412221144.2da50e902df14cda0d86eeaa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 22:11:44 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Jisheng,
> 
> On Mon, 12 Apr 2021 17:41:01 +0800
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
> > If instruction being single stepped caused a page fault, the kprobes
> > is cancelled to let the page fault handler continue as a normal page
> > fault. But the local irqflags are disabled so cpu will restore pstate
> > with DAIF masked. After pagefault is serviced, the kprobes is
> > triggerred again, we overwrite the saved_irqflag by calling
> > kprobes_save_local_irqflag(). NOTE, DAIF is masked in this new saved
> > irqflag. After kprobes is serviced, the cpu pstate is retored with
> > DAIF masked.
> > 
> > This patch is inspired by one patch for riscv from Liao Chang.
> 
> Thanks for pointing it out. But I think kprobes_restore_local_irqflag()
> is also needed for kcb->kprobe_status == KPROBE_REENTER case...no.
> This is more complicated. In the reenter case, I think we have to retry
> the kpreprobe_fault_handler() with recovered previous kprobes so that
> it can handle page fault in its handler.

Ah, this is another issue, and needs another fix.

So this patch itself is good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Hmm, RISC-V and other code also needs same fix.
> 
> Thank you,
> 
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  arch/arm64/kernel/probes/kprobes.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index 66aac2881ba8..85645b2b0c7a 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -267,10 +267,12 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
> >  		if (!instruction_pointer(regs))
> >  			BUG();
> >  
> > -		if (kcb->kprobe_status == KPROBE_REENTER)
> > +		if (kcb->kprobe_status == KPROBE_REENTER) {
> >  			restore_previous_kprobe(kcb);
> > -		else
> > +		} else {
> > +			kprobes_restore_local_irqflag(kcb, regs);
> >  			reset_current_kprobe();
> > +		}
> >  
> >  		break;
> >  	case KPROBE_HIT_ACTIVE:
> > -- 
> > 2.31.0
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
