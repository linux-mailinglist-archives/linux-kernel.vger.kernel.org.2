Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1A235C730
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbhDLNMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238974AbhDLNMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08BDE610CA;
        Mon, 12 Apr 2021 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618233108;
        bh=Zanz5qvZw0cWJyNWZgIdn36zowK6B/3y64wJX8xDVA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TGIPsFVMVdByjHtg3ZVGZQe83imde/ahXjWUUC0f52OPHnHSZdmq2u+i8uodJHcSN
         WyCoJPZNRpVnItYzdn59iJesvqXUci73lG3JI+y6ZQ5NlYzxZCTDFrhfenfdhZW98v
         6R3nbLNVw2sF29Gs/Ul5MCXioUPK3m3V4UwJptkWwuSjaL3YrXIbhmEN9zZ4hUF6fT
         scp3MBlonnl38LasRQvpC+lwV+cmeIhsMNb8L5z0S0NLF2oBtygExcVYFneXtBhuIY
         yMUHAr4Cwi3cIkHvy6lCQq4Jiq+bZYGb+d9T+lAVcZcnc0XEjrQzw/kIo/piJY8RUq
         IOyKsRf3pJhlA==
Date:   Mon, 12 Apr 2021 22:11:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liao Chang <liaochang1@huawei.com>
Subject: Re: [PATCH] arm64: kprobes: Restore local irqflag if kprobes is
 cancelled
Message-Id: <20210412221144.2da50e902df14cda0d86eeaa@kernel.org>
In-Reply-To: <20210412174101.6bfb0594@xhacker.debian>
References: <20210412174101.6bfb0594@xhacker.debian>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Mon, 12 Apr 2021 17:41:01 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> If instruction being single stepped caused a page fault, the kprobes
> is cancelled to let the page fault handler continue as a normal page
> fault. But the local irqflags are disabled so cpu will restore pstate
> with DAIF masked. After pagefault is serviced, the kprobes is
> triggerred again, we overwrite the saved_irqflag by calling
> kprobes_save_local_irqflag(). NOTE, DAIF is masked in this new saved
> irqflag. After kprobes is serviced, the cpu pstate is retored with
> DAIF masked.
> 
> This patch is inspired by one patch for riscv from Liao Chang.

Thanks for pointing it out. But I think kprobes_restore_local_irqflag()
is also needed for kcb->kprobe_status == KPROBE_REENTER case...no.
This is more complicated. In the reenter case, I think we have to retry
the kpreprobe_fault_handler() with recovered previous kprobes so that
it can handle page fault in its handler.

Hmm, RISC-V and other code also needs same fix.

Thank you,

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 66aac2881ba8..85645b2b0c7a 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -267,10 +267,12 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
>  		if (!instruction_pointer(regs))
>  			BUG();
>  
> -		if (kcb->kprobe_status == KPROBE_REENTER)
> +		if (kcb->kprobe_status == KPROBE_REENTER) {
>  			restore_previous_kprobe(kcb);
> -		else
> +		} else {
> +			kprobes_restore_local_irqflag(kcb, regs);
>  			reset_current_kprobe();
> +		}
>  
>  		break;
>  	case KPROBE_HIT_ACTIVE:
> -- 
> 2.31.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
