Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5439E7FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFGUEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhFGUEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:04:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F64DC061787
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 13:02:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 69so9336048plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2XQQivzvNRkfVR3uSuxxvXJvrtUp9ycHqIQW57PEVc=;
        b=FUJQObTw+/Sj5743vZFa+P0h1Lm/oP1FX1dHa+Jtegd7gPGGZIcatslpsMnCbbxgty
         x8T7iwJ+hbKMaQW6gP4FuBSIKvHOG/QspuRA2lAySUNb6SGgzi8+WRrU631omy47Xhdw
         PYEuK6nxnzR1wiUC/dqtuK14DitfffDlK/w8CVAIMVn++0Y3Qksr5DFVh3J23JBQMpOU
         X1CfbuI8PTA02PSH6/a2xGZ5hFEG2IYEzQiC9EHjPdWrfYWKg1p0DKs5OZ2JSRzCDIY7
         YLeffiPvPfoFvrypyX7/kTlKaKD9XfWD0OVHmFy9ZIMZ2ebmHkAd1MLYx8IQ/LA4wA0H
         9Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2XQQivzvNRkfVR3uSuxxvXJvrtUp9ycHqIQW57PEVc=;
        b=rMEGUOD4GPl4BG5JJhTVcgXP5pYS+aMrbrnZ620Sq/DHaHNZnpXRToNVjgA70f+BpE
         ZV6Mxs34vIJOOsBXUvaaGXITvGjfdd+aMq0NzlRsQPYrftfYSQid8Icjts0pG7Tzr8AT
         8g53bwyellHrOMAixJygzZiS7zTL559ZDQk+rs3Hf1QotfyrfkB9ibyqGkIY2L3UDhvb
         c5Tv7Zh2hsdthib87ChWPn2lbm3Maw/Mf3mn5Y9ZOwXSEmXTJ4htNHJGkoex1l0P0zGS
         hGX29FlyPqsWNO2600+AGqhYRr9Ja6t3UvV3eQhwFFdaddZuIHr8prehKmIITyZ9Yi/w
         m+fA==
X-Gm-Message-State: AOAM53286r+jRUTNOcr1hAmu58BSD+m9l0oSm7wzghYgpn4glNzPFD8q
        VX+4+6xWEj71JZfaOT+BgAPCCX5F9kg4SbaoOBbANtenG8ePpw==
X-Google-Smtp-Source: ABdhPJzvxHRhWpJjs2Wf9Ov/7iB+vMzF0yxTtBqxQOHhtftZGhx8lpquxFicR0ACfQDsXLXgsM0CgtTAyTv2de9x/nQ=
X-Received: by 2002:a17:90a:b28d:: with SMTP id c13mr854921pjr.80.1623096169879;
 Mon, 07 Jun 2021 13:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210606005531.165954-1-davidgow@google.com>
In-Reply-To: <20210606005531.165954-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Jun 2021 13:02:38 -0700
Message-ID: <CAFd5g44YH5P=4U34kTnWwgTKQbT6toLtEfDNHw3bHLHqiyj8QQ@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: test: Improve failure message in KUNIT_EXPECT_KASAN_FAIL()
To:     David Gow <davidgow@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 5:55 PM David Gow <davidgow@google.com> wrote:
>
> The KUNIT_EXPECT_KASAN_FAIL() macro currently uses KUNIT_EXPECT_EQ() to
> compare fail_data.report_expected and fail_data.report_found. This
> always gave a somewhat useless error message on failure, but the
> addition of extra compile-time checking with READ_ONCE() has caused it
> to get much longer, and be truncated before anything useful is displayed.
>
> Instead, just check fail_data.report_found by hand (we've just set
> report_expected to 'true'), and print a better failure message with
> KUNIT_FAIL(). Because of this, report_expected is no longer used
> anywhere, and can be removed.
>
> Beforehand, a failure in:
> KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)area)[3100]);
> would have looked like:
> [22:00:34] [FAILED] vmalloc_oob
> [22:00:34]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:991
> [22:00:34]     Expected ({ do { extern void __compiletime_assert_705(void) __attribute__((__error__("Unsupported access size for {READ,WRITE}_ONCE()."))); if (!((sizeof(fail_data.report_expected) == sizeof(char) || sizeof(fail_data.repp
> [22:00:34]     not ok 45 - vmalloc_oob
>
> With this change, it instead looks like:
> [22:04:04] [FAILED] vmalloc_oob
> [22:04:04]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:993
> [22:04:04]     KASAN failure expected in "((volatile char *)area)[3100]", but none occurred
> [22:04:04]     not ok 45 - vmalloc_oob
>
> Also update the example failure in the documentation to reflect this.
>
> Signed-off-by: David Gow <davidgow@google.com>

Nice work!

Acked-by: Brendan Higgins <brendanhiggins@google.com>
