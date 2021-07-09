Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B813C211E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhGIJDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhGIJDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:03:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA77A613D0;
        Fri,  9 Jul 2021 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625821234;
        bh=VJ16V2VpdcasUBiXG5p6TX1Xjj34GA6UfKAZNthInl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c3+1IFqJGIjEd4gUNkskhJH+38PycJK/HOnY83UZWpNB29PFUAxCmI/lzxEsA3rIW
         2W+UX8Q4SqNmdC4y4UPMuZlldtD4xr72BMwn+7t6GpF8vxksW8JQSU51sjQbxBnagh
         ZSOEuXyGpFlZthPklSvx4SUCzYz/BMgYW6rCC22LW9JtMm1XEIL6UIy+RX3SljlbNa
         BsKbgGCnxDNTm30+Rzse4LUW6gE9Vm/PwixpxKxMcC+IOfIwbMFalhMtXKhNxDstoh
         xYh/LsBlaH6Vx5nx5vlEhbiaoBpEF3clBRc7a4O9kxx94/EdUQDLHoGDaB90JZvcEF
         tpJobRFVm/ojQ==
Date:   Fri, 9 Jul 2021 18:00:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <chenzefeng2@huawei.com>,
        <kepler.chenxin@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <liucheng32@huawei.com>, <mhiramat@kernel.org>,
        <nixiaoming@huawei.com>, <tixy@linaro.org>, <xiaoqian9@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
Subject: Re: [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on
 single-stepping
Message-Id: <20210709180031.adc7260b54645b0292a6f02a@kernel.org>
In-Reply-To: <20210709024630.22268-1-huangshaobo6@huawei.com>
References: <YOcOcNBRou5KlbOR@kroah.com>
        <20210709024630.22268-1-huangshaobo6@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaobo,

Thanks for backporting!
Greg, it seems this patch can be applied to 4.9 too without any issue.

Thank you,

On Fri, 9 Jul 2021 10:46:30 +0800
Shaobo Huang <huangshaobo6@huawei.com> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> commit f3fbd7ec62dec1528fb8044034e2885f2b257941 upstream
> 
> This is arm port of commit 6a5022a56ac3 ("kprobes/x86: Allow to
> handle reentered kprobe on single-stepping")
> 
> Since the FIQ handlers can interrupt in the single stepping
> (or preparing the single stepping, do_debug etc.), we should
> consider a kprobe is hit in the NMI handler. Even in that
> case, the kprobe is allowed to be reentered as same as the
> kprobes hit in kprobe handlers
> (KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE).
> 
> The real issue will happen when a kprobe hit while another
> reentered kprobe is processing (KPROBE_REENTER), because
> we already consumed a saved-area for the previous kprobe.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> Cc: stable@vger.kernel.org #v2.6.25~v4.11
> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> ---
>  arch/arm/probes/kprobes/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index 3eb018fa1a1f..c3362ddd6c4c 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -270,6 +270,7 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
>  			switch (kcb->kprobe_status) {
>  			case KPROBE_HIT_ACTIVE:
>  			case KPROBE_HIT_SSDONE:
> +			case KPROBE_HIT_SS:
>  				/* A pre- or post-handler probe got us here. */
>  				kprobes_inc_nmissed_count(p);
>  				save_previous_kprobe(kcb);
> @@ -278,6 +279,11 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
>  				singlestep(p, regs, kcb);
>  				restore_previous_kprobe(kcb);
>  				break;
> +			case KPROBE_REENTER:
> +				/* A nested probe was hit in FIQ, it is a BUG */
> +				pr_warn("Unrecoverable kprobe detected at %p.\n",
> +					p->addr);
> +				/* fall through */
>  			default:
>  				/* impossible cases */
>  				BUG();
> -- 
> 2.12.3
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
