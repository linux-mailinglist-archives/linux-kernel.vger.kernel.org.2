Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5230A5AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhBAKnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhBAKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:40:57 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A005C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:40:17 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d7so15776609otf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZ3P7u3TRYoNHUYZqgM31be6IdJ5ULeRL5Xx+spxYug=;
        b=J+G/5cHAOoeeChiA2gvAbHNdL/cLBHqEBYggQT9DagQENHw2vR2w4LUTIVIvHsJlK3
         BvSxBLO/KJ9Er43uplO1k6Nn3E7BdwDOUPopWx+aZ2FXgSNK2JI54UIJklO0rX6zBdIw
         9aE46+23PnFPuBR/2G774C/y/2rLDh99LNWGG61nW8kLmQ/1fKZ7pUel0nZixWV701sR
         lir1+JvjiGlvFswRQDg9gL3k2utSVl1RbNnAEgpAVy+TGfmBa6+LL3rI3QTkWKj3rHXX
         wKXMyKhWSF+JDGlBb0PeCkMlr3RwSEiMoODTJAVp6Em7TF2WzW9954ZDEDfbmnbcxnY/
         Hmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZ3P7u3TRYoNHUYZqgM31be6IdJ5ULeRL5Xx+spxYug=;
        b=U8mTenjy7pcwpAwHI8DZ4UBjCjTMubvbu5CmK+KvLkaqUEXtiL0YUfjvsmP0CFcaZI
         1RluK8UcAJFfPTijh+O6eeWmD3fQVPxZH7vzT0gebXY86VSFd9xeER5UGLgmP82rU4jW
         YgiSo841LXSkvcXPzGA7LVQyhHcjohPZbzgcnHCaHtrUbNmF9TBslwfODfaufxazCNxU
         fP3dH3TfQWzzgSoEHn3XnHDv1L1lyzFqT+P9NIfaESA4P67SBFkg7avMCp+GyXGtoiJC
         lychknyITkEOWxe/i4pjYcuDqJVecXAP+Ph3ZRXlXOaTNotxXLDKaNKCHo0NBwp4na3Y
         u1Zg==
X-Gm-Message-State: AOAM530TKINIYb2WHlXM5Ers5mI42wsXUnilTJ1+jt0TUqaQnjSjgED6
        k/NMbdT7kK77l6JoLlv/X8Hh/ECXgojRAQZOJXucOw==
X-Google-Smtp-Source: ABdhPJxbLZb3s83wkvuMcsz//ZdUo7T5QE3e00JDOcFsWOEZM13K0O32Rx5cT+vayqYjgDKiCVKQe0Xa2wvImTBggmo=
X-Received: by 2002:a9d:4687:: with SMTP id z7mr11570191ote.233.1612176016311;
 Mon, 01 Feb 2021 02:40:16 -0800 (PST)
MIME-Version: 1.0
References: <9dc196006921b191d25d10f6e611316db7da2efc.1611946152.git.andreyknvl@google.com>
In-Reply-To: <9dc196006921b191d25d10f6e611316db7da2efc.1611946152.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 1 Feb 2021 11:40:05 +0100
Message-ID: <CANpmjNMWVHttcMsWs0g_US1FsXM_Fwi9A3GzW_gfitnVkR66SA@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: untag addresses for KFENCE
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 at 19:50, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> KFENCE annotations operate on untagged addresses.
>
> Untag addresses in KASAN runtime where they might be tagged.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

> ---
>
> This can be squashed into:
>
> revert kasan-remove-kfence-leftovers
> kfence, kasan: make KFENCE compatible with KASA
>
> ---
>  mm/kasan/common.c |  2 +-
>  mm/kasan/kasan.h  | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a390fae9d64b..fe852f3cfa42 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -416,7 +416,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>         if (unlikely(object == NULL))
>                 return NULL;
>
> -       if (is_kfence_address(object))
> +       if (is_kfence_address(kasan_reset_tag(object)))
>                 return (void *)object;
>
>         redzone_start = round_up((unsigned long)(object + size),
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 11c6e3650468..4fb8106f8e31 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -320,22 +320,28 @@ static inline u8 kasan_random_tag(void) { return 0; }
>
>  static inline void kasan_poison(const void *address, size_t size, u8 value)
>  {
> +       address = kasan_reset_tag(address);
> +
>         /* Skip KFENCE memory if called explicitly outside of sl*b. */
>         if (is_kfence_address(address))
>                 return;
>
> -       hw_set_mem_tag_range(kasan_reset_tag(address),
> +       hw_set_mem_tag_range((void *)address,
>                         round_up(size, KASAN_GRANULE_SIZE), value);
>  }
>
>  static inline void kasan_unpoison(const void *address, size_t size)
>  {
> +       u8 tag = get_tag(address);
> +
> +       address = kasan_reset_tag(address);
> +
>         /* Skip KFENCE memory if called explicitly outside of sl*b. */
>         if (is_kfence_address(address))
>                 return;
>
> -       hw_set_mem_tag_range(kasan_reset_tag(address),
> -                       round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> +       hw_set_mem_tag_range((void *)address,
> +                       round_up(size, KASAN_GRANULE_SIZE), tag);
>  }
>
>  static inline bool kasan_byte_accessible(const void *addr)
> --
> 2.30.0.365.g02bc693789-goog
>
