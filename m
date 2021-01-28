Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17E306FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhA1HpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhA1Hnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:43:55 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EF7C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:43:15 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id p15so3666647ilq.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R34wmap4SlZQiVdkg4GoUNHYognsPIau3/lAsDGw4ww=;
        b=JuwSz00A+EuJFHf+7JP6WRl7/DURYn5ADwiJCNhLZzTHtNOFDXGVP0o8+5yGgHIhB0
         xoDpPwv7XvdNxjkpyYQloIf8k15L19G6Tf4XCXIwoZKzoM/6lAy0CF2AL/b2ICrVZbzY
         ZLczipoHHHL9Z7EC/5ZY26L2JNlBO0ctsouL7sITUMzq4PwcDQT52UuRItUqobhGn5Fs
         UbHNMDjBkBbkAxh2jV3oDoIib7kH+8Iv1+02uRUBnwBRmEemKLsxwo0AlBHC3RsIkNtL
         4zgeDBlQ3qOvwzsYRSTxX5zKLbOJ91nCEllpeLsxXXu8LdejczL+K3m/FpyEDbxPwAMZ
         FTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R34wmap4SlZQiVdkg4GoUNHYognsPIau3/lAsDGw4ww=;
        b=ZP9fq5mJJlLYYkMzX3GQzHhIk1T2XJis9HGO4SvU/SrZhVQxM65mjD25hCFEU1StMB
         /KdPIZnOxjyRruHzfaWZxKY8OhfEDu+xBVXpCz6LYix2SmZdyxG/L8cvRMVKaAv/vzJJ
         jPO6iuT8v6iv4HuxBfMbW2S3g3He+mdUFIRuNZVAlREzhib68er8d6sDYS2b0+d9WK2a
         9bCckjKH+3jKI9Mck4nhmsG72vnR/5r0t88djoD7/i7oUdNpVmWOk9YCNlUHTMt8sU6q
         WMiCYpgwVv006yphUGIXGNwr8p+U5jNnF+e9SWZ/2r79tfuILCu/kkH60eJT+VU+dtf3
         1ZOQ==
X-Gm-Message-State: AOAM5303ODr1nXh+Cq9xfO3F2b1ZE5yfzX5V/OVWMotZIWgkLzNZXIOR
        rMOniN5aRTVoGgObYaUhvz4osgG5NByzxUynUFs=
X-Google-Smtp-Source: ABdhPJxfPmtA//UDL6jbaBgYGr0yMcusgQaCXh5P1cB6yZXF4048HMIeXPZjLU+v01hQMHmgzwsfGqjp0Jq37WEBIfM=
X-Received: by 2002:a92:5bc2:: with SMTP id c63mr11989709ilg.142.1611819794700;
 Wed, 27 Jan 2021 23:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20210128021947.22877-1-laoar.shao@gmail.com> <20210128021947.22877-4-laoar.shao@gmail.com>
 <e5ea9e8b1190c2a397a1b84dd55bb9c706dc7058.camel@perches.com>
In-Reply-To: <e5ea9e8b1190c2a397a1b84dd55bb9c706dc7058.camel@perches.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 28 Jan 2021 15:42:38 +0800
Message-ID: <CALOAHbC+-BqQtXx3Miqa_6VboNA=5gsgTWzwJvk_uH_A+4SFAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
To:     Joe Perches <joe@perches.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        andriy.shevchenko@linux.intel.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:35 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2021-01-28 at 10:19 +0800, Yafang Shao wrote:
> > Currently the pGp only shows the names of page flags, rather than
> > the full information including section, node, zone, last cpupid and
> > kasan tag. While it is not easy to parse these information manually
> > because there're so many flavors. Let's interpret them in pGp as well.
> []
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> []
> > @@ -1916,6 +1916,46 @@ char *format_flags(char *buf, char *end, unsigned long flags,
> >       return buf;
> >  }
> >
> > +struct page_flags_layout {
> > +     int width;
> > +     int shift;
> > +     int mask;
> > +     char *name;
> > +};
> > +
> > +struct page_flags_layout pfl[] = {
>
> static const struct page_flags_layout pfl[] = {

Sure.

>
> > +     {SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK, "Section "},
> > +     {NODES_WIDTH, NODES_PGSHIFT, NODES_MASK, "Node "},
> > +     {ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK, "Zone "},
> > +     {LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK, "Lastcpupid "},
> > +     {KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK, "Kasantag "},
> > +};
> > +
> > +static
> > +char *format_layout(char *buf, char *end, unsigned long flags)
>
> poor name.  perhaps format_page_flags
>

Thanks for the suggestion.

> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < sizeof(pfl) / sizeof(struct page_flags_layout) && buf < end; i++) {
>
>         for (i = 0; i < ARRAY_SIZE(pfl) && buf < end; i++) {
>

Sure.


>
> > @@ -1929,7 +1969,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
> >       switch (fmt[1]) {
> >       case 'p':
> >               flags = *(unsigned long *)flags_ptr;
> > -             /* Remove zone id */
> > +             buf = format_layout(buf, end, flags & ~((1UL << NR_PAGEFLAGS) - 1));
> >               flags &= (1UL << NR_PAGEFLAGS) - 1;
>
> Perhaps store the bitshift into a temp and use the temp twice
>
>                 foo = BIT(NR_PAGEFLAGS) - 1;
>
>                 buf = format_layout(buf, end, flags & ~foo);
>                 flags &= foo;
>
>

Thanks for the suggestion. I will change them all.


-- 
Thanks
Yafang
