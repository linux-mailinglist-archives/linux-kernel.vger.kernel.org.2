Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88733EA119
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhHLI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhHLI5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:57:36 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9554C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:57:11 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bi32so9301657oib.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvfdMZYMJAya7AOkWdDc2oNND0X7RYexhanHnq6ZuEo=;
        b=AQQ58CvZy+rfpZWHDYz/szGP6NhLQ7avJgQsOENXbxHg66Rtz/gGjDD5044NvFnq9i
         i+uKnufxs+r3OE6tVIWowA3Y+Z9zNpapLfMyHNmFf7CdsZAGK7HN/Z3lw0q3oeWDss5J
         oWhEKGCNWNwYFsVDuAVISFYqQdk3N5Tn9SSidPwx1BfnU6WWLqjHRxrbD8qxVdMxFGQy
         MIh3BmEbvqf9GNR4Gov/v214Ivdw/HkR0Nhj77tjmnTeOWQqUPjw5quVEJ1Up8nzSngX
         JxZBFS42WPH/vjBsMcB2hI8tgGA23BJkx0t4VDRAQ+tRvAdLEANySxSgZpMQUr5BZUKx
         5+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvfdMZYMJAya7AOkWdDc2oNND0X7RYexhanHnq6ZuEo=;
        b=c3GlwpoRPwCXMxmFMe/BV4IcRS6M9Ju+pvEHixp+AubuKqKOIRV2gbQDuFlLcj57Cv
         59aUEMrqM4onGk8lMGNCu5IrlHJ0b1NVyZVL6jPuC4PNDWkQzvlIQa4zuyJnqk4HNkyH
         Evci9jTiQPMNtuj0oXieDRA8gYGxfvElq87Kie5gquKQgDYDnnvA5c/xk5tS8m1JBNF5
         eGjW+A4YhzAGEJPBTU9FxOvUNjAKDyrb9QTDDf6urv6apt2XUvf84BBhvHTEK971Ev5N
         h8uNkCdBWXpLT984BIX8EizKt9q8qgAGqv2zBph876VJ/OXpAqQxN1jFYplivJzUvgkL
         TCvw==
X-Gm-Message-State: AOAM532D3N8GUiWwuuUdQz+TKhzEcfpfbMoDWxUVKwPeHAEMgYPhayTu
        0wRLt43KEMRrmCzZV0k1M3G5rLgzb8Z9JT0wviE97w==
X-Google-Smtp-Source: ABdhPJxXljl5uxmG8b/LJgqiYIBpjeeqvZDPTYQ2FwzMVMFT0567lr4jLcPNWeNlomoy6Tc0iwNQs7/6yGs+z/8M/bw=
X-Received: by 2002:aca:eb8a:: with SMTP id j132mr2510361oih.121.1628758629909;
 Thu, 12 Aug 2021 01:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <e9e2f7180f96e2496f0249ac81887376c6171e8f.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <e9e2f7180f96e2496f0249ac81887376c6171e8f.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:56:58 +0200
Message-ID: <CANpmjNPGsD_nZbcDNVTeL-b9W7X+2_AhzNAiSLdtxuvfyNFMEA@mail.gmail.com>
Subject: Re: [PATCH 3/8] kasan: test: avoid corrupting memory via memset
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

On Wed, 11 Aug 2021 at 21:21, <andrey.konovalov@linux.dev> wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> kmalloc_oob_memset_*() tests do writes past the allocated objects.
> As the result, they corrupt memory, which might lead to crashes with the
> HW_TAGS mode, as it neither uses quarantine nor redzones.
>
> Adjust the tests to only write memory within the aligned kmalloc objects.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---
>  lib/test_kasan.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index c82a82eb5393..fd00cd35e82c 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -431,61 +431,61 @@ static void kmalloc_uaf_16(struct kunit *test)
>  static void kmalloc_oob_memset_2(struct kunit *test)
>  {
>         char *ptr;
> -       size_t size = 8;
> +       size_t size = 128 - KASAN_GRANULE_SIZE;
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 7 + OOB_TAG_OFF, 0, 2));
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size, 0, 2));

I think one important aspect of these tests in generic mode is that
the written range touches both valid and invalid memory. I think that
was meant to test any explicit instrumentation isn't just looking at
the starting address, but at the whole range.

It seems that with these changes that is no longer tested. Could we
somehow make it still test that?


>         kfree(ptr);
>  }
>
>  static void kmalloc_oob_memset_4(struct kunit *test)
>  {
>         char *ptr;
> -       size_t size = 8;
> +       size_t size = 128 - KASAN_GRANULE_SIZE;
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 5 + OOB_TAG_OFF, 0, 4));
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size, 0, 4));
>         kfree(ptr);
>  }
>
> -
>  static void kmalloc_oob_memset_8(struct kunit *test)
>  {
>         char *ptr;
> -       size_t size = 8;
> +       size_t size = 128 - KASAN_GRANULE_SIZE;
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 1 + OOB_TAG_OFF, 0, 8));
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size, 0, 8));
>         kfree(ptr);
>  }
>
>  static void kmalloc_oob_memset_16(struct kunit *test)
>  {
>         char *ptr;
> -       size_t size = 16;
> +       size_t size = 128 - KASAN_GRANULE_SIZE;
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 1 + OOB_TAG_OFF, 0, 16));
> +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size, 0, 16));
>         kfree(ptr);
>  }
>
>  static void kmalloc_oob_in_memset(struct kunit *test)
>  {
>         char *ptr;
> -       size_t size = 666;
> +       size_t size = 128 - KASAN_GRANULE_SIZE;
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr, 0, size + 5 + OOB_TAG_OFF));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +                               memset(ptr, 0, size + KASAN_GRANULE_SIZE));
>         kfree(ptr);
>  }
>
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/e9e2f7180f96e2496f0249ac81887376c6171e8f.1628709663.git.andreyknvl%40gmail.com.
