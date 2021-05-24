Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19B38F1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhEXQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhEXQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:56:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:55:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e17so15980705iol.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCGFricQjCqKzwZaW3kUQGXMVuxnxkEkAZ7s/yaERUA=;
        b=sG8t4mZrhVVjAAKBB4G6b7mURLITxdFxZowTley4vKnO66HsO4mEvteCj2MVEZOJuK
         j64aJDG/naXDwU86a46u/0Cz3Ftbg0lSGDPVblLBiMk0L926zVEata+cMsABthlZ9ZQn
         e66AujY73WZnb5pd63kDqYSDi588rhppaJh+Cgb4YKaNvUz7ka3vA+Thmqsup6aw0PlH
         s4zc2E0ZqzT+5mlyFyWvuH/SKFtZTe7pVnycO9W1vp6X+3WCnnXM7f2XK4GIRmXnOgL4
         usgXPn9jCpxR2jIJ8WD5LnLZz7+f3mXcmkmN2jx4AcM06ndTcUr9tnzR1H3EAbsYkcdB
         JZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCGFricQjCqKzwZaW3kUQGXMVuxnxkEkAZ7s/yaERUA=;
        b=lbJqGXennJfdbdoPLql71AMqryD5D8+hoFVBF2Se3ZYTOnUZbYkCM7KVWE8+dfJicB
         +bsajs1ZBCpWKuT4gi5/hR+mbwab1z66hcu09+gnYL2fkohzCiP7GRwOQttJFBabqFFA
         rfZBbRkUZ7b76vm8gUThj1vR25wreuLR16eo4NiUGAFlDWWF19meDOyvzgE7eKmpyx/C
         /bSpf/Puao0ltZIPOS2NyQDSq7M3nDVradACLx24cFWGFkFuD1uE8NJz8VwmFABcOFje
         V4rY/uY3ATf3nFqPLg/uH8LNQIWIvFYIelnWgt4Va2uPw9AmzAlAzb9XqzY02YBA6FYm
         Z9QQ==
X-Gm-Message-State: AOAM530XID0613TkvqaE+yEH8kX77Ea5wPvgjVI600kUiDId9TvyIbAa
        OtMNDWs+LzwK21VngUlbGB5Hbfc7OXzrRrm2il85Dg==
X-Google-Smtp-Source: ABdhPJx15g9L/3CvukHmOn46pbBvJCT4nRHl3t6gaw0pipekzy/SJPM/UiSJNNASqPqS4BR4IwZlfFXhIpYwG31e0og=
X-Received: by 2002:a05:6602:54:: with SMTP id z20mr15240420ioz.48.1621875312955;
 Mon, 24 May 2021 09:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
In-Reply-To: <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 24 May 2021 09:55:01 -0700
Message-ID: <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Trent Piepho <tpiepho@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        oskar@scara.com, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 3:51 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, May 22, 2021 at 05:18:06PM -0700, Trent Piepho wrote:
>
> Thanks for the fix! My comments below.
>
> > If the input is out of the range of the allowed values, either larger
> > than the largest value or closer to zero than the smallest non-zero
> > allowed value, then a division by zero would occur.
> >
> > In the case of input too large, the division by zero will occur on the
> > first iteration.  The best result (largest allowed value) will be found
> > by always choosing the semi-convergent and excluding the denominator
> > based limit when finding it.
> >
> > In the case of the input too small, the division by zero will occur on
> > the second iteration.  The numerator based semi-convergent should not be
> > calculated to avoid the division by zero.  But the semi-convergent vs
> > previous convergent test is still needed, which effectively chooses
> > between 0 (the previous convergent) vs the smallest allowed fraction
> > (best semi-convergent) as the result.
>
> This misses the test cases (*). Please, develop them with Daniel.

FYI, I was leaning towards not having this in the proposed
math_kunit.c, since this code is gated behind CONFIG_RATIONAL=y, while
the others are not.
I.e. I think we want to add a new rational_kunit.c to contain this test case.

I can help write it up if wanted, but I'll give some pointers on how
to do so below.

Trent, https://www.kernel.org/doc/html/latest/dev-tools/kunit/start.html
would be the entry point for KUnit documentation.
After you feel comfortable with the following, I'd recommend
https://www.kernel.org/doc/html/latest/dev-tools/kunit/usage.html#testing-against-multiple-inputs

You can run the tests added via something like this

$ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
CONFIG_KUNIT=y
CONFIG_RATIONAL=y
CONFIG_RATIONAL_KUNIT_TEST=y
EOF

(feel free to put the heredoc into a file, just using it for a
copy-paste friendly one-liner)

given a starting change like this (which I can see crash w/o the fix,
and pass w/ it).

diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index f19bc9734fa7..20460b567493 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -15,3 +15,14 @@ config PRIME_NUMBERS

 config RATIONAL
        bool
+
+config RATIONAL_KUNIT_TEST
+       tristate "KUnit test for rational number support" if !KUNIT_ALL_TESTS
+       # depends on KUNIT && RATIONAL  # this is how it should work, but
+       depends on KUNIT
+       select RATIONAL # I don't grok kconfig enough to know why this
is necessary
+       default KUNIT_ALL_TESTS
+       help
+               This builds unit tests for the rational number support.
+
+               If unsure, say N.
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 7456edb864fc..a11ffdb953ef 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PRIME_NUMBERS)     += prime_numbers.o
 obj-$(CONFIG_RATIONAL)         += rational.o

 obj-$(CONFIG_TEST_DIV64)       += test_div64.o
+obj-$(CONFIG_RATIONAL_KUNIT_TEST)      += rational_kunit.o
diff --git a/lib/math/rational_kunit.c b/lib/math/rational_kunit.c
new file mode 100644
index 000000000000..88ad0e2baece
--- /dev/null
+++ b/lib/math/rational_kunit.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+
+#include <linux/rational.h>
+
+static void rational_bug_test(struct kunit *test)
+{
+       unsigned long n = 0, d = 0;
+
+       rational_best_approximation(31415, 100, (1 << 8) - 1, (1 << 5)
- 1, &n, &d);
+       KUNIT_EXPECT_EQ(test, n, 255);
+       KUNIT_EXPECT_EQ(test, d, 1);
+}
+
+static struct kunit_case rational_test_cases[] = {
+       KUNIT_CASE(rational_bug_test),
+       {}
+};
+
+static struct kunit_suite rational_test_suite = {
+       .name = "rational",
+       .test_cases = rational_test_cases,
+};
+
+kunit_test_suites(&rational_test_suite);
+
+MODULE_LICENSE("GPL v2");



>
> *) We usually don't accept changes in the generic libraries without test cases.
>
> Fixes tag?
>
> > Reported-by: Yiyuan Guo <yguoaz@gmail.com>
> > Signed-off-by: Trent Piepho <tpiepho@gmail.com>
>
> ...
>
> > +                     /* This tests if the semi-convergent is closer than the previous
> > +                      * convergent.  If d1 is zero there is no previous convergent as this
> > +                      * is the 1st iteration, so always choose the semi-convergent.
> >                        */
> > -                     if (2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> > +                     if (!d1 || 2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
> >                               n1 = n0 + t * n1;
> >                               d1 = d0 + t * d1;
> >                       }
>
> I think that refactoring may lead us to check first iteration before even going
> into the loop. But it's another story and we may do it later (the algo uses
> heavy division anyway, so couple of additional branches probably won't affect
> performance too much).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
