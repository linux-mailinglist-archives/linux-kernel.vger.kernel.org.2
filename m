Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB823311140
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhBERuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhBEPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:52:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C957C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:34:00 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612546438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fABqgVHGSIcylUG/hBFzkYVB0r70cgGXiBucp9uc04g=;
        b=na0TyHwyQApMrnZcFKRYY6AWioWymdq6m0snMWRPu2oUKUDnfSeeFXwJrPSf3eGPJT03vV
        8aSqkAzIaI2fmeor2Fs3jyKJE7cJItmIKlYdfwWXXTBPTCyMXnwTM/PA904YsnZsXfUbOy
        gsHXVyyuvD1FZ1Y2+J4ILWzzjKiiKqiV/Nh1BQMG0f3JQSQS0ocGUTZTxQBmMSIlO5g3W2
        jH1maVHL98eTRxffWfTEnXwmW+Cc2944QzegS/Qu2tzwSAfKWHSsSmvdGezHkHLW0KkjS1
        rxhZwoW7BxZm214RqvdDUGPSgcJFQZUCKfBXkc/sutnGlpbaI3DDMxCyxVQTKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612546438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fABqgVHGSIcylUG/hBFzkYVB0r70cgGXiBucp9uc04g=;
        b=bbg3NbnTVfUPczQ4EBtYwAuQKvC8qBijv92iJsKiY+xwbNPWA28AbK49MWeUmLEW35C0id
        DJHCJ6y8dU6ZFjAQ==
To:     Yejune Deng <yejune.deng@gmail.com>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, yejune.deng@gmail.com
Subject: Re: [PATCH] ntp: use memset and offsetof init
In-Reply-To: <20210120025114.16294-1-yejune.deng@gmail.com>
References: <20210120025114.16294-1-yejune.deng@gmail.com>
Date:   Fri, 05 Feb 2021 18:33:58 +0100
Message-ID: <87k0rm8lmh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20 2021 at 10:51, Yejune Deng wrote:
> In pps_fill_timex(), use memset and offsetof instead of '= 0'.
>
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  kernel/time/ntp.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 87389b9e21ab..3416c0381104 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -225,14 +225,11 @@ static inline int is_error_status(int status)
>  static inline void pps_fill_timex(struct __kernel_timex *txc)
>  {
>  	/* PPS is not implemented, so these are zero */
> -	txc->ppsfreq	   = 0;
> -	txc->jitter	   = 0;
> -	txc->shift	   = 0;
> -	txc->stabil	   = 0;
> -	txc->jitcnt	   = 0;
> -	txc->calcnt	   = 0;
> -	txc->errcnt	   = 0;
> -	txc->stbcnt	   = 0;
> +	int offset, len;
> +
> +	offset = offsetof(struct __kernel_timex, ppsfreq);
> +	len    = offsetof(struct __kernel_timex, tai) - offset;
> +	memset(txc + offset, 0, len);

That zeros bytes at a memory location which is

     (offset) * sizeof(struct __kernel_timex)

bytes away from txc. How did this every boot?

And no, even if you fix that pointer math problem then this kind of
calculation from the middle of a struct is error prone.

Thanks,

        tglx
