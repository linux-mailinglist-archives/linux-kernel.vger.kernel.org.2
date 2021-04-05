Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB7354968
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbhDEXqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbhDEXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:46:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2661C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 16:46:21 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so4021360otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTdV629ZhMgRAehKkgmyuxBMkQiqLv+0INgoX/85OgY=;
        b=QUzjliudZ5IBbeJ4LJDfU1XRaXig20/Dtad2yxZBNPAegCSx4hA8C2ovxzv2QgmQAA
         4NIJu59Nyowyw8Gf6V7PBg626xMLNLCB5qxeo/FDJRfqD5tuYOK47LQBFe5PIwCOYukK
         Tdvsrefr1sAjW45TI+/rSAPRPmwhyBqOJSqpJ8zXhWF2+tNNJ3fCugZN/WP30EaBjiJ4
         kQuhWNQS+Y8vxkbERbIdAkaz5f1cALD8CbVWBeN1RPJUZpuUFgFurN1BQDT6UUonL/yR
         7F9fsFcyoP1jdWBdpScVykiNRzYkQ/qh+neN7AGvrgHm03b2H7H07Luq5bEDzowDswWz
         rIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTdV629ZhMgRAehKkgmyuxBMkQiqLv+0INgoX/85OgY=;
        b=itGt/ge9mL3rGBXhp8KZEJ4Xh0ZtjAEwg3IidxnuC3ljzyoN+JlwPH5/hHim3lhE9L
         EXtJo93UvMm9UCT5RE8bBOuEOvfFyao9VyCG5p3ZN7+cD/XZ2+p9x3fprXc/wDvrQIqW
         w6m2DztdwBudFRBNQ2kjBtjM6mh06Mhzp7DJaHN0pMfkvE0TlP25VI02pkRZcNfiVbTC
         Y7ABMN7wgiO9FzS4HT1A5HlEacVCuyiil15pJmuJZPz6Z3DVw6YUivwqh8SLydDKP7nR
         ejHP9T3BRsTOkCf4Mf32494BL+qe3YlcqPER6UJy6HSJLa5p4yIf92u5kLlSqon64fSI
         Sw3w==
X-Gm-Message-State: AOAM531CDOJml1qbiXZW3f6i90kzOaVo4136RxZqkspmCcTI49oDXK3y
        8vcpiRWq234Jk2/Z9jsvGSHw4Q00sSuyNMikhTisxA==
X-Google-Smtp-Source: ABdhPJwCM1A2Jh9U35cxNbSDkipZ/Qb09Xy2Nr3JFPIBM/f6nAunfi1K81wAVxPZlUAkcJKtlWSNkxJu8mndUTxWhDg=
X-Received: by 2002:a9d:5508:: with SMTP id l8mr24572016oth.233.1617666380817;
 Mon, 05 Apr 2021 16:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210405220647.1965262-1-pcc@google.com> <CA+fCnZc=+d036Ve7k-4OdtZ+epSd4QywRs-qc9JWV72Z8Er1yw@mail.gmail.com>
In-Reply-To: <CA+fCnZc=+d036Ve7k-4OdtZ+epSd4QywRs-qc9JWV72Z8Er1yw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 6 Apr 2021 01:46:09 +0200
Message-ID: <CANpmjNPBfowFu2vANXfHHaWZFYyLTD84sf4YWnfJ6AnnKYZ8XQ@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix kasan_byte_accessible() to be consistent
 with actual checks
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 at 00:43, Andrey Konovalov <andreyknvl@gmail.com> wrote:
> On Tue, Apr 6, 2021 at 12:07 AM Peter Collingbourne <pcc@google.com> wrote:
> >
> > We can sometimes end up with kasan_byte_accessible() being called
> > on non-slab memory. For example ksize() and krealloc() may end up
> > calling it on KFENCE allocated memory. In this case the memory will
> > be tagged with KASAN_SHADOW_INIT, which a subsequent patch ("kasan:
> > initialize shadow to TAG_INVALID for SW_TAGS") will set to the same
> > value as KASAN_TAG_INVALID, causing kasan_byte_accessible() to fail
> > when called on non-slab memory.
> >
> > This highlighted the fact that the check in kasan_byte_accessible()
> > was inconsistent with checks as implemented for loads and stores
> > (kasan_check_range() in SW tags mode and hardware-implemented
> > checks in HW tags mode). kasan_check_range() does not have a
> > check for KASAN_TAG_INVALID, and instead has a comparison against
> > KASAN_SHADOW_START. In HW tags mode, we do not have either, but we
> > do set TCR_EL1.TCMA which corresponds with the comparison against
> > KASAN_TAG_KERNEL.
> >
> > Therefore, update kasan_byte_accessible() for both SW and HW tags
> > modes to correspond with the respective checks on loads and stores.
> >
> > Link: https://linux-review.googlesource.com/id/Ic6d40803c57dcc6331bd97fbb9a60b0d38a65a36
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> >  mm/kasan/kasan.h   |  3 +--
> >  mm/kasan/sw_tags.c | 10 +++++++---
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 8c55634d6edd..e18e8da35255 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -368,8 +368,7 @@ static inline bool kasan_byte_accessible(const void *addr)
> >         u8 ptr_tag = get_tag(addr);
> >         u8 mem_tag = hw_get_mem_tag((void *)addr);
> >
> > -       return (mem_tag != KASAN_TAG_INVALID) &&
> > -               (ptr_tag == KASAN_TAG_KERNEL || ptr_tag == mem_tag);
> > +       return ptr_tag == KASAN_TAG_KERNEL || ptr_tag == mem_tag;
> >  }
> >
> >  #else /* CONFIG_KASAN_HW_TAGS */
> > diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> > index 94c2d33be333..00ae8913fc74 100644
> > --- a/mm/kasan/sw_tags.c
> > +++ b/mm/kasan/sw_tags.c
> > @@ -121,10 +121,14 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
> >  bool kasan_byte_accessible(const void *addr)
> >  {
> >         u8 tag = get_tag(addr);
> > -       u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
> > +       void *untagged_addr = kasan_reset_tag(addr);
> > +       u8 shadow_byte;
> >
> > -       return (shadow_byte != KASAN_TAG_INVALID) &&
> > -               (tag == KASAN_TAG_KERNEL || tag == shadow_byte);
> > +       if (untagged_addr < kasan_shadow_to_mem((void *)KASAN_SHADOW_START))
> > +               return false;
> > +
> > +       shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(untagged_addr));
> > +       return tag == KASAN_TAG_KERNEL || tag == shadow_byte;
> >  }
> >
> >  #define DEFINE_HWASAN_LOAD_STORE(size)                                 \
> > --
> > 2.31.0.208.g409f899ff0-goog
> >
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> Thank you, Peter!

Reviewed-by: Marco Elver <elver@google.com>

Thanks!
