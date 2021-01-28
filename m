Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E993076C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhA1NIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhA1NIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:08:31 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817FC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:07:51 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id x21so5447782iog.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGb1aq9paqdFYSvD64IBXTiYrmqFFnd0vb6R7QmmNTg=;
        b=p70H8AQQYZzDm0nS+E3kN9R09LzpmxMwRxrpvEccPjOUfvFXBjt1q4JBdbWzJSvcYc
         ksDiAUoEjSre7VFBYg+r1ryjHI+2Iab1RNWdZ/fkHU2q9BcrAqtSQKeTQIFxO2SEBy6e
         yKf/UFaaIQ7RpbM/eYiaeGnjFBmudkayLm9jBbee+Pm9Y/Paf4UDgBN5rFcfp4bqvBtY
         dYQGsoj/+GA5/GssZIpTHEONshpef72WaRgEdDMgO/qD8llT9nKvhJAcmb8OBiRk4j2T
         Dd5fXexd00IypeSHicTLDu8zefeGoxqkDzAddmqIJMGBqBEJbUkQr6u4+7ck3YRKsbp3
         B4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGb1aq9paqdFYSvD64IBXTiYrmqFFnd0vb6R7QmmNTg=;
        b=A0x28Cshb1t5wTCGYt8/nw7jkn7EL21Empn2lIWghsbilKn1S7Vphurr9CK+yXFhDt
         KMVBBd+/I3Nk+w2li5H07I6KNRYeJ0dASMQg9+qJKOqG8wYga47jMnOnv2p33lKBTJLJ
         oXeP8zAhaVSLkVGT6swjeIV9RAhS8skkeJdy5BNtIY7aMjd7QOPkVZp5ATt3nOpLqu+B
         /Wk1KxLSRcC1cA/XKdr05GmxoiX+vFk8QO6c76ODGkpPRiggVc1MLzl7AfyAk5hzeulG
         f1yaCXXMVhfi2VfMbgehuYojEjejDiNWEj8YCd2J8wBHLt9ziJ+BAO9hCvv9cDibG+6I
         4r7Q==
X-Gm-Message-State: AOAM532Yh8D/moag/dg5ZNB6rfM1uT/cfxuN+93aiANYWAWFrpbMc/Rg
        jhOGsF7sflM0NNsoIq2m1Z61bImJgQO9Ked9+5E=
X-Google-Smtp-Source: ABdhPJzYt0hhRe2II8tIYn5i7WwQtuPiA4qyA1CTx26ZsMNxFrtmWv3RFGMlg5hB1jiiDdgjmLpWq1FRlyDWjXSxs04=
X-Received: by 2002:a5e:9612:: with SMTP id a18mr10938738ioq.13.1611839271227;
 Thu, 28 Jan 2021 05:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20210128021947.22877-1-laoar.shao@gmail.com> <20210128021947.22877-4-laoar.shao@gmail.com>
 <894d55e7-d723-3a03-7a33-10b3ad8f66e8@suse.cz>
In-Reply-To: <894d55e7-d723-3a03-7a33-10b3ad8f66e8@suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 28 Jan 2021 21:07:15 +0800
Message-ID: <CALOAHbCDCdBpC0iODyvEEuui4uVindnKE+7f0E8CrUYhsgEPDQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
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

On Thu, Jan 28, 2021 at 6:42 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 3:19 AM, Yafang Shao wrote:
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
>
> node, zone could be decimal?

Make sense to me. Will change it.

>
> >
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
> > +};
> > +
> > +struct page_flags_layout pfl[] = {
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
>


-- 
Thanks
Yafang
