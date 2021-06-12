Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C763A4F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhFLPxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFLPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:53:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 08:51:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k15so7012034pfp.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=13vDzbI957CXDNEDtcZR2S0juOb9uGtVIdJ1VlmUGxM=;
        b=lSSHhbMP8v2VoHlvUXfUyX1msYdK7i2l/zphFT4PyuG6HNDDYT7KiMHSr+ZKTXJ+ZD
         Ndi49LNJchotWTey+CTKsNH85bVpK8k9wwDCVzktEJ5RWA24oh9JeD30R43ZCcvGWpKY
         x1qazk4LiLegvrSvt4spLvV21NcAvab+bFblAOe//kPF88REVhEasBVmTMO93jr4Vpo0
         Jkloz2JkdajqyvQCapu54ifOePJx4ip0XezVq6XDZdi2xwBboQsmuvTWRBHWGz4f/Ioi
         IR0cAtU1T0if8ElcFdCsCRSY9v9AlPk/8h/oYlQhDLAv9yOpIa2OdDnsQA+NGF3Gif6A
         OHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=13vDzbI957CXDNEDtcZR2S0juOb9uGtVIdJ1VlmUGxM=;
        b=UGdU/TrfuEBeb8Lx6x9VDJmZmpvBXlkhZOtBhcGODNgqPKcWDxsY0zD9D6LxGDWkkk
         +aPv06p4RnBvVKO6d0NKRzVvYmymP5umO1yv9deZm/wV78oYLqTRL+M/aS9KYFJRhWSl
         GgZXvTLWxnl5Rab+lyMC9NRI4C1bmqbI6M9/yLxzBj6ZVRB9u3X/oFz+6NQUgrMuMqKR
         jhxpTm+4tDroxOykfyoyKdMgbTcQo8aJNZnxEIwH8nkvPprXCcK6Cw7d2o3fmRT7tDO0
         3nXAX6jYcbc+NX5mj0gSVRXXyCMqsEqDxxdRqhTI7pfKy1vIqk5Gbo6BnoGG5rhCptjP
         2vIw==
X-Gm-Message-State: AOAM532MyndJjkkkebcXL3QaO6GjK6c3rhPdtPllvEAMXqIp40aPCmSy
        k7QnKNnyPFEpKfZpODigOr8=
X-Google-Smtp-Source: ABdhPJxeofGXExwLsfdM4964kd2TTSRR4vEi6CmJptlxHOf0tP4ANhG+X8CoDPWU3VZL6Nwlpi+b3g==
X-Received: by 2002:a63:b043:: with SMTP id z3mr9161280pgo.89.1623513077639;
        Sat, 12 Jun 2021 08:51:17 -0700 (PDT)
Received: from DESKTOP-PJLD54P.localdomain (122-116-74-98.HINET-IP.hinet.net. [122.116.74.98])
        by smtp.gmail.com with ESMTPSA id t19sm12891513pjq.44.2021.06.12.08.51.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jun 2021 08:51:17 -0700 (PDT)
Date:   Sat, 12 Jun 2021 23:51:08 +0800
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
Message-ID: <20210612155108.GA68@DESKTOP-PJLD54P.localdomain>
References: <20210612045156.44763-1-kylee0686026@gmail.com>
 <20210612045156.44763-3-kylee0686026@gmail.com>
 <CANpmjNMLzxMO0k_kvGaAvzyGoyKxBTtjx4PH=-MKKgDb1-dQaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMLzxMO0k_kvGaAvzyGoyKxBTtjx4PH=-MKKgDb1-dQaA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 04:42:44PM +0200, Marco Elver wrote:
