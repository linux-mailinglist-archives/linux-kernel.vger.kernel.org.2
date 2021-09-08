Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3813403CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbhIHPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:47:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52946 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349643AbhIHPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:47:01 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631115952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yAkHgPRVcQqnWyQ1zDi3CwlV2IitkRbB6BYiUctgc3g=;
        b=o8TPCpLtGsMByVPW2Q4LcL1PERyzDwLjxhcQ1V8EnIDAyxznNaJFeJdg4EysHbkYEc3TpT
        KRJE20mgOHSRYoy74RnkqVfuAoyT5j/Y+IDem2m1ob7pJUGFFeWiZM3XBNolUDAeX5TtnC
        zBdcoaF1/pFz3WELomz8VB4swnfof+pFlGZcEzdOZvWmD+wPdieZ/bt0DKNNYV+sUJ5zWg
        73iLsOYu6W4kCZr7cV8bSnRhByb6VLm+j5sEZ3/TqNddycPvebfMKdez/BvAxelxKcY/vi
        TAJ7+87u4fcfaVIIhoheXELIiS5CAl6SMlCalqZM6vTLU2KMP8BNvKIt5SGsAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631115952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yAkHgPRVcQqnWyQ1zDi3CwlV2IitkRbB6BYiUctgc3g=;
        b=tv5pNvXF7zaO9Ge2R6UTtt67S4tqoGmxA8ILV59yqYtKuhVXqButc4f2wgOnR2MjwUUQRP
        KlQ77FtKbtUcazDw==
To:     OPENSOURCE Lukas Hannen 
        <lukas.hannen@opensource.tttech-industrial.com>,
        John Stultz <john.stultz@linaro.org>,
        "EMC: linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Subject: [PATCH] changed timespec64_to_ns to avoid underrun
In-Reply-To: <AM6PR01MB541637BD6F336B8FFB72AF80EEC69@AM6PR01MB5416.eurprd01.prod.exchangelabs.com>
References: <AM6PR01MB541637BD6F336B8FFB72AF80EEC69@AM6PR01MB5416.eurprd01.prod.exchangelabs.com>
Date:   Wed, 08 Sep 2021 17:45:51 +0200
Message-ID: <87y2876pg0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

On Wed, Aug 25 2021 at 10:12, OPENSOURCE Lukas Hannen wrote:

thanks for the patch. A few formal nitpicks:

The subject line lacks a subsystem prefix. You can figure that 
usually out by running:

   git log --format=oneline --abbrev-commit include/linux/time64.h

Look for the most used. So in this case it would be simply 'time:'

'changed ... underrun'

Please use imperative mood, i.e. 'Change'. But 'change' is redundant
here anyway because it would not be a patch if it would not change
anything.

So something like: 'Handle negative seconds correctly in timespec64_to_ns()'
would be more informative. Your subject line does not really match
the problem.

Also note the brackets which make it obvious that this talks about a
function.

You have a redundant 'Subject:' in the Subject: header

> This patch fixes a small oversight in timespec64_to_ns() that has

This patch is redundant as well. See Documentation/process/ and grep for
'This patch'

> resulted in negative seconds being erroneously clamped to KTIME_MAX
> due to a cast to unsigned long long (which expands to the 2's complement
> of a negative long long, even if the architecture does not implement
> negative numbers using 2's complement)
>
> This is especially relevant in the PTP context, since the ptp_clock_info
> struct (from include/linux/ptp_clock_kernel.h) specifies
>
>	int (*adjtime)(struct ptp_clock_info *ptp, s64 delta);
>	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
> 
> which is exactly the kind of timespec64 / nanoseconds mix in combination
> with negative values ( ns adjust times ) that can easily lead to calling
> timespec64_to_ns with a negative ts->tv_sec, which would in turn lead to
> instability of the ptp clock.

This is confusing at best.

The adjtime() callback has nothing to do with timespec64_to_ns(). The
conversion happens in the calling code.

gettime64() neither because that reads the time from the PTP clock which
cannot be negative and nothing uses timespec64_to_ns() there either.

The place where a negative seconds value must be handled correctly is
ptp_clock_adjtime().


So something like this:

timespec64_ns() prevents multiplication overflows by comparing the
seconds value of the timespec to KTIME_SEC_MAX. If the value is greater
or equal it returns KTIME_MAX.

But that check casts the signed seconds value to unsigned which makes
the comparision true for all negative values and therefore return
wrongly KTIME_MAX.

Negative second values are perfectly valid and required in some places,
e.g. ptp_clock_adjtime().

Remove the cast and add a check for the negative boundary which is
required to prevent undefined behaviour of the multiplication due to
multiplication underflow.

Hmm?

> Fixes: cb47755725da ("time: Prevent undefined behaviour in timespec64_to_ns()")'
> Signed-off-by: Lukas Hannen <lukas.hannen@opensource.tttech-industrial.com>
>
> ---
> The Patch should apply cleanly to all the branches that the original

Emphasis on should. See below.

> commit cb47755725da ("time: Prevent undefined behaviour in timespec64_to_ns()")'
> was backported to.
>
> include/linux/time64.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/time64.h b/include/linux/time64.h
> index 5117cb5b56561..81b9686a20799 100644
> --- a/include/linux/time64.h
> +++ b/include/linux/time64.h
> @@ -21,15 +21,17 @@ struct itimerspec64 {
>  };
>
>  /* Located here for timespec[64]_valid_strict */
>  #define TIME64_MAX                     ((s64)~((u64)1 << 63))
>  #define TIME64_MIN                     (-TIME64_MAX - 1)
>
>  #define KTIME_MAX                      ((s64)~((u64)1 << 63))
> +#define KTIME_MIN                      (-KTIME_MAX - 1)
>  #define KTIME_SEC_MAX                  (KTIME_MAX / NSEC_PER_SEC)
> +#define KTIME_SEC_MIN                  (KTIME_MIN / NSEC_PER_SEC)

Your patch is white space damaged, which makes it fail to apply.
Something replaced all tabs with spaces, most likely your mail client.

Please figure out a way to send patches either via git-email or by using
a email client which tries not to be smarter than the person using it.
Send the patch to yourself and validate that it applies cleanly.

I fixed it up for you this time.

Thanks,

        tglx
