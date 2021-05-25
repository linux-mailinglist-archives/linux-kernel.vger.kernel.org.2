Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDC390D18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhEYXzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhEYXzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:55:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AE5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:53:39 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n10so33521362ion.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aG3zY4Zwvqbw3qtldlfIyO67xCc+0gUh/5uHytg+r6E=;
        b=R/mtER1gnmpEBkn3Tg0/RihrpUbuBEVuL7DKt0XqBqreJcSG0Z8J4VuBYfK5dOI/c1
         5MU95DyH/G/6jKd/L43U+BxjcUtcpO6/Iz50nyV2E4uUfr60u+UljuRK8wyn8Akx9Akl
         p3YlIs8hipcIsS76ARrXVl/Qt405KLOgpCO3cItJVHnjNzof4V/ANcV4tXi+x+YmmFIB
         mzYFXEUv2SFD/xyQSEFqkdFzUzqc5iSUrjcqP4+x0qj+wiPzlm9/9jm7ldIgsipApsLo
         CwElgGe1vWXv5nmPr/3p+rTP/ZGNnNCtf0gvNbXJ0Byhy18uobEXzcU6XmvNntMj10Eb
         YWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aG3zY4Zwvqbw3qtldlfIyO67xCc+0gUh/5uHytg+r6E=;
        b=ENRmI2ZlBIQoC5HY4dMG08nmZ/Q4izv9HLKWOFvUzQUtspC+M4ujm/gRnpulLepjqI
         3zmdkyRu9E8T8VJoocEumtra2IUe+lOnBr8+Kys0H7hmlICL4w50QLz8NaJ4K1fKZ7nK
         c9CMnM2aMnDwdar2kYUlG5tsJVPM7u9GfhHe/yz1QotsNMW5qn879RZQYArWmYFt1eWr
         DfmmgqgA5lTZkYvcsAQD8ltLy3WjQpxQWt7LnqRpyqes2rirtAwuh1ZYuMbZpuQvU/FA
         ENx+BN9NI43czzqWqzhKk5UKoGvg1rPb2GdLnRXXWJbWLnb+cOyA8PwNbcnyRXPZutEc
         au8Q==
X-Gm-Message-State: AOAM531iVd2bZH/dWLcp7RCFV4j591T9ofuBpeObsVFQurDZlJtAtFR9
        W08Q8QmbgJicYoh3UxRnyNCE0AqAk43AGYssTQRYnQ==
X-Google-Smtp-Source: ABdhPJzxOJlsQB3tU2Uzg0D0TumlpulC81mlr+gpzk1rZak1zD0lvgQaRHLh2S/ox9rnZ5EoN7uKkdrVBDT73gGtdJg=
X-Received: by 2002:a6b:7714:: with SMTP id n20mr21483943iom.126.1621986818928;
 Tue, 25 May 2021 16:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210525233519.343068-1-tpiepho@gmail.com> <20210525233519.343068-2-tpiepho@gmail.com>
In-Reply-To: <20210525233519.343068-2-tpiepho@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 25 May 2021 16:53:27 -0700
Message-ID: <CAGS_qxpTWu1a2pVWqGxQe9uvX7A47Q86zZAdS-6r3xJhFmdfaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] lib/math/rational: Add Kunit test cases
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 4:36 PM Trent Piepho <tpiepho@gmail.com> wrote:
>
> Adds a number of test cases that cover a range of possible code paths.
>
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

LGTM, thanks!

> ---
> Changes from v2:
>   Rename file to follow new kunit naming convention
>   Fix whitespace issues
>   Remove unicode characters
>   Add more testcases
>
>  lib/Kconfig.debug         | 12 ++++++++
>  lib/math/Makefile         |  1 +
>  lib/math/rational_kunit.c | 60 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+)
>  create mode 100644 lib/math/rational_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580..6c0e66a7d416 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2429,6 +2429,18 @@ config BITS_TEST
>
>           If unsure, say N.
>
> +config RATIONAL_KUNIT_TEST
> +       tristate "KUnit test for rational.c" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       select RATIONAL
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the rational math unit test.
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 7456edb864fc..de7d16ca3cf5 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_PRIME_NUMBERS)     += prime_numbers.o
>  obj-$(CONFIG_RATIONAL)         += rational.o
>
>  obj-$(CONFIG_TEST_DIV64)       += test_div64.o
> +obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
> diff --git a/lib/math/rational_kunit.c b/lib/math/rational_kunit.c
> new file mode 100644
> index 000000000000..439b06fdfe66
> --- /dev/null
> +++ b/lib/math/rational_kunit.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/test.h>
> +
> +#include <linux/rational.h>
> +
> +struct rational_test_param {
> +       unsigned long num, den;
> +       unsigned long max_num, max_den;
> +       unsigned long exp_num, exp_den;
> +
> +       const char *name;
> +};
> +
> +static const struct rational_test_param test_parameters[] = {
> +       { 1230, 10,     100, 20,        100, 1,    "Exceeds bounds, semi-convergent term > half last term" },
> +       { 34567, 100,   120, 20,        120, 1,    "Exceeds bounds, semi-convergent term < half last term" },
> +       { 1, 30,        100, 10,        0, 1,      "Closest to zero" },
> +       { 1, 19,        100, 10,        1, 10,     "Closest to smallest non-zero" },
> +       { 1155, 7735,   255, 255,       33, 221,   "Exact answer" },
> +       { 27, 32,       16, 16,         11, 13,    "Convergent" },
> +       { 67, 54,       17, 18,         5, 4,      "Convergent, semiconvergent term half convergent term" },
> +       { 453, 182,     60, 60,         57, 23,    "Semiconvergent, semiconvergent term half convergent term" },
> +       { 87, 32,       70, 32,         68, 25,    "Semiconvergent, numerator limit" },
> +       { 14533, 4626,  15000, 2400,    7433, 2366, "Semiconvergent, demominator limit" },
> +};
> +
> +static void get_desc(const struct rational_test_param *param, char *desc)
> +{
> +       strscpy(desc, param->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +/* Creates function rational_gen_params */
> +KUNIT_ARRAY_PARAM(rational, test_parameters, get_desc);
> +
> +static void rational_test(struct kunit *test)
> +{
> +       const struct rational_test_param *param =
> +               (const struct rational_test_param *)test->param_value;
> +       unsigned long n = 0, d = 0;
> +
> +       rational_best_approximation(param->num, param->den, param->max_num, param->max_den, &n, &d);
> +       KUNIT_EXPECT_EQ(test, n, param->exp_num);
> +       KUNIT_EXPECT_EQ(test, d, param->exp_den);
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
