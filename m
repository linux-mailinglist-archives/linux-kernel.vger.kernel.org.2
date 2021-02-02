Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC630C8F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhBBSFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhBBSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:02:03 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0219C061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:01:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b17so12915947plz.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1MZ9fF4ca6SaeZxY2832DoPpHMX3bUKUCoXNkXBzTg=;
        b=jNc6EBwzUkzTtMo8aKtmyGRuQeJI8FCv9ajgC1jsmbZugoDWUFBII58VnJu0uuN8t9
         snMbSb8N7JVeJ/2WltI5QDNqqrOfw79I/JYj022yEqy4NYfkj1845rkFH8PjMwC8YJm1
         hTFmkWBYfj9yY2j79PSKWV7XhF1iD0mzKfVeVkXyM6S5nNrq3y9rlzZTDtRnzuofKyjN
         kWNpd7yu3E5vPKhpKpd4HnvsxWVM/Fkpq6gq4BwX2jwPqafISPYJxHxUe0HixBpwwULc
         3/WF8Ok/3LK+UNpI2Vwumkw95ili4WpTSMHWlv7Nd99tE5Sjwmk1c1V3DdNT/rvl6UEY
         prZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1MZ9fF4ca6SaeZxY2832DoPpHMX3bUKUCoXNkXBzTg=;
        b=CrBS6QxYmNUMNTTwEg7nGKnMwcnXJKCQbUhq+lXwmxdPLWobl0lAPOWRpHwqQB7ZZm
         qZYACW0r4wFQgp7EHhveigJTJny376Gfaz5u/s4E012a5Etx4kmSamMBKWYOG1x1XKZ1
         DbQCGdz+DLI0I9H8gzYZwleP6n6rQ6Z7w10FsMY/tyCeVjEIWG9NY/qqBTRWVGFCBrcv
         Q5ftW/fq+8grjK0dSUO4yDncfHOPXz+3i96Fq4RjoNeDP/MWfPKopDGis02CC7yayqSK
         6w5JZ8+gw51jn4j75++q4C/Nkd5ywB/qtjPwxYYyM9aX9u1mU5CJUeY9qJGP6iJBv/vk
         Brbg==
X-Gm-Message-State: AOAM533OCSN0SMKPGtd4YwMvm3SoqHxjilPJBy6q/5NfbgZiMZsRLTP7
        xLpH9YOzQ61XyQsgkvhsXljmYEBfiec6jvBhrCZA8A==
X-Google-Smtp-Source: ABdhPJyD0h7LZ4QaTVYqzgxpWCXP9hJsjTvhDlivqpOVW/0uvtNZf6xwpn5YdGtZuubAcgENenHV4RtBk52X01pR3YE=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr5531989pjb.166.1612288881120;
 Tue, 02 Feb 2021 10:01:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com> <c153f78b173df7537c9be6f2f3a888ddf0b42a3b.1612208222.git.andreyknvl@google.com>
 <YBl4fY54BN4PaLVG@elver.google.com>
