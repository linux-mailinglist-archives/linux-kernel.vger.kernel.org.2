Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DFB354867
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 23:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhDEVxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 17:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbhDEVxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 17:53:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93F1C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 14:53:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w23so2839410edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5agwQ0zThzc864zDwQsU0D8PGaKGEvgUD6u4hDPScD0=;
        b=NA7k8+kdwRZCnDG2UOwug4CS0plPPRJreVTt9HdBi+DESBdCmAkiaJANEJacbq09tO
         HYkXWo50oJApb/05+yZ0XeNQTeVVCYvAf4VVwFH0kmd/My2eExXZBNmVm+n/qb3v5zrK
         iKbz70/JWKHi7IFRIDxUTXQQ8nHNX7SWv7inM31iiLCN1e/Ycl4PRvG1+UZ9OAyOcxZy
         ntQiAO1f7mdxSET2eU12Jc1w8N2JfBEr2rpsEoP3a+6TrcXnqD6AuI739k+EUwncMKxd
         0AmYCH9vH3qRddtoQ68XVL0fixkOE6Wev2nB/PpFATwdmTrEPeflDr5972/6XVDIR3zE
         j0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5agwQ0zThzc864zDwQsU0D8PGaKGEvgUD6u4hDPScD0=;
        b=kMFpXFoWP80jQXBYtRw2ZOPCQD2wjyPTV10UzPopdhwGdXwG6YkaijqaSvUoFRxnag
         Z/JAxbXLG9n3qINiKf3g+YmUED2XHq+UsYgu64Tfi/HEya0XfqE0ogUly34krv9izV2f
         Di07x9I+kK2WPEV43EeWSipzwNYZvfko8TXxO7b0CEE80s48L0vZScfaUyfv5L9xdokq
         lQxrp6IPF10mLu2af72aE9bG79n+HaHraC5/U44VKW2kZkeYo2D0JiPsq+LwAwkSWH9n
         cejxWbg/uk3fop/s/r6r7pPD62+mhXxZ1O2koiVzMuM54f8tMjAVZSRix9gkk23hVaBg
         rHUw==
X-Gm-Message-State: AOAM533YX6+QYBCpB+GF/+bDKvgV11gLjEn64niU7DTsSpoxdn/AhLAI
        A2fgzuHDKRlp5f07ICqikTY1L526we1q7Y267WB09cnoj2k=
X-Google-Smtp-Source: ABdhPJzLYW8JXD4N1iYvdzWmzlQ7A5bHoQSa+dS5Dt6T6bzAzET4LqVbj+R2p2t0lVUJ+hy7uVz6kMf6qv/5R/ORSmY=
X-Received: by 2002:aa7:d541:: with SMTP id u1mr14436442edr.95.1617659583372;
 Mon, 05 Apr 2021 14:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210405214321.1953019-1-pcc@google.com>
In-Reply-To: <20210405214321.1953019-1-pcc@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Apr 2021 23:52:52 +0200
Message-ID: <CA+fCnZeC20t5Lhswo7zcULNgfksxqb2_fP4j0pNy29E_q6hJyg@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix kasan_byte_accessible() to be consistent with
 actual checks
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

On Mon, Apr 5, 2021 at 11:43 PM Peter Collingbourne <pcc@google.com> wrote:
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
>  mm/kasan/kasan.h   | 3 +--
>  mm/kasan/sw_tags.c | 8 +++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
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
> index 94c2d33be333..914225eeda99 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -121,10 +121,12 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>  bool kasan_byte_accessible(const void *addr)
>  {
>         u8 tag = get_tag(addr);
> -       u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
> +       void *untagged_addr = kasan_reset_tag(addr);
> +       u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(untagged_addr));

Hi Peter,

Let's move dereferencing shadow memory past the KASAN_SHADOW_START
check. Otherwise, in case the check is to fail, accessing shadow will
likely crash the kernel.

Thanks!

>
> -       return (shadow_byte != KASAN_TAG_INVALID) &&
> -               (tag == KASAN_TAG_KERNEL || tag == shadow_byte);
> +       return untagged_addr >=
> +                      kasan_shadow_to_mem((void *)KASAN_SHADOW_START) &&
> +              (tag == KASAN_TAG_KERNEL || tag == shadow_byte);
>  }
>
>  #define DEFINE_HWASAN_LOAD_STORE(size)                                 \
> --
> 2.31.0.208.g409f899ff0-goog
>
