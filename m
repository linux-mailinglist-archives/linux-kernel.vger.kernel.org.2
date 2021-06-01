Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6728D397700
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhFAPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhFAPqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:46:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A130C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:44:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h7so1724440iok.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvfBq2aXtJ08TGHS8dCWxvUmTewAGJbPcj6f0TWlUiY=;
        b=kRP9RlunMLDQfqS8+ys+DPhZExy23ZacwK6tldf29WDZpUF9gMrU53snMNzxbOK8Xx
         mFBKUUhUjw2mJKRMdKO8xXTbdkbju+jNtMPX3uGyompBImAvdoPQ9hKtelQZjwaJk/1m
         W729w4nS3IOnXZ45i+J7UUP3+yzQMn0TRsaCJ5BV2EK08w30jsd+Rui/r6Bs6fZoH05W
         XqYJuQxTiBtHsFk3+hJU64fLX0dUYqHWwwAmkY/KYdCEMxWvmSXwgfDq4ViCFGNMFw85
         txmnvZvHyvN2N0+mfIJfIfQYcXxhFqyWEg0EQ65Z4gTejqVYbCU5YV5a5HK8sjfwpCJm
         Vleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvfBq2aXtJ08TGHS8dCWxvUmTewAGJbPcj6f0TWlUiY=;
        b=ZEGCUPATjMpvY/+WCPdLXP9CJf1jVbxl2wF6Haqr40Mz3uNQ8MXhAWr7ankCgGo9Xx
         BbkPMrWSm1eTPX6MPROSBCB/S39phbRhfePSvZZWY78WPvwzurVN10D+ZuKwHXL44bJv
         XIjFhDzB5dUT9AAYZXguUOUDyCGIX7XMjdVYzwFZOVMC6r4URtdfnnV0p6BDmeizr1Xn
         rrEk9f3z7iLsnIzO3VIZ7OWu4PNlCqfc5UYYsEB6P/55jhPxghIyE7HCVkA97hkh+ys7
         mQhf+FOd+Y59/Q8xKU8s3Jx+WH2rfJQZCZ9fMXOpCxJHncB4RlXKYcygNSQWv/tEmY1+
         a8Aw==
X-Gm-Message-State: AOAM532I0QwPEgqua+8GMZioBADLnRmXavuztucMT+LkzdRu7RmWPnVm
        TjdUb3o7o2pCyUcGl4FWOliukT2woPpgyO/bLrXexA==
X-Google-Smtp-Source: ABdhPJx/UMblI0JBFNQGhmSUwzNnzmzVmDXqPuPba6tlXA1wNfGoVEasufKEZ/1btEqVM+yw8XDTXVMNqCEn91SVNFA=
X-Received: by 2002:a02:5b45:: with SMTP id g66mr11315101jab.62.1622562281646;
 Tue, 01 Jun 2021 08:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com> <20210528075932.347154-4-davidgow@google.com>
In-Reply-To: <20210528075932.347154-4-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 1 Jun 2021 08:44:27 -0700
Message-ID: <CAGS_qxr+nOBoL86GzX3o+CUvp0FFGv7qJh70ALUxe-Hr6X7+xA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kasan: test: make use of kunit_skip()
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:59 AM David Gow <davidgow@google.com> wrote:
>
> From: Marco Elver <elver@google.com>
>
> Make use of the recently added kunit_skip() to skip tests, as it permits
> TAP parsers to recognize if a test was deliberately skipped.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>


> ---
>  lib/test_kasan.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index cacbbbdef768..0a2029d14c91 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -111,17 +111,13 @@ static void kasan_test_exit(struct kunit *test)
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
> -       if (!IS_ENABLED(config)) {                                      \
> -               kunit_info((test), "skipping, " #config " required");   \
> -               return;                                                 \
> -       }                                                               \
> +       if (!IS_ENABLED(config))                                        \
> +               kunit_skip((test), "Test requires " #config "=y");      \
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {                 \
> -       if (IS_ENABLED(config)) {                                       \
> -               kunit_info((test), "skipping, " #config " enabled");    \
> -               return;                                                 \
> -       }                                                               \
> +       if (IS_ENABLED(config))                                         \
> +               kunit_skip((test), "Test requires " #config "=n");      \
>  } while (0)
>
>  static void kmalloc_oob_right(struct kunit *test)
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
