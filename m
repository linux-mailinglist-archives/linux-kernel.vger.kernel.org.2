Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0983B0F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFVVij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVVii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:38:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C0BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 14:36:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso29611wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0ZEVvjuHzd2ACo/dIcrBaloN44ChLz98dWzTFd7BC4=;
        b=Hrg7q7XrOU/ZiC3OQPncaOVpH4LaHdnzfqQ9Cdxha1N+e692kwi1CVSztk9ebBahbV
         RtvacJzWioG5DvHYKcQIAuj4HicAAVaWb6prX9W78RQq89MKcHfn3UazoyRShnZjOeCJ
         ijmGi1Gtt4uYeT1S2LQV1vALJcNSqcNk1NsgkSOI2c3X2JbWdWwvm+xCCVT66g5yDWn+
         ySlJqB8NhXHwuxWXFtJDVMnv6CeP3JBTAHig/OwV+Ow+wAd2h4hTUCp/KtxBRGdJ0GvY
         u1nMJo1oaQDI69ietfG4mVNcbzGjSMvUh2XHvPMtMXeLUKwxIgzad2u1nEJrRMHV0i6c
         dAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0ZEVvjuHzd2ACo/dIcrBaloN44ChLz98dWzTFd7BC4=;
        b=qkxq4p6Q1+eNGTbMWKDXI/QpaASXNXhh72EltKxCb5VEU4onDDoxM/RLt0khfpobKD
         bsl9Bcde6dKvGZhUtOzvLG/YzFaomTlaLYE/ASrTDQGoUG0u+Cy12OaxTC7TO0n7ef9b
         XEen1v5ps6WweJ/saxOKnKmEvkgjRZPIcxI8XouuThrDlOH8RDGKrgMbvoss7L5v9nGy
         XMuo9hrDLpoTvW4yhp4BbfjP+tF5GtBNgZd6lkTuxa+BcybQ7Vw0v7Rg2Ur9A3mVs4g3
         HGI/WZXBIX00kGKKEcoJm5Yg53mIHRFJ/8HQ3fZPzbluv9sTeenMC+ilsllumoih5QVo
         xIlw==
X-Gm-Message-State: AOAM531C6DJvS1Km6Ghn2hdN4GVdF0W8eA3yKE1uO4nLDUGswvoQMjnz
        J3PK2PMU71ZTGYajoill8lE=
X-Google-Smtp-Source: ABdhPJzto5h2P9HzwtqCQw0gLvshXrIkRZiRp8+BgKsObGa2M3NHrK0wCv9HpZxImEmNmax01sp8uw==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr6950193wmi.157.1624397780817;
        Tue, 22 Jun 2021 14:36:20 -0700 (PDT)
Received: from othello.cust.communityfibre.co.uk ([2a02:6b64:80a9:0:1be:22d4:3c1d:bcad])
        by smtp.gmail.com with ESMTPSA id f5sm622264wrf.22.2021.06.22.14.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 14:36:20 -0700 (PDT)
From:   Cassio Neri <cassio.neri@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org,
        Cassio Neri <cassio.neri@gmail.com>
Subject: [PATCH v4] time: Improve performance of time64_to_tm(). Add tests.
Date:   Tue, 22 Jun 2021 22:36:16 +0100
Message-Id: <20210622213616.313046-1-cassio.neri@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cassio Neri <cassio.neri@gmail.com>

The current implementation of time64_to_tm() contains unnecessary loops,
branches and look-up tables. The new one uses an arithmetic-based algorithm
appeared in [1] and is approximately 3x faster (YMMV).

The drawback is that the new code isn't intuitive and contains many 'magic
numbers' (not unusual for this type of algorithm). However, [1] justifies
all those numbers and, given this function's history, the code is unlikely
to need much maintenance, if any at all.

Add a KUnit test for it which checks every day in a 160,000 years interval
centered at 1970-01-01 against the expected result.

[1] Neri, Schneider, "Euclidean Affine Functions and Applications to
Calendar Algorithms". https://arxiv.org/abs/2102.06959

Signed-off-by: Cassio Neri <cassio.neri@gmail.com>

---

* Disclaimer: I'm an author of [1].

* Test evidence: Same test implemented by time_test.c, compiler switches
are close to kernel's, and it's possible to run this test on 32 and 64
bits:

    https://godbolt.org/z/chcoee8o9

* Benchmarks: Measures the time taken by each implementation to process
65,536 pseudo-random numbers (time64_t) drawn under the uniform
distribution on the interval corresponding to dates spanning 800 years
centered at 1970-01-01:

    https://quick-bench.com/q/bPV45fKpIgB7Q6QXZ7I1a-Y9AGw

