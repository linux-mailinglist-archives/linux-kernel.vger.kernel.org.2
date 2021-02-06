Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1E311A41
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBFDhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhBFCkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:40:40 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EBC08EE2A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 16:30:02 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id x81so8849133qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 16:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0LzoWkDG6kTjS+MHMPiAc7h3VC/7ldZ4zMm47YimA8=;
        b=YuEtQeXa+rLEE7RxWElrFxp7pRRvHtwhuqij0AsG1vKz3BGDByRmYPq6ym4fTrfrMX
         gYjcRwBM2zS4BxTYDFcB7emNAlw28pm7Xx6mSRSrSsSAsYoQt2QcN9sbD/1QuMlqyQh8
         o3IaQIDquDWdpStQpMmMG84Z4B/YFS4Ye/xRUWkod+ckJndW4t5qhnLBDv9PtOSeTKrS
         +J9YdOaMrVLEzua2EEm02/lKEwPxgN+t/Ec2qfkasDIBZAEBKRoJZzrZ2CNuwfppESng
         hU22H3Q8duXTk2KaWWJv0hiLN4syln26DNceKKScno5OgZYWtPX5js9RK0xcasyyyiDf
         q5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/0LzoWkDG6kTjS+MHMPiAc7h3VC/7ldZ4zMm47YimA8=;
        b=XlO+1GtM9DzYdYQj4I7YFjsiaV49BgbxdSc2LH+a8VHjPLqCZxgWWsqPcWRLh7fjhl
         yD49N+3nZKhtPtGyAqCLbL8oi2cHCdn1ad35/YZB5Nor1h5I8eXN21uZledBGW1TLHEj
         hplaSWeS115vE1mn7bg4Z9oHdPOvVwNqh/LoZx09XzPLSiElGAPALw8XFM69VPodEd/7
         gUtwuy5sowHdrLzxapM1W52ckF43zLgEt8YTzMoji/Axxjg+qg0krnrrYe0V54FOr+s5
         0Eyx+H8ItfpgMTkhdyORvc6YlkilpO+5A3Yjj2D5kV769eTy9b//idEFekZOtBPykBSs
         0JFw==
X-Gm-Message-State: AOAM533QYcrJkM6H4k2GaOOdcplacc3cxVUy7e4F/qFUynVm7JEf7ol1
        4entH60I2UWPVLa4J/3UXygi3ZHDRujJBGc3
X-Google-Smtp-Source: ABdhPJxjfFnFgLoeuOiTPWkD+dPTVtJzGoDmLmEc4+BLzV42IcuYt4SnuSkYPEvIck5KzRTyISrWfw==
X-Received: by 2002:ae9:c319:: with SMTP id n25mr7025121qkg.468.1612571401524;
        Fri, 05 Feb 2021 16:30:01 -0800 (PST)
Received: from Gentoo ([156.146.58.50])
        by smtp.gmail.com with ESMTPSA id w38sm4328404qth.79.2021.02.05.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:30:00 -0800 (PST)
Date:   Sat, 6 Feb 2021 06:00:30 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] kernel: irq: Some words replce with better alternatives
 in the file timings.c
Message-ID: <YB3jJuqqy2oms1wm@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210205122836.1355944-1-unixbhaskar@gmail.com>
 <878s828if1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dHknB+CH36qmhPBT"
Content-Disposition: inline
In-Reply-To: <878s828if1.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dHknB+CH36qmhPBT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 19:43 Fri 05 Feb 2021, Thomas Gleixner wrote:
>Bhaskar,
>
>On Fri, Feb 05 2021 at 17:58, Bhaskar Chowdhury wrote:
>
>The correct prefix for this file is:
>
>   genirq/timings:
>
>which you can find via: git log kernel/irq/timings.c
>
>Also if you send a patch with spelling fixes then you might take care
>that your subject line does not contain spelling mistakes ...

Whoops! good catch ....thanks, Tohomas!
>
>> +	 * ends the sequence as predictable for our purpose. In this
>>  	 * case, assume we have the beginning of a sequence and the
>> -	 * timestamp is the first value. As it is impossible to
>> +	 * timestamps is the first value. As it is impossible to
>
>timestamp is ... is correct
>
>>  	 * predict anything at this point, return.
>>  	 *
>> -	 * Note the first timestamp of the sequence will always fall
>> +	 * Note the first timestamps of the sequence will always fall
>
>Same here
>
>>  	 * in this test because the old_ts is zero. That is what we
>> -	 * want as we need another timestamp to compute an interval.
>> +	 * want as we need another timestamps to compute an interval.
>
>And here.
>
>>  	 */
>>  	if (interval >= NSEC_PER_SEC) {
>>  		irqs->count = 0;
>> @@ -523,7 +523,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
>>   * thus the count is reinitialized.
>>   *
>>   * The array of values **must** be browsed in the time direction, the
>> - * timestamp must increase between an element and the next one.
>> + * timestamps must increase between an element and the next one.
>
>No 's' either.
>
>>   *
>>   * Returns a nanosec time based estimation of the earliest interrupt,
>>   * U64_MAX otherwise.
>> @@ -556,7 +556,7 @@ u64 irq_timings_next_event(u64 now)
>>  	 * type but with the cost of extra computation in the
>>  	 * interrupt handler hot path. We choose efficiency.
>>  	 *
>> -	 * Inject measured irq/timestamp to the pattern prediction
>> +	 * Inject measured irq/timestamps to the pattern prediction
>
>This one needs the 's', yes.
>
>>  	 * model while decrementing the counter because we consume the
>>  	 * data from our circular buffer.
>>  	 */
>

Can we please forget that this attempt is ever exists :)

>Thanks,
>
>        tglx

--dHknB+CH36qmhPBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAd4yIACgkQsjqdtxFL
KRWDsQgAtlYtIQuNFClWb2S+awUBWW02JmNGtDGRcO2G4wN/5+lB4S4ZUJHljMTX
Ld3ZtjqW9w+3+Oq3LjU2dH/o0GdGtFbiXcXvHb1wIt7ZMpwmSlB6vX0hPF/J0Rwk
r9iJxfdteZnXbGSST6H2jby/6XMWezhnyPq1zh3zB07MeKOKxJmNpQGdplXN/yah
i4X+YxOV4aqcEbmrfknSo7XjWy4Nx/PGdWdntosLeGs0ohX2tGFz17sPihj5GYhD
RePA/p3lNVWivaVFJtTAjhOr+SD0CCOvGpkxCl3e0rHox6iLN0I0lmqTQwcmAROv
GmZSmUWbMv3psK+Q4dJxiQLM8MU8kg==
=gDhn
-----END PGP SIGNATURE-----

--dHknB+CH36qmhPBT--
