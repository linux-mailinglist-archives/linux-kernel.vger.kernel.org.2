Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982F6343B88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCVISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhCVISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:18:08 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E608FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:18:07 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so15102587ota.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sk5nXZmNrPBhnu290SRFE/AaX0zXvxqhg24fy7HJRik=;
        b=UsoPckqy/cBUBbKkWG7iVBL06TORbtJfQyHbYe8pqPWyQh5dez8eGB3IQJEvHOmg7G
         ZMmlbJljicTOw9XSZNbt1qAZc3Ur+4ZDG11DBj0gtsRxDM8bgvJwy5qesu2zrTnJUvmd
         u4Aw3PiSfzfqkzwffdfqKKIlriCizZHLJPPi7BK9KTYZVUJYflke8Z/fFMVHGrr7+D5v
         Nw1yV+N4pVB6UyYAhV98yvt8euaZ74R03+HjtyWE+4z384GtTMTA3pKxGrnG7uyCQRxc
         wtI07Y5BoxRPev2GwNJSwhzmFzExRkw2QIfJeCouKPL35isVkA2epjzCeJdFlBvEJJME
         jyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sk5nXZmNrPBhnu290SRFE/AaX0zXvxqhg24fy7HJRik=;
        b=LjGar5MOug3Uh7XLrpAys2xvjPq6UvheJqsUA8Mxu6hYLx8HWS2XrFB36VqB/Urrfr
         dkdBYdUKyRTMRIRbTOOLhr5+IajJDLjEFHfgUfeM+lpiAJm+NaFPkhwJxrsBf+wjC3Au
         K+DdVGc/yjRAQgjt0YWvWj10d0j8eP1HE/n/WOG85v+uF0RS9Nb2qGpyUcoMD+MLyKbn
         DVXwZBRx7YbYZ0xNcdpxK15ITfq2ArzURCfb8yEpQCEZFddEmsP/rHyLgJT5qUNV76SN
         +4UnOCifMG7aiWoXYlfU1yjOnFHnkZ7CTLu7tx35lJEoX+jM2Yc80mIB9MfCD4tlo9a6
         gPtQ==
X-Gm-Message-State: AOAM531d2SWGy+NZPFaJJrqoN0chc8ZxOCFQaM5NftdA01SGjiS5ryC/
        0mSjqIVTZ5RgFOZ9mvhGhU4106VSGraFFzT2il+GTcRzFJ4=
X-Google-Smtp-Source: ABdhPJzvbElyZZDDIxpenI8cVDVzjmJITxV9NKesMpuZ8BW6GJm0JmhCXcsj5hWyJduf0shx2QAG0j6jEips7rMEgHY=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr10905818otg.17.1616401087131;
 Mon, 22 Mar 2021 01:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210319144058.772525-1-dja@axtens.net> <20210319144058.772525-3-dja@axtens.net>
In-Reply-To: <20210319144058.772525-3-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 22 Mar 2021 09:17:55 +0100
Message-ID: <CANpmjNOGp0DLn8sMwvm5SQo4cqJDogtrEPGFhawRPd3Amr3D=w@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] kasan: allow architectures to provide an outline
 readiness check
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 15:41, Daniel Axtens <dja@axtens.net> wrote:
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
>
> --
>
> I discuss the justfication for this later in the series. Also,
> both previous RFCs for ppc64 - by 2 different people - have
> needed this trick! See:
>  - https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
>  - https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
> ---
>  include/linux/kasan.h | 4 ++++
>  mm/kasan/common.c     | 4 ++++
>  mm/kasan/generic.c    | 3 +++
>  mm/kasan/shadow.c     | 4 ++++
>  4 files changed, 15 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 8b3b99d659b7..6bd8343f0033 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h

Does kasan_arch_is_ready() need to be defined in the public interface
of KASAN? Could it instead be moved to mm/kasan/kasan.h?

> @@ -23,6 +23,10 @@ struct kunit_kasan_expectation {
>
>  #endif
>
> +#ifndef kasan_arch_is_ready
> +static inline bool kasan_arch_is_ready(void)   { return true; }
> +#endif
> +
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>
>  #include <linux/pgtable.h>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 6bb87f2acd4e..f23a9e2dce9f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -345,6 +345,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>         if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
>                 return false;
>
> +       /* We can't read the shadow byte if the arch isn't ready */
> +       if (!kasan_arch_is_ready())
> +               return false;
> +

While it probably doesn't matter much, it seems this check could be
moved up, rather than having it in the middle here.


>         if (!kasan_byte_accessible(tagged_object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
>                 return true;
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
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 727ad4629173..1f650c521037 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -80,6 +80,10 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
>          */
>         addr = kasan_reset_tag(addr);
>
> +       /* Don't touch the shadow memory if arch isn't ready */
> +       if (!kasan_arch_is_ready())
> +               return;
> +
>         /* Skip KFENCE memory if called explicitly outside of sl*b. */
>         if (is_kfence_address(addr))
>                 return;
> --
> 2.27.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210319144058.772525-3-dja%40axtens.net.
