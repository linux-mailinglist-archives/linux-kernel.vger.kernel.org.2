Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B43548B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbhDEWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhDEWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:43:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F5FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 15:43:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u17so12617495ejk.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yo52b4J16syd/qfNeKjfg1qCC8mR8uBgoSHsQDF+zy8=;
        b=hwD7BLAc9IN7zVKm9X1tRpL0lk2t4cFOw4vHEPOS36yFjYpHpOOn3/O4nHZHyOzuye
         EVyw7NL8OztU4tehz0MzJZfB7pZSCnUK4Ckvfh0vrpOU/XQb3Cp9NFiHAML/xAaLzd75
         BX8nrk2MQmvxKk9Eb9HERskM/ze/Ol68W6wlwsCEQg9hBIkD9AodO/fLyda0CRJi3ljo
         houat1mIpC8vvPhMT3PZEXZSxojvQP07XAWZ8hNnDeyjx5CWCf+bq58DL76LM8JiuKqB
         Fpz9Tj/mHNxKkdKyskQK1z99GL3PIt4yFe2C/Ybg2FR0u87WTNqvkRD2l0Ec1hgOTHk+
         K1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yo52b4J16syd/qfNeKjfg1qCC8mR8uBgoSHsQDF+zy8=;
        b=N7IbYdxxRgfqrO7LdWOkZ8+lYqXcMvsrCzBiWzRbWAoBHjh2YM5HSH/6Nm2BsWNI7u
         NfAjMvKNsQ0Vd3BFwHl5ZUUfLGTp/Jm+f5LPrftV0s3etEHiq4SyKJHtDchsZJR9fvB8
         lAvG9QWKBym/RGNVu8xZTMRL7tHP92C5QPz1R7jIRoUaJR7/CLG89rzZmlaB8m1XeU9f
         cPn0UCtgX3N2F53O5sA+O+ktGlWb5gaBdT334ZdYLLjvG54QuChPOeQLPY9Oee/hwxMP
         TH8oe9LPvDxKwoLKnz+q0aTcm9xEesUkle/H9EJOsEQSjJfefov37vjtWZSciFMtWfYm
         oWuA==
X-Gm-Message-State: AOAM530Lu5Pzbsq89O+n3iZSbGLZh1IbTkyg9CwCCiNqEEO+ZJFy9Jyy
        NbDmk8WwXTErVpnrY1Mk/w7QMGGy8bKfL2Namp0=
X-Google-Smtp-Source: ABdhPJwKlSaCOul8s/f4tEbscuCbIAZgiL/leovnNzFPGSauV6kH5prdShdudT7OVnZq0CVtP6h77utCNn/TicH9uD8=
X-Received: by 2002:a17:906:4e17:: with SMTP id z23mr30869445eju.439.1617662613103;
 Mon, 05 Apr 2021 15:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210405220647.1965262-1-pcc@google.com>
In-Reply-To: <20210405220647.1965262-1-pcc@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 6 Apr 2021 00:43:22 +0200
Message-ID: <CA+fCnZc=+d036Ve7k-4OdtZ+epSd4QywRs-qc9JWV72Z8Er1yw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix kasan_byte_accessible() to be consistent
 with actual checks
To:     Peter Collingbourne <pcc@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 12:07 AM Peter Collingbourne <pcc@google.com> wrote:
>
> We can sometimes end up with kasan_byte_accessible() being called
> on non-slab memory. For example ksize() and krealloc() may end up
> calling it on KFENCE allocated memory. In this case the memory will
> be tagged with KASAN_SHADOW_INIT, which a subsequent patch ("kasan:
> initialize shadow to TAG_INVALID for SW_TAGS") will set to the same
> value as KASAN_TAG_INVALID, causing kasan_byte_accessible() to fail
> when called on non-slab memory.
>
> This highlighted the fact that the check in kasan_byte_accessible()
> was inconsistent with checks as implemented for loads and stores
> (kasan_check_range() in SW tags mode and hardware-implemented
> checks in HW tags mode). kasan_check_range() does not have a
> check for KASAN_TAG_INVALID, and instead has a comparison against
> KASAN_SHADOW_START. In HW tags mode, we do not have either, but we
> do set TCR_EL1.TCMA which corresponds with the comparison against
> KASAN_TAG_KERNEL.
>
> Therefore, update kasan_byte_accessible() for both SW and HW tags
> modes to correspond with the respective checks on loads and stores.
>
> Link: https://linux-review.googlesource.com/id/Ic6d40803c57dcc6331bd97fbb9a60b0d38a65a36
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
>  mm/kasan/kasan.h   |  3 +--
>  mm/kasan/sw_tags.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8c55634d6edd..e18e8da35255 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -368,8 +368,7 @@ static inline bool kasan_byte_accessible(const void *addr)
>         u8 ptr_tag = get_tag(addr);
>         u8 mem_tag = hw_get_mem_tag((void *)addr);
>
> -       return (mem_tag != KASAN_TAG_INVALID) &&
> -               (ptr_tag == KASAN_TAG_KERNEL || ptr_tag == mem_tag);
> +       return ptr_tag == KASAN_TAG_KERNEL || ptr_tag == mem_tag;
>  }
>
>  #else /* CONFIG_KASAN_HW_TAGS */
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 94c2d33be333..00ae8913fc74 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -121,10 +121,14 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>  bool kasan_byte_accessible(const void *addr)
>  {
>         u8 tag = get_tag(addr);
> -       u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
> +       void *untagged_addr = kasan_reset_tag(addr);
> +       u8 shadow_byte;
>
> -       return (shadow_byte != KASAN_TAG_INVALID) &&
> -               (tag == KASAN_TAG_KERNEL || tag == shadow_byte);
> +       if (untagged_addr < kasan_shadow_to_mem((void *)KASAN_SHADOW_START))
> +               return false;
> +
> +       shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(untagged_addr));
> +       return tag == KASAN_TAG_KERNEL || tag == shadow_byte;
>  }
>
>  #define DEFINE_HWASAN_LOAD_STORE(size)                                 \
> --
> 2.31.0.208.g409f899ff0-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you, Peter!
