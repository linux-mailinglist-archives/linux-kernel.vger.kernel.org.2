Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A073B09DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFVQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:05:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:05:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624377817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JnVKyMg9SuBYhTFBMyALQ+Z3KB0NJsIz1GdkzeqLkzk=;
        b=QVnxklIR50F1oybZT+erCBwaf0P9FJ2mo7fNzsYf2mqY2f4SvTVwszNEuTN/hPuNfFgpdg
        /8E9LmFLCf6z/5QbYQo/YodedAQ/TqrLVi2kMTq/q6rRsXmpQeHAFHStB4mwaSP7qh6t7m
        Mp3P7vdKTC0BFSzJ2bluQfiyqTcnLxwb4+qJkfzu+jzyRyNSkvDGDav/mfIx+FAbgfn4C2
        1IafR58Brw4/c6tUEW+D/D8aOZ9TsRxF341me6rZmFau+S08oXrO+f/6DSD01g4qSAkEoT
        zUJ1kT8ZaRaQ25l3zvgzjCd0WRcSVbvCBosnRuG6/rTvqffUGLxbd49FUuRNiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624377817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JnVKyMg9SuBYhTFBMyALQ+Z3KB0NJsIz1GdkzeqLkzk=;
        b=hBiq9ea+DX0cVi8XpoDs8zKKZC02dJakjOtGx2srW7HGVP5XsyDkcsQ5Q9vM3evAnRJXmM
        hIL1C0HrGQZqm7Bg==
To:     Cassio Neri <cassio.neri@gmail.com>, john.stultz@linaro.org
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org,
        Cassio Neri <cassio.neri@gmail.com>
Subject: Re: [PATCH v3] kernel/time: Improve performance of time64_to_tm. Add tests.
In-Reply-To: <20210602190004.47049-1-cassio.neri@gmail.com>
References: <20210602190004.47049-1-cassio.neri@gmail.com>
Date:   Tue, 22 Jun 2021 18:03:37 +0200
Message-ID: <87lf71evja.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cassio,

On Wed, Jun 02 2021 at 20:00, Cassio Neri wrote:

A few nitpicks vs. the subject line. The proper prefix is 'time:' and
please write time64_to_tm().

> The current implementation of time64_to_tm contains unnecessary loops,
> branches and look-up tables. The new one uses an arithmetic-based algorithm
> appeared in [1] and is ~3.2 times faster (YMMV).
>
> The drawback is that the new code isn't intuitive and contains many 'magic
> numbers' (not unusual for this type of algorithm). However, [1] justifies
> all those numbers and, given this function's history, I reckon the code is

s/I reckon//

> unlikely to need much maintenance, if any at all.
>
> Added file kernel/time/time_test.c containing a KUnit test case that checks
> every day in a 160,000 years interval centered at 1970-01-01 against the
> expected result. A new config TIME_KUNIT_TEST symbol was introduced to
> give the option to run this test suite.

Add a KUnit test for it which checks every day in a 160,000 years
interval centered at 1970-01-01 against the expected result.

Changelogs should be written in imperative mood. The details about the
filename and the config symbol are not interesting for the change log.

> * Test evidence: This runs the same test implemented in
> kernel/time/time_test.c (see above). It's possible to run it on 32 and 64
> bits.
>
>     https://godbolt.org/z/1rn1aqfqY

Just that this uses XMM registers which the kernel does not. :)

> +/*
> + * Tradicional implementation of is_leap.

Traditional

Also the comment is odd. ... implementation of "is_leap" above a
function named "is_leap" !?!

You probably want to say:

    Traditional implementation of leap year evaluation.

or something like that.


>  void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
>  {
> -	long days, rem, y;
> +	long days, rem;
>  	int remainder;
> -	const unsigned short *ip;
> +
> +	u64 u64tmp, udays, century, year;
> +	u32 u32tmp, day_of_century, year_of_century, day_of_year, month,
> +		day;
> +	bool is_Jan_or_Feb, is_leap;

Can you please reorder that so it results in a reverse fir tree:

	u64 u64tmp, udays, century, year;
	u32 u32tmp, day_of_century, year_of_century, day_of_year, month, day;
	bool is_Jan_or_Feb, is_leap;
	long days, rem;
 	int remainder;

> +
> +	udays           = ((u64) days) + 2305843009213814918ULL;

The tabulation uses spaces instead of tabs here and in various places below.

> +
> +	u64tmp          = 4 * udays + 3;
> +	century         = div64_u64_rem(u64tmp, 146097, &u64tmp);
> +	day_of_century  = (u32) (u64tmp / 4);
> +
> +	u32tmp          = 4 * day_of_century + 3;
> +	u64tmp          = 2939745ULL * u32tmp;
> +	year_of_century = upper_32_bits(u64tmp);
> +	day_of_year     = lower_32_bits(u64tmp) / 2939745 / 4;
> +
> +	year            = 100 * century + year_of_century;
> +	is_leap         = year_of_century != 0 ?
> +		year_of_century % 4 == 0 : century % 4 == 0;

This really is hard to read.

	is_leap		= year_of_century != 0 ?
			  year_of_century % 4 == 0 : century % 4 == 0;

or just:

	is_leap         = year_of_century ? !(year_of_century % 4) : !(century % 4);

That's longer than 80 characters, but that's not a really hard rule.

> +	u32tmp          = 2141 * day_of_year + 132377;
> +	month           = u32tmp >> 16;
> +	day             = ((u16) u32tmp) / 2141;
> +
> +	/* Recall that January 01 is the 306-th day of the year in the
> +	 * computational (not Gregorian) calendar.
> +	 */

        /*
         * Please format multiline comments according to regular
         * kernel codingstyle.
         */

> +	is_Jan_or_Feb   = day_of_year >= 306;
> +
> +	/* Converts to the Gregorian calendar and adjusts to Unix time. */
> +	year            = year + is_Jan_or_Feb - 6313183731940000ULL;
> +	month           = is_Jan_or_Feb ? month - 12 : month;
> +	day             = day + 1;
> +	day_of_year     = is_Jan_or_Feb ?
> +		day_of_year - 306 : day_of_year + 31 + 28 + is_leap;

See above.

Other than these nitpicks. Nice work!

Thanks,

        tglx
