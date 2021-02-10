Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F258316720
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBJMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:52:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:52978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBJMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:52:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612961484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9eYi99J7mxFQDOzF/dkA+if59XFW+gFl2AA2TsPnXfA=;
        b=rqFNp+jkPLtRw66YyBi/vmcTyFZIC0ZMM/T4dwkcg3F7xDYsatvzl7qgin6ZxsZ/oRWjGH
        UxQZAnHYBy4iGvsuHffoPp7gS7cyOqpZFXogVG2LFuz4HlT6u21728eTgWIgEnyuTkfq06
        GCSfZ5E23bGFs8PVqYsKx8NCvQ7AqmA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D04A7AEB9;
        Wed, 10 Feb 2021 12:51:23 +0000 (UTC)
Date:   Wed, 10 Feb 2021 13:51:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
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
Subject: Re: [PATCH v4 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YCPWypWctDMGWUpA@alley>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
 <20210209105613.42747-4-laoar.shao@gmail.com>
 <YCKT8WCPGU+HBY91@alley>
 <CALOAHbBO6gXzbXjnH_EPsk4v-AdEQNhwNez7mbM6oTaut1pokw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBO6gXzbXjnH_EPsk4v-AdEQNhwNez7mbM6oTaut1pokw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-10 00:21:37, Yafang Shao wrote:
> On Tue, Feb 9, 2021 at 9:53 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2021-02-09 18:56:13, Yafang Shao wrote:
> > > Currently the pGp only shows the names of page flags, rather than
> > > the full information including section, node, zone, last cpupid and
> > > kasan tag. While it is not easy to parse these information manually
> > > because there're so many flavors. Let's interpret them in pGp as well.
> > >
> > > To be compitable with the existed format of pGp, the new introduced ones
> > > also use '|' as the separator, then the user tools parsing pGp won't
> > > need to make change, suggested by Matthew. The new information is
> > > tracked onto the end of the existed one.
> > >
> > > On example of the output in mm/slub.c as follows,
> > > - Before the patch,
> > > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> > >
> > > - After the patch,
> > > [ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> > >
> > > The documentation and test cases are also updated. The output of the
> > > test cases as follows,
> > > [  501.485081] test_printf: loaded.
> > > [  501.485768] test_printf: all 388 tests passed
> > > [  501.488762] test_printf: unloaded.
> > >
> >
> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > > index 14c9a6af1b23..3f26611adb34 100644
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -1916,6 +1916,66 @@ char *format_flags(char *buf, char *end, unsigned long flags,
> > >       return buf;
> > >  }
> > >
> > > +struct page_flags_layout {
> > > +     int width;
> > > +     int shift;
> > > +     int mask;
> > > +     const struct printf_spec *spec;
> > > +     const char *name;
> > > +};
> > > +
> > > +static const struct page_flags_layout pfl[] = {
> > > +     {SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
> > > +      &default_dec_spec, "section"},
> > > +     {NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
> > > +      &default_dec_spec, "node"},
> > > +     {ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
> > > +      &default_dec_spec, "zone"},
> > > +     {LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
> > > +      &default_flag_spec, "lastcpupid"},
> > > +     {KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
> > > +      &default_flag_spec, "kasantag"},
> > > +};
> > > +
> > > +static
> > > +char *format_page_flags(char *buf, char *end, unsigned long flags)
> > > +{
> > > +     DECLARE_BITMAP(mask, ARRAY_SIZE(pfl));
> > > +     unsigned long last;
> > > +     int i;
> > > +
> > > +     if (flags & (BIT(NR_PAGEFLAGS) - 1)) {
> > > +             if (buf < end)
> > > +                     *buf = '|';
> > > +             buf++;
> > > +     }
> >
> > This is far from obvious. You print '|' here because you printed
> > something somewhere else. See below.
> >
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(pfl); i++)
> > > +             __assign_bit(i, mask, pfl[i].width);
> >
> > The bitmap looks like an overkill. If I get it correctly, it is a
> > tricky way to handle only flags defined by the used build
> > configuration. See below.
> >
> > > +     last = find_last_bit(mask, ARRAY_SIZE(pfl));
> > > +
> > > +     for_each_set_bit(i, mask, ARRAY_SIZE(pfl)) {
> > > +             /* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
> > > +             buf = string(buf, end, pfl[i].name, *pfl[i].spec);
> > > +
> > > +             if (buf < end)
> > > +                     *buf = '=';
> > > +             buf++;
> > > +             buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
> > > +                          *pfl[i].spec);
> > > +
> > > +             /* No separator for the last entry */
> > > +             if (i != last) {
> > > +                     if (buf < end)
> > > +                             *buf = '|';
> > > +                     buf++;
> > > +             }
> > > +     }
> > > +
> > > +     return buf;
> > > +}
> > > +
> > >  static noinline_for_stack
> > >  char *flags_string(char *buf, char *end, void *flags_ptr,
> > >                  struct printf_spec spec, const char *fmt)
> > > @@ -1929,10 +1989,10 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
> > >       switch (fmt[1]) {
> > >       case 'p':
> > >               flags = *(unsigned long *)flags_ptr;
> > > -             /* Remove zone id */
> > > -             flags &= (1UL << NR_PAGEFLAGS) - 1;
> > >               names = pageflag_names;
> >
> > The "names" variable is needed only with "break;" when using the final
> > format_flags(buf, end, flags, names);
> >
> > > -             break;
> > > +             buf = format_flags(buf, end, flags & (BIT(NR_PAGEFLAGS) - 1), names);
> > > +             buf = format_page_flags(buf, end, flags);
> >
> > I am sorry for my ignorance. I am not familiar with MM.
> > But it is pretty hard to understand what call does what.
> >
> > I have found the following comment in include/linux/page_flags.h:
> >
> >  * The page flags field is split into two parts, the main flags area
> >  * which extends from the low bits upwards, and the fields area which
> >  * extends from the high bits downwards.
> >
> > Sigh, I know that you already reworked this several times because
> > people "nitpicked" about the code style. But it seems that it
> > rather diverged instead of converged.
> >
> > What about the following?
> >
> > Note: It is inpired by the names "main area" and "fields area"
> >       mentioned in the above comment from page_flags.h.
> >       I have later realized that "page_flags_layout" actually made
> >       sense as well. Feel free to rename page_flags_fileds
> >       back to page_flags_layout.
> >
> > Anyway, this is my proposal:
> >
> 
> This proposal is similar to v2.
> I don't mind changing it back with your additional better naming.

Great.

> By the way, it will be better to make a little change per Joe's
> suggestion on v2 that using a pointer instead of the index, for
> example,
> 
>  for (p = pff; p < pff + ARRAY_SIZE(pff); p++) {

This looks a bit non-standard. IMHO, Joe was not against using index.
He proposed:

	for (i = 0; i < ARRAY_SIZE(pfl) && buf < end; i++) {

, see
https://lore.kernel.org/lkml/e5ea9e8b1190c2a397a1b84dd55bb9c706dc7058.camel@perches.com/

I am not sure about the (buf < end) check. It might be some
optimization or it did fit the the old code.

Anyway, I like the currently used:

	for (i = 0; i < ARRAY_SIZE(pff); i++) {

It is standard, easy to understand, and thus more safe. I am sure that
compiler will optimize it very well.

Best Regards,
Petr
