Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A013AACF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhFQHI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQHIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:08:23 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F82C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:06:16 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso5111157otl.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhqmE1vBTbQZlPad3fKuDW4Qef6o+8lKl4ONa0J/G/8=;
        b=eGrVtvwA+i6aNAMo3ETYrgy4DVEWUiimdDfxOE2LFye56wFHpr1W4MnbrblQ8rRQcC
         xJ75y+uRuCGoD3u+AwSOr3k3oP8buzdYF7JppwE5mTFUR0Oe2ouOwNKfRRuPgh7Rr/zk
         RyQf66jXNR/8yk3XRkGerNoLo+WDXQA6ePmSKgvat2HJxflCZPul4uR6rRSq1QM9w53J
         2TE6qCvLxMRjTV1m+KDKmwdi6doQ3jZ+Roh6f2GRMQZ7Uk/4Z11RLlP8MRyTk+7ApLA2
         rL5GXw+oTZeFmgnFcHUqZTo1Ehtao2FNASwGb3WRDOZm6rnFo/I35o+YxhzFb9V+4O/Y
         35jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhqmE1vBTbQZlPad3fKuDW4Qef6o+8lKl4ONa0J/G/8=;
        b=lmTc+o72LX3McvyeBXRvVeDC5wYIAKKFX0PH58XQjzIDr+CWeZSNMAkG1K9KCLqp6Z
         +TYCo53/2BgzyvuswwrMwLRJRS/QAsZvN52HXh9J2l59orQWYQM1uS0II1vCixI5Fq1W
         IhM1kw7wTEHwYUv9cXQGn7A5CgALWstgZAUjwARUKZ+tGJj/7nlTRlRq2EHDfQpG0ZWa
         OAvjNLbjJUpes6UPOOPGKdqyly3GXTRvWbMXb4X4KZeXS9+WZwr/HWezIJQZ7JHnaeoe
         kvxmGzCAgNdYCm7zyscreLOcVA3WHS832cmlxGTkqiY5QhyBPBZzuuaGEVKnPtEOnkzb
         /dNQ==
X-Gm-Message-State: AOAM533vCLKZsEgnjsqj9IlzN+rhhbE/kO5QlTI5yxpGiU/+tGjq3t//
        dLlKWil9GFdaHziCzsXFmZZiOUa2p0kSVi8Lf6qlDQ==
X-Google-Smtp-Source: ABdhPJzb3pydS4fL1OGc3+kLyBtkxKVQSv+5ySB2k1JVkAvfcK53EAa09UHM2AiBfuP55Icc+GyGNfs+i3l/fcRAo0o=
X-Received: by 2002:a9d:4e7:: with SMTP id 94mr3260598otm.233.1623913575674;
 Thu, 17 Jun 2021 00:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210617063956.94061-1-dja@axtens.net> <20210617063956.94061-3-dja@axtens.net>
In-Reply-To: <20210617063956.94061-3-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Jun 2021 09:06:02 +0200
Message-ID: <CANpmjNPvCprs4+aToP4GXC1upii2sVYbHPRcDoVr=qL3psMUSw@mail.gmail.com>
Subject: Re: [PATCH v14 2/4] kasan: allow architectures to provide an outline
 readiness check
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 08:40, Daniel Axtens <dja@axtens.net> wrote:
>
> Allow architectures to define a kasan_arch_is_ready() hook that bails
> out of any function that's about to touch the shadow unless the arch
> says that it is ready for the memory to be accessed. This is fairly
> uninvasive and should have a negligible performance penalty.
>
> This will only work in outline mode, so an arch must specify
> ARCH_DISABLE_KASAN_INLINE if it requires this.
>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

With Christophe's suggestion:

Reviewed-by: Marco Elver <elver@google.com>


> --
>
> Both previous RFCs for ppc64 - by 2 different people - have
> needed this trick! See:
>  - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
>  - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
>
> I haven't been able to exercise the arch hook error for !GENERIC as I
> don't have a particularly modern aarch64 toolchain or a lot of experience
> cross-compiling with clang. But it does fire for GENERIC + INLINE on x86.
> ---
>  mm/kasan/common.c  | 4 ++++
>  mm/kasan/generic.c | 3 +++
>  mm/kasan/kasan.h   | 8 ++++++++
>  mm/kasan/shadow.c  | 8 ++++++++
>  4 files changed, 23 insertions(+)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 10177cc26d06..0ad615f3801d 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -331,6 +331,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>         u8 tag;
>         void *tagged_object;
>
> +       /* Bail if the arch isn't ready */
> +       if (!kasan_arch_is_ready())
> +               return false;
> +
>         tag = get_tag(object);
>         tagged_object = object;
>         object = kasan_reset_tag(object);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 53cbf28859b5..c3f5ba7a294a 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -163,6 +163,9 @@ static __always_inline bool check_region_inline(unsigned long addr,
>                                                 size_t size, bool write,
>                                                 unsigned long ret_ip)
>  {
> +       if (!kasan_arch_is_ready())
> +               return true;
> +
>         if (unlikely(size == 0))
>                 return true;
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8f450bc28045..b18abaf8c78e 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -449,6 +449,14 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
>
>  #endif /* CONFIG_KASAN_GENERIC */
>
> +#ifndef kasan_arch_is_ready
> +static inline bool kasan_arch_is_ready(void)   { return true; }
> +#else
> +#if !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
> +#error kasan_arch_is_ready only works in KASAN generic outline mode!
> +#endif
> +#endif
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 082ee5b6d9a1..3c7f7efe6f68 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -73,6 +73,10 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
>  {
>         void *shadow_start, *shadow_end;
>
> +       /* Don't touch the shadow memory if arch isn't ready */
> +       if (!kasan_arch_is_ready())
> +               return;
> +
>         /*
>          * Perform shadow offset calculation based on untagged address, as
>          * some of the callers (e.g. kasan_poison_object_data) pass tagged
> @@ -99,6 +103,10 @@ EXPORT_SYMBOL(kasan_poison);
>  #ifdef CONFIG_KASAN_GENERIC
>  void kasan_poison_last_granule(const void *addr, size_t size)
>  {
> +       /* Don't touch the shadow memory if arch isn't ready */
> +       if (!kasan_arch_is_ready())
> +               return;
> +
>         if (size & KASAN_GRANULE_MASK) {
>                 u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
>                 *shadow = size & KASAN_GRANULE_MASK;
> --
> 2.30.2
>