> On Sat, 12 Jun 2021 at 06:52, Kuan-Ying Lee <kylee0686026@gmail.com> wrote:
> > 1. Move kasan_get_free_track() and kasan_set_free_info()
> >    into tags.c
> > 2. Move kasan_get_bug_type() to header file
> >
> > Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>
> > Suggested-by: Marco Elver <elver@google.com>
> > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/kasan/Makefile         |  4 +--
> >  mm/kasan/hw_tags.c        | 22 ---------------
> >  mm/kasan/report_hw_tags.c |  6 +---
> >  mm/kasan/report_sw_tags.c | 46 +------------------------------
> >  mm/kasan/report_tags.h    | 56 +++++++++++++++++++++++++++++++++++++
> >  mm/kasan/sw_tags.c        | 41 ---------------------------
> >  mm/kasan/tags.c           | 58 +++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 118 insertions(+), 115 deletions(-)
> >  create mode 100644 mm/kasan/report_tags.h
> >  create mode 100644 mm/kasan/tags.c
> [...]
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index ed5e5b833d61..4ea8c368b5b8 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -216,28 +216,6 @@ void __init kasan_init_hw_tags(void)
> >         pr_info("KernelAddressSanitizer initialized\n");
> >  }
> >
> > -void kasan_set_free_info(struct kmem_cache *cache,
> > -                               void *object, u8 tag)
> > -{
> > -       struct kasan_alloc_meta *alloc_meta;
> > -
> > -       alloc_meta = kasan_get_alloc_meta(cache, object);
> > -       if (alloc_meta)
> > -               kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
> > -}
> > -
> > -struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> > -                               void *object, u8 tag)
> > -{
> > -       struct kasan_alloc_meta *alloc_meta;
> > -
> > -       alloc_meta = kasan_get_alloc_meta(cache, object);
> > -       if (!alloc_meta)
> > -               return NULL;
> > -
> > -       return &alloc_meta->free_track[0];
> > -}
> > -
> >  void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
> >  {
> >         /*
> > diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
> > index 42b2168755d6..ef5e7378f3aa 100644
> > --- a/mm/kasan/report_hw_tags.c
> > +++ b/mm/kasan/report_hw_tags.c
> > @@ -14,11 +14,7 @@
> >  #include <linux/types.h>
> >
> >  #include "kasan.h"
> > -
> > -const char *kasan_get_bug_type(struct kasan_access_info *info)
> > -{
> > -       return "invalid-access";
> > -}
> > +#include "report_tags.h"
> >
> >  void *kasan_find_first_bad_addr(void *addr, size_t size)
> >  {
> > diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> > index 821a14a19a92..d965a170083e 100644
> > --- a/mm/kasan/report_sw_tags.c
> > +++ b/mm/kasan/report_sw_tags.c
> > @@ -26,51 +26,7 @@
> >
> >  #include <asm/sections.h>
> >
> > -#include "kasan.h"
> > -#include "../slab.h"
> > -
> > -const char *kasan_get_bug_type(struct kasan_access_info *info)
> > -{
> > -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> > -       struct kasan_alloc_meta *alloc_meta;
> > -       struct kmem_cache *cache;
> > -       struct page *page;
> > -       const void *addr;
> > -       void *object;
> > -       u8 tag;
> > -       int i;
> > -
> > -       tag = get_tag(info->access_addr);
> > -       addr = kasan_reset_tag(info->access_addr);
> > -       page = kasan_addr_to_page(addr);
> > -       if (page && PageSlab(page)) {
> > -               cache = page->slab_cache;
> > -               object = nearest_obj(cache, page, (void *)addr);
> > -               alloc_meta = kasan_get_alloc_meta(cache, object);
> > -
> > -               if (alloc_meta) {
> > -                       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> > -                               if (alloc_meta->free_pointer_tag[i] == tag)
> > -                                       return "use-after-free";
> > -                       }
> > -               }
> > -               return "out-of-bounds";
> > -       }
> > -
> > -#endif
> > -       /*
> > -        * If access_size is a negative number, then it has reason to be
> > -        * defined as out-of-bounds bug type.
> > -        *
> > -        * Casting negative numbers to size_t would indeed turn up as
> > -        * a large size_t and its value will be larger than ULONG_MAX/2,
> > -        * so that this can qualify as out-of-bounds.
> > -        */
> > -       if (info->access_addr + info->access_size < info->access_addr)
> > -               return "out-of-bounds";
> > -
> > -       return "invalid-access";
> > -}
> > +#include "report_tags.h"
> >
> >  void *kasan_find_first_bad_addr(void *addr, size_t size)
> >  {
> > diff --git a/mm/kasan/report_tags.h b/mm/kasan/report_tags.h
> > new file mode 100644
> > index 000000000000..4f740d4d99ee
> > --- /dev/null
> > +++ b/mm/kasan/report_tags.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __MM_KASAN_REPORT_TAGS_H
> > +#define __MM_KASAN_REPORT_TAGS_H
> > +
> > +#include "kasan.h"
> > +#include "../slab.h"
> > +
> > +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> > +const char *kasan_get_bug_type(struct kasan_access_info *info)
> > +{
> [...]
> > +       /*
> > +        * If access_size is a negative number, then it has reason to be
> > +        * defined as out-of-bounds bug type.
> > +        *
> > +        * Casting negative numbers to size_t would indeed turn up as
> > +        * a large size_t and its value will be larger than ULONG_MAX/2,
> > +        * so that this can qualify as out-of-bounds.
> > +        */
> > +       if (info->access_addr + info->access_size < info->access_addr)
> > +               return "out-of-bounds";
> 
> This seems to change behaviour for SW_TAGS because it was there even
> if !CONFIG_KASAN_TAGS_IDENTIFY. Does it still work as before?
> 

You are right. It will change the behavior.
However, I think that if !CONFIG_KASAN_TAG_IDENTIFY, it should be reported
"invalid-access".

Or is it better to keep it in both conditions?

> > +
> > +       return "invalid-access";
> > +}
> > +#else
> > +const char *kasan_get_bug_type(struct kasan_access_info *info)
> > +{
> > +       return "invalid-access";
> > +}
> > +#endif
> > +
> > +#endif
> > diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> > index dd05e6c801fa..bd3f540feb47 100644
> > --- a/mm/kasan/sw_tags.c
> > +++ b/mm/kasan/sw_tags.c
> > @@ -167,47 +167,6 @@ void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
> >  }
> >  EXPORT_SYMBOL(__hwasan_tag_memory);
> >
> > -void kasan_set_free_info(struct kmem_cache *cache,
> > -                               void *object, u8 tag)
> > -{
> > -       struct kasan_alloc_meta *alloc_meta;
> > -       u8 idx = 0;
> > -
> > -       alloc_meta = kasan_get_alloc_meta(cache, object);
> > -       if (!alloc_meta)
> > -               return;
> > -
> > -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> > -       idx = alloc_meta->free_track_idx;
> > -       alloc_meta->free_pointer_tag[idx] = tag;
> > -       alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> > -#endif
> > -
> > -       kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> > -}
> > -
> > -struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> > -                               void *object, u8 tag)
> > -{
> > -       struct kasan_alloc_meta *alloc_meta;
> > -       int i = 0;
> > -
> > -       alloc_meta = kasan_get_alloc_meta(cache, object);
> > -       if (!alloc_meta)
> > -               return NULL;
> > -
> > -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> > -       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> > -               if (alloc_meta->free_pointer_tag[i] == tag)
> > -                       break;
> > -       }
> > -       if (i == KASAN_NR_FREE_STACKS)
> > -               i = alloc_meta->free_track_idx;
> > -#endif
> > -
> > -       return &alloc_meta->free_track[i];
> > -}
> > -
> >  void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
> >                         unsigned long ret_ip)
> >  {
> > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > new file mode 100644
> > index 000000000000..9c33c0ebe1d1
> > --- /dev/null
> > +++ b/mm/kasan/tags.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * This file contains common tag-based KASAN code.
> > + *
> > + * Author: Kuan-Ying Lee <kylee0686026@gmail.com>
> 
> We appreciate your work on this, but this is misleading. Because you
> merely copied/moved the code, have a look what sw_tags.c says -- that
> should either be preserved, or we add nothing here.
> 
> I prefer to add nothing or the bare minimum (e.g. if the company
> requires a Copyright line) for non-substantial additions because this
> stuff becomes out-of-date fast and just isn't useful at all. 'git log'
> is the source of truth.

This was my first time to upload a new file.
Thanks for the suggestions. :)
I will remove this author tag and wait for Greg's process advice.

> 
> Cc'ing Greg for process advice. For moved code, does it have to
> preserve the original Copyright line if there was one?
> 
> Thanks,
> -- Marco
