Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB20830A916
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhBANvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhBANvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:51:16 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06659C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:50:36 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e1so15576627ilu.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ABF6jWhcQFCEmEQUi+MWDc4uEldLt/+v1YpG4pvAfY=;
        b=l8FX33RFY+6UjFhdAfGlB2xSl5/mqnQgdobUWZng8utCR1RZNMAheLlLps7aHUwYZG
         QZ0DrmVuB+ST+5fy72xMxpyOvgKVs8+HLWE34/OV8EMkwh/Rmh0UXRWveOSmxbPR9J8X
         Y1cBQ1d8FEOiEy4twZMCxF3AMAW2XrpVLqesm36k6L7ll5bzapx3zfhshDdoQ+/5e1gc
         xXM7ww1xbrAYIZLXWTJr7c9neQDD25yCzwOO/navm8zmVZPkubPGakLuW/H8qwwNANTt
         8aXt22Q1TiFTQhJd6tGNjGZeD0EJQwKtTO2fY3HXaD0tdBY/KRbb8XdQbQ0Tal+A/mu+
         BxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ABF6jWhcQFCEmEQUi+MWDc4uEldLt/+v1YpG4pvAfY=;
        b=BncyQZs5taD/JH5aUQgP4ErRmlI7xJ+XoPAPe8pkbkwkURIxgUJTPzw1TPcIS01/VE
         ypTRfrBQ8xhOW9SuDBYaTfWKgAuo+D2bhQXszziMuBOtNccv9uKVXYZ2CKgWx2D301V0
         toGiH3retk+j1oL0P9AjMgFPiw4GiQWdRukOG6E5XsnKLM3sCI3AL2kZDD3zJXoXYCBC
         pmTtliAw9QcXbERwHvuwjr517yBddkcfvdRgHx/8PXHIrQzoDEJ8aFclhDa7aqlwRC3w
         Y6qurgh0wGW76oA/R8TO3DKVmb1W3mf5x2f1JX0UdGWYBTquoL/h7JmE+N+VsuSLnGe/
         CNug==
X-Gm-Message-State: AOAM532/yvMGK2/ggRiRlMQDvWqVlTpwDyvFjZnoJ86wmaOyT7zdlnzu
        Pizy6fSVZOO8yCnru7KQijpoWZ+sH3yCDJwpW+U=
X-Google-Smtp-Source: ABdhPJznUESnOIbGJwf1+ormRBd1+0OM0Q1fktPuC8QeY4ftQlGam+1WVF7x5yGNPlq1dMmzU5ZhpS8iKMDqKiunzYA=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr12410988ilh.137.1612187435360;
 Mon, 01 Feb 2021 05:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20210201115610.87808-1-laoar.shao@gmail.com> <20210201115610.87808-4-laoar.shao@gmail.com>
 <YBgBxaFSy8P/nrcH@smile.fi.intel.com>
