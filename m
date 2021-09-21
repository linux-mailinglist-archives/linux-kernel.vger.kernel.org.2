Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E015E412B15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243452AbhIUCGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhIUBuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E8C06AB39
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:10:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u8so22163144lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eV7ZEknL6BkA6f/6DuS4NzZxFcAYVBj2zF/41tusYQ=;
        b=nO1fHPON5V8RPEe8sjglg5u1uwbH+IpUsz9W0GgnwtFFbCbvZjpCK2W0AZ02vPueOk
         rhEZcjahbMzw7oDngXGb7xTeUJ225XsTgyFkqbQ+w7l+W+gWBOQMcG/DpY+y1USQRED8
         /Aiy3uD6vO8NhZG0eZhQiMwn9gqCV/kpKBU6BEAyVE5N7AKXWw8GzqGePPIq13OuhqUf
         E64Zlqrz2cZeaJMToQ47ZjRg5kGEiAjdgGlZqLOjC7WUe145oyDs0MQ5bRhJFv9cqNBE
         QVpq+AMYa6hl0j+3rtEprLI/dUDBPPcgVGWUjr2MNPtxCW6DKaNiJBLDsjasHT07FZ9k
         fEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eV7ZEknL6BkA6f/6DuS4NzZxFcAYVBj2zF/41tusYQ=;
        b=r0M7NNasZygfG2bD2xhYF9DeylZ+jpvkcg3itrs9UEQk0jP/04fjbBABZMHwgewP4Z
         qBix5tHkDKBoWugLj2ZeJUeZtkm3LFXhq6OvOD8dN1GnA8wa00GwaP1xND7ro7Q/Q7dd
         tjiCv7PPgfsF6pj70ZU/C8hAqzAMdRi2la90z51HQOCo9WP7p3YBHZALDxVHWRuZ3eS8
         pnRCwswohvm4E4hXkjz/Z1JPG/ytuLE3fIKO2ahEZzSN843ePqgo0P2hLXE1ywUcu/8Q
         PKVzUePNO0kGuSG/cSmYZuVnYqoEIFp1eAPC/vBOM+Jjnrw/QyZbt5tSiv9JkaGXkuO/
         CQLg==
X-Gm-Message-State: AOAM530q8qHmeh3spx8taLhvjNDAwccseXtdTiqg6xuhCpo9NxrnjU7g
        7vPxEs72Mrel2YtubtWIcERyrjJXpXKNSfklpeJA5g==
X-Google-Smtp-Source: ABdhPJz0WBX5wfCly2Kf6J53UybjMeTFy9UttFKEgQfdbXF1ZEwIseu8gK/Gt1DRko2YV4OErJW8g8bbgNraSSRafBY=
X-Received: by 2002:a05:6512:3ba5:: with SMTP id g37mr7361147lfv.651.1632175849450;
 Mon, 20 Sep 2021 15:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210920180853.1825195-1-keescook@chromium.org> <20210920180853.1825195-3-keescook@chromium.org>
