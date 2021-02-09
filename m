Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1ED3153B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhBIQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhBIQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:22:54 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A728C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:22:14 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z18so16595358ile.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfG2y+Tmojg7YdfWhT+eo2WxBxeLU3Fn2z2e1GY+59U=;
        b=hpV2e7jEL/pTgFwx+uiwkp82FR8uGDsSilQmXJIzHqkT5R2DXTo8+5J9f8r98z5Zw1
         Ic3PV04ZjqofoJXumYGUY8gE9FT1rHBZnIbbMJk3Wy5dohyxHpdR0vSwUXrngBLuFeok
         0FH0P0SF+RwSQigNzLCJu+raaK65lef5D1IibL/IXwJrjjs3SdjblBQKERbEdtbzgqBD
         K5jb1Ux8r6/UIHAhfx/weIeIbdx7pWc9R1adn6MhOLUjJ3foT0/DHc31Mn2DmEaCogrT
         uinNuOmRk0FWBg8zhReb/Q7+31p20iEU61LWkYjr4SsX8L9+WbBZvzung9SeIzKQ8O0F
         RCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfG2y+Tmojg7YdfWhT+eo2WxBxeLU3Fn2z2e1GY+59U=;
        b=X6qQmnmOVtBk57tNgH/6QnO3FmUxcwjy2+8RIFGE+IAU+xmM+UDxp4nWBcWMfjGRUB
         LOtw3mq5yY8wZZv0ReKjC30AhgLUYeBA7xQtz2ZeQfQeUH6FibEtOAx9xjuSE9dBnCgw
         9UDrKV8hYDhDJdP1Y/W4Ng/yiU9yGXYyr3j3/O2q4oszFZIhqutE7Mrjrgxn/STEL/QY
         oVJ5fiISUKadmCjSp3ieVHUFRQo9VttyK0Icygvvttk9bEAXhN6idp3SXL+EXqyeJqYx
         VhclljNqUr62n15Ke1uLhjAf13m5KZ+R/CTpFod+TlLBv6GkJ2CtOYWgO9MSwBhGCKXi
         ifqA==
X-Gm-Message-State: AOAM531fUfG7YVEOH++5a41Ii+v2HTspVRyg4dG8mPR7QTs2wJdsFN7n
        mHInNNImE8egJlip4gAWglLu/9qtF4Z2sb2OVVc=
X-Google-Smtp-Source: ABdhPJypG/VLn5XpEeuQqgcp/zaT3K4X3Uj+A1Gs/YIGHSQz1IT1lleiHwgDdsLsx/WFHPkHrvlqHiY8M25CNufH8oE=
X-Received: by 2002:a05:6e02:b:: with SMTP id h11mr20743678ilr.168.1612887733669;
 Tue, 09 Feb 2021 08:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20210209105613.42747-1-laoar.shao@gmail.com> <20210209105613.42747-4-laoar.shao@gmail.com>
 <YCKT8WCPGU+HBY91@alley>