(Apologies that the benchmark is in C++ but results in C should be close.
Results need to be taken with a pinch of salt since compiler switches are
not the same as the kernel's.)

* Disasembly: Compiler switches are close to kernel's and shows, in
particular, reduction in code size:

    https://godbolt.org/z/6rq7jvcfz

* History:

  v4 Address Thomas Gleixner's comments: changelog text, reverse variable
     declarations, fix tabulation and changed expression of is_leap_year.
  v3 Address Joe Perches' comments: rename variable, change some types and
     use upper_32_bits and lower_32_bits.
  v2 Address Joe Perches's comments: more descriptive variable names, use
     ULL markers and other smaller changes.
  v1 Original implementation.

* Many thanks to reviewers.

---
 kernel/time/Kconfig     |   9 +++
 kernel/time/Makefile    |   1 +
 kernel/time/time_test.c |  98 ++++++++++++++++++++++++++++++
 kernel/time/timeconv.c  | 128 ++++++++++++++++++++++------------------
 4 files changed, 178 insertions(+), 58 deletions(-)
 create mode 100644 kernel/time/time_test.c

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 83e158d016ba..3610b1bef142 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -64,6 +64,15 @@ config LEGACY_TIMER_TICK
 	  lack support for the generic clockevent framework.
 	  New platforms should use generic clockevents instead.
 
+config TIME_KUNIT_TEST
+	tristate "KUnit test for kernel/time functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test RTC library functions.
+
+	  If unsure, say N.
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 1fb1c1ef6a19..b733d09a6e4d 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
 obj-$(CONFIG_TIME_NS)				+= namespace.o
+obj-$(CONFIG_TIME_KUNIT_TEST)			+= time_test.o
diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
new file mode 100644
index 000000000000..341ebfad5e99
--- /dev/null
+++ b/kernel/time/time_test.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: LGPL-2.1+
+
+#include <kunit/test.h>
+#include <linux/time.h>
+
+/*
+ * Traditional implementation of leap year evaluation.
+ */
+static bool is_leap(long year)
+{
+	return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
+}
+
+/*
+ * Gets the last day of a month.
+ */
+static int last_day_of_month(long year, int month)
+{
+	if (month == 2)
+		return 28 + is_leap(year);
+	if (month == 4 || month == 6 || month == 9 || month == 11)
+		return 30;
+	return 31;
+}
+
+/*
+ * Advances a date by one day.
+ */
+static void advance_date(long *year, int *month, int *mday, int *yday)
+{
+	if (*mday != last_day_of_month(*year, *month)) {
+		++*mday;
+		++*yday;
+		return;
+	}
+
+	*mday = 1;
+	if (*month != 12) {
+		++*month;
+		++*yday;
+		return;
+	}
+
+	*month = 1;
+	*yday  = 0;
+	++*year;
+}
+
+/*
+ * Checks every day in a 160000 years interval centered at 1970-01-01
+ * against the expected result.
+ */
+static void time64_to_tm_test_date_range(struct kunit *test)
+{
+	/*
+	 * 80000 years	= (80000 / 400) * 400 years
+	 *		= (80000 / 400) * 146097 days
+	 *		= (80000 / 400) * 146097 * 86400 seconds
+	 */
+	time64_t total_secs = ((time64_t) 80000) / 400 * 146097 * 86400;
+	long year = 1970 - 80000;
+	int month = 1;
+	int mdday = 1;
+	int yday = 0;
+
+	struct tm result;
+	time64_t secs;
+	s64 days;
+
+	for (secs = -total_secs; secs <= total_secs; secs += 86400) {
+
+		time64_to_tm(secs, 0, &result);
+
+		days = div_s64(secs, 86400);
+
+		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
+			year, month, mdday, yday, days
+
+		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, month - 1, result.tm_mon, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, mdday, result.tm_mday, FAIL_MSG);
+		KUNIT_ASSERT_EQ_MSG(test, yday, result.tm_yday, FAIL_MSG);
+
+		advance_date(&year, &month, &mdday, &yday);
+	}
+}
+
+static struct kunit_case time_test_cases[] = {
+	KUNIT_CASE(time64_to_tm_test_date_range),
+	{}
+};
+
+static struct kunit_suite time_test_suite = {
+	.name = "time_test_cases",
+	.test_cases = time_test_cases,
+};
+
+kunit_test_suite(time_test_suite);
diff --git a/kernel/time/timeconv.c b/kernel/time/timeconv.c
index 62e3b46717a6..f876218427a3 100644
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -22,47 +22,16 @@
 
 /*
  * Converts the calendar time to broken-down time representation
- * Based on code from glibc-2.6
  *
  * 2009-7-14:
  *   Moved from glibc-2.6 to kernel by Zhaolei<zhaolei@cn.fujitsu.com>
+ * 2021-06-02:
+ *   Partially reimplemented by Cassio Neri <cassio.neri@gmail.com>
  */
 
 #include <linux/time.h>
 #include <linux/module.h>
