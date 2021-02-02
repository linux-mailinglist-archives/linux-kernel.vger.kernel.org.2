Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01F30CA58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbhBBSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhBBSlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:41:49 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E29C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:41:08 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 63so20865683oty.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AM9+VMIDUzwgmsYBk9umRY0HUzM3XXRBDO1nka7d3og=;
        b=s9rHW2e0Nrv0tmYo6Fias3UCwRvC3sycwUaSoUl5TmWaf7y8UPYAxbNoId0ZKFyV0G
         EZRTqAviAAx5h3M44XGhYBG7ijYHRbr+315nDi089h86Yj5vloULaaOOAK2KH28RQOrB
         GaTXje2AzkUQdSI+viwvcwTy2ZZgWhjXVHK/cy89VtqVx5fFo2pFcC/a7OWRANkca9NF
         OowcE6XVOkVJWncAxyUJn3c2Cy2PkqvUo/+P2u7G1aA4mrsmYIrt6Ul+WCARvBon8jtn
         pw00h/M4Wu+7kjmIC+9lQNtnS0ZY2UtNEuGr2pWq971W/PdOnHLz0XELsnqBX1sjt+2Z
         J33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AM9+VMIDUzwgmsYBk9umRY0HUzM3XXRBDO1nka7d3og=;
        b=Et12wYYY5d4Tq3qCMl0UJi95QHl8bKFqxTyc1LQ0rrfOUEtUULN61n/fVe2DIzx3uc
         rue33nhKgFjZKB+zrfWGoPEiXAgFafuN7MDjgWUgCf3Qf8/DNo5eNHNhiQXF1K0K+Fc8
         dCHWtQhpQGH5luNBkWnrNJVPt2QthgO86ZxCGglhFJ9nQCTnSclB8Kfz4Z1LMLw63OYa
         qrTOnzIG7SZRt/uM+FFtNKGtqI/p+i/ZHWg+umI6BPtUoQ57e9v0QY43CeFmgfB4aIdG
         Zn+KUxTGAQSUtIIz6LxNG3HpTnMrncApTMIL2XcNN+wQR5jl+R281EAWRAa8S1VG2AK8
         xrDA==
X-Gm-Message-State: AOAM5330DlpLiv2iKVQoHL1c86QJ6Bir7r2pxdV1biluWetzAHj0yZIY
        Cb02cqini6bpTXUOzZFx9SGTooFP4xt32IyiQSkkEw==
X-Google-Smtp-Source: ABdhPJyszm0Fovxs8Faqw0izV1peYSHPFf1e4UR8/ubU5Sy4IxlghvFKxy0dDX0vNZO/byxceLA6nptlOzBLctRSooA=
X-Received: by 2002:a05:6830:1d79:: with SMTP id l25mr15633121oti.17.1612291267706;
 Tue, 02 Feb 2021 10:41:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com> <c153f78b173df7537c9be6f2f3a888ddf0b42a3b.1612208222.git.andreyknvl@google.com>
 <YBl4fY54BN4PaLVG@elver.google.com> <CAAeHK+wnufE=jOAOsG6LTA5Objcj=OyakEDr4zPKVW+Qq+y28g@mail.gmail.com>
In-Reply-To: <CAAeHK+wnufE=jOAOsG6LTA5Objcj=OyakEDr4zPKVW+Qq+y28g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Feb 2021 19:40:56 +0100
Message-ID: <CANpmjNOkBQdvgB-4QNXQMoNFppzVCsCz+ZcuviDL0HX5zJ4kbg@mail.gmail.com>
Subject: Re: [PATCH 01/12] kasan, mm: don't save alloc stacks twice
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Tue, 2 Feb 2021 at 19:01, 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
[...]
> > > @@ -83,6 +83,7 @@ static inline void kasan_disable_current(void) {}
> > >  struct kasan_cache {
> > >       int alloc_meta_offset;
> > >       int free_meta_offset;
> > > +     bool is_kmalloc;
[...]
> > >       if (kasan_stack_collection_enabled())
> > > -             set_alloc_info(cache, (void *)object, flags);
> > > +             set_alloc_info(cache, (void *)object, flags, kmalloc);
> >
> > It doesn't bother me too much, but: 'bool kmalloc' shadows function
> > 'kmalloc' so this is technically fine, but using 'kmalloc' as the
> > variable name here might be confusing and there is a small chance it
> > might cause problems in a future refactor.
>
> Good point. Does "is_kmalloc" sound good?

Sure, that's also consistent with the new struct field.

Thanks,
-- Marco