In-Reply-To: <20210920180853.1825195-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Sep 2021 15:10:37 -0700
Message-ID: <CAKwvOdnYYa+72VhtJ4ug=SJVFn7w+n7Th+hKYE87BRDt4hvqOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] test_overflow: Regularize test reporting output
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 11:09 AM Kees Cook <keescook@chromium.org> wrote:
>
> Report test run summaries more regularly, so it's easier to understand
> the output:
> - Remove noisy "ok" reports for shift and allocator tests.
> - Reorganize per-type output to the end of each type's tests.
> - Replace redundant vmalloc tests with __vmalloc so that __GFP_NO_WARN
>   can be used to keep the expected failure warnings out of dmesg,
>   similar to commit 8e060c21ae2c ("lib/test_overflow.c: avoid tainting
>   the kernel and fix wrap size")
>
> Resulting output:
>
>   test_overflow: 18 u8 arithmetic tests finished
>   test_overflow: 19 s8 arithmetic tests finished
>   test_overflow: 17 u16 arithmetic tests finished
>   test_overflow: 17 s16 arithmetic tests finished
>   test_overflow: 17 u32 arithmetic tests finished
>   test_overflow: 17 s32 arithmetic tests finished
>   test_overflow: 17 u64 arithmetic tests finished
>   test_overflow: 21 s64 arithmetic tests finished
>   test_overflow: 113 shift tests finished
>   test_overflow: 17 overflow size helper tests finished
>   test_overflow: 11 allocation overflow tests finished
>   test_overflow: all tests passed
>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Much appreciated!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  lib/test_overflow.c | 50 +++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/lib/test_overflow.c b/lib/test_overflow.c
> index 01a469ff7ff6..e1fd2d72dc61 100644
> --- a/lib/test_overflow.c
> +++ b/lib/test_overflow.c
> @@ -252,10 +252,10 @@ static int __init test_ ## t ## _overflow(void) {                 \
>         int err = 0;                                                    \
>         unsigned i;                                                     \
>                                                                         \
> -       pr_info("%-3s: %zu arithmetic tests\n", #t,                     \
> -               ARRAY_SIZE(t ## _tests));                               \
>         for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)                   \
>                 err |= do_test_ ## t(&t ## _tests[i]);                  \
> +       pr_info("%zu %s arithmetic tests finished\n",                   \
> +               ARRAY_SIZE(t ## _tests), #t);                           \
>         return err;                                                     \
>  }
>
> @@ -291,6 +291,7 @@ static int __init test_overflow_calculation(void)
>  static int __init test_overflow_shift(void)
>  {
>         int err = 0;
> +       int count = 0;
>
>  /* Args are: value, shift, type, expected result, overflow expected */
>  #define TEST_ONE_SHIFT(a, s, t, expect, of) ({                         \
> @@ -313,9 +314,7 @@ static int __init test_overflow_shift(void)
>                         pr_warn("got %llu\n", (u64)__d);                \
>                 __failed = 1;                                           \
>         }                                                               \
> -       if (!__failed)                                                  \
> -               pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,       \
> -                       of ? "overflow" : #expect);                     \
> +       count++;                                                        \
>         __failed;                                                       \
>  })
>
> @@ -479,6 +478,8 @@ static int __init test_overflow_shift(void)
>         err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
>         err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
>
> +       pr_info("%d shift tests finished\n", count);
> +
>         return err;
>  }
>
> @@ -530,7 +531,6 @@ static int __init test_ ## func (void *arg)                         \
>                 free ## want_arg (free_func, arg, ptr);                 \
>                 return 1;                                               \
>         }                                                               \
> -       pr_info(#func " detected saturation\n");                        \
>         return 0;                                                       \
>  }
>
> @@ -544,10 +544,7 @@ DEFINE_TEST_ALLOC(kmalloc,  kfree,      0, 1, 0);
>  DEFINE_TEST_ALLOC(kmalloc_node,         kfree,      0, 1, 1);
>  DEFINE_TEST_ALLOC(kzalloc,      kfree,      0, 1, 0);
>  DEFINE_TEST_ALLOC(kzalloc_node,  kfree,             0, 1, 1);
> -DEFINE_TEST_ALLOC(vmalloc,      vfree,      0, 0, 0);
> -DEFINE_TEST_ALLOC(vmalloc_node,  vfree,             0, 0, 1);
> -DEFINE_TEST_ALLOC(vzalloc,      vfree,      0, 0, 0);
> -DEFINE_TEST_ALLOC(vzalloc_node,  vfree,             0, 0, 1);
> +DEFINE_TEST_ALLOC(__vmalloc,    vfree,      0, 1, 0);
>  DEFINE_TEST_ALLOC(kvmalloc,     kvfree,     0, 1, 0);
>  DEFINE_TEST_ALLOC(kvmalloc_node, kvfree,     0, 1, 1);
>  DEFINE_TEST_ALLOC(kvzalloc,     kvfree,     0, 1, 0);
> @@ -559,8 +556,14 @@ static int __init test_overflow_allocation(void)
>  {
>         const char device_name[] = "overflow-test";
>         struct device *dev;
> +       int count = 0;
>         int err = 0;
>
> +#define check_allocation_overflow(alloc)       ({      \
> +       count++;                                        \
> +       test_ ## alloc(dev);                            \
> +})
> +
>         /* Create dummy device for devm_kmalloc()-family tests. */
>         dev = root_device_register(device_name);
>         if (IS_ERR(dev)) {
> @@ -568,23 +571,22 @@ static int __init test_overflow_allocation(void)
>                 return 1;
>         }
>
> -       err |= test_kmalloc(NULL);
> -       err |= test_kmalloc_node(NULL);
> -       err |= test_kzalloc(NULL);
> -       err |= test_kzalloc_node(NULL);
> -       err |= test_kvmalloc(NULL);
> -       err |= test_kvmalloc_node(NULL);
> -       err |= test_kvzalloc(NULL);
> -       err |= test_kvzalloc_node(NULL);
> -       err |= test_vmalloc(NULL);
> -       err |= test_vmalloc_node(NULL);
> -       err |= test_vzalloc(NULL);
> -       err |= test_vzalloc_node(NULL);
> -       err |= test_devm_kmalloc(dev);
> -       err |= test_devm_kzalloc(dev);
> +       err |= check_allocation_overflow(kmalloc);
> +       err |= check_allocation_overflow(kmalloc_node);
> +       err |= check_allocation_overflow(kzalloc);
> +       err |= check_allocation_overflow(kzalloc_node);
> +       err |= check_allocation_overflow(__vmalloc);
> +       err |= check_allocation_overflow(kvmalloc);
> +       err |= check_allocation_overflow(kvmalloc_node);
> +       err |= check_allocation_overflow(kvzalloc);
> +       err |= check_allocation_overflow(kvzalloc_node);
> +       err |= check_allocation_overflow(devm_kmalloc);
> +       err |= check_allocation_overflow(devm_kzalloc);
>
>         device_unregister(dev);
>
> +       pr_info("%d allocation overflow tests finished\n", count);
> +
>         return err;
>  }
>
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
