Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0D3E5DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbhHJOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:24:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43714 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbhHJOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:21:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628605261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=VDGHBk8tQR44Lf8F3j420x6+Qn1ZVZrp3PWRsihZtvg=;
        b=RhwbHrWY/6e+wG5oxL0v233f/iSL7ZrkzwRbj37grRZj6XxdvyuQukFpxdihh5a1q0FDLK
        9EF+qSzMvqWmOCCol4MVtOXVf/R/eEiAh2CFAo+x3il36a7csE70NIhwabHpzAwnUK0lNG
        7Dcv0HEOIB042g29cnyU+I+zaEs3ta+ReL5I6gzG4HNpOZOfxMXYAFAun8C12m0n9Tm09w
        2AOT9qjPVX6/xlLq7oXlb1Z/hmwYXAbsGC2o3nax8A0ZJ3QzKfYTJaG/oczQ3/bRLAfGZp
        NHfShznA+LEz3TKgrNG1n0XUZrK7wDQFoH/kH4kaUq+pVnAwUpeFJmuuIusUqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628605261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=VDGHBk8tQR44Lf8F3j420x6+Qn1ZVZrp3PWRsihZtvg=;
        b=+7XloPyPFscFA7BB0psnYXn6snwHnGL6yw82K8Q/4h1OFhrSm1d44YLH1JRYfQ5kQE0Iab
        YUWcCgayHV+Z1hAQ==
To:     Lee Jones <lee.jones@linaro.org>, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/1] genirq/cpuhotplug: Bump debugging information print
 down to KERN_DEBUG
In-Reply-To: <20210617073136.315723-1-lee.jones@linaro.org>
Date:   Tue, 10 Aug 2021 16:21:01 +0200
Message-ID: <8735rhs7n6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17 2021 at 08:31, Lee Jones wrote:
> This sort of information is only generally useful when debugging.
>
> No need to have these sprinkled through the kernel log otherwise.

Yes and no. 

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  kernel/irq/cpuhotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> index 02236b13b3599..cf8d4f75632e8 100644
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -42,7 +42,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
>  		 * If this happens then there was a missed IRQ fixup at some
>  		 * point. Warn about it and enforce fixup.
>  		 */
> -		pr_warn("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",

This one is clearly a warning as this should not happen. See the
comments around that.

> +		pr_debug("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
>  			cpumask_pr_args(m), d->irq, cpu);
>  		return true;
>  	}
> @@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
>  		raw_spin_unlock(&desc->lock);
>  
>  		if (affinity_broken) {
> -			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
> +			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
>  					    irq, smp_processor_id());

Maybe, but distro people might have opinions on that.

Thanks,

        tglx