-
-/*
- * Nonzero if YEAR is a leap year (every 4 years,
- * except every 100th isn't, and every 400th is).
- */
-static int __isleap(long year)
-{
-	return (year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0);
-}
-
-/* do a mathdiv for long type */
-static long math_div(long a, long b)
-{
-	return a / b - (a % b < 0);
-}
-
-/* How many leap years between y1 and y2, y1 must less or equal to y2 */
-static long leaps_between(long y1, long y2)
-{
-	long leaps1 = math_div(y1 - 1, 4) - math_div(y1 - 1, 100)
-		+ math_div(y1 - 1, 400);
-	long leaps2 = math_div(y2 - 1, 4) - math_div(y2 - 1, 100)
-		+ math_div(y2 - 1, 400);
-	return leaps2 - leaps1;
-}
-
-/* How many days come before each month (0-12). */
-static const unsigned short __mon_yday[2][13] = {
-	/* Normal years. */
-	{0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365},
-	/* Leap years. */
-	{0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366}
-};
+#include <linux/kernel.h>
 
 #define SECS_PER_HOUR	(60 * 60)
 #define SECS_PER_DAY	(SECS_PER_HOUR * 24)
@@ -77,9 +46,11 @@ static const unsigned short __mon_yday[2][13] = {
  */
 void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
 {
-	long days, rem, y;
+	u64 u64tmp, udays, century, year;
+	u32 u32tmp, day_of_century, year_of_century, day_of_year, month, day;
+	bool is_Jan_or_Feb, is_leap_year;
+	long days, rem;
 	int remainder;
-	const unsigned short *ip;
 
 	days = div_s64_rem(totalsecs, SECS_PER_DAY, &remainder);
 	rem = remainder;
@@ -103,27 +74,68 @@ void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
 	if (result->tm_wday < 0)
 		result->tm_wday += 7;
 
-	y = 1970;
-
-	while (days < 0 || days >= (__isleap(y) ? 366 : 365)) {
-		/* Guess a corrected year, assuming 365 days per year. */
-		long yg = y + math_div(days, 365);
-
-		/* Adjust DAYS and Y to match the guessed year. */
-		days -= (yg - y) * 365 + leaps_between(y, yg);
-		y = yg;
-	}
-
-	result->tm_year = y - 1900;
-
-	result->tm_yday = days;
-
-	ip = __mon_yday[__isleap(y)];
-	for (y = 11; days < ip[y]; y--)
-		continue;
-	days -= ip[y];
-
-	result->tm_mon = y;
-	result->tm_mday = days + 1;
+	/*
+	 * The following algorithm is, basically, Proposition 6.3 of Neri
+	 * and Schneider [1]. In a few words: it works on the computational
+	 * (fictitious) calendar where the year starts in March, month = 2
+	 * (*), and finishes in February, month = 13. This calendar is
+	 * mathematically convenient because the day of the year does not
+	 * depend on whether the year is leap or not. For instance:
+	 *
+	 * March 1st		0-th day of the year;
+	 * ...
+	 * April 1st		31-st day of the year;
+	 * ...
+	 * January 1st		306-th day of the year; (Important!)
+	 * ...
+	 * February 28th	364-th day of the year;
+	 * February 29th	365-th day of the year (if it exists).
+	 *
+	 * After having worked out the date in the computational calendar
+	 * (using just arithmetics) it's easy to convert it to the
+	 * corresponding date in the Gregorian calendar.
+	 *
+	 * [1] "Euclidean Affine Functions and Applications to Calendar
+	 * Algorithms". https://arxiv.org/abs/2102.06959
+	 *
+	 * (*) The numbering of months follows tm more closely and thus,
+	 * is slightly different from [1].
+	 */
+
+	udays	= ((u64) days) + 2305843009213814918ULL;
+
+	u64tmp		= 4 * udays + 3;
+	century		= div64_u64_rem(u64tmp, 146097, &u64tmp);
+	day_of_century	= (u32) (u64tmp / 4);
+
+	u32tmp		= 4 * day_of_century + 3;
+	u64tmp		= 2939745ULL * u32tmp;
+	year_of_century	= upper_32_bits(u64tmp);
+	day_of_year	= lower_32_bits(u64tmp) / 2939745 / 4;
+
+	year		= 100 * century + year_of_century;
+	is_leap_year	= year_of_century ? !(year_of_century % 4) : !(century % 4);
+
+	u32tmp		= 2141 * day_of_year + 132377;
+	month		= u32tmp >> 16;
+	day		= ((u16) u32tmp) / 2141;
+
+	/*
+	 * Recall that January 1st is the 306-th day of the year in the
+	 * computational (not Gregorian) calendar.
+	 */
+	is_Jan_or_Feb	= day_of_year >= 306;
+
+	/* Converts to the Gregorian calendar and adjusts to Unix time. */
+	year		= year + is_Jan_or_Feb - 6313183731940000ULL;
+	month		= is_Jan_or_Feb ? month - 12 : month;
+	day		= day + 1;
+	day_of_year	+= is_Jan_or_Feb ? -306 : 31 + 28 + is_leap_year;
+
+	/* Converts to tm's format. */
+	result->tm_year = (long) (year - 1900);
+	result->tm_mon  = (int) month;
+	result->tm_mday = (int) day;
+	result->tm_yday = (int) day_of_year;
 }
 EXPORT_SYMBOL(time64_to_tm);

base-commit: 245a057fee18be08d6ac12357463579d06bea077
-- 
2.32.0

