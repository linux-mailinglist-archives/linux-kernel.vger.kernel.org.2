Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A68C311047
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhBERFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhBERBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 12:01:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD75C061788
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:43:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612550595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46T3e7IPiQjvvWNmdsCx/VP9WgjJf3TMPB2At7n7NO4=;
        b=0q9blxNOZca/qAJnf+VbiuFeMKUwhRLuGluPkhUFJS2gE5OjI/H7URNzTTvZDVBmvUfm9B
        UPQvZMXlr/IXnpvO6GGAfDhCEB6isk/erkFygCcd9v33OAq/bmAHGHf901H7/54bHYyIAK
        BoC24aplULALgUb+lTUzH6fXm19b65aISJq/aiJiv0MjKT29KnwvPiuCAcXc7j636eOlwY
        tE5A9Vfg0qOcAsAV495phDDDKbL26xtf7KemD4uQLbM4kDvB4LVyLjqlBW6BtwllQSihEF
        LocDp9ljoOIX5Et9YyDhlpolT0yroeaw8Mte7hy5kPYrp2Xio78BoUJlCn+IgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612550595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46T3e7IPiQjvvWNmdsCx/VP9WgjJf3TMPB2At7n7NO4=;
        b=6F/0pDM80PDAOtRG5A7G83y4A61jU05ZecITkBfUyTuYU79jD4O9GTRdLB01mh4YyEMSOr
        /uP4Z3fudtXrT3Aw==
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH] kernel: irq: Some words replce with better alternatives in the file timings.c
In-Reply-To: <20210205122836.1355944-1-unixbhaskar@gmail.com>
References: <20210205122836.1355944-1-unixbhaskar@gmail.com>
Date:   Fri, 05 Feb 2021 19:43:14 +0100
Message-ID: <878s828if1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar,

On Fri, Feb 05 2021 at 17:58, Bhaskar Chowdhury wrote:

The correct prefix for this file is:

   genirq/timings:

which you can find via: git log kernel/irq/timings.c

Also if you send a patch with spelling fixes then you might take care
that your subject line does not contain spelling mistakes ...

> +	 * ends the sequence as predictable for our purpose. In this
>  	 * case, assume we have the beginning of a sequence and the
> -	 * timestamp is the first value. As it is impossible to
> +	 * timestamps is the first value. As it is impossible to

timestamp is ... is correct

>  	 * predict anything at this point, return.
>  	 *
> -	 * Note the first timestamp of the sequence will always fall
> +	 * Note the first timestamps of the sequence will always fall

Same here

>  	 * in this test because the old_ts is zero. That is what we
> -	 * want as we need another timestamp to compute an interval.
> +	 * want as we need another timestamps to compute an interval.

And here.

>  	 */
>  	if (interval >= NSEC_PER_SEC) {
>  		irqs->count = 0;
> @@ -523,7 +523,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
>   * thus the count is reinitialized.
>   *
>   * The array of values **must** be browsed in the time direction, the
> - * timestamp must increase between an element and the next one.
> + * timestamps must increase between an element and the next one.

No 's' either.

>   *
>   * Returns a nanosec time based estimation of the earliest interrupt,
>   * U64_MAX otherwise.
> @@ -556,7 +556,7 @@ u64 irq_timings_next_event(u64 now)
>  	 * type but with the cost of extra computation in the
>  	 * interrupt handler hot path. We choose efficiency.
>  	 *
> -	 * Inject measured irq/timestamp to the pattern prediction
> +	 * Inject measured irq/timestamps to the pattern prediction

This one needs the 's', yes.

>  	 * model while decrementing the counter because we consume the
>  	 * data from our circular buffer.
>  	 */

Thanks,

        tglx
