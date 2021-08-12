Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1B3EA11D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhHLI55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbhHLI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:57:55 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055FC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:57:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t128so9277487oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faqrh261ptBS/eNsuw/b4oqk4dw9ADdOP4UjgUKWvsw=;
        b=Kalpk5uOc15zbg8HtacD9Bv+mH3SScynLFasK2T74sZPa9azKfPFw1WTb9bw+WSOEa
         3uFe4vGtE3hjgQOpeHfXtXje9VmeLJCm12qi0S+OvVuFlym10D5Ep/5t2PQ9BvP6dfwC
         RYnKHPjDvrk86fy1887P+cvv5gc8jbJhvGxqGbK4zULD61x25s1n7zEkpLOHfC38XkyC
         nl4o7ebORlp7unpmZzgecatHVli/anKTgjFi2dQgL9BBpCwnkD+NV4hBfAT0J2CIDerP
         PF19R2GUidFuuXAI5VEwyjEXygqIk144lZUJxUWm/aocxIBpuS4ZPG+rb7wJ2vKRS7PJ
         JWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faqrh261ptBS/eNsuw/b4oqk4dw9ADdOP4UjgUKWvsw=;
        b=N5/BkTOsbw4b46DizmnvLOE5V2VqmSabyG4F7KGuWo79qL2wt0KNohfiH+JZsnURr2
         vAMZd2DPLO2xBYNrbtIG3lHC5aomQSyHZcEf3GoWdQ/GmqsQO+AT/VUnEVrJ3VAmUyB9
         H5otN7SJ8BlHmUSzTXzBaiTyo25hEonTsTd7Nep9cS2JvCiFK+UgzMEflESSEFDSXecO
         HdRgNPJkHm+XOsM6VD/1drITDWOnqkwA6ARdusV+QJmiEA/XJh8t0Zg1KIvgAepcPPoo
         agVsOlNjRjzj8VGSSwFLCJNgp7IJ40aMPEa4hKHjclMN8gZjYU2rsj4EhNIVx/uJw7O0
         Y7Lw==
X-Gm-Message-State: AOAM531rR3mVTBoTMk9HgjEpNBXeFSmChZDEIEUDWQff7Iu0iJl20F7G
        F/lWdTm7j9JB+arDqD41FVxcWAqPt5a6qrIRzGTkxQ==
X-Google-Smtp-Source: ABdhPJyThRvzDLALQcpwLovtPcnOyVJQOA1OUZJTpbvLUpPrKWCyl5aHylRrqUmPjE13sDWGOnLdRqQEfNuke2tWNhM=
X-Received: by 2002:aca:2316:: with SMTP id e22mr2504583oie.172.1628758649694;
 Thu, 12 Aug 2021 01:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <474aa8b7b538c6737a4c6d0090350af2e1776bef.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <474aa8b7b538c6737a4c6d0090350af2e1776bef.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:57:18 +0200
Message-ID: <CANpmjNNCV_sioFk0C3mChxCq6-eED+ThV2h-ygPVyaWg3667LQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] kasan: test: rework kmalloc_oob_right
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
> Rework kmalloc_oob_right() to do these bad access checks:
>
> 1. An unaligned access one byte past the requested kmalloc size
>    (can only be detected by KASAN_GENERIC).
> 2. An aligned access into the first out-of-bounds granule that falls
>    within the aligned kmalloc object.
> 3. Out-of-bounds access past the aligned kmalloc object.
>
> Test #3 deliberately uses a read access to avoid corrupting memory.
> Otherwise, this test might lead to crashes with the HW_TAGS mode, as it
> neither uses quarantine nor redzones.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/test_kasan.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 8f7b0b2f6e11..1bc3cdd2957f 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -122,12 +122,28 @@ static void kasan_test_exit(struct kunit *test)
>  static void kmalloc_oob_right(struct kunit *test)
>  {
>         char *ptr;
> -       size_t size = 123;
> +       size_t size = 128 - KASAN_GRANULE_SIZE - 5;
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 'x');
> +       /*
> +        * An unaligned access past the requested kmalloc size.
> +        * Only generic KASAN can precisely detect these.
> +        */
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 'x');
> +
> +       /*
> +        * An aligned access into the first out-of-bounds granule that falls
> +        * within the aligned kmalloc object.
> +        */
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + 5] = 'y');
> +
> +       /* Out-of-bounds access past the aligned kmalloc object. */
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =
> +                                       ptr[size + KASAN_GRANULE_SIZE + 5]);
> +
>         kfree(ptr);
>  }
>
> --
> 2.25.1
