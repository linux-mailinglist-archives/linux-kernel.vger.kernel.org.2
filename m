Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F833B44B7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFYNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhFYNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:48:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C692AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:45:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c7so13469577edn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CpnvSJnCFtaGuYOVBatHS50FEMI3wJ5bkwuLzl1+lo=;
        b=HP6Z00KL8KrDrJaJoViBRS6UP7jk++nCt3H1seK3dJww4zkJWoyTAFrWj2wtJnRn4o
         TKXnGN70eQnJTZqZI8LTK0+suqnKniR1CHSea5VixV/3vFFG1Jyrss/fJu/+XRxLvtoO
         nMLvw/tun18UgPIqqMGPAsIYuJ2VZFsThyBb507XXUZPxdQaicsTERY5kkNX26GyFobJ
         ZrVtRcWfOuVeGoiJ2x05H1Eg/A7qGzPWsKgTbp59i2cpkadFNX2MD/eqVdTHgvtSm6Zj
         3tEMOGBJ36pRhjWgzxK3gS32pKfTcP8U9FDGJ2D8zm0Rb0JEozI4k/gABYPMedExdyUu
         bikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CpnvSJnCFtaGuYOVBatHS50FEMI3wJ5bkwuLzl1+lo=;
        b=qaVo1vzjCkcnFF66cAoFDT5SEPHbJaQmrrkG/I99ynyVdCqQaOD+uj6paE1rpsPu4f
         JUlmBoQ4alf0ySSNWvGLgNLonJXjoHYJmeczYsVJc5nnn3CW2i9ajr4O1YgYvBDvgRPJ
         RxjlNFScK+zAQYOcWbCJdBvEa7hR+OAxOm0qchFM+8v6bes2jHd1dk4zNGxUlHsYGNWZ
         bgxD0i0xj+TLOHr4vWuV+VFYztjFYiqELeKXdIM0J/1ibTMoTZkKYOvTfceBFeWfuKIJ
         ZMDenuytU67Y0E3Zrm1edGhDg3CNq21HoVw5xo1omGv4+1ntkvXC4RF9T8ZUokQcaaeN
         EhVg==
X-Gm-Message-State: AOAM5300XQAiL/0Di8V4PP/Lmt+6iIIBDXyirLOEroY8QGMrcYgssYSG
        CqxmhTx7LeBQXI1ZCGaEk/QgAkp7GRtzeyQDnlc=
X-Google-Smtp-Source: ABdhPJxuvnKDUvbpTpuYYKdL2Bajdp3tVKlgY04Ox58c3KNVp2Si6xh5xFh78NigskIzs8sROTm8v0BhfzMZVNw4srI=
X-Received: by 2002:a05:6402:1d11:: with SMTP id dg17mr15087371edb.30.1624628742089;
 Fri, 25 Jun 2021 06:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210624034050.511391-1-dja@axtens.net> <20210624034050.511391-3-dja@axtens.net>
In-Reply-To: <20210624034050.511391-3-dja@axtens.net>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 25 Jun 2021 16:45:19 +0300
Message-ID: <CA+fCnZe14NZMbD8wPJQr=jj_0Mik8ZN1-Q3H6iM2tPp8qY1X4w@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] kasan: allow architectures to provide an outline
 readiness check
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 6:41 AM Daniel Axtens <dja@axtens.net> wrote:
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
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> --
>
> Both previous RFCs for ppc64 - by 2 different people - have
> needed this trick! See:
>  - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
>  - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
>
> Build tested on arm64 with SW_TAGS and x86 with INLINE: the error fires
> if I add a kasan_arch_is_ready define.
> ---
>  mm/kasan/common.c  | 3 +++
>  mm/kasan/generic.c | 3 +++
>  mm/kasan/kasan.h   | 6 ++++++
>  mm/kasan/shadow.c  | 6 ++++++
>  4 files changed, 18 insertions(+)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 10177cc26d06..2baf121fb8c5 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -331,6 +331,9 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>         u8 tag;
>         void *tagged_object;
>
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
> index 8f450bc28045..4dbc8def64f4 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -449,6 +449,12 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
>
>  #endif /* CONFIG_KASAN_GENERIC */
>
> +#ifndef kasan_arch_is_ready
> +static inline bool kasan_arch_is_ready(void)   { return true; }
> +#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
> +#error kasan_arch_is_ready only works in KASAN generic outline mode!
> +#endif
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 082ee5b6d9a1..8d95ee52d019 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -73,6 +73,9 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
>  {
>         void *shadow_start, *shadow_end;
>
> +       if (!kasan_arch_is_ready())
> +               return;
> +
>         /*
>          * Perform shadow offset calculation based on untagged address, as
>          * some of the callers (e.g. kasan_poison_object_data) pass tagged
> @@ -99,6 +102,9 @@ EXPORT_SYMBOL(kasan_poison);
>  #ifdef CONFIG_KASAN_GENERIC
>  void kasan_poison_last_granule(const void *addr, size_t size)
>  {
> +       if (!kasan_arch_is_ready())
> +               return;
> +
>         if (size & KASAN_GRANULE_MASK) {
>                 u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
>                 *shadow = size & KASAN_GRANULE_MASK;
> --
> 2.30.2
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
