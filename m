Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3903976FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhFAPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:45:46 -0400
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:60896 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230288AbhFAPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:45:45 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F279218037362;
        Tue,  1 Jun 2021 15:44:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id F16BAD1517;
        Tue,  1 Jun 2021 15:44:02 +0000 (UTC)
Message-ID: <2e74612a83da2051f9111d695b8da87a3a199e66.camel@perches.com>
Subject: Re: [PATCH] kernel/time: Improve performance of time64_to_tm. Add
 tests.
From:   Joe Perches <joe@perches.com>
To:     Cassio Neri <cassio.neri@gmail.com>, john.stultz@linaro.org,
        tglx@linutronix.de
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Jun 2021 08:44:01 -0700
In-Reply-To: <20210531162054.45694-1-cassio.neri@gmail.com>
References: <20210531162054.45694-1-cassio.neri@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F16BAD1517
X-Spam-Status: No, score=-1.40
X-Stat-Signature: tgh7wajtn6mxc7f9r4hoeqxgyz98q8pz
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18VojcWT2hHAcdJ07ZdzR8Z01WO86H9dM0=
X-HE-Tag: 1622562242-70666
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-31 at 17:20 +0100, Cassio Neri wrote:
> The current implementation of time64_to_tm contains unnecessary loops,
> branches and look-up tables. The new one uses an arithmetic-based algorithm
> appeared in [1] and is ~3.3 times faster.
> 
> The drawback is that the new code isn't intuitive and contains many 'magic
> numbers' (not unusual for this type of algorithm). However, [1] justifies
> all those numbers and, given this function's history, I reckon the code is
> unlikely to need much maintenance, if any at all.
> 
> Added file kernel/time/time_test.c containing a KUnit test case that checks
> every day in a 160,000 years interval centered at 1970-01-01 against the
> expected result. A new config TIME_KUNIT_TEST symbol was introduced to
> give the option to run this test suite.

Apologies for the previous blank reply.

> diff --git a/kernel/time/timeconv.c b/kernel/time/timeconv.c
[]
> -/**
> - * time64_to_tm - converts the calendar time to local broken-down time
> +/*
> + * This function converts time64_t to rtc_time.
>   *
> - * @totalsecs:	the number of seconds elapsed since 00:00:00 on January 1, 1970,
> - *		Coordinated Universal Time (UTC).
> - * @offset:	offset seconds adding to totalsecs.
> - * @result:	pointer to struct tm variable to receive broken-down time
> + * @param[in]  totalsecs   The number of seconds since 01-01-1970 00:00:00.
> + * @param[in]  offset      Seconds added to totalsecs.
> + * @param[out] result      Pointer to struct tm variable to receive
> + *                         broken-down time.
>   */

Please do not change this header.
This is kernel-doc and you remove it.

>  void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
>  {
> -	long days, rem, y;
> +	long days, rem;
>  	int remainder;
> -	const unsigned short *ip;
> +
> +	u64 r0, n1, q1, u64rem;
> +	u32 r1, n2, q2, r2;
> +	u64 u2;
> +	u32 n3, q3, r3;
> +
> +	u32 j;
> +	u64 y;
> +	u32 m, d;

Perhaps use more descriptive naming.

> @@ -103,27 +92,40 @@ void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
>  	if (result->tm_wday < 0)
>  		result->tm_wday += 7;
>  
> 
> -	y = 1970;
> +	/*
> +	 * The following algorithm is Proposition 6.3 of Neri and Schneider,
> +	 * "Euclidean Affine Functions and Applications to Calendar Algorithms".
> +	 * https://arxiv.org/abs/2102.06959
> +	 */
>  
> 
> -	while (days < 0 || days >= (__isleap(y) ? 366 : 365)) {
> -		/* Guess a corrected year, assuming 365 days per year. */
> -		long yg = y + math_div(days, 365);
> +	r0 = days + 2305843009213814918;

Please use appropriate ULL markers for values >= 1<<32
and compile test using 32 bit compilers as most will emit
warnings for these values.

Also it might be useful to post test results for 32 bit compilers.
>  
> 
> -		/* Adjust DAYS and Y to match the guessed year. */
> -		days -= (yg - y) * 365 + leaps_between(y, yg);
> -		y = yg;
> -	}
> +	n1 = 4 * r0 + 3;
> +	q1 = div64_u64_rem(n1, 146097, &u64rem);
> +	r1 = u64rem / 4;
>  
> -	result->tm_year = y - 1900;
> +	n2 = 4 * r1 + 3;
> +	u2 = ((u64) 2939745) * n2;

It seems odd to cast numeric constants.

> +	/* r2 contains the number of days since previous Mar 1st and j == true
> +	 * if and only if month is Jan or Feb. The bellow is then a correction
> +	 * to get the numbers of days since previous Jan 1st.
> +	 */
> +	result->tm_yday = j ? r2 - 306 : r2 + 59 + is_leap(y);

Perhaps more readable to let the compiler create 306 and 59 by using
365, 31 and 28



