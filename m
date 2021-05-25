Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E8390615
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhEYQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:02:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:1839 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhEYQCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:02:41 -0400
IronPort-SDR: cgX0EZ4QbWl2zLWkQLjAVaISdoahNOw8saJY9CTTPmU9KaYz/O/3ChG2qexh2Cmlne1xi5hnUH
 6dRDdFTYTg6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202265988"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="202265988"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 09:01:02 -0700
IronPort-SDR: WLODMvOLqtpOE75Dwul1gst6vp9VgMAyE0Ryu4KH240t7tWH1ds66WPgPi749vDn1PqVVgYH2Z
 7sqRdtFYznBA==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="546829469"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 09:00:59 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1llZUF-00EcKd-0G; Tue, 25 May 2021 19:00:55 +0300
Date:   Tue, 25 May 2021 19:00:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andy@kernel.org,
        akpm@linux-foundation.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH v2 2/2] lib/math/rational: Add Kunit test cases
Message-ID: <YK0fNuZFGpCQw3Sd@smile.fi.intel.com>
References: <20210525144250.214670-1-tpiepho@gmail.com>
 <20210525144250.214670-2-tpiepho@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210525144250.214670-2-tpiepho@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 07:42:50AM -0700, Trent Piepho wrote:
> Adds a number of test cases that cover a range of possible code paths.

Good for the starter!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> ---
>  lib/Kconfig.debug        | 12 +++++++++
>  lib/math/Makefile        |  1 +
>  lib/math/rational-test.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 lib/math/rational-test.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580..6c0e66a7d416 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2429,6 +2429,18 @@ config BITS_TEST
>  
>  	  If unsure, say N.
>  
> +config RATIONAL_KUNIT_TEST
> +	tristate "KUnit test for rational.c" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	select RATIONAL
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the rational math unit test.
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 7456edb864fc..bfac26ddfc22 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
>  obj-$(CONFIG_RATIONAL)		+= rational.o
>  
>  obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
> +obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> diff --git a/lib/math/rational-test.c b/lib/math/rational-test.c
> new file mode 100644
> index 000000000000..f64166dbe9ea
> --- /dev/null
> +++ b/lib/math/rational-test.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/test.h>
> +
> +#include <linux/rational.h>
> +
> +struct rational_test_param {
> +	unsigned long num, den;
> +	unsigned long max_num, max_den;
> +	unsigned long exp_num, exp_den;
> +
> +	const char *name;
> +};
> +
> +static const struct rational_test_param test_parameters[] = {
> +	{ 1230,	10,	100, 20,	100, 1,    "Exceeds bounds, semi-convergent term > ½ last term" },
> +	{ 34567,100, 	120, 20,	120, 1,    "Exceeds bounds, semi-convergent term < ½ last term" },
> +	{ 1, 30,	100, 10,	0, 1,	   "Closest to zero" },
> +	{ 1, 19,	100, 10,	1, 10,     "Closest to smallest non-zero" },
> +	{ 27,32,	16, 16,		11, 13,    "Use convergent" },
> +	{ 1155, 7735,	255, 255,	33, 221,   "Exact answer" },
> +	{ 87, 32,	70, 32,		68, 25,    "Semiconvergent, numerator limit" },
> +	{ 14533, 4626,	15000, 2400,	7433, 2366, "Semiconvergent, demominator limit" },
> +};
> +
> +static void get_desc(const struct rational_test_param *param, char *desc)
> +{
> +	strscpy(desc, param->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +/* Creates function rational_gen_params */
> +KUNIT_ARRAY_PARAM(rational, test_parameters, get_desc);
> +
> +static void rational_test(struct kunit *test)
> +{
> +	const struct rational_test_param *param = (const struct rational_test_param *)test->param_value;
> +	unsigned long n = 0, d = 0;
> +
> +	rational_best_approximation(param->num, param->den, param->max_num, param->max_den, &n, &d);
> +	KUNIT_EXPECT_EQ(test, n, param->exp_num);
> +	KUNIT_EXPECT_EQ(test, d, param->exp_den);
> +}
> +
> +static struct kunit_case rational_test_cases[] = {
> +       KUNIT_CASE_PARAM(rational_test, rational_gen_params),
> +       {}
> +};
> +
> +static struct kunit_suite rational_test_suite = {
> +       .name = "rational",
> +       .test_cases = rational_test_cases,
> +};
> +
> +kunit_test_suites(&rational_test_suite);
> +
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


