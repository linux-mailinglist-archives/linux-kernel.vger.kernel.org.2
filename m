Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261D53907CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhEYRgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhEYRft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:35:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA703C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:34:18 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e17so19916425iol.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5lrDELqW5Drz5Hiwm8yf8JZU2CjM3Lmf+IJx7j5yfYU=;
        b=QPE8hZFYe7mxrh8HfGDXEoulDcEhcBPHUWeB6tUNXBM20HS8U9Ynqr5sjuAhebaP4e
         X3+TIk9LtdlywQ6Sw2IiJTieHjeYz6Dp2y8zUOWa/OwIA8Ea5+6Bm5PQtRBnUnXT6OWT
         77yYD7mfJF3ZDC0S4ticA++D35JwCCxUzmZ7m1jarJd570V4P+txyZfM4PzAHDf1PCkn
         zKwr9NzMhX16pwzxPeO03M/MyJ7sthoEFm35W1tTUeUDzZuRevg+kUH5+gX6mdGhJOzT
         nTbajPCZ487zq7XkRkfAnxFT7yVWGw0wxFmBYLCPEKuotMFuSygxaT6F5UUTTnpZqEuN
         on5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5lrDELqW5Drz5Hiwm8yf8JZU2CjM3Lmf+IJx7j5yfYU=;
        b=c9U1FTTd+dPO4e8FBCFJmiKowJe5coVQSGgmhgnFMzl8jG4ybB30bL7ac/RNgbLqKW
         zpPoYTiCmE8WCFBuWoLKd0GbX2tAgSDi4cvrXXJwd4YFFP/L60IcdMG5DGvMqzRtV09V
         2LyEhIZoXdybl2B8MC8vJP9qukk5OoitKfP0zHUCEbvb2qoCeovOFicsbOVySs3+ulf0
         vZ+kmhsKyW9o6lB1wtCLzlcvRukfI1RyN9fdTQLnQqpY+KgGGUmPB050HcMWOdSMiyKg
         1U1A4p5vuxlwx7u4BmziH0jsIl6UMYvsKoetyxeRJ+WB/PiLCCy+58GULrwbM/d/TwEK
         nyjQ==
X-Gm-Message-State: AOAM532lLaTcnlBaEDBxISIDnReJBPy4gsRBAvm1QEVRNUyACiIEfwHy
        Z5t5J6otX1QUZlgXjIcXSBmx3pLCH7yIDNpupgbfUw==
X-Google-Smtp-Source: ABdhPJwVQB67EdDuDmmgMg/etKxA0H+E6XmuaQqef52U8be4K8+LPcnOooqG8EbAa7/D6J3lNQPRsxop2VmrcybYwEs=
X-Received: by 2002:a05:6602:54:: with SMTP id z20mr20470242ioz.48.1621964057874;
 Tue, 25 May 2021 10:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210525144250.214670-1-tpiepho@gmail.com> <20210525144250.214670-2-tpiepho@gmail.com>
In-Reply-To: <20210525144250.214670-2-tpiepho@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 25 May 2021 10:34:05 -0700
Message-ID: <CAGS_qxqSo=s5=geB56QGKtgsHwjYfULYJfuaCTcghY3+c9yVBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/math/rational: Add Kunit test cases
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 7:43 AM Trent Piepho <tpiepho@gmail.com> wrote:
>
> Adds a number of test cases that cover a range of possible code paths.
>
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks really good to me, just two nits.

Tangent:
I didn't check to see that this covers all the interesting cases, but
it seems like it does.
If you want, you can try generating a code coverage report to double check.
Instructions for doing so can be found in
https://lore.kernel.org/linux-kselftest/20210414222256.1280532-1-dlatypov@g=
oogle.com/
I would have done that and included the #s in this email, but my
workplace decided to subtly break my workstation in some way and I
haven't gotten around to root causing...

> ---
>  lib/Kconfig.debug        | 12 +++++++++
>  lib/math/Makefile        |  1 +
>  lib/math/rational-test.c | 56 ++++++++++++++++++++++++++++++++++++++++

Ah, sorry, I forgot to mention this in the previous email.
If you look at kunit/style.rst docs, you'll see the documentation now
states a preference for the name of this file to be one of
{rational_test.c, rational_kunit.c}

Unfortunately, we have a number of tests throughout the tree that
don't reflect this, including lib/kunit/kunit-example-test.c :(

>  3 files changed, 69 insertions(+)
>  create mode 100644 lib/math/rational-test.c
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
> +         For more information on KUnit and unit tests in general please =
refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 7456edb864fc..bfac26ddfc22 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_PRIME_NUMBERS)     +=3D prime_numbers.o
>  obj-$(CONFIG_RATIONAL)         +=3D rational.o
>
>  obj-$(CONFIG_TEST_DIV64)       +=3D test_div64.o
> +obj-$(CONFIG_RATIONAL_KUNIT_TEST) +=3D rational-test.o
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
> +       unsigned long num, den;
> +       unsigned long max_num, max_den;
> +       unsigned long exp_num, exp_den;
> +
> +       const char *name;
> +};
> +
> +static const struct rational_test_param test_parameters[] =3D {
> +       { 1230, 10,     100, 20,        100, 1,    "Exceeds bounds, semi-=
convergent term > =C2=BD last term" },
> +       { 34567,100,    120, 20,        120, 1,    "Exceeds bounds, semi-=
convergent term < =C2=BD last term" },

very minor nit: there's an extraneous space character after the "100,"

> +       { 1, 30,        100, 10,        0, 1,      "Closest to zero" },
> +       { 1, 19,        100, 10,        1, 10,     "Closest to smallest n=
on-zero" },
> +       { 27,32,        16, 16,         11, 13,    "Use convergent" },
> +       { 1155, 7735,   255, 255,       33, 221,   "Exact answer" },
> +       { 87, 32,       70, 32,         68, 25,    "Semiconvergent, numer=
ator limit" },
> +       { 14533, 4626,  15000, 2400,    7433, 2366, "Semiconvergent, demo=
minator limit" },
> +};
> +
> +static void get_desc(const struct rational_test_param *param, char *desc=
)
> +{
> +       strscpy(desc, param->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +/* Creates function rational_gen_params */
> +KUNIT_ARRAY_PARAM(rational, test_parameters, get_desc);
> +
> +static void rational_test(struct kunit *test)
> +{
> +       const struct rational_test_param *param =3D (const struct rationa=
l_test_param *)test->param_value;
> +       unsigned long n =3D 0, d =3D 0;
> +
> +       rational_best_approximation(param->num, param->den, param->max_nu=
m, param->max_den, &n, &d);
> +       KUNIT_EXPECT_EQ(test, n, param->exp_num);
> +       KUNIT_EXPECT_EQ(test, d, param->exp_den);
> +}
> +
> +static struct kunit_case rational_test_cases[] =3D {
> +       KUNIT_CASE_PARAM(rational_test, rational_gen_params),
> +       {}
> +};
> +
> +static struct kunit_suite rational_test_suite =3D {
> +       .name =3D "rational",
> +       .test_cases =3D rational_test_cases,
> +};
> +
> +kunit_test_suites(&rational_test_suite);
> +
> +MODULE_LICENSE("GPL v2");
> --
> 2.26.2
>