In-Reply-To: <YBgBxaFSy8P/nrcH@smile.fi.intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 1 Feb 2021 21:49:59 +0800
Message-ID: <CALOAHbAUPCUfZp_58QbVzvbP2UqoPqHAzzsgk1UTZ95v1rtqTw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in pGp
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 9:27 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:
> > Currently the pGp only shows the names of page flags, rather than
> > the full information including section, node, zone, last cpupid and
> > kasan tag. While it is not easy to parse these information manually
> > because there're so many flavors. Let's interpret them in pGp as well.
> >
> > - Before the patch,
> > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> >
> > - After the patch,
> > [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
> >
> > The Documentation and test cases are also updated.
>
> Thanks for an update, my comments below.
>
> ...
>
> > -     %pGp    referenced|uptodate|lru|active|private
> > +     %pGp    Node 0,Zone 2,referenced|uptodate|lru|active|private
>
> Since of the nature of printf() buffer, I wonder if these should be at the end.
> I.o.w. the question is is the added material more important to user to see than
> the existed one?
>

The existing one should be more important than the added one.
But the order of output will not match with the value for page->flags.
E.g.
    flags=0x17ffffc0010200(slab|head,Node 0,Zone 2,Lastcpupid 0x1fffff)
It may be strange to compare the value with the string.

> ...
>
> > +static void __init
> > +page_flags_test(int section, int node, int zone, int last_cpupid,
> > +             int kasan_tag, int flags, const char *name, char *cmp_buf)
> > +{
> > +     unsigned long page_flags = 0;
> > +     unsigned long size = 0;
> > +
> > +#ifdef SECTION_IN_PAGE_FLAGS
> > +     page_flags |= (sec & SECTIONS_MASK) << SECTIONS_PGSHIFT;
> > +     snprintf(cmp_buf, BUF_SIZE, "Section %#x,", sec);
>
> I would keep it in the same form as latter ones, i.e.
>
>         snprintf(cmp_buf + size, BUF_SIZE - size, "Section %#x,", sec);
>
> In this case it will be easier if at some point we might need to reshuffle.
>

Good suggestion.

> > +     size = strlen(cmp_buf);
> > +#endif
> > +
> > +     page_flags |= (node & NODES_MASK) << NODES_PGSHIFT;
> > +     snprintf(cmp_buf + size, BUF_SIZE - size, "Node %d", node);
> > +     size = strlen(cmp_buf);
> > +
> > +     page_flags |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
> > +     snprintf(cmp_buf + size, BUF_SIZE - size, ",Zone %d", zone);
> > +     size = strlen(cmp_buf);
> > +
> > +#ifndef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> > +     page_flags |= (last_cpupid & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
> > +     snprintf(cmp_buf + size, BUF_SIZE - size, ",Lastcpupid %#x", last_cpupid);
> > +     size = strlen(cmp_buf);
> > +#endif
> > +
> > +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> > +     page_flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> > +     snprintf(cmp_buf + size, BUF_SIZE - size, ",Kasantag %#x", tag);
> > +     size = strlen(cmp_buf);
> > +#endif
> > +
> > +     test(cmp_buf, "%pGp", &page_flags);
> > +
> > +     if (flags) {
>
> If below will be always for flags set, I would rewrite this condition as
>
>         if (!flags)
>                 return;
>
> but it's up to you.
>
> > +             page_flags |= flags;
> > +             snprintf(cmp_buf + size, BUF_SIZE - size, ",%s", name);
> > +             test(cmp_buf, "%pGp", &page_flags);
> > +     }
> > +}
>
> ...
>
> > -     flags = 0;
>
> > -     flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
> > -             | 1UL << PG_active | 1UL << PG_swapbacked;
>
> I would leave this untouched and reuse below...
>
> > +     cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
> > +     if (!cmp_buffer)
> > +             return;
>
> ...as
>
> > +     page_flags_test(0, 0, 0, 0, 0, 0, NULL, cmp_buffer);
>
>         flags = 0;
>         page_flags_test(0, 0, 0, 0, 0, flags, NULL, cmp_buffer);
>
> > +     page_flags_test(1, 1, 1, 0x1ffff, 1,
> > +                     (1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
> > +                      | 1UL << PG_active | 1UL << PG_swapbacked),
> > +                     "uptodate|dirty|lru|active|swapbacked",
> > +                     cmp_buffer);
>
>         flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
>                 | 1UL << PG_active | 1UL << PG_swapbacked;
>         page_flags_test(1, 1, 1, 0x1ffff, 1, flags,
>                         "uptodate|dirty|lru|active|swapbacked",
>                         cmp_buffer);
>

Sure, I will change them.

> ...
>
> > +static const struct page_flags_layout pfl[] = {
> > +     {SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
> > +      &default_dec_spec, "Section "},
> > +     {NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
> > +      &default_dec_spec, "Node "},
> > +     {ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
> > +      &default_dec_spec, "Zone "},
> > +     {LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
> > +      &default_flag_spec, "Lastcpupid "},
> > +     {KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
> > +      &default_flag_spec, "Kasantag "},
> > +};
>
> Please add trailing space only once where it's needed (below in the code).
>
> ...
>
> > +static
> > +char *format_page_flags(char *buf, char *end, unsigned long page_flags)
> > +{
> > +     unsigned long flags = page_flags & ((1UL << NR_PAGEFLAGS) - 1);
> > +     int size = ARRAY_SIZE(pfl);
> > +     bool separator = false;
> > +     int i;
> > +
> > +     for (i = 0; i < size; i++) {
> > +             if (pfl[i].width == 0)
> > +                     continue;
> > +
> > +             if (separator) {
> > +                     if (buf < end)
> > +                             *buf = ',';
> > +                     buf++;
> > +             }
>
> > +
> > +
>
> One blank line is enough.
>

Thanks for pointing it out.

BTW, it seems we need to improve the check_patch to catch this kind of
issue automatically.

> > +             buf = string(buf, end, pfl[i].name, *pfl[i].spec);
> > +
> > +             buf = number(buf, end, (page_flags >> pfl[i].shift) & pfl[i].mask,
> > +                          *pfl[i].spec);
> > +             separator = true;
> > +     }
> > +
> > +     if (flags) {
> > +             if (buf < end)
> > +                     *buf = ',';
> > +             buf++;
> > +     }
>
> I think you may optimize above to avoid using the separator variable.
>
>         DECLARE_BITMAP(mask, ARRAY_SIZE(pfl));
>         unsigned long flags;
>         unsigned long last;
>
>         for (i = 0; i < ARRAY_SIZE(pfl); i++)
>                 __assign_bit(mask, pfl[i].width);
>
>         last = find_last_bit(mask, ARRAY_SIZE(pfl));
>
>         for_each_set_bit(i, mask, ARRAY_SIZE(pfl)) {
>                 flags = (page_flags >> pfl[i].shift) & pfl[i].mask;
>
>                 /* Format: Flag Name + ' ' (space) + Number + ',' (separator) */
>                 buf = string(buf, end, pfl[i].name, *pfl[i].spec);
>
>                 if (buf < end)
>                         *buf = ' ';
>                 buf++;
>
>                 buf = number(buf, end, flags, *pfl[i].spec);
>
>                 /* No separator for the last entry */
>                 if ((page_flags & (BIT(NR_PAGEFLAGS) - 1)) || (i != last)) {
>                         if (buf < end)
>                                 *buf = ',';
>                         buf++;
>                 }
>         }
>

Good suggestion. I will think about it.

-- 
Thanks
Yafang
