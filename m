Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6DF3F6D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 04:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhHYCdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 22:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbhHYCdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:33:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93428C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:32:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e1so6495613plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eDJmVvgenVuiIv2JEnx8MK1MJtgJ4Z9SkKmag4UFJOE=;
        b=OHer6DSzHuzgbdiT8IIbRRDD+g7/i5dXXp4CBNVYTDQa+ehW/taWIkkf1fwUeoFzP8
         txx2AOzpmJ638nD0PeREtA7aOJxXRZAjn8QnMwqpk5L3kgP6R5JQPeAAkfRZf9yomAaD
         W9/ZPZ6i14ukXTZYuiESo3p2auMy5i6FZdruk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eDJmVvgenVuiIv2JEnx8MK1MJtgJ4Z9SkKmag4UFJOE=;
        b=l5m/u4dDk4AEVlrs9gsJWBgptWydMoixq429HgYKp3595u12Kr5PNKqmZIm+S80GWV
         CUqVylK2Fvf/io3JcUQOcrosIyW9ixnYbUU3SNChzkQFIkuh19I/QhaNVYSncpN177fD
         e0d5G0fxU94SK9Cf/mAXc1GbQ6g1m0O7hPMlVFQNBQZf3QehNHDMECSVqoj77/IK80+2
         tB49HGRN1eI4PEgCdcnGIfw2o7CwU6VwdaCYHhamIRsCXfTGp1Y29HkR5qOmpN230vSZ
         hp+EQoAu7nPb1zkDGxlv62MZkaMaprdsPjn2/mVlqeFX1x48hrtaVQdR9YMEGpsNKCZb
         69IQ==
X-Gm-Message-State: AOAM531436zH9Mub4ToyI56MtXQTVIB7c0SEM8rxG9j/38+0ANC0dqVH
        8Pd9t7PzP8ZOsiaZMxw9UmetsA==
X-Google-Smtp-Source: ABdhPJwHK/HQN7ocahSaJv0B2/ksMf6ueoQEKg1gRTzT5mQ9oiv63nsCgteO9MtRHSmJVg1lf1b1KA==
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id u4-20020a170902a604b029012cdda230c4mr35345108plq.73.1629858772979;
        Tue, 24 Aug 2021 19:32:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13sm20544264pfi.210.2021.08.24.19.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 19:32:52 -0700 (PDT)
Date:   Tue, 24 Aug 2021 19:32:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH for-next 21/25] lib: Introduce CONFIG_TEST_MEMCPY
Message-ID: <202108241921.26866A8F@keescook>
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-22-keescook@chromium.org>
 <CABVgOSn=fmUctW_xexDyS_c4G3ee4vGvuJLaanRDQbzQkfAOBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn=fmUctW_xexDyS_c4G3ee4vGvuJLaanRDQbzQkfAOBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:00:19PM +0800, David Gow wrote:
> On Sun, Aug 22, 2021 at 3:56 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Before changing anything about memcpy(), memmove(), and memset(), add
> > run-time tests to check basic behaviors for any regressions.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Thanks for adding a KUnit test here: it's great to have better
> coverage of some of these basic functions!
> 
> There's a name mismatch with the Kconfig entry and the Makefile,
> otherwise this looks good and works fine on my machine (under both UML
> and qemu/x86_64).

Hah! Whoops. Thanks for noticing this -- I think I didn't use a clean
tree and never noticed because I had the old module.

> It would be possible to split these tests up further if you wanted,
> which could be useful if there's a desire to track the individual
> assertion results independently. That's probably what I'd've done, but
> It's a matter of personal preference either way, though: the tests
> aren't absurdly huge or over-complicated as-is.

Noted. Yeah, for me, I think it's "does memcpy work or not?" and each of
the EXPECTs are required, so it felt like 1 test with lots of EXPECTs.

