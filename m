Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CCE396F23
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhFAIml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhFAImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:42:40 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:41:00 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso3327344oow.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYdknBQo193eNCNhduTrPIy+Y/+hGQ3dFnlOg4zBZ6I=;
        b=dx8s1vD5Cd514KEwrT2NzfZZ0rJW+QulznUM8B/TAOkv+nyGIkniISQpHXU2YPdJX4
         Eof6mdP92MI3sjLn4XKfCyeu/vGbuasjuYb0q4hP55hGzDYHxU5MUlDX9CjUjrCJXN/2
         7rywZp/Ob/I7IStWwM3m5eOxcGcCInbwnA1PTbtdOaeFH5r2BC0mbZ9z2zPCZpeJzInH
         wqgO3ozo95P9wtbwFodaPB/YJLxQBdGeWmwp1IbPr3nHKJwtNn/rpzUjQ58bpFAQN5Vo
         kXJW/c1mGJGSI0seRN+tbXwAfFigr68Op/rAqMQhWgkOukyOhmdsBVkErMOnYOcZZajZ
         ZOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYdknBQo193eNCNhduTrPIy+Y/+hGQ3dFnlOg4zBZ6I=;
        b=atBwN6Z3ct9M5fwgfbV0ki0FzTZYIkUHlrp6dc2jEtVcyAtvD6WnkCoEsCTPrjDfQE
         VC8nzoc7Po/plWCmozug/zf2hMDzZuNuonyWzJjBYvJbGgM9rOBBJ1WYUVoihRifT00+
         7p1vZBH7Qcg1q2NqweImDCWAyuTbRbILzjzZKIB15qxAahs2L3kHdaQljj4Aakiqjcov
         sT4YV2ZcsNNjQvciHK7ASmCBYNLiSr0FGEN/npD7z5rL4zCy8BCy7DKVYUj+fDoUGzLD
         QQ2jPidD9E3g55UWWy/sflMmRyd2Jhu3vE/fVYuP1P/XpWs2nUM6tHx2+a2lHuo5uKu9
         vASg==
X-Gm-Message-State: AOAM531nlqQUJ8k9jVKO7pLLHLQE/RZuIsKCkSZJzPl6SI+7L5wFCLzR
        phna1iTRfjQqH4jleS2J/hSVbmTLVfeUEaf/2Emg7iCZ
X-Google-Smtp-Source: ABdhPJxiBCo8GVxBekn8AmRO6NxZpaGfSwUtcBA71Cb4KQQnIa0AwnREyRkVYK+ptly73bpwJbfp89zU3ZNNfpln1gM=
X-Received: by 2002:a4a:d89a:: with SMTP id b26mr19548775oov.11.1622536859448;
 Tue, 01 Jun 2021 01:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-7-aisheng.dong@nxp.com> <274fb19f-d14c-bb45-b69a-a7c8b4c1722e@redhat.com>
In-Reply-To: <274fb19f-d14c-bb45-b69a-a7c8b4c1722e@redhat.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 1 Jun 2021 16:39:49 +0800
Message-ID: <CAA+hA=RmW38Ot9S3c9kzGTqfHZZcjw_SOT-T0_80nvJM1p-M0Q@mail.gmail.com>
Subject: Re: [PATCH V2 6/6] mm/sparse: remove one duplicated #ifdef CONFIG_SPARSEMEM_EXTREME
To:     David Hildenbrand <david@redhat.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 4:26 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 31.05.21 11:19, Dong Aisheng wrote:
> > Those two blocks of code contained by #ifdef CONFIG_SPARSEMEM_EXTREME
> > condition are right along with each other. Not need using another #ifdef
> > condition.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> >   *new patch
> > ---
> >   mm/sparse.c | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 6412010478f7..2905ee9fde10 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -114,16 +114,7 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
> >
> >       return 0;
> >   }
> > -#else /* !SPARSEMEM_EXTREME */
> > -static inline int sparse_index_init(unsigned long section_nr, int nid)
> > -{
> > -     return 0;
> > -}
> >
> > -static inline void sparse_alloc_section_roots(void) {}
> > -#endif
> > -
> > -#ifdef CONFIG_SPARSEMEM_EXTREME
> >   unsigned long __section_nr(struct mem_section *ms)
> >   {
> >       unsigned long root_nr;
> > @@ -142,11 +133,18 @@ unsigned long __section_nr(struct mem_section *ms)
> >
> >       return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
> >   }
> > -#else
> > +#else /* !SPARSEMEM_EXTREME */
> > +static inline int sparse_index_init(unsigned long section_nr, int nid)
> > +{
> > +     return 0;
> > +}
> > +
> >   unsigned long __section_nr(struct mem_section *ms)
> >   {
> >       return (unsigned long)(ms - mem_sections[0]);
> >   }
> > +
> > +static inline void sparse_alloc_section_roots(void) {}
> >   #endif
>
> Want to tag that one (endif) with /* SPARSEMEM_EXTREME */ as well while
> at it?

Thanks, i could add it in v3 later with your tag.

Regards
Aisheng

>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Thanks,
>
> David / dhildenb
>
