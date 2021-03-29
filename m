Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB734D40C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhC2Pg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC2PgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:36:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3071AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:36:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso7886102pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YP03UpIuOEGxIuDdLf5I1V97pJYhY/44A539ah6Go6k=;
        b=jf73mCvFikKQK34+CiaYQiocgSloOf+SOXs5/NLKXJTxObVt/9+gPj3eXTKYQvaylu
         4tBx3IW4HRysl/5a2nIobne7QbZF0GGX9SuqodGN+S3k1fzcKe5fRNtGdnW4STJtH1vX
         pIlbEk3xYlXhHIExWKym2TPyCiAGwhe9dOqEKLahpGu9BoPWKwTfdb9j/rwL28iPQkSu
         XTct7Lk3jCzaPPtP86nH7kuOxD5YItVP6rqLq+cvwBR3TJlemD+pB6usE2j6pbYE9EBD
         babD2SOMREx+gv6Hw4PhnOBf7++PN/NK0pkxu/4IG2HsCAOZZiw84WF4yuNVX6hzYduv
         ZWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YP03UpIuOEGxIuDdLf5I1V97pJYhY/44A539ah6Go6k=;
        b=iY01eMtPsBDGAWs8vzwRo+FxlviLz3nCt2bRHfd/6mBInjAZJFQSAC0kUx1zB5SAYl
         N05Btjz3QXfuk1aPCPCGB7H0SqlxEU5VqyR0S1peEscWwtQA80k5/Pda0IrfO/Qvkmu6
         PgHacqgyqJ1Iiqpot/nv9pkStsYezjoFvfR2ny9Ey2dMNd6xSYihOuCXIpX+nmqFX1cX
         Zd4rfegfasVXBxuKUqIRX2S3kLhh3XvogmWsvpEOSa5VuTjrejgWm3sdaThhUQGki2Rx
         xgrjcNfHmjkikp+VWdFQ92ZxGZDYKln/FsH8U0Y3u5nqgWxI/lMW32nBY60xijjpATK2
         V64g==
X-Gm-Message-State: AOAM532h3Jc9IaLjiOQeCrOgsX/81I9pFXdsnvnJflmJVWh8zRUsH+KU
        6jdv36lEULsSAoD9e7fRYkc=
X-Google-Smtp-Source: ABdhPJzhKT070FMpmXHZSX2ge66cpPVsH13y9YHiAfKLwVbCD35kN3EvWoZWYU32L4l8hBacKrYntA==
X-Received: by 2002:a17:902:7404:b029:e4:503b:f83d with SMTP id g4-20020a1709027404b02900e4503bf83dmr28722675pll.35.1617032167700;
        Mon, 29 Mar 2021 08:36:07 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:3c:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id s8sm15366821pjg.29.2021.03.29.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 08:36:07 -0700 (PDT)
Date:   Mon, 29 Mar 2021 08:36:04 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Daphne Preston-Kendall <dpk@nonceword.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an
 error when TAI has not been configured
Message-ID: <20210329153604.GA21716@hoboy.vegasvil.org>
References: <87sg4iupzs.fsf@nanos.tec.linutronix.de>
 <20210327032859.GA3168@hoboy.vegasvil.org>
 <YGGbAIoCKDbZLQQ0@localhost>
 <20210329142612.GC20909@hoboy.vegasvil.org>
 <87o8f26m8c.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8f26m8c.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:57:55PM +0200, Thomas Gleixner wrote:
> I think adjtimex is the right place and not yet another random file
> somewhere. Something like the below.

Perfect.

Acked-by: Richard Cochran <richardcochran@gmail.com>

> ---
>  include/uapi/linux/timex.h |    7 +++++--
>  kernel/time/ntp.c          |    4 +++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> --- a/include/uapi/linux/timex.h
> +++ b/include/uapi/linux/timex.h
> @@ -188,9 +188,12 @@ struct __kernel_timex {
>  #define STA_MODE	0x4000	/* mode (0 = PLL, 1 = FLL) (ro) */
>  #define STA_CLK		0x8000	/* clock source (0 = A, 1 = B) (ro) */
>  
> +#define STA_TAISET	0x10000 /* TAI offset was set via adjtimex (ro) */
> +
>  /* read-only bits */
> -#define STA_RONLY (STA_PPSSIGNAL | STA_PPSJITTER | STA_PPSWANDER | \
> -	STA_PPSERROR | STA_CLOCKERR | STA_NANO | STA_MODE | STA_CLK)
> +#define STA_RONLY (STA_PPSSIGNAL | STA_PPSJITTER | STA_PPSWANDER |	\
> +		   STA_PPSERROR | STA_CLOCKERR | STA_NANO | STA_MODE |	\
> +		   STA_CLK | STA_TAISET)
>  
>  /*
>   * Clock states (time_state)
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -741,8 +741,10 @@ static inline void process_adjtimex_mode
>  	}
>  
>  	if (txc->modes & ADJ_TAI &&
> -			txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
> +	    txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET) {
>  		*time_tai = txc->constant;
> +		time_status |= STA_TAISET;
> +	}
>  
>  	if (txc->modes & ADJ_OFFSET)
>  		ntp_update_offset(txc->offset);
