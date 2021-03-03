Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6D32BE9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386000AbhCCRdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:33:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241221AbhCCNMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:12:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0834A60C3E;
        Wed,  3 Mar 2021 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614773912;
        bh=v3CqCbTv0mkQkZ9Ih1RedXVPZV9P2fo8wFRseCGcHv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=blDw8YeZouCbRsfc7ZOUXPRTlU59K/tmWQLE8EanPyntbPVhlqDdyM3ZtTCq0d4OG
         qrod534Ed4NAeIkg6ogDPq5pMCoJR5J3LrAlD8BJmZEugEGc94+PzpbMq5GV+CMQAR
         MnpIku34NR5dTqmIv6TNWUEC0k1fM3UY4dslGpQ1bg5NZjw0j2VG5a2Bt3Rk9Hs3Vw
         PvkcyVKZy0KJMX5BwbK4WzsHN8TmKXWDgWdHWg4qZrkvd4UazhLOctL2VCDZNw/Qxs
         EZoviPLUTogdPA6j3raB605qmkGjGyv1HjuDnmjupQVgvIrnAi3DGuWd+4ZFdH4kUN
         83uw+wxaX/AeQ==
Date:   Wed, 3 Mar 2021 21:18:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     ShaoBo Huang <huangshaobo6@huawei.com>
Cc:     <linux@armlinux.org.uk>, <tixy@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>,
        <nixiaoming@huawei.com>, <chenzefeng2@huawei.com>,
        <liucheng32@huawei.com>, <kepler.chenxin@huawei.com>,
        <xiaoqian9@huawei.com>
Subject: Re: [PATCH 4.9.y] arm: kprobes: Allow to handle reentered kprobe on
 single-stepping
Message-Id: <20210303211827.eeb89c8a9b140152fbcd997c@kernel.org>
In-Reply-To: <20210303071052.33740-1-huangshaobo6@huawei.com>
References: <20210303071052.33740-1-huangshaobo6@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ShaoBo,

Thanks for backporting and real bug report!

On Wed, 3 Mar 2021 15:10:52 +0800
ShaoBo Huang <huangshaobo6@huawei.com> wrote:

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