> > +FORTIFY_SOURCE
> > +M:     Kees Cook <keescook@chomium.org>
> > +L:     linux-hardening@vger.kernel.org
> > +S:     Supported
> > +F:     include/linux/fortify-string.h
> > +F:     lib/test_fortify/*
> > +F:     scripts/test_fortify.sh
> > +K:     \b__NO_FORTIFY\b
> > +
> 
> Do you want this to be part of the memcpy() KUnit test commit, or is
> it better suited in one of the changes to the actual fortify stuff?

Whoops, thanks. This got --fixup'ed into the wrong patch. I've moved it
now.

> >  FPGA DFL DRIVERS
> >  M:     Wu Hao <hao.wu@intel.com>
> >  R:     Tom Rix <trix@redhat.com>
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 831212722924..9199be57ba2a 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2467,6 +2467,17 @@ config RATIONAL_KUNIT_TEST
> >
> >           If unsure, say N.
> >
> > +config MEMCPY_KUNIT_TEST
> > +       tristate "Test memcpy(), memmove(), and memset() functions at runtime" if !KUNIT_ALL_TESTS
> > +       depends on KUNIT
> > +       default KUNIT_ALL_TESTS
> > +       help
> > +         Builds unit tests for memcpy(), memmove(), and memset() functions.
> > +         For more information on KUnit and unit tests in general please refer
> > +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +         If unsure, say N.
> > +
> >  config TEST_UDELAY
> >         tristate "udelay test driver"
> >         help
> > diff --git a/lib/Makefile b/lib/Makefile
> > index bd17c2bf43e1..8a4c8bdb38a2 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -77,6 +77,7 @@ obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
> >  obj-$(CONFIG_TEST_LKM) += test_module.o
> >  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
> >  obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> > +obj-$(CONFIG_TEST_MEMCPY) += test_memcpy.o
> 
> This doesn't match CONFIG_MEMCPY_KUNIT_TEST above, so the test is
> never compiled in.

Now fixed to be CONFIG_MEMCPY_KUNIT_TEST.

> 
> >  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
> >  obj-$(CONFIG_TEST_SORT) += test_sort.o
> >  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
> > diff --git a/lib/test_memcpy.c b/lib/test_memcpy.c
> > new file mode 100644
> > index 000000000000..ec546cec883e
> > --- /dev/null
> > +++ b/lib/test_memcpy.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test cases for memcpy(), memmove(), and memset().
> > + */
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <kunit/test.h>
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/overflow.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/vmalloc.h>
> > +
> > +struct some_bytes {
> > +       union {
> > +               u8 data[32];
> > +               struct {
> > +                       u32 one;
> > +                       u16 two;
> > +                       u8  three;
> > +                       /* 1 byte hole */
> > +                       u32 four[4];
> > +               };
> > +       };
> > +};
> > +
> > +#define check(instance, v) do {        \
> > +       int i;  \
> > +       BUILD_BUG_ON(sizeof(instance.data) != 32);      \
> > +       for (i = 0; i < sizeof(instance.data); i++) {   \
> > +               KUNIT_ASSERT_EQ_MSG(test, instance.data[i], v, \
> > +                       "line %d: '%s' not initialized to 0x%02x @ %d (saw 0x%02x)\n", \
> > +                       __LINE__, #instance, v, i, instance.data[i]);   \
> > +       }       \
> > +} while (0)
> > +
> > +#define compare(name, one, two) do { \
> > +       int i; \
> > +       BUILD_BUG_ON(sizeof(one) != sizeof(two)); \
> > +       for (i = 0; i < sizeof(one); i++) {     \
> > +               KUNIT_EXPECT_EQ_MSG(test, one.data[i], two.data[i], \
> > +                       "line %d: %s.data[%d] (0x%02x) != %s.data[%d] (0x%02x)\n", \
> > +                       __LINE__, #one, i, one.data[i], #two, i, two.data[i]); \
> > +       }       \
> > +       kunit_info(test, "ok: " TEST_OP "() " name "\n");       \
> > +} while (0)
> > +
> > +static void memcpy_test(struct kunit *test)
> > +{
> > +#define TEST_OP "memcpy"
> > +       struct some_bytes control = {
> > +               .data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                       },
> > +       };
> > +       struct some_bytes zero = { };
> > +       struct some_bytes middle = {
> > +               .data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                         0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00,
> > +                         0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                       },
> > +       };
> > +       struct some_bytes three = {
> > +               .data = { 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                         0x20, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                         0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
> > +                       },
> > +       };
> > +       struct some_bytes dest = { };
> > +       int count;
> > +       u8 *ptr;
> > +
> > +       /* Verify static initializers. */
> > +       check(control, 0x20);
> > +       check(zero, 0);
> > +       compare("static initializers", dest, zero);
> > +
> > +       /* Verify assignment. */
> > +       dest = control;
> > +       compare("direct assignment", dest, control);
> > +
> > +       /* Verify complete overwrite. */
> > +       memcpy(dest.data, zero.data, sizeof(dest.data));
> > +       compare("complete overwrite", dest, zero);
> > +
> > +       /* Verify middle overwrite. */
> > +       dest = control;
> > +       memcpy(dest.data + 12, zero.data, 7);
> > +       compare("middle overwrite", dest, middle);
> > +
> > +       /* Verify argument side-effects aren't repeated. */
> > +       dest = control;
> > +       ptr = dest.data;
> > +       count = 1;
> > +       memcpy(ptr++, zero.data, count++);
> > +       ptr += 8;
> > +       memcpy(ptr++, zero.data, count++);
> > +       compare("argument side-effects", dest, three);
> > +#undef TEST_OP
> > +}
> > +
> > +static void memmove_test(struct kunit *test)
> > +{
> > +#define TEST_OP "memmove"
> > +       struct some_bytes control = {
> > +               .data = { 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                       },
> > +       };
> > +       struct some_bytes zero = { };
> > +       struct some_bytes middle = {
> > +               .data = { 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x00, 0x00, 0x00, 0x00,
> > +                         0x00, 0x00, 0x00, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                       },
> > +       };
> > +       struct some_bytes five = {
> > +               .data = { 0x00, 0x00, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x00, 0x00, 0x00, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                       },
> > +       };
> > +       struct some_bytes overlap = {
> > +               .data = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> > +                         0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                       },
> > +       };
> > +       struct some_bytes overlap_expected = {
> > +               .data = { 0x00, 0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0x07,
> > +                         0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                         0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
> > +                       },
> > +       };
> > +       struct some_bytes dest = { };
> > +       int count;
> > +       u8 *ptr;
> > +
> > +       /* Verify static initializers. */
> > +       check(control, 0x99);
> > +       check(zero, 0);
> > +       compare("static initializers", zero, dest);
> > +
> > +       /* Verify assignment. */
> > +       dest = control;
> > +       compare("direct assignment", dest, control);
> > +
> > +       /* Verify complete overwrite. */
> > +       memmove(dest.data, zero.data, sizeof(dest.data));
> > +       compare("complete overwrite", dest, zero);
> > +
> > +       /* Verify middle overwrite. */
> > +       dest = control;
> > +       memmove(dest.data + 12, zero.data, 7);
> > +       compare("middle overwrite", dest, middle);
> > +
> > +       /* Verify argument side-effects aren't repeated. */
> > +       dest = control;
> > +       ptr = dest.data;
> > +       count = 2;
> > +       memmove(ptr++, zero.data, count++);
> > +       ptr += 9;
> > +       memmove(ptr++, zero.data, count++);
> > +       compare("argument side-effects", dest, five);
> > +
> > +       /* Verify overlapping overwrite is correct. */
> > +       ptr = &overlap.data[2];
> > +       memmove(ptr, overlap.data, 5);
> > +       compare("overlapping write", overlap, overlap_expected);
> > +#undef TEST_OP
> > +}
> > +
> > +static void memset_test(struct kunit *test)
> > +{
> > +#define TEST_OP "memset"
> > +       struct some_bytes control = {
> > +               .data = { 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                       },
> > +       };
> > +       struct some_bytes complete = {
> > +               .data = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > +                         0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > +                         0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > +                         0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > +                       },
> > +       };
> > +       struct some_bytes middle = {
> > +               .data = { 0x30, 0x30, 0x30, 0x30, 0x31, 0x31, 0x31, 0x31,
> > +                         0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31,
> > +                         0x31, 0x31, 0x31, 0x31, 0x30, 0x30, 0x30, 0x30,
> > +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                       },
> > +       };
> > +       struct some_bytes three = {
> > +               .data = { 0x60, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                         0x30, 0x61, 0x61, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                         0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> > +                       },
> > +       };
> > +       struct some_bytes dest = { };
> > +       int count, value;
> > +       u8 *ptr;
> > +
> > +       /* Verify static initializers. */
> > +       check(control, 0x30);
> > +       check(dest, 0);
> > +
> > +       /* Verify assignment. */
> > +       dest = control;
> > +       compare("direct assignment", dest, control);
> > +
> > +       /* Verify complete overwrite. */
> > +       memset(dest.data, 0xff, sizeof(dest.data));
> > +       compare("complete overwrite", dest, complete);
> > +
> > +       /* Verify middle overwrite. */
> > +       dest = control;
> > +       memset(dest.data + 4, 0x31, 16);
> > +       compare("middle overwrite", dest, middle);
> > +
> > +       /* Verify argument side-effects aren't repeated. */
> > +       dest = control;
> > +       ptr = dest.data;
> > +       value = 0x60;
> > +       count = 1;
> > +       memset(ptr++, value++, count++);
> > +       ptr += 8;
> > +       memset(ptr++, value++, count++);
> > +       compare("argument side-effects", dest, three);
> > +#undef TEST_OP
> > +}
> > +
> > +static struct kunit_case memcpy_test_cases[] = {
> > +       KUNIT_CASE(memset_test),
> > +       KUNIT_CASE(memcpy_test),
> > +       KUNIT_CASE(memmove_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite memcpy_test_suite = {
> > +       .name = "memcpy-test",
> 
> It may be better to just name the suite "memcpy", since -- by
> definition -- it's a test if it's a KUnit test suite.

Sounds good. I will adjust this.

> 
> > +       .test_cases = memcpy_test_cases,
> > +};
> > +
> > +kunit_test_suite(memcpy_test_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > --
> > 2.30.2
> >

Thanks!

-Kees

-- 
Kees Cook
