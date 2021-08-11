Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED73E8B51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhHKH6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhHKH5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:57:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA2C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 00:57:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 6so1266731wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fwdGYBFgtkOqg6Jmf4Lw7TWs5Ty3SB5HHOMxdZUGSIU=;
        b=CYpPDOwh8i/ZK3wz1cD++NtBIT2vsMW9FxdhQK83mZxvfUv3mpZIADIbXdpBQWCkV1
         JJXOn7lvraaFMao3SNN982YcUzOVUSOcNNAJm1VZTGFzq/24Fke94qtXfTXwfvaai8vD
         U+NGFKtBnZFrKcDHXkr9NtGjwhhYGJzFL/RjW1rCCrryAHdhmdFtq4iq/8qUT8UsjgPw
         5XOWuieIbH8kG6hMdYWcoJqKVP3dOOR/1pQAAErUypVgtBh0QOe9pckV6RGJQOY3vjpm
         Q3LegtABagGHMmMvyBR9G3wdUjfzcH43lEW7O2k7YF0Q3fJjC8q82RU5BbhbqxDsCh7K
         +uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fwdGYBFgtkOqg6Jmf4Lw7TWs5Ty3SB5HHOMxdZUGSIU=;
        b=eme2c45S1ZoiK6ocGNQrzy+aIN6Lq1SbJr9FQo8BvozxMs2MX8NLcI/AVA3R+cp3vY
         1gebhmTu2j6M7SF4qZptKkqsVtNVFdugck0rNaoZj70PBRMs6VljMP/s5fD7VBEGHI5k
         2Wy4TmdJZlteNx2FIa1j21wHxMSc/1R/nM5e2abeU79pZEa5luCLj+IS5FBlCE+FT2yQ
         crsPIm40EPLgC/q38z7eONFcaNcjRHnAJWZgSsY/X08/FJDmpActeHuFfii7kY13HhNU
         Lnx6idB9S3iRMux0gVC4o+DrSw1eVMChOAoiCE1r+naC6bSoeMc7JH3BR2cYsjEtKIgT
         d1Aw==
X-Gm-Message-State: AOAM530+vdVUwh4tRZReDkDKChr4x4TBqBEi6YHsfnw9mWquVS76u+6l
        ENl6EMaSi6Eqs8JbZ2PRFT7X5w==
X-Google-Smtp-Source: ABdhPJzuv3WRP4WOBZMGrILo9gbtARiKtSXE/OqYs5yJ13//2rk/TkadbKotKF/Z+voBJNIhQQLXaw==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr8606394wmj.180.1628668647684;
        Wed, 11 Aug 2021 00:57:27 -0700 (PDT)
Received: from google.com ([95.148.6.212])
        by smtp.gmail.com with ESMTPSA id h2sm5082806wmm.33.2021.08.11.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 00:57:26 -0700 (PDT)
Date:   Wed, 11 Aug 2021 08:57:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/1] genirq/cpuhotplug: Bump debugging information print
 down to KERN_DEBUG
Message-ID: <YROC5avuGQyBIpmD@google.com>
References: <20210617073136.315723-1-lee.jones@linaro.org>
 <8735rhs7n6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735rhs7n6.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021, Thomas Gleixner wrote:

> On Thu, Jun 17 2021 at 08:31, Lee Jones wrote:
> > This sort of information is only generally useful when debugging.
> >
> > No need to have these sprinkled through the kernel log otherwise.
> 
> Yes and no. 
> 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  kernel/irq/cpuhotplug.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> > index 02236b13b3599..cf8d4f75632e8 100644
> > --- a/kernel/irq/cpuhotplug.c
> > +++ b/kernel/irq/cpuhotplug.c
> > @@ -42,7 +42,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
> >  		 * If this happens then there was a missed IRQ fixup at some
> >  		 * point. Warn about it and enforce fixup.
> >  		 */
> > -		pr_warn("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
> 
> This one is clearly a warning as this should not happen. See the
> comments around that.
> 
> > +		pr_debug("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
> >  			cpumask_pr_args(m), d->irq, cpu);
> >  		return true;
> >  	}
> > @@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
> >  		raw_spin_unlock(&desc->lock);
> >  
> >  		if (affinity_broken) {
> > -			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
> > +			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
> >  					    irq, smp_processor_id());
> 
> Maybe, but distro people might have opinions on that.

The trouble is, even if these are real warnings, they have an affect
on performance on real products.  To the point where so much logging
builds up during pre-release testing, that it sets off the watchdog(s)
on some high profile consumer devices.

What would you suggest?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
