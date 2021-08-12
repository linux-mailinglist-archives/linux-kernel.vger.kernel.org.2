Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621DA3EA11F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhHLI6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhHLI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:58:03 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13977C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:57:38 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w6so9182318oiv.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Az2ike7xADR+kcJZFa8tXN1V5SP3VTm+A32wNNbsp6w=;
        b=u1i8Cx7rVJHryya2B4C2ZBwhWRGzSp7oRmg2YlORyLAw6fXdrVpS+bxhezSx53dMe8
         F7vUU7Lq+y+HWjOp9K0JB68UNM5+7Yhvynq2A2AOy00fnGAhj4SnCsGxpk01hYZ9A271
         ivq4irRtBaPK38jTcx/mdF3KgS5nB9Ul2Ro8XnMziQCgmBIziMxoS+MZV7djEcOToPmY
         LTXAsqIjcT+SkCwNVZ+LnbqFWJO02tpHlpez6SXENhe0MCWMbYRbBtkmGRbH5fFC++zL
         NqAu2ymUpiSm1HCR7ZzsA6okeKQ2zEa4pVZoPSO567PwfL14DYOfF4p+PHmUheZoB9RZ
         FUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Az2ike7xADR+kcJZFa8tXN1V5SP3VTm+A32wNNbsp6w=;
        b=tjPT1BNrwUsSuq3erND+Uk9V+RRXHdQSp2ttVKIoTdMtVsKNIFeHPqzYFVeu34O3Az
         iNBZC5EVskMWgWBTQtrvYkYNOTTt86xJKGauxv3ZvnDMtNVDS+NLxFSgWMrc9UvPjZRi
         n1zCZGbyAX6++DPKwoE2i6PppF9yaP+p24jmJtnVRa+PYDYbN4GixNXkSC9dPkKdK/AO
         WZGfTLLWP05tHqfKopFZVYXUcysVzMmBk+ovSVLUk2gWR1CFd84NuZzPBFrqCMF+pCGG
         z7FNtto3wh1R2w/CDlB9efQPH61lMH/B66uJQQ98Q9Ddh1VS/4YWU+/J0+s6AKzSzf9x
         dkKA==
X-Gm-Message-State: AOAM531NOCC2C/QZqauWDcg4FV9yTcUh+SE7GlNl9/EXFnxF8KmkItmy
        0AuWxIXf27J2rWWEzt9Kb+eogLUY6Sw2zs1EaO5lhw==
X-Google-Smtp-Source: ABdhPJzh1K+l+GmxSRRkgy7o2Ro8rRsvxrO5GougZdYASrFTPvZg6ZfX6bVOeyd4mAylNv+7j412CVM9wm5e2wC8q0Q=
X-Received: by 2002:aca:5301:: with SMTP id h1mr2626318oib.70.1628758657248;
 Thu, 12 Aug 2021 01:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <408c63e4a0353633a13403aab4ff25a505e03d93.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <408c63e4a0353633a13403aab4ff25a505e03d93.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:57:25 +0200
Message-ID: <CANpmjNMo0p+pQS=_rL37RpPPdzLFDqYw8D3V+qeCt3_jDu+anA@mail.gmail.com>
Subject: Re: [PATCH 4/8] kasan: test: disable kmalloc_memmove_invalid_size for HW_TAGS
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
> The HW_TAGS mode doesn't check memmove for negative size. As a result,
> the kmalloc_memmove_invalid_size test corrupts memory, which can result
> in a crash.
>
> Disable this test with HW_TAGS KASAN.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>



> ---
>  lib/test_kasan.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index fd00cd35e82c..0b5698cd7d1d 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -495,11 +495,17 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
>         size_t size = 64;
>         volatile size_t invalid_size = -2;
>
> +       /*
> +        * Hardware tag-based mode doesn't check memmove for negative size.
> +        * As a result, this test introduces a side-effect memory corruption,
> +        * which can result in a crash.
> +        */
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
> +
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
>         memset((char *)ptr, 0, 64);
> -
>         KUNIT_EXPECT_KASAN_FAIL(test,
>                 memmove((char *)ptr, (char *)ptr + 4, invalid_size));
>         kfree(ptr);
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/408c63e4a0353633a13403aab4ff25a505e03d93.1628709663.git.andreyknvl%40gmail.com.
