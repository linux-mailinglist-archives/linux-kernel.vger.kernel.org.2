Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB20D30C90B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhBBSHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhBBSFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:05:31 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F40C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:04:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e9so2905779pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkJ396ovGQTUsRhCdFoZILK6dCLPexHJ2EGZdWor+hw=;
        b=bmHbrW4wHvIdfjHfeZ3EaQjyVR5RRbKrvsyfN94JInNi9Cn/Ji526G1EpUl55uf6bH
         m13PPwd6OvYcUlrgA/4HEDMO743f3REGWb/rhRNZx0Aufi7rf6VXi+aZ5OuZiITpO1L9
         7lT7EPS+7AOGkhtIhtsHxq98UcXFLblKenrLQqqrlr1B45IRYPlDXDDJTwOVMJa/BGKP
         yBbfOe7hVFgzgcoQsCfXkRDgtuvOBds9FsxJP+7V6ungIy4DVbkpiRQsI3TRPgliGdW1
         DaaAKLFjlCfHCv7Q4+Qh5yw17ptKBNaw6Pl8Q50l3Y1UPSOqxUiL72dpSLziTfMOEIlk
         6U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkJ396ovGQTUsRhCdFoZILK6dCLPexHJ2EGZdWor+hw=;
        b=D60wiNEaQHL7en/rJnKgouwXHxuUCFYBTilfrniXKaGPwNaUbmhH3V4j+c18YDh+aB
         3hVBTloNRwvx9t7d6KYWnrq5r9IHRnrM1tSojsRWW36eQ30WTiV2XJ4QL2cC3F75bJoD
         7MnrqXAtrVPH68Mcox1wc5blVk2dL+BagTjCvqLzJ9BTKJYYpuu9uWuEyECOnz8Daj78
         EIPbYl9q01Z0OnZu0DYiD+0VE9GSpT7zigjyglHBzfA4fXJBbgqJPlZqS9J1Ww3s4Bzt
         60QlO7bbBS1d539Tx3oXHIlegWSsKpYM/F9wEDgFCnKKd8HEFqYTSswSBuZuF7heP3SJ
         +ZPA==
X-Gm-Message-State: AOAM531Hs2jYR9P3Sj+5XKaHm5D2yTX8Kz3jbe3ytOlmizcBzyNLjsJG
        FTTpD5rW+1EigLyj9vf7JFSobAlPxOJft8y1VlfBew==
X-Google-Smtp-Source: ABdhPJzk53kiwjHoUAN5T37N7cq5l6z6TqzmjhMRUYbQYZsukvhrqYwA9meKTYnDVYMved0hS9LJFa4X1pkaHapfvQc=
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr5325944pjb.41.1612289090058;
 Tue, 02 Feb 2021 10:04:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com> <17d6bef698d193f5fe0d8baee0e232a351e23a32.1612208222.git.andreyknvl@google.com>
 <20210202154200.GC26895@gaia>
In-Reply-To: <20210202154200.GC26895@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Feb 2021 19:04:38 +0100
Message-ID: <CAAeHK+y31RvnR2UPtekuscAd=Ogk5zouW_kzxPm7-mVotpqQOA@mail.gmail.com>
Subject: Re: [PATCH 10/12] arm64: kasan: simplify and inline MTE functions
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

On Tue, Feb 2, 2021 at 4:42 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Feb 01, 2021 at 08:43:34PM +0100, Andrey Konovalov wrote:
> > +/*
> > + * Assign allocation tags for a region of memory based on the pointer tag.
> > + * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> > + * size must be non-zero and MTE_GRANULE_SIZE aligned.
> > + */
>
> OK, so we rely on the caller to sanity-check the range. Fine by me but I
> can see (un)poison_range() only doing this for the size. Do we guarantee
> that the start address is aligned?

See the previous patch in the series. kasan_poison() checks and warns
on both unaligned addr and size. kasan_unpoison() checks addr and
rounds up size.

> > +static __always_inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> > +{
> > +     u64 curr, end;
> > +
> > +     if (!size)
> > +             return;
> > +
> > +     curr = (u64)__tag_set(addr, tag);
> > +     end = curr + size;
> > +
> > +     do {
> > +             /*
> > +              * 'asm volatile' is required to prevent the compiler to move
> > +              * the statement outside of the loop.
> > +              */
> > +             asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> > +                          :
> > +                          : "r" (curr)
> > +                          : "memory");
> > +
> > +             curr += MTE_GRANULE_SIZE;
> > +     } while (curr != end);
> > +}
> >
> >  void mte_enable_kernel_sync(void);
> >  void mte_enable_kernel_async(void);
> > @@ -47,10 +95,12 @@ static inline u8 mte_get_mem_tag(void *addr)
> >  {
> >       return 0xFF;
> >  }
> > +
> >  static inline u8 mte_get_random_tag(void)
> >  {
> >       return 0xFF;
> >  }
> > +
> >  static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>
> This function used to return a pointer and that's what the dummy static
> inline does here. However, the new mte_set_mem_tag_range() doesn't
> return anything. We should have consistency between the two (the new
> static void definition is fine by me).

Right, forgot to update the empty function definition. Will do in v2.

>
> Otherwise the patch looks fine.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!
