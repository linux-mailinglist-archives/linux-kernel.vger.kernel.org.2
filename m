Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D75307027
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhA1Htx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhA1HpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:45:21 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67960C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:44:41 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id c20so4390229ilj.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztUYIztZJjhj5tFTgkC2lU/YF4nMMpQ1Z9nSKOugLuE=;
        b=BnIWltQ+ltM4LRkMogP4dKfVIO7xiPORVwxQ0nsXxhWa1OMmPQ4GucpEe2IKlqyiyO
         qPu2N5q9y/dQLjkdqAXqjloZXd7nOGxnHMSx9ZTjaTjrN+kon2+/7TPOHF+honm8KB1S
         psmdStrdSQGYK5ABjeFcm9+bscp6aYtbQ7YjNAIVnm1DaXlN4RSpTsckF14PXrnFPorU
         J0znJ2RG4GQMSOagUDSu1ksZ3bx8wpiO8fwY+H7K9aP/N/oek7kKdsvppEsCiZHF9f/Y
         3DkjaGdBemoKcJ+wl6dZrzvQNz3EjiQkG/KiJB6vXLuc3BnUv8b9gCmkaADf6llDpv0N
         wBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztUYIztZJjhj5tFTgkC2lU/YF4nMMpQ1Z9nSKOugLuE=;
        b=kooNL+DWM71o1SQqYWuQNkZjCO5UtcZpiTausOAJKigcvvex/di+Z0E1SxVsXuyUce
         Vhk8xPjJMQIzMP9SMuELTOM9CLq1qrnacLRNA22+5dVQPEJE4VAx2telmnZb5oUbrPtC
         LVpcwjb2F8EMxBRBmVY0n47EeT7Pupcl8BFt2z01y5KYUv7gahkNyN+sX+XN1B4L8Apm
         UagP8HKDD5MS+xRu2Fvw/CXq70bTG1qkBoKB/UIhJaMSz8O4FQzSQEu7hvpLJ6QLMfsz
         gE5TonO6GQxqr9+/os8UEnX+RLLUhOnJ3lAvXs4oS/35E8kyEsxCR7467AjLHvLrIyrU
         QONg==
X-Gm-Message-State: AOAM530BemeXf32vhG+9YynzKPeHG2vZsUfVQXHvE3PUK66RE2MVVCIR
        xiBxhIbcQ3IsUBbi485yizPmlS5AJEFTOlIZALo=
X-Google-Smtp-Source: ABdhPJzULsm865g/naY1bEEhYBuGR1pd0EN42gD0wgvfHu/xIbSXDX7Yp5vnipe1yrPYgKoMcYpzkBcEKziuVwuEmYM=
X-Received: by 2002:a92:5bc2:: with SMTP id c63mr11992705ilg.142.1611819880901;
 Wed, 27 Jan 2021 23:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20210128021947.22877-1-laoar.shao@gmail.com> <20210128021947.22877-4-laoar.shao@gmail.com>
 <27e53062-7b0e-42e8-6f44-4eba44832805@huawei.com>
In-Reply-To: <27e53062-7b0e-42e8-6f44-4eba44832805@huawei.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 28 Jan 2021 15:44:04 +0800
Message-ID: <CALOAHbC-mMgu9s521_KcHFPbBRcFcCFXeniXVqTqT2WW9YmXCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        andriy.shevchenko@linux.intel.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:52 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Hi:
> On 2021/1/28 10:19, Yafang Shao wrote:
> > Currently the pGp only shows the names of page flags, rather than
> > the full information including section, node, zone, last cpupid and
> > kasan tag. While it is not easy to parse these information manually
> > because there're so many flavors. Let's interpret them in pGp as well.
> >
> > - Before the patch,
> > [ 6312.639698] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(slab|head)
> >
> > - After the patch,
> > [ 6315.235783] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(Node 0x0,Zone 0x2,Lastcpupid 0x1fffff,slab|head)
> >
>
> Thanks. This really helps!
>
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  lib/vsprintf.c | 42 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 3b53c73580c5..bd809f4f1b82 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1916,6 +1916,46 @@ char *format_flags(char *buf, char *end, unsigned long flags,
> >       return buf;
> >  }
> >
> > +struct page_flags_layout {
> > +     int width;
> > +     int shift;
> > +     int mask;
> > +     char *name;
>
> Should we add const for name ?
>

Good suggestion.

> > +};
> > +
> > +struct page_flags_layout pfl[] = {
>
> Should we add static const for pfl[] as we won't change its value and use it outside this file ?
>

Sure.

> > +     {SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK, "Section "},
> > +     {NODES_WIDTH, NODES_PGSHIFT, NODES_MASK, "Node "},
> > +     {ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK, "Zone "},
> > +     {LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK, "Lastcpupid "},
> > +     {KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK, "Kasantag "},
> > +};
> > +
> > +static
> > +char *format_layout(char *buf, char *end, unsigned long flags)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < sizeof(pfl) / sizeof(struct page_flags_layout) && buf < end; i++) {
>
> I think we can use ARRAY_SIZE here.
>

Sure.

> > +             if (pfl[i].width == 0)
> > +                     continue;
> > +
> > +             buf = string(buf, end, pfl[i].name, default_str_spec);
> > +
> > +             if (buf >= end)
> > +                     break;
> > +             buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
> > +                          default_flag_spec);
> > +
> > +             if (buf >= end)
> > +                     break;
> > +             *buf = ',';
> > +             buf++;
> > +     }
> > +
> > +     return buf;
> > +}
> > +
> >  static noinline_for_stack
> >  char *flags_string(char *buf, char *end, void *flags_ptr,
> >                  struct printf_spec spec, const char *fmt)
> > @@ -1929,7 +1969,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
> >       switch (fmt[1]) {
> >       case 'p':
> >               flags = *(unsigned long *)flags_ptr;
> > -             /* Remove zone id */
> > +             buf = format_layout(buf, end, flags & ~((1UL << NR_PAGEFLAGS) - 1));
> >               flags &= (1UL << NR_PAGEFLAGS) - 1;
> >               names = pageflag_names;
> >               break;
> >
> Many thanks.



-- 
Thanks
Yafang
