Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052D23EA114
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhHLI5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHLI5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:57:09 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92338C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:56:44 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id a7-20020a9d5c870000b029050333abe08aso6825727oti.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I29wkPGgO6NQxXu1JpY/V8GMi3CkTzzZeeIK4bDLNvw=;
        b=hPI9bp/GgD3uadRZs5kcsIl69srGX7pVP0jPT7j4+7TjdukraPt/2fC5KjSZdUtDK0
         GwJ7Rw20XqSDVdVdK4127Esn7GOOo4CE+sF3/YDmj/5SRuplEtudLxg+D9CgUW5X3IlO
         71a7suz8Q9qNFRjfauG2yppj9kMrIKV2cMlHCAf4ZPdfjUAF/T5N/OgDueZqHH5/k3/1
         yvbYu6vuoUntbI02+V/qZbe+AUZNLNQ4niSrUa/LYj2ZZ7s8J7aiAMGH6EBhuqNa8D2s
         2Erk+lofy/R3VUHm9Y0G44/X+Vybl/231VoIiHU+MjGRlTsaoVFUTowHhRidKYvrvcNB
         9CsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I29wkPGgO6NQxXu1JpY/V8GMi3CkTzzZeeIK4bDLNvw=;
        b=WsQwitabX6i4KxDHJ26tYYQxu1FnPr/bZGWEacY0S1eKgyfVN7ygBUF60Usu/U/v5/
         wggXjNWNushbsuu9FLiIJ8RIE0BO1ka4AHT5FnsLM8oJ/4BjvnJNUiuw6+oqnCy/byYT
         WWZVCDCk8RIh3SD5cyKi4jwr6R0YryHjswsslss2Vh30KSsDCBCUVY5M5qr7kBkqNHyC
         VeRHEN/47Ey0vtqo3SIcQ3P0q6g+4X5I4Nd4n768DHm6t7OzidaCX14iBPqAAGjLySje
         0aawulOy6z8cnXoWJP2WrTDkErRJ52OyfDDXkSYMtoaFh3aTVLLZZ3jZdB3ZBRPXgk7h
         SIRQ==
X-Gm-Message-State: AOAM531emt6qpczYq3EjJQCicJfu3fjH6oip2yt9iH22IDSXRo0QGEOr
        lTy94d8agYaF5p+IVMQA4GQh8aaYKivMuGBJWF+8JA==
X-Google-Smtp-Source: ABdhPJy8FvklqUSYdwBSErFoY2cJHDYfrxOpkSc5UNUD8X1LYr4yBN3B1qyJT2tNPqPct+1wdHhbKvh4i3PrtBTNtug=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr2632529otq.233.1628758603786;
 Thu, 12 Aug 2021 01:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <3773f984cbd64f008af9b03e82fc1b317cda9fda.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <3773f984cbd64f008af9b03e82fc1b317cda9fda.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:56:32 +0200
Message-ID: <CANpmjNMgkSG=QGKn-iOcUONTCxKtFHr2upbKcv46RsTYTcCx_Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] kasan: test: clean up ksize_uaf
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:23, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> Some KASAN tests use global variables to store function returns values
> so that the compiler doesn't optimize away these functions.
>
> ksize_uaf() doesn't call any functions, so it doesn't need to use
> kasan_int_result. Use volatile accesses instead, to be consistent with
> other similar tests.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

Although I do wonder if the compiler might one day mess with the
volatile reads. At least this way we might also catch if the compiler
messes up volatile reads. ;-)

> ---
>  lib/test_kasan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index efd0da5c750f..e159d24b3b49 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -731,8 +731,8 @@ static void ksize_uaf(struct kunit *test)
>         kfree(ptr);
>
>         KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = *ptr);
> -       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = *(ptr + size));
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
>  }
>
>  static void kasan_stack_oob(struct kunit *test)
> --
> 2.25.1
>