In-Reply-To: <YBl4fY54BN4PaLVG@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Feb 2021 19:01:09 +0100
Message-ID: <CAAeHK+wnufE=jOAOsG6LTA5Objcj=OyakEDr4zPKVW+Qq+y28g@mail.gmail.com>
Subject: Re: [PATCH 01/12] kasan, mm: don't save alloc stacks twice
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 5:06 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> > Currently KASAN saves allocation stacks in both kasan_slab_alloc() and
> > kasan_kmalloc() annotations. This patch changes KASAN to save allocation
> > stacks for slab objects from kmalloc caches in kasan_kmalloc() only,
> > and stacks for other slab objects in kasan_slab_alloc() only.
> >
> > This change requires ____kasan_kmalloc() knowing whether the object
> > belongs to a kmalloc cache. This is implemented by adding a flag field
> > to the kasan_info structure. That flag is only set for kmalloc caches
> > via a new kasan_cache_create_kmalloc() annotation.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> > ---
> >  include/linux/kasan.h |  9 +++++++++
> >  mm/kasan/common.c     | 18 ++++++++++++++----
> >  mm/slab_common.c      |  1 +
> >  3 files changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 6d8f3227c264..2d5de4092185 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -83,6 +83,7 @@ static inline void kasan_disable_current(void) {}
> >  struct kasan_cache {
> >       int alloc_meta_offset;
> >       int free_meta_offset;
> > +     bool is_kmalloc;
> >  };
> >
> >  #ifdef CONFIG_KASAN_HW_TAGS
> > @@ -143,6 +144,13 @@ static __always_inline void kasan_cache_create(struct kmem_cache *cache,
> >               __kasan_cache_create(cache, size, flags);
> >  }
> >
> > +void __kasan_cache_create_kmalloc(struct kmem_cache *cache);
> > +static __always_inline void kasan_cache_create_kmalloc(struct kmem_cache *cache)
> > +{
> > +     if (kasan_enabled())
> > +             __kasan_cache_create_kmalloc(cache);
> > +}
> > +
> >  size_t __kasan_metadata_size(struct kmem_cache *cache);
> >  static __always_inline size_t kasan_metadata_size(struct kmem_cache *cache)
> >  {
> > @@ -278,6 +286,7 @@ static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> >  static inline void kasan_cache_create(struct kmem_cache *cache,
> >                                     unsigned int *size,
> >                                     slab_flags_t *flags) {}
> > +static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
> >  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> >  static inline void kasan_poison_slab(struct page *page) {}
> >  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index fe852f3cfa42..374049564ea3 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -210,6 +210,11 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >               *size = optimal_size;
> >  }
> >
> > +void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
> > +{
> > +     cache->kasan_info.is_kmalloc = true;
> > +}
> > +
> >  size_t __kasan_metadata_size(struct kmem_cache *cache)
> >  {
> >       if (!kasan_stack_collection_enabled())
> > @@ -394,17 +399,22 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
> >       }
> >  }
> >
> > -static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> > +static void set_alloc_info(struct kmem_cache *cache, void *object,
> > +                             gfp_t flags, bool kmalloc)
> >  {
> >       struct kasan_alloc_meta *alloc_meta;
> >
> > +     /* Don't save alloc info for kmalloc caches in kasan_slab_alloc(). */
> > +     if (cache->kasan_info.is_kmalloc && !kmalloc)
> > +             return;
> > +
> >       alloc_meta = kasan_get_alloc_meta(cache, object);
> >       if (alloc_meta)
> >               kasan_set_track(&alloc_meta->alloc_track, flags);
> >  }
> >
> >  static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> > -                             size_t size, gfp_t flags, bool keep_tag)
> > +                             size_t size, gfp_t flags, bool kmalloc)
> >  {
> >       unsigned long redzone_start;
> >       unsigned long redzone_end;
> > @@ -423,7 +433,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> >                               KASAN_GRANULE_SIZE);
> >       redzone_end = round_up((unsigned long)object + cache->object_size,
> >                               KASAN_GRANULE_SIZE);
> > -     tag = assign_tag(cache, object, false, keep_tag);
> > +     tag = assign_tag(cache, object, false, kmalloc);
> >
> >       /* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
> >       kasan_unpoison(set_tag(object, tag), size);
> > @@ -431,7 +441,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> >                          KASAN_KMALLOC_REDZONE);
> >
> >       if (kasan_stack_collection_enabled())
> > -             set_alloc_info(cache, (void *)object, flags);
> > +             set_alloc_info(cache, (void *)object, flags, kmalloc);
>
> It doesn't bother me too much, but: 'bool kmalloc' shadows function
> 'kmalloc' so this is technically fine, but using 'kmalloc' as the
> variable name here might be confusing and there is a small chance it
> might cause problems in a future refactor.

Good point. Does "is_kmalloc" sound good?

Thanks!
