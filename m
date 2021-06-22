Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6FE3B021E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFVLBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFVLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:01:52 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7346FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 03:59:36 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so14190531ote.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ST43GppbGqjxXxYbgPLZB6WISUmWZ5bTKVdHwZJ0LK0=;
        b=Nj20QEq+KxkLWAiRbPMmd9mJB90uKVMEJjEvf0yYVodg05DYpqSc/pXCThJAUiFWWl
         iNKgJcJ7DNn2WKIsPkHdudD+TvaWQFYuF2utzM/0BiSNl/bRqb4V/j6c+SppGNmH7N/m
         SJK8N2DsxlWNrBwtx4EhulxxN/48KFv1mHi3Q4jI1oF0WpsMWn9vLog4SIbJAH8a0T+0
         k7XMG81iMUlbL9TnQ1ybXmXmFvN3qgKx+4Qsh0jggwve3xTJ1Ok1CCJOtWLJIOyYJ5iK
         9WTN/RGCZZi5C7hQpYFPSEy41Jz0UqtXRSt9nAsvVe4HMhV/4wUnZgEPrWItlRzJHJeI
         jaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ST43GppbGqjxXxYbgPLZB6WISUmWZ5bTKVdHwZJ0LK0=;
        b=j/SGdWb5ZbZQzmqfcqxlq0ynIHTmU/l7v19/q6WIQH3+E2l2sgz5HvuaZ9LA4zUTk/
         KWv4oIt97NEXCI+csKTv9c6qfBFg6ctptkr7ZEoFFC/VEnykFvn0w7KNiekManB55gZZ
         uXa7cGvpypOhNhiZBgEM2s7RyzUdfjcS+Ehav6NufZZ6gDpihCuTOBWdD0ppjWk9kw9d
         NyEXLw3gWaMihnKuX65VRYmEMYLnwkBkzjH3/BwIHk2cLPTTlnovMy0fjv5VpUo+u1G4
         F6yaSy+u1gsgimsGIjrdy3gLuRXNaMveH6ERkws+HRYl92XTrFBBr8xvinKA28+RgI66
         W2QQ==
X-Gm-Message-State: AOAM531jaagqiBWf+bMS0NWmiZGbhH2mwIvopkqkcGHtD09Hz0wRLpla
        8xWxRvPSsJ55BMEaEjUng9fauQ7tH5MvRTa1Ls/whDIoyCK4yQ==
X-Google-Smtp-Source: ABdhPJyFj9ZXB0FBR0cxOcfQPd3wwOJR8y/fh4HikV7DTsq/slH7YOgsNfWAae+cwaRu5GpXy8mGpPmB6Ualf8IS/kQ=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr2616280oto.17.1624359575598;
 Tue, 22 Jun 2021 03:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210622084723.27637-1-yee.lee@mediatek.com> <CANpmjNPyP2-oULXuO9ZdC=yj_XSiC2TWKNBp0RL_h3k-XvpFsA@mail.gmail.com>
 <46b1468146206e6cef0c33ecbfd86e02ea819db4.camel@mediatek.com>
In-Reply-To: <46b1468146206e6cef0c33ecbfd86e02ea819db4.camel@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Jun 2021 12:59:24 +0200
Message-ID: <CANpmjNNOkPAHvZv2nJgv_1AfxpQ7c2oFXJAUrWGJAsMKaUEy-w@mail.gmail.com>
Subject: Re: [PATCH] kasan: [v2]unpoison use memzero to init unaligned object
To:     Yee Lee <yee.lee@mediatek.com>
Cc:     andreyknvl@gmail.com, wsd_upstream@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 at 12:48, Yee Lee <yee.lee@mediatek.com> wrote:
>
> On Tue, 2021-06-22 at 11:01 +0200, Marco Elver wrote:
> > On Tue, 22 Jun 2021 at 10:48, <yee.lee@mediatek.com> wrote:
> > >
> > > From: Yee Lee <yee.lee@mediatek.com>
> > >
> > > Follows the discussion:
> > > https://patchwork.kernel.org/project/linux-mediatek/list/?series=504439
> >
> > The info about the percentage of how frequent this is could have been
> > provided as a simple reply to the discussion.
> >
> > > This patch Add memzero_explict to initialize unaligned object.
> >
> > This patch does not apply to anything (I see it depends on the
> > previous patch).
> >
> > What you need to do is modify the original patch, and then send a
> > [PATCH v2] (git helps with that by passing --reroll-count or -v) that
> > applies cleanly to your base kernel tree.
> >
> > The commit message will usually end with '---' and then briefly
> > denote
> > what changed since the last version.
> >
> Got it.
>
> >
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> >
> > > Based on the integrateion of initialization in kasan_unpoison().
> > > The hwtag instructions, constrained with its granularity, has to
> > > overwrite the data btyes in unaligned objects. This would cause
> > > issue when it works with SLUB debug redzoning.
> > >
> > > In this patch, an additional initalizaing path is added for the
> > > unaligned objects. It contains memzero_explict() to clear out the
> > > data and disables its init flag for the following hwtag actions.
> > >
> > > In lab test, this path is executed about 1.1%(941/80854) within the
> > > overall kasan_unpoison during a non-debug booting process.
> >
> > Nice, thanks for the data. If it is somehow doable, however, I'd
> > still
> > recommend to additionally guard the new code path by a check if
> > debug-support was requested. Ideally with an IS_ENABLED() config
> > check
> > so that if it's a production kernel the branch is simply optimized
> > out
> > by the compiler.
>
> Does it mean the memzero code path would be applied only at
> CONFIG_DEBUG_SLUB enabled? It expects no other potential overwriting
> in non-debug kernel.

Yes, if the problem only occurs with slub debugging enabled.

> By the way, based on de-coupling principle, adding a specific
> conditional statement(is_enable slub_debug) in a primitive
> funciton(kasan_unpoison) is not neat. It may be more proper that the
> conditional statement be added in other procedures of slub alloc.

What do you have in mind?

Well, there is kmem_cache_debug_flags(). Perhaps there's a better
place to add the check?

> Thanks,
>
> BR,
> Yee
>
> >
> > > Lab test: QEMU5.2 (+mte) / linux kernel 5.13-rc7
> > >
> > > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> > > ---
> > >  mm/kasan/kasan.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > > index d8faa64614b7..edc11bcc3ff3 100644
> > > --- a/mm/kasan/kasan.h
> > > +++ b/mm/kasan/kasan.h
> > > @@ -389,7 +389,7 @@ static inline void kasan_unpoison(const void
> > > *addr, size_t size, bool init)
> > >                 return;
> > >         if (init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
> > >                 init = false;
> > > -               memset((void *)addr, 0, size);
> > > +               memzero_explicit((void *)addr, size);
> > >         }
> > >         size = round_up(size, KASAN_GRANULE_SIZE);
> > >         hw_set_mem_tag_range((void *)addr, size, tag, init);
> > > 2.18.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google
> > > Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it,
> > > send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit
> > > https://groups.google.com/d/msgid/kasan-dev/20210622084723.27637-1-yee.lee%40mediatek.com
> > > .
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/46b1468146206e6cef0c33ecbfd86e02ea819db4.camel%40mediatek.com.
