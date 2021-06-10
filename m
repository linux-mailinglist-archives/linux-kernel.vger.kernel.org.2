Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2453A33C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFJTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:18:00 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36546 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJTR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:17:59 -0400
Received: by mail-pf1-f178.google.com with SMTP id c12so2437230pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FeIin1xUayqrHRUthoj+2bXTLrVBPUyLS4OgbBTjDtk=;
        b=QKWjry/y1OFqoCcvJhkEfCJchYeKCDBWKyn7HlgOxu0LPJ9QxZhCJE8UdygKvTHdYS
         P77NYs24p0gamA6CmMA/iM69ZGtp7JosjHqRp1SbiWk5CQM0rh07QM4RlHFtsbXniBdV
         B9hquP5HFsDfoPPLzTnJIZyTcXMcynXkb1D8xmQW6Sj0ACbwiBY+xDw+5NriOTW7uKw0
         7ShA5ds9uiyS89NwczqUFlrULvw8vMaGbRnUfzRS0I2iz0Exql8jd8SEYtepEnsNQ+7h
         x/OPKbP4zfKM9STAEc+fbwVPYZZUbmm33h2vOReNO7ZAHR+03NZU6s4yaZxH/zZSPhrE
         VwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FeIin1xUayqrHRUthoj+2bXTLrVBPUyLS4OgbBTjDtk=;
        b=bnxcfDhj00nTZRIj/OqyXJsWor08uWV9xmHnlk7Lt0Hzs5cKzGfk7OIYwNnrBtXuto
         iHEURQo3ha57Kfsq573bIeTMjvOVNxn3ILzsiz4KF2W9h324p4m3mWMbp+gWDzqpslDY
         aZPQaqb9Qqd/l7ecCrTyZYmOzzkwv3MhFr066KlfUARO8inwuHeLyJJuniJxRxD768G0
         /LXyXdd6EJJiILjZec8dag0XPBq3lSUKVtWKK7ZJVN/rt0g0pxryIYcmSE/UHZ6YfPXc
         rWC8sz2tFoh6RwSNfD3qgND6QwkSafGQE3NO8kWgOdoK5F2etM8wWRi+QSMSPpLLLJj5
         H7Ug==
X-Gm-Message-State: AOAM533swrWPcmH9oAqD6sr7yZsSiUrx9+A7in8K+uz3y0WKRsanauim
        sP/+PgUpzY98uyQN84FUoos=
X-Google-Smtp-Source: ABdhPJzJQgOu2UnpQGtaRZcsPZkpXDzKbf07NNfymypblk8YN73tKriVQZBwOp3p9V2WSZpkI9f8mg==
X-Received: by 2002:a63:d908:: with SMTP id r8mr6321649pgg.414.1623352492981;
        Thu, 10 Jun 2021 12:14:52 -0700 (PDT)
Received: from localhost (g151.115-65-219.ppp.wakwak.ne.jp. [115.65.219.151])
        by smtp.gmail.com with ESMTPSA id w21sm3281795pfq.143.2021.06.10.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:14:52 -0700 (PDT)
Date:   Fri, 11 Jun 2021 04:14:45 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        boqun.feng@gmail.com, bp@alien8.de, catalin.marinas@arm.com,
        dvyukov@google.com, elver@google.com, ink@jurassic.park.msu.ru,
        jonas@southpole.se, juri.lelli@redhat.com, linux@armlinux.org.uk,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, rth@twiddle.net,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: Re: [RFC PATCH 08/10] openrisc: snapshot thread flags
Message-ID: <YMJkpaHyxCd/Wqke@antec>
References: <20210609122001.18277-1-mark.rutland@arm.com>
 <20210609122001.18277-9-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609122001.18277-9-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 01:19:59PM +0100, Mark Rutland wrote:
> Some thread flags can be set remotely, and so even when IRQs are
> disabled, the flags can change under our feet. Generally this is
> unlikely to cause a problem in practice, but it is somewhat unsound, and
> KCSAN will legitimately warn that there is a data race.
> 
> To avoid such issues, we should snapshot the flags prior to using them.
> Let's use the new helpers to do so on openrisc.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> ---
>  arch/openrisc/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> index 1ebcff271096..a730a914c2b4 100644
> --- a/arch/openrisc/kernel/signal.c
> +++ b/arch/openrisc/kernel/signal.c
> @@ -315,7 +315,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
>  			}
>  		}
>  		local_irq_disable();
> -		thread_flags = current_thread_info()->flags;
> +		thread_flags = read_thread_flags();
>  	} while (thread_flags & _TIF_WORK_MASK);
>  	return 0;
>  }

This looks good to me.  As per patch 01/10 this adds a READ_ONCE around the
original flags read.

Acked-by: Stafford Horne <shorne@gmail.com>
