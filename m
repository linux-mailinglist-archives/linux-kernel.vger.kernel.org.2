Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747764202AE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 18:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhJCQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJCQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 12:29:30 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAEC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 09:27:42 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q205so17527985iod.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5w14pACpoxsQ3TFrs7KmyZVY7r/vaDnkMZUZO1ngik=;
        b=MXjrW9mY+a/gXFgLG6oQScrnY0uleIHBIcH9doKJKaK1+66Z3XPGlHC1yGYKZJ7upQ
         GRO1je7knBI7usd9rQ9oQGx2iNhC8vC3F0w7G9G3IgmiLkpgug27fp5RTlVuGK1MREHm
         hjX1vfP1qukT9Mcba/dSw7m1pMSFECYCIvy3tUNIer2u1PCVae+ZhKpBk9cH9aDv7XLq
         8Tn/w5K/ERUb8eyfS7OezaRjrfnH7g5oiEdIs2J9khCX5nca43xko5mnDhlgElGZk2ZX
         u+ndPrDlb3+WXdO24WfDhdncWjSD2xY4Au+Fxv/SRyvt/6GB5z4VH3W4016eFQGWzhas
         ZKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5w14pACpoxsQ3TFrs7KmyZVY7r/vaDnkMZUZO1ngik=;
        b=D1cqngcZZnHb5lX9I5fSNXWtLHbrOjPBjILtYIrtTfQrIhO0lVEH/4ke/BIGW0e4Kv
         EWG1FsNeHwP08Wc+TJkSUno0biwazZvFa103Uz0Oi5xqr8oDaAoPjDSTwrlzx7JjDY29
         B+olro1vyFNjGpPIoYRmM9fdgKBfB1Bk4rU/9wb67N8bGZj1Kkjg9xrSca7QdQptZOyk
         mpowz3Pio42qnn7HFeiFOa2i09BsP8GM1e8+LaomG/1L8NfwagepXYQ3/sQ1BG77p1I4
         ZacnIKL+/HTMDkJ7Sa5p2fp55gkpc553KlafaEQ9xj8uc2EVqedCjWzivlMrWNjflPSw
         cQJg==
X-Gm-Message-State: AOAM531ivNWqF/UW5jgx4m05Kypxm22TLZa0OXCaLpmwdjfbSBAGNM4b
        Gyf174/rTyGggl+EJW33KIA29dW0+/KWf+Qk25M=
X-Google-Smtp-Source: ABdhPJxVrz3rT6h1KZm+9SHUacnquEAHScQiTtCF8pHLENV9hptvWJl26PtoqE7yl5R+Y0mNFafi6gfZjEA9ZDrzX5g=
X-Received: by 2002:a05:6638:16c5:: with SMTP id g5mr7339293jat.130.1633278462090;
 Sun, 03 Oct 2021 09:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211001024105.3217339-1-willy@infradead.org>
In-Reply-To: <20211001024105.3217339-1-willy@infradead.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 18:27:31 +0200
Message-ID: <CA+fCnZeJ1AdvEmNmwo8r+ue0qtQVUoQyeMSsq0DMXyK2EQxj5g@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tag for large allocations when using CONFIG_SLAB
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 4:42 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> If an object is allocated on a tail page of a multi-page slab, kasan
> will get the wrong tag because page->s_mem is NULL for tail pages.
> I'm not quite sure what the user-visible effect of this might be.
>
> Fixes: 7f94ffbc4c6a ("kasan: add hooks implementation for tag-based mode")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2baf121fb8c5..41779ad109cd 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -298,7 +298,7 @@ static inline u8 assign_tag(struct kmem_cache *cache,
>         /* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
>  #ifdef CONFIG_SLAB
>         /* For SLAB assign tags based on the object index in the freelist. */
> -       return (u8)obj_to_index(cache, virt_to_page(object), (void *)object);
> +       return (u8)obj_to_index(cache, virt_to_head_page(object), (void *)object);
>  #else
>         /*
>          * For SLUB assign a random tag during slab creation, otherwise reuse
> --
> 2.32.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
