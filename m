Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740AA39B4F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFDIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:36:59 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:41827 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFDIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:36:58 -0400
Received: by mail-wm1-f52.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so5167940wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2b0T1Sxej99eruw62S3x3NVpggwE8s3zSnQ/kAj+v5M=;
        b=F+l7vS9mspnDxjzmugKkd+3cOYdAiz3Erk7D6qZf8mtnEAKcwuw6kazm9hz1EFahOj
         clkHrBRMDV7JNniUyj7E+Zr1Ez+gjqJKcoK1Ave4pgwXrt8T8o2EJDE91zH03roHH8Zv
         GhJRXKGqnxbpkB1EgHfVeKjfvqpBj/sfNGGiKpNwIhkJmdTZhU44hFtAM25UZZHt9SUn
         APUdeCcuIYV9CIFCwJuEONuTVbfnzapTNoKmDciegRy20F9QOfncCDn7LidyyFw5/TKQ
         17DK50ke10Gjx/am5SiU375gKdMyyz5cG8oeAkca1xK0ghQIMNGAiwYk+b+WJsaovIEd
         GZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2b0T1Sxej99eruw62S3x3NVpggwE8s3zSnQ/kAj+v5M=;
        b=gC7Xhq0tOMbHUKNRbY5iHE+1gW3ahTVVel6BFpP4b8Xu4SJ2sr0tB9ycmzUUCiJ0vY
         NGO2OGk1iCOjiGf6Ti1kBLmeOQ8rEFrJG4MuFGkn2B4K4hAG+xYgCVacq4DHQ/j4sw5X
         rWYe29nInf/jvq5ldGoaluLCZX1n7lA+cqw5nhxxOqR513Rcm1EMOcxSK4BVv0FWR7Bx
         2J2WHst2V/Wyhp4SsqlNduZezgDnHKXLSiP73KFYD02jTVm5pj9PDg1Gnyrj0TfpE7sO
         kEGFZMNVazZqjje8I5xMfEdJiqEip3hfZpRa1T3lq9mvuf8HPYYaTBv53ThKiffTj85r
         unqw==
X-Gm-Message-State: AOAM531MQQky22Ohxn8Yc3qHgdfE5+vJZmp5rSqDSoQ+Irhzr82NeH1u
        3t2u/npKdKpm+m8Yz+/qofMFhV62fiQCu6hjA37eZg==
X-Google-Smtp-Source: ABdhPJygKvNG3LnT5cEwEmnb0WBAB/6YQwR5YDckdTcqzHT/4lbxHM22LC33BAEinQLOVn3vZenUVC6Vj3Ua9cAVSmQ=
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr2466292wmi.151.1622795651753;
 Fri, 04 Jun 2021 01:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210604052548.1889909-1-davidgow@google.com> <CANpmjNP3kK=YWEacvPr5RRen4YkSKL9akLn06Eq6H+azqSGimA@mail.gmail.com>
In-Reply-To: <CANpmjNP3kK=YWEacvPr5RRen4YkSKL9akLn06Eq6H+azqSGimA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 4 Jun 2021 16:34:00 +0800
Message-ID: <CABVgOSkEGWZx=Cojx4d9+VdjFHNN4=HVmvcO7k6tZ_w5gcA0yg@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: Improve failure message in KUNIT_EXPECT_KASAN_FAIL()
To:     Marco Elver <elver@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 3:55 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 4 Jun 2021 at 07:26, 'David Gow' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> > The KUNIT_EXPECT_KASAN_FAIL() macro currently uses KUNIT_EXPECT_EQ() to
> > compare fail_data.report_expected and fail_data.report_found. This
> > always gave a somewhat useless error message on failure, but the
> > addition of extra compile-time checking with READ_ONCE() has caused it
> > to get much longer, and be truncated before anything useful is displayed.
> >
> > Instead, just check fail_data.report_found by hand (we've just test
> > report_expected to 'true'), and print a better failure message with
> > KUNIT_FAIL()
> >
> > Beforehand, a failure in:
> > KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)area)[3100]);
> > would looked like:
> > [22:00:34] [FAILED] vmalloc_oob
> > [22:00:34]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:991
> > [22:00:34]     Expected ({ do { extern void __compiletime_assert_705(void) __attribute__((__error__("Unsupported access size for {READ,WRITE}_ONCE()."))); if (!((sizeof(fail_data.report_expected) == sizeof(char) || sizeof(fail_data.repp
> > [22:00:34]     not ok 45 - vmalloc_oob
> >
> > With this change, it instead looks like:
> > [22:04:04] [FAILED] vmalloc_oob
> > [22:04:04]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:993
> > [22:04:04]     KASAN failure expected in "((volatile char *)area)[3100]", but none occurred
> > [22:04:04]     not ok 45 - vmalloc_oob
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > Stumbled across this because the vmalloc_oob test is failing (i.e.,
> > KASAN isn't picking up an error) under qemu on my system, and the
> > message above was horrifying. (I'll file a Bugzilla bug for the test
> > failure today.)
> >
> > Cheers,
> > -- David
> >
> >  lib/test_kasan.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index cacbbbdef768..deda13c9d9ff 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -98,9 +98,11 @@ static void kasan_test_exit(struct kunit *test)
> >         barrier();                                                      \
> >         expression;                                                     \
> >         barrier();                                                      \
> > -       KUNIT_EXPECT_EQ(test,                                           \
> > -                       READ_ONCE(fail_data.report_expected),           \
>
> What do we have fail_data.report_expected for? Could we remove it now?
> I think it's unused now.
>

I thought this was being used in kasan_update_kunit_status() (in
mm/kasan/report.c), but it looks like I was mistaken. We should be
able to get rid of it, then/

> > -                       READ_ONCE(fail_data.report_found));             \
> > +       if (READ_ONCE(fail_data.report_found) == false) {               \
>
> if (!READ_ONCE(fail_data.report_found)) {
> ?
>

I'll change this for v2.

> > +               KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "  \
> > +                               "expected in \"" #expression            \
> > +                                "\", but none occurred");              \
> > +       }                                                               \
>
> Thanks,
> -- Marco
