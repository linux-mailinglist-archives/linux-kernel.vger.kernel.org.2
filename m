Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6A3976CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhFAPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:37:27 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:55744 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230385AbhFAPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:37:26 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 3E097100E7B46;
        Tue,  1 Jun 2021 15:35:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 3A3DC1A29F8;
        Tue,  1 Jun 2021 15:35:42 +0000 (UTC)
Message-ID: <94d7df0774ca9f18c3bbc818714fcee7045b3fa0.camel@perches.com>
Subject: Re: [PATCH] kernel/time: Improve performance of time64_to_tm. Add
 tests.
From:   Joe Perches <joe@perches.com>
To:     Cassio Neri <cassio.neri@gmail.com>, john.stultz@linaro.org,
        tglx@linutronix.de
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Jun 2021 08:35:41 -0700
In-Reply-To: <20210531162054.45694-1-cassio.neri@gmail.com>
References: <20210531162054.45694-1-cassio.neri@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A3DC1A29F8
X-Spam-Status: No, score=-1.40
X-Stat-Signature: dbojhdignweuz41poyqryijzhzw9uyx6
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+etLeSJSjCWlh8BULRT6kERXHo3FNnrPs=
X-HE-Tag: 1622561742-36034
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
> 
> [1] Neri, Schneider, "Euclidean Affine Functions and Applications to
> Calendar Algorithms". https://arxiv.org/abs/2102.06959
> 
> Signed-off-by: Cassio Neri <cassio.neri@gmail.com>
> 
> ---
> 
> * Disclaimer: I'm an author of [1] and, surely, I have an interest in
> seeing my algorithm made into the kernel. If not by this patch, I'm
> willing to work closely with maintainers, if they wish, in order to write
> an appropriate implementation.
> 
> * Benchmarks: It measures the time taken by each implementation to process
> 65,536 numbers. These numbers are pseudo-random under the uniform
> distribution on the interval corresponding to dates spanning 800 years
> centered at 1970-01-01:
> 
>     https://quick-bench.com/q/i4IssrPmwid7CHOT4OLao82sBzY
> 
> (Apologies that the benchmark is in C++ but results in C should be close.)
> 
> Disasembly: Shows, in particular, reduction in code size:
> 
>     https://godbolt.org/z/nra84xr8e
> 
> * FWIW: drivers/rtc/lib.c implements rtc_time64_to_tm very similarly to
> time64_to_tm. I've submitted a patch to RTC maintainers to make similar
> changes:
> 
>     https://tinyurl.com/dxsz2nv7
> 
> ---
>  kernel/time/Kconfig     |   9 ++++
>  kernel/time/Makefile    |   1 +
>  kernel/time/time_test.c |  98 ++++++++++++++++++++++++++++++++++++
>  kernel/time/timeconv.c  | 108 ++++++++++++++++++++--------------------
>  4 files changed, 163 insertions(+), 53 deletions(-)
>  create mode 100644 kernel/time/time_test.c
> 
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index 83e158d016ba..3610b1bef142 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -64,6 +64,15 @@ config LEGACY_TIMER_TICK
>  	  lack support for the generic clockevent framework.
>  	  New platforms should use generic clockevents instead.
>  
> 
> +config TIME_KUNIT_TEST
> +	tristate "KUnit test for kernel/time functions" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable this option to test RTC library functions.
> +
> +	  If unsure, say N.
> +
>  if GENERIC_CLOCKEVENTS
>  menu "Timers subsystem"
>  
> 
> diff --git a/kernel/time/Makefile b/kernel/time/Makefile
> index 1fb1c1ef6a19..b733d09a6e4d 100644
> --- a/kernel/time/Makefile
> +++ b/kernel/time/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
>  obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
>  obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
>  obj-$(CONFIG_TIME_NS)				+= namespace.o
> +obj-$(CONFIG_TIME_KUNIT_TEST)			+= time_test.o
> diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
> new file mode 100644
> index 000000000000..7893539cb458
> --- /dev/null
> +++ b/kernel/time/time_test.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: LGPL-2.1+
> +
> +#include <kunit/test.h>
> +#include <linux/time.h>
> +
> +/*
> + * Tradicional implementation of is_leap.
> + */
> +static bool is_leap(long year)
> +{
> +	return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
> +}
> +
> +/*
> + * Gets the last day of a month.
> + */
> +static int last_day_of_month(long year, int month)
> +{
> +	if (month == 2)
> +		return 28 + is_leap(year);
> +	if (month == 4 || month == 6 || month == 9 || month == 11)
> +		return 30;
> +	return 31;
> +}
> +
> +/*
> + * Advances a date by one day.
> + */
> +static void advance_date(long *year, int *month, int *mday, int *yday)
> +{
> +	if (*mday != last_day_of_month(*year, *month)) {
> +		++*mday;
> +		++*yday;
> +		return;
> +	}
> +
> +	*mday = 1;
> +	if (*month != 12) {
> +		++*month;
> +		++*yday;
> +		return;
> +	}
> +
> +	*month = 1;
> +	*yday  = 0;
> +	++*year;
> +}
> +
> +/*
> + * Checks every day in a 160000 years interval centered at 1970-01-01
> + * against the expected result.
> + */
> +static void time64_to_tm_test_date_range(struct kunit *test)
> +{
> +	/*
> +	 *  80000 years = (80000 / 400) * 400 years
> +	 *              = (80000 / 400) * 146097 days
> +	 *              = (80000 / 400) * 146097 * 86400 seconds
> +	 */
> +	time64_t total_secs = ((time64_t) 80000) / 400 * 146097 * 86400;
> +	long     year       = 1970 - 80000;
> +	int      month      = 1;
> +	int      mdday      = 1;
> +	int      yday       = 0;
> +
> +	struct tm result;
> +	time64_t  secs;
> +	s64       days;
> +
> +	for (secs = -total_secs; secs <= total_secs; secs += 86400) {
> +
> +		time64_to_tm(secs, 0, &result);
> +
> +		days = div_s64(secs, 86400);
> +
> +		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
> +			year, month, mdday, yday, days
> +
> +		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
> +		KUNIT_ASSERT_EQ_MSG(test, month - 1, result.tm_mon, FAIL_MSG);
> +		KUNIT_ASSERT_EQ_MSG(test, mdday, result.tm_mday, FAIL_MSG);
> +		KUNIT_ASSERT_EQ_MSG(test, yday, result.tm_yday, FAIL_MSG);
> +
> +		advance_date(&year, &month, &mdday, &yday);
> +	}
> +}
> +
> +static struct kunit_case time_test_cases[] = {
> +	KUNIT_CASE(time64_to_tm_test_date_range),
> +	{}
> +};
> +
> +static struct kunit_suite time_test_suite = {
> +	.name = "time_test_cases",
> +	.test_cases = time_test_cases,
> +};
> +
> +kunit_test_suite(time_test_suite);
> diff --git a/kernel/time/timeconv.c b/kernel/time/timeconv.c
> index 62e3b46717a6..21ede23cd719 100644
> --- a/kernel/time/timeconv.c
> +++ b/kernel/time/timeconv.c
> @@ -22,64 +22,53 @@
>  
> 
>  /*
>   * Converts the calendar time to broken-down time representation
> - * Based on code from glibc-2.6
>   *
>   * 2009-7-14:
>   *   Moved from glibc-2.6 to kernel by Zhaolei<zhaolei@cn.fujitsu.com>
> + * 2021-5-22:
> + *   Partially reimplemented by Cassio Neri <cassio.neri@gmail.com>
>   */
>  
> 
>  #include <linux/time.h>
>  #include <linux/module.h>
>  
> 
>  /*
> - * Nonzero if YEAR is a leap year (every 4 years,
> - * except every 100th isn't, and every 400th is).
> + * True if y is a leap year (every 4 years, except every 100th isn't, and
> + * every 400th is).
>   */
> -static int __isleap(long year)
> +static bool is_leap(long year)
>  {
> -	return (year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0);
> +	/* This implementation is more branch-predictor friendly than the
> +	 * traditional:
> +	 *   return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
> +	 */
> +	return year % 100 != 0 ? year % 4 == 0 : year % 400 == 0;
>  }
>  
> 
> -/* do a mathdiv for long type */
> -static long math_div(long a, long b)
> -{
> -	return a / b - (a % b < 0);
> -}
> -
> -/* How many leap years between y1 and y2, y1 must less or equal to y2 */
> -static long leaps_between(long y1, long y2)
> -{
> -	long leaps1 = math_div(y1 - 1, 4) - math_div(y1 - 1, 100)
> -		+ math_div(y1 - 1, 400);
> -	long leaps2 = math_div(y2 - 1, 4) - math_div(y2 - 1, 100)
> -		+ math_div(y2 - 1, 400);
> -	return leaps2 - leaps1;
> -}
> -
> -/* How many days come before each month (0-12). */
> -static const unsigned short __mon_yday[2][13] = {
> -	/* Normal years. */
> -	{0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365},
> -	/* Leap years. */
> -	{0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366}
> -};
> -
>  #define SECS_PER_HOUR	(60 * 60)
>  #define SECS_PER_DAY	(SECS_PER_HOUR * 24)
>  
> 
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
>  
> 
>  	days = div_s64_rem(totalsecs, SECS_PER_DAY, &remainder);
>  	rem = remainder;
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
> 
> -	result->tm_year = y - 1900;
> +	n2 = 4 * r1 + 3;
> +	u2 = ((u64) 2939745) * n2;
> +	q2 = u2 >> 32;
> +	r2 = ((u32) u2) / 2939745 / 4;
>  
> 
> -	result->tm_yday = days;
> +	n3 = 2141 * r2 + 197913;
> +	q3 = n3 >> 16;
> +	r3 = ((u16) n3) / 2141;
>  
> 
> -	ip = __mon_yday[__isleap(y)];
> -	for (y = 11; days < ip[y]; y--)
> -		continue;
> -	days -= ip[y];
> +	j = r2 >= 306;
> +	y = 100 * q1 + q2 + j - 6313183731940000;
> +	m = j ? q3 - 12 : q3;
> +	d = r3 + 1;
>  
> 
> -	result->tm_mon = y;
> -	result->tm_mday = days + 1;
> +	result->tm_year = y - 1900;
> +	result->tm_mon  = m - 1;
> +	result->tm_mday = d;
> +
> +	/* r2 contains the number of days since previous Mar 1st and j == true
> +	 * if and only if month is Jan or Feb. The bellow is then a correction
> +	 * to get the numbers of days since previous Jan 1st.
> +	 */
> +	result->tm_yday = j ? r2 - 306 : r2 + 59 + is_leap(y);
>  }
>  EXPORT_SYMBOL(time64_to_tm);
> 
> base-commit: 245a057fee18be08d6ac12357463579d06bea077


