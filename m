Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A350338821E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbhERVaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhERVaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:30:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE699C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:29:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q2so8372732pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYR9eU6zjqRdk1UGxgennD6RvKzci+hwvzZHKh2keKU=;
        b=Ln6aUylj3ah1PbOD8LF6vxSm5v/O4RV049EXKgCKSDEdCW7TEJ3kJRQhdFIt5OSEt1
         mAjC7CKrLPGMVIIsbcO068gUVZUmwjzWmJ1M3zSuyf3Tx0SUM5Om0mxyRQxv2aRFaXAg
         iGUScRO0EImJEJF6EkuWsLpwBKUHRTPWzy8D0wLmcBcz/YhB3tBE/wkoF1yRaD85oPQ5
         ccrBQ94YQ8sfKf0KaNDmbFaVPpw58nIA3PDesn06Wl4Ohy9zRHcQzDxY72Ip6Wpund3Y
         oJXvUeMp7izYv4VT6iylvVjCfjEK5wBFcRvBDVftAZzCHKJf9fgIKzuqAHJpD2weod4a
         XO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYR9eU6zjqRdk1UGxgennD6RvKzci+hwvzZHKh2keKU=;
        b=VfzO2zg5Fz5YU1Ru5HiB7M7FwexbV9I0YQu1eaG16DjKsnRM93WmwUEeAP18o4MfSf
         kfKxfG9omLP3YQhAq8IvB3oiEJfgBkftLr5/xcpx6yI3QdiJOJJJKlUppB5vjXY+BKJH
         ElQRV/RAyDOnXRVoZqCZxgnBXkRoucHNe1DygwC4VlOeICb1aswnmdHujjU2lSE+fNkl
         KeHDQtm9QfGsepjuCGg4Jb3PUx+sl3+XCNUF0lDaSKK0KK9JSgyVAwIYnC9a7Y4hChDo
         zlmVnse7QC20h6vFj6SMkJlod/uNDNYrx8zThpqaiNWZkrRfGyOQD5ZvGfMC0wuCMMpK
         FDVg==
X-Gm-Message-State: AOAM532YT4NxhaJXCnPr+Ge242+cFIil2k/a3IUg2+Ln5fOp55DleX/Q
        r/jpjRAYlJlypZupMgztizKnG1K/Zn6x5YjMVIs0lA==
X-Google-Smtp-Source: ABdhPJyv6bKTO8t8pYTtHQJqfJlht9WR9p64GGgwanjqkbWmKlY4s/vF0xxy3EUgh4bWQ6/U92TWqNF6HTX4pf540I8=
X-Received: by 2002:a63:e30d:: with SMTP id f13mr7202766pgh.201.1621373341191;
 Tue, 18 May 2021 14:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210511220515.4140742-1-dlatypov@google.com>
In-Reply-To: <20210511220515.4140742-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 May 2021 14:28:50 -0700
Message-ID: <CAFd5g45j=_20YRU85bv3Vg4z2DDha=kqQJh-g4tcmjzaMhtv2g@mail.gmail.com>
Subject: Re: [PATCH v2] lib/test: convert test_overflow.c to use KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 3:05 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This largely consists of:
> * replacing `err |= test_func(...)` calls with `test_func(test, ...)`.
> * changing pr_warn to KUNIT_*_MSG() macros to mark the failed test
> while printing a diagnostic message
> * dropping __init as there are concerns of this causing issues w/ KUnit
> when running on some other arches.
>
> With the exception of now needing to set CONFIG_KUNIT=y, the test can
> still be run as before, at boot time or as a test module.
> But now the output of the test will be TAP (Test Anything Protocol),
> the format used by kselftest instead of just warnings and printing
> "FAIL!" , see [1].
>
> But now the test can also be run more quickly via kunit.py
>
> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> CONFIG_KUNIT=y
> CONFIG_TEST_OVERFLOW=y
> EOF
>
> Note: after a mrproper this took
> > Elapsed time: 38.683s total, 3.598s configuring, 32.141s building, 0.000s running
>
> (Normally would be less clunky as you wouldn't use a heredoc).
>
> [1] Here's an example failure message after tweaking the test array:
>   TAP version 14
>   1..1
>       # Subtest: lib_overflow
>       1..10
>       # test_u8_overflow: u8 : 18 arithmetic tests
>       # test_u8_overflow: EXPECTATION FAILED at lib/test_overflow.c:251
>       Expected _got == p->sum, but
>           _got == 0
>           p->sum == 1
>   wrong result for 0 + 0 (type u8)
>   ...
>       not ok 1 - test_u8_overflow
>       # test_s8_overflow: s8 : 19 arithmetic tests
>       ok 2 - test_s8_overflow
>   ...
>       # test_overflow_shift: ok: (s32)(0 << 31) == 0
>       # test_overflow_shift: ok: (s64)(0 << 63) == 0
>       ok 9 - test_overflow_shift
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>

Looks good to me.

Acked-by: Brendan Higgins <brendanhiggins@google.com>
