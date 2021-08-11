Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26D3E902C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhHKMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:09:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbhHKMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:09:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628683718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCPYmftPfGiygaluib21F8+dmifVxGxWYVTKWjQffJE=;
        b=0MLwhpEjGT+kB+aY1hx2dkGme4FZ8aWIh4nQPVyMhWmCpTxlGDJ9oma/iDNXvZtZkofrib
        UIDbFXmIg73MeJjr1YObjHi5d5ZLYppBEkH9aO2hqz/vVQy3KIeAthzlZYWLykQ6Y/F/e3
        lRIofXSBIYnKKeeZdjZXKMpQaR/ZXh35fX5c0h3DGh8E3HgSlUJg8YY/fdDQbT+0ngq9d1
        ayxJTW2RDM4ptP2SMSlsCu00XBa6X33MUnINFhePNEavDY246s8rr1m10L+RT8tfIYxtm0
        uEKpIQ1I3w+KJxgbpPsSxUF8pOOF1emFNhhjtJ+9pr+YWUtMxL5rEzTr1jO9yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628683718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCPYmftPfGiygaluib21F8+dmifVxGxWYVTKWjQffJE=;
        b=ivSogjaZ4TJIiOeQj5iu4L3Rp8xGmuzTiApoq3dCjFocOi4UqCBZHaThKPBbQxbr1bOk3c
        nJ8ZqNTWiYP0hPBQ==
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/1] genirq/cpuhotplug: Bump debugging information print
 down to KERN_DEBUG
In-Reply-To: <YROC5avuGQyBIpmD@google.com>
References: <20210617073136.315723-1-lee.jones@linaro.org>
 <8735rhs7n6.ffs@tglx> <YROC5avuGQyBIpmD@google.com>
Date:   Wed, 11 Aug 2021 14:08:38 +0200
Message-ID: <87fsvgp4jd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11 2021 at 08:57, Lee Jones wrote:
> On Tue, 10 Aug 2021, Thomas Gleixner wrote:
>> > @@ -42,7 +42,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
>> >  		 * If this happens then there was a missed IRQ fixup at some
>> >  		 * point. Warn about it and enforce fixup.
>> >  		 */
>> > -		pr_warn("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
>> 
>> This one is clearly a warning as this should not happen. See the
>> comments around that.
>> 
>> > +		pr_debug("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
>> >  			cpumask_pr_args(m), d->irq, cpu);
>> >  		return true;
>> >  	}
>> > @@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
>> >  		raw_spin_unlock(&desc->lock);
>> >  
>> >  		if (affinity_broken) {
>> > -			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
>> > +			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
>> >  					    irq, smp_processor_id());
>> 
>> Maybe, but distro people might have opinions on that.
>
> The trouble is, even if these are real warnings, they have an affect
> on performance on real products.  To the point where so much logging
> builds up during pre-release testing, that it sets off the watchdog(s)
> on some high profile consumer devices.

I'm fine with making the second one debug, but the first one really
should not trigger at all.

Thanks,

        tglx