In-Reply-To: <YCKT8WCPGU+HBY91@alley>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 10 Feb 2021 00:21:37 +0800
Message-ID: <CALOAHbBO6gXzbXjnH_EPsk4v-AdEQNhwNez7mbM6oTaut1pokw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] vsprintf: dump full information of page flags in pGp
To:     Petr Mladek <pmladek@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 9:53 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2021-02-09 18:56:13, Yafang Shao wrote:
> > Currently the pGp only shows the names of page flags, rather than
> > the full information including section, node, zone, last cpupid and
> > kasan tag. While it is not easy to parse these information manually
> > because there're so many flavors. Let's interpret them in pGp as well.
> >
> > To be compitable with the existed format of pGp, the new introduced ones
> > also use '|' as the separator, then the user tools parsing pGp won't
> > need to make change, suggested by Matthew. The new information is
> > tracked onto the end of the existed one.
> >
> > On example of the output in mm/slub.c as follows,
> > - Before the patch,
> > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> >
> > - After the patch,
> > [ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> >
> > The documentation and test cases are also updated. The output of the
> > test cases as follows,
> > [  501.485081] test_printf: loaded.
> > [  501.485768] test_printf: all 388 tests passed
> > [  501.488762] test_printf: unloaded.
> >
>
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 14c9a6af1b23..3f26611adb34 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1916,6 +1916,66 @@ char *format_flags(char *buf, char *end, unsigned long flags,
> >       return buf;
> >  }
> >
> > +struct page_flags_layout {
> > +     int width;
> > +     int shift;
> > +     int mask;
> > +     const struct printf_spec *spec;
> > +     const char *name;
> > +};
> > +
> > +static const struct page_flags_layout pfl[] = {
> > +     {SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
> > +      &default_dec_spec, "section"},
> > +     {NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
> > +      &default_dec_spec, "node"},
> > +     {ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
> > +      &default_dec_spec, "zone"},
> > +     {LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
> > +      &default_flag_spec, "lastcpupid"},
> > +     {KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
> > +      &default_flag_spec, "kasantag"},
> > +};
> > +
> > +static
> > +char *format_page_flags(char *buf, char *end, unsigned long flags)
> > +{
> > +     DECLARE_BITMAP(mask, ARRAY_SIZE(pfl));
> > +     unsigned long last;
> > +     int i;
> > +
> > +     if (flags & (BIT(NR_PAGEFLAGS) - 1)) {
> > +             if (buf < end)
> > +                     *buf = '|';
> > +             buf++;
> > +     }
>
> This is far from obvious. You print '|' here because you printed
> something somewhere else. See below.
>
> > +
> > +     for (i = 0; i < ARRAY_SIZE(pfl); i++)
> > +             __assign_bit(i, mask, pfl[i].width);
>
> The bitmap looks like an overkill. If I get it correctly, it is a
> tricky way to handle only flags defined by the used build
> configuration. See below.
>
> > +     last = find_last_bit(mask, ARRAY_SIZE(pfl));
> > +
> > +     for_each_set_bit(i, mask, ARRAY_SIZE(pfl)) {
> > +             /* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
> > +             buf = string(buf, end, pfl[i].name, *pfl[i].spec);
> > +
> > +             if (buf < end)
> > +                     *buf = '=';
> > +             buf++;
> > +             buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
> > +                          *pfl[i].spec);
> > +
> > +             /* No separator for the last entry */
> > +             if (i != last) {
> > +                     if (buf < end)
> > +                             *buf = '|';
> > +                     buf++;
> > +             }
> > +     }
> > +
> > +     return buf;
> > +}
> > +
> >  static noinline_for_stack
> >  char *flags_string(char *buf, char *end, void *flags_ptr,
> >                  struct printf_spec spec, const char *fmt)
> > @@ -1929,10 +1989,10 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
> >       switch (fmt[1]) {
> >       case 'p':
> >               flags = *(unsigned long *)flags_ptr;
> > -             /* Remove zone id */
> > -             flags &= (1UL << NR_PAGEFLAGS) - 1;
> >               names = pageflag_names;
>
> The "names" variable is needed only with "break;" when using the final
> format_flags(buf, end, flags, names);
>
> > -             break;
> > +             buf = format_flags(buf, end, flags & (BIT(NR_PAGEFLAGS) - 1), names);
> > +             buf = format_page_flags(buf, end, flags);
>
> I am sorry for my ignorance. I am not familiar with MM.
> But it is pretty hard to understand what call does what.
>
> I have found the following comment in include/linux/page_flags.h:
>
>  * The page flags field is split into two parts, the main flags area
>  * which extends from the low bits upwards, and the fields area which
>  * extends from the high bits downwards.
>
> Sigh, I know that you already reworked this several times because
> people "nitpicked" about the code style. But it seems that it
> rather diverged instead of converged.
>
> What about the following?
>
> Note: It is inpired by the names "main area" and "fields area"
>       mentioned in the above comment from page_flags.h.
>       I have later realized that "page_flags_layout" actually made
>       sense as well. Feel free to rename page_flags_fileds
>       back to page_flags_layout.
>
> Anyway, this is my proposal:
>

This proposal is similar to v2.
I don't mind changing it back with your additional better naming.
By the way, it will be better to make a little change per Joe's
suggestion on v2 that using a pointer instead of the index, for
example,

 for (p = pff; p < pff + ARRAY_SIZE(pff); p++) {

I will leave it for a moment in case others have a different opinion.

Anyway I like your proposal.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..cf67b39d72ae 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1916,6 +1916,67 @@ char *format_flags(char *buf, char *end, unsigned long flags,
>         return buf;
>  }
>
> +/* Meta information for page flags in the fields area */
> +struct page_flags_fields {
> +       int width;
> +       int shift;
> +       int mask;
> +       const struct printf_spec *spec;
> +       const char *name;
> +};
> +
> +static const struct page_flags_fields pff[] = {
> +       {SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
> +        &default_dec_spec, "section"},
> +       {NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
> +        &default_dec_spec, "node"},
> +       {ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
> +        &default_dec_spec, "zone"},
> +       {LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
> +        &default_flag_spec, "lastcpupid"},
> +       {KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
> +        &default_flag_spec, "kasantag"},
> +};
> +
> +static
> +char *format_page_flags(char *buf, char *end, unsigned long flags)
> +{
> +       unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
> +       bool append = false;
> +       int i;
> +
> +       /* Page flags from the main area. */
> +       if (main_flags) {
> +               buf = format_flags(buf, end, main_flags, pageflag_names);
> +               append = true;
> +       }
> +
> +       /* Page flags from the fields area */
> +       for (i = 0; i < ARRAY_SIZE(pff); i++) {
> +               /* Skip undefined fields. */
> +               if (!pff[i].width)
> +                       continue;
> +
> +               /* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
> +               if (append) {
> +                       if (buf < end)
> +                               *buf = '|';
> +                       buf++;
> +               }
> +
> +               buf = string(buf, end, pff[i].name, *pff[i].spec);
> +               if (buf < end)
> +                       *buf = '=';
> +               buf++;
> +               buf = number(buf, end, (flags >> pff[i].shift) & pff[i].mask,
> +                            *pff[i].spec);
> +
> +               append = true;
> +       }
> +
> +       return buf;
> +}
> +
>  static noinline_for_stack
>  char *flags_string(char *buf, char *end, void *flags_ptr,
>                    struct printf_spec spec, const char *fmt)
> @@ -1929,10 +1990,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
>         switch (fmt[1]) {
>         case 'p':
>                 flags = *(unsigned long *)flags_ptr;
> -               /* Remove zone id */
> -               flags &= (1UL << NR_PAGEFLAGS) - 1;
> -               names = pageflag_names;
> -               break;
> +               return format_page_flags(buf, end, flags);
>         case 'v':
>                 flags = *(unsigned long *)flags_ptr;
>                 names = vmaflag_names;
> --
> 2.26.2
>


-- 
Thanks
Yafang
