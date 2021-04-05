Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC4354878
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbhDEWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhDEWHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:07:43 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE0C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 15:07:37 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z9so11354853ilb.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqNqwPugUsFfYIOn9Xnz7sTj2i1Lh+cPdEqfufLvtro=;
        b=JRQibDUJOCYRONPO7/h68qgaO3C6iu2PnWJt+gHkMCRmDiy4Zn4RuSVnnovi01VLOU
         8/vLuLjBl+bjDflkeEwSk7dMXgbmkSkAmUa029IQ7BykuUJrzF/myQS8OvhISfp5FAoU
         /RlQ9l8LFSJLr1HxmnkONyyd/dhj0UG5mUd3mv+4lQLeNELujEdOzzUpsSoA0EKTkoMP
         7+YuQVlKRkBOu8LpNCl8h7G8rehzSxJvGKATdwGzd49UrY++QgImsTz8vuBsEPz26TC5
         QKvrsl5H5amsC9hQEgRJnPOrT7VisfIMSuV1lFHXyP5a8DoJfJ6T+3SJctJ3/gptyXIY
         1sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqNqwPugUsFfYIOn9Xnz7sTj2i1Lh+cPdEqfufLvtro=;
        b=Y2CfPBzt/KnwUGxq8TuLKjuI+ourT7bXpZEbXxTMtbP3SsRnjsj/DsGgdPixI3Wfz7
         cvTasKyiUv+arELfuC2bxUcJzUk6/XrrfjNgBlHb4I/+8zZnOoQRPW3nDC4vlsvxUi0I
         ZFJA/vArl/j/yKYEcEv5hN5fsKC5ESZXbxPmYEJYCD9kHR9y749DBtqZ3xd22BanXNZg
         vRtguFAUg2gn572l49EMiQUvmK1n1pxYkXNNBjAVRksm1Zfg8T99nIzLxfzCqnhPTbsB
         jfIHcwQnHidIwTSD7efOVLqzjYe9Q0CqQqNRxBdxL+PGi658uDwr3ylwi1/IX16A+WqW
         eibA==
X-Gm-Message-State: AOAM531eR88XxWe5atCUAooND+UcL1cQchjdxK/putaqmojOvOIBFnnI
        w9OsnHAdthrxFf38qgkcGyx6idfKKXRltCKrhchX9g==
X-Google-Smtp-Source: ABdhPJzXT3hYr0/Y0T/iwf8Bj0YfhD8CFEMSzs//a1D3pDq4ig8lGJ+3N4iT/Fd6bJz2XE2Sb8bIQBH38nlPI9/vj+8=
X-Received: by 2002:a92:de42:: with SMTP id e2mr20795355ilr.278.1617660456342;
 Mon, 05 Apr 2021 15:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210405214321.1953019-1-pcc@google.com> <CA+fCnZeC20t5Lhswo7zcULNgfksxqb2_fP4j0pNy29E_q6hJyg@mail.gmail.com>
In-Reply-To: <CA+fCnZeC20t5Lhswo7zcULNgfksxqb2_fP4j0pNy29E_q6hJyg@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 5 Apr 2021 15:07:25 -0700
Message-ID: <CAMn1gO65_-gxd4ocQ2DF94wZB_X0XTuy59-Bi7R0XCqG2yf6KA@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix kasan_byte_accessible() to be consistent with
 actual checks
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 2:53 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Mon, Apr 5, 2021 at 11:43 PM Peter Collingbourne <pcc@google.com> wrote:
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
> >  mm/kasan/kasan.h   | 3 +--
> >  mm/kasan/sw_tags.c | 8 +++++---
> >  2 files changed, 6 insertions(+), 5 deletions(-)
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
> > index 94c2d33be333..914225eeda99 100644
> > --- a/mm/kasan/sw_tags.c
> > +++ b/mm/kasan/sw_tags.c
> > @@ -121,10 +121,12 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
> >  bool kasan_byte_accessible(const void *addr)
> >  {
> >         u8 tag = get_tag(addr);
> > -       u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
> > +       void *untagged_addr = kasan_reset_tag(addr);
> > +       u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(untagged_addr));
>
> Hi Peter,
>
> Let's move dereferencing shadow memory past the KASAN_SHADOW_START
> check. Otherwise, in case the check is to fail, accessing shadow will
> likely crash the kernel.
>
> Thanks!

Makes sense, fixed in v2.

Peter
