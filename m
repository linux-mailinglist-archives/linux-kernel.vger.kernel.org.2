Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1F39952F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFBVIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 17:08:11 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40660 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBVIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 17:08:10 -0400
Received: by mail-pl1-f181.google.com with SMTP id e7so1755645plj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNUkfr2jiqoum1l+JR+9hvvM09i9FIV2v2Qt/6pB6Qk=;
        b=Itig39zUNGx4mcfj6h+b01gTlyXgadWn2Getz86htrJN4z9KoQ28YXrAnAT/oLMcKp
         QApHjZ2wjHJ3QP3VfF7E39ecuXGMzQkMV4TFqcEFqga/HRRjUc7cZS0/oQgqdmzTSIV1
         KTrB0Vp8qpqykq063iqtVY9Vr/U1s6p3Br7RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNUkfr2jiqoum1l+JR+9hvvM09i9FIV2v2Qt/6pB6Qk=;
        b=RIiSJyUOOsquK0vQaBdqDiDr45mhhbGCH/9NfgGR/2dZLGhS+YdqCtX6tyG0OULofG
         vTli71ZJQXzh1QRwyqbcQ2kauDRmVckLT+B0u4wC61fA+utyvc5JVQtEgTMHeGygekj4
         8uDuDansHYWfb5hSeGeL1PG8aYIsXwpe6ImhwPqj0vuP60ZjPmuNNicO0wrx8iPmU8hH
         uKifskSY5972E3b6S7Yt9V9S4X6XGMsyn4ex0WY9W5ruifbkrYEEL88T+5O4L4sBC3T2
         WcL7CrPcTqjqpHJrT8j37isxaE7mIWBmPHgIqyOZmdXmLAebXV8KWZQ8Yg+UZhsoExZ2
         0nFw==
X-Gm-Message-State: AOAM5328pjlewBRubq0rCaXRNy9D7Dsanu/mkr+fxOlABAajl/H7/DCt
        1PqHyjVfKLMiF0GTeDsPVSK6yQ==
X-Google-Smtp-Source: ABdhPJygzEyuxEDqWrJ4oyVDj2qIFLJTaNgS8KxjUXiSpUmzwLIVISiMRxVVrjyD8S2G7zyNgxlMrQ==
X-Received: by 2002:a17:902:aa04:b029:ec:f779:3a2b with SMTP id be4-20020a170902aa04b02900ecf7793a2bmr32876745plb.44.1622667927369;
        Wed, 02 Jun 2021 14:05:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w123sm426385pfb.109.2021.06.02.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:05:26 -0700 (PDT)
Date:   Wed, 2 Jun 2021 14:05:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tanner Love <tannerlove.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Romain Perier <romain.perier@gmail.com>,
        Tanner Love <tannerlove@google.com>
Subject: Re: [PATCH] genirq: change force_irqthreads from bool test to static
 key
Message-ID: <202106021402.C7D3331@keescook>
References: <20210602180338.3324213-1-tannerlove.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602180338.3324213-1-tannerlove.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 02:03:38PM -0400, Tanner Love wrote:
> From: Tanner Love <tannerlove@google.com>
> 
> With CONFIG_IRQ_FORCED_THREADING=y, testing the bool force_irqthreads
> could incur a cache line miss in invoke_softirq().
> 
> Replace the test with a static key to avoid the potential cache miss.
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Tanner Love <tannerlove@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/ide/ide-iops.c    | 7 +++----
>  include/linux/interrupt.h | 4 +++-
>  kernel/irq/manage.c       | 6 +++---
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> index f2be127ee96e..f86cdb8451e6 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -109,7 +109,6 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad,
>  	ide_hwif_t *hwif = drive->hwif;
>  	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
>  	unsigned long flags;
> -	bool irqs_threaded = force_irqthreads;
>  	int i;
>  	u8 stat;
>  
> @@ -117,7 +116,7 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad,
>  	stat = tp_ops->read_status(hwif);
>  
>  	if (stat & ATA_BUSY) {
> -		if (!irqs_threaded) {
> +		if (!force_irqthreads) {
>  			local_save_flags(flags);
>  			local_irq_enable_in_hardirq();
>  		}
> @@ -133,13 +132,13 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad,
>  				if ((stat & ATA_BUSY) == 0)
>  					break;
>  
> -				if (!irqs_threaded)
> +				if (!force_irqthreads)
>  					local_irq_restore(flags);
>  				*rstat = stat;
>  				return -EBUSY;
>  			}
>  		}
> -		if (!irqs_threaded)
> +		if (!force_irqthreads)
>  			local_irq_restore(flags);
>  	}
>  	/*
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 4777850a6dc7..9e676c351f23 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -13,6 +13,7 @@
>  #include <linux/hrtimer.h>
>  #include <linux/kref.h>
>  #include <linux/workqueue.h>
> +#include <linux/jump_label.h>
>  
>  #include <linux/atomic.h>
>  #include <asm/ptrace.h>
> @@ -504,7 +505,8 @@ extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
>  # ifdef CONFIG_PREEMPT_RT
>  #  define force_irqthreads	(true)
>  # else
> -extern bool force_irqthreads;
> +DECLARE_STATIC_KEY_FALSE(force_irqthreads_key);
> +#  define force_irqthreads	(static_branch_unlikely(&force_irqthreads_key))

I like this idiom, though it did make me look twice because I thought
you were missing the static_branch...() calls above. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  # endif
>  #else
>  #define force_irqthreads	(0)
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 4c14356543d9..395945e54929 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -25,12 +25,12 @@
>  #include "internals.h"
>  
>  #if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
> -__read_mostly bool force_irqthreads;
> -EXPORT_SYMBOL_GPL(force_irqthreads);
> +DEFINE_STATIC_KEY_FALSE(force_irqthreads_key);
> +EXPORT_SYMBOL_GPL(force_irqthreads_key);
>  
>  static int __init setup_forced_irqthreads(char *arg)
>  {
> -	force_irqthreads = true;
> +	static_branch_enable(&force_irqthreads_key);
>  	return 0;
>  }
>  early_param("threadirqs", setup_forced_irqthreads);
> -- 
> 2.32.0.rc0.204.g9fa02ecfa5-goog
> 

-- 
Kees Cook
