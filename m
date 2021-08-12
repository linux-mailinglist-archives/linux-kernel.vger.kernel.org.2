Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7313EA103
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhHLIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbhHLIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:51:19 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A8C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:50:54 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so4113454otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6hRQLk+mDuzM1tU9wPV9OpAoS0YdU979SiyLqR9lWg=;
        b=tNp1TxiRYJy2MGgWr4EvL6owOqgDQyzN2IUYbSgj6mySD33StDfMV/dKqh4aO3NRDu
         3fSLh2Eh3w/3meKn++MDnyTHzyFbFHyVUHXVk02nIg3UuMrNNG+/93O59Qo/Q9X2VCkD
         5XUy44q/T6C48y8mwrqwNmJ3+s0gRrUWcw6vLmOcWrpj59UL6t9inlLQ0L9i5Fjtr7ya
         rHUu+umhvG9bK0WvdEAQPc/ibl3+0GOOazlluG4JEzAFJO73r6on2N7zHPp8BEBcqyXM
         H/hQhbwVkqMeoRSHL4ZeXcYb0H9l+x03uOZkManey/4y46Zez7ige0/4dzrm5fVvo3c3
         YoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6hRQLk+mDuzM1tU9wPV9OpAoS0YdU979SiyLqR9lWg=;
        b=lmLlQDNdA1ARn212Gib/Zht+M26mPbH4OdNYdQNHgYEqgTN9wl42ITNObXlyv3Itc5
         HasWVMJproAMPujEWo0ojYEmjhwWXQ3MO1WDvo5xEbwnvQXWrpFhHxXZkEqayGPHcn9S
         HeOOdtYMOEFgh/KLmV5D2COV1x9fXsgoLBdZkxukqeSwweUmI/weTAzluhTuYGu2Wno5
         6mthx3IxQYPIN9HOkIKbF0dV77LlA3XuwNwXpgZfPxM5Ux97fHttFsTJTigSWfACWn6E
         YJTn/Vow39hc0lc8f+BjyqBx0PCN8kRAdnNuyfvK0SjMZWI2k2LXvCbX5pZpfI6tA2/v
         h6FA==
X-Gm-Message-State: AOAM532spoTlbv685Yzotw+tXL9AwAj0HKQ5jpBkOCSFwtdzzKoz7c9u
        V1wHOEzTfJGmT/65jx+O9OttY1uJsw0l/UEFCFIGAw==
X-Google-Smtp-Source: ABdhPJxREciDWAvw2hXJoSNgwGzwAgfrsH/9ESk5Gp+0a5WDvKPxkb7At1Mz00fE9R8WAj7OmLftA00Br1JhwbCe4D4=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr2681205oti.251.1628758254073;
 Thu, 12 Aug 2021 01:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <17b812a3c28024acfca9b1a9e45c8235b35efa32.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <17b812a3c28024acfca9b1a9e45c8235b35efa32.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:50:42 +0200
Message-ID: <CANpmjNMYJw9Qv48tsC-EVwKDeG9FWCwmf3SLZzATyfGoMDc2Qg@mail.gmail.com>
Subject: Re: [PATCH 7/8] kasan: test: avoid corrupting memory in copy_user_test
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

On Wed, 11 Aug 2021 at 21:30, <andrey.konovalov@linux.dev> wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> copy_user_test() does writes past the allocated object. As the result,
> it corrupts kernel memory, which might lead to crashes with the HW_TAGS
> mode, as it neither uses quarantine nor redzones.
>
> (Technically, this test can't yet be enabled with the HW_TAGS mode, but
> this will be implemented in the future.)
>
> Adjust the test to only write memory within the aligned kmalloc object.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>



> ---
>  lib/test_kasan_module.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
> index f1017f345d6c..fa73b9df0be4 100644
> --- a/lib/test_kasan_module.c
> +++ b/lib/test_kasan_module.c
> @@ -15,13 +15,11 @@
>
>  #include "../mm/kasan/kasan.h"
>
> -#define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
> -
>  static noinline void __init copy_user_test(void)
>  {
>         char *kmem;
>         char __user *usermem;
> -       size_t size = 10;
> +       size_t size = 128 - KASAN_GRANULE_SIZE;
>         int __maybe_unused unused;
>
>         kmem = kmalloc(size, GFP_KERNEL);
> @@ -38,25 +36,25 @@ static noinline void __init copy_user_test(void)
>         }
>
>         pr_info("out-of-bounds in copy_from_user()\n");
> -       unused = copy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
> +       unused = copy_from_user(kmem, usermem, size + 1);
>
>         pr_info("out-of-bounds in copy_to_user()\n");
> -       unused = copy_to_user(usermem, kmem, size + 1 + OOB_TAG_OFF);
> +       unused = copy_to_user(usermem, kmem, size + 1);
>
>         pr_info("out-of-bounds in __copy_from_user()\n");
> -       unused = __copy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
> +       unused = __copy_from_user(kmem, usermem, size + 1);
>
>         pr_info("out-of-bounds in __copy_to_user()\n");
> -       unused = __copy_to_user(usermem, kmem, size + 1 + OOB_TAG_OFF);
> +       unused = __copy_to_user(usermem, kmem, size + 1);
>
>         pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
> -       unused = __copy_from_user_inatomic(kmem, usermem, size + 1 + OOB_TAG_OFF);
> +       unused = __copy_from_user_inatomic(kmem, usermem, size + 1);
>
>         pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
> -       unused = __copy_to_user_inatomic(usermem, kmem, size + 1 + OOB_TAG_OFF);
> +       unused = __copy_to_user_inatomic(usermem, kmem, size + 1);
>
>         pr_info("out-of-bounds in strncpy_from_user()\n");
> -       unused = strncpy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
> +       unused = strncpy_from_user(kmem, usermem, size + 1);
>
>         vm_munmap((unsigned long)usermem, PAGE_SIZE);
>         kfree(kmem);
> --
> 2.25.1
>
