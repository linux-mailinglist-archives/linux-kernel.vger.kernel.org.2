Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6456244C457
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhKJP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:28:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56702 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhKJP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:28:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 802A61FDC1;
        Wed, 10 Nov 2021 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636557956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IZxAl8IxEx6VpBy1oHZJ4kum57LRrM+qb7phkdnBSqI=;
        b=scXAnA1lG/086lPT1rd7mX84NA7NUMzC68HjRrr2TSsBIdy0A3AHVWfs1/t+p8rzjSaTrD
        ahq2llDApqAE7NRK8FCWcKzUntUTHYqs3iSuMI9tWtz2aqVvPP4dVAB5RzDb5lZcRnQ/pv
        mX4TG+7CuX9pvvDttsL7Bfym9JcFPCA=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DB69AA3B89;
        Wed, 10 Nov 2021 15:25:51 +0000 (UTC)
Date:   Wed, 10 Nov 2021 16:25:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: restore flushing of NMI buffers on remote CPUs
 after NMI backtraces
Message-ID: <YYvkhAQiYF5Uy9AK@alley>
References: <20211107045116.1754411-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107045116.1754411-1-npiggin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-11-07 14:51:16, Nicholas Piggin wrote:
> printk from NMI context relies on irq work being raised on the local CPU
> to print to console. This can be a problem if the NMI was raised by a
> lockup detector to print lockup stack and regs, because the CPU may not
> enable irqs (because it is locked up).
> 
> Introduce printk_trigger_flush() that can be called another CPU to try
> to get those messages to the console, call that where printk_safe_flush
> was previously called.
> 
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -227,6 +227,12 @@ static void watchdog_smp_panic(int cpu)
>  		cpumask_clear(&wd_smp_cpus_ipi);
>  	}

The above context did not apply. I guess that it is a pending change
that did not even reached linux-next yet.

The pushed code might be seen at
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=rework/printk_safe-removal&id=5d5e4522a7f404d1a96fd6c703989d32a9c9568d

>  
> +	/*
> +	 * Force flush any remote buffers that might be stuck in IRQ context
> +	 * and therefore could not run their irq_work.
> +	 */
> +	printk_trigger_flush();
> +
>  	if (hardlockup_panic)
>  		nmi_panic(NULL, "Hard LOCKUP");
>  

The patch has been committed into printk/linux.git,
branch rework/printk_safe-removal.

I am going to add it into the pull request for 5.16-rc2 following week.

Best Regards,
Petr
