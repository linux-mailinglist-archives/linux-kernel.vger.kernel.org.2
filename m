Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7930A8B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhBAN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhBAN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:28:31 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FDEC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:27:50 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z18so15267182ile.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BELtHAvSCgNIbArcYZ8LXqCZU44K+DZgMM7UPty4+Ck=;
        b=rxG5wyGX/Y6ekS24eiiM+iaARCjJBBzR493zvgJTN/Vs9/2DvSiuFE4uJInzu04i9u
         V9OvCgqiSbbagdd4uORfigyCy4gF5I0uNE018C5kb6VagrhjY2/zj/lEsy8b7mFhJg4c
         E+olhQMHnV3kd29b7CtPyT52NKRtE6ssFgDtTCMlOI1phOQyyeWCf+FJMyUKAOuB5oZz
         4ImGmnwtTsxVYTlI0u3bXSXPL4KWPGroYmVnPm51/fKWUdujGjFoor5b8mua8sTl7i1N
         1bMSJTCU3VP2nTHxvs/8DByiBEsc8V3tsocZ+0VD/9IbbwoHuCXRx7tfl9nb4OURgEL4
         ZfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BELtHAvSCgNIbArcYZ8LXqCZU44K+DZgMM7UPty4+Ck=;
        b=CfcSo0+Kal3E4Y+Scy6jY+3sj/4TPoizZSj/s9hBtulbzZ8KC5SOjFkOLq4YfHT6Zd
         4yGCWl9qH3nJ+PqlERT1wVNx9657WKE5BzQZ+Z9sl2QcXQF9bjiZLqyCMPUKvPjm0yHw
         jgAOIXNqXs58389JD4jcyGeOkWgC0jJCNq0abnImO/eCXocmmAX1NtR+2wigvkeF3qcp
         vF31Cf+R9F1FBe8CWtSlmn48mfcvEF6euukje3fHHFLQdLqGWP2ycw9Oen0mbc/D0Ud7
         e4HBcF95sDJSCKH9zr7M34rJbz9GJWVIm5aEZildsHZcKMJrK5Sw7/ZCrn87KJMHTwDn
         z1Sw==
X-Gm-Message-State: AOAM530JJE2x01ODr49Oq5wRtrtrvNBy/prRFhcmz0Ygkwu2lKScmgse
        3JzVKe1HFknuUnFvUUcdUgxG9vgJsR5U8mG6UiE=
X-Google-Smtp-Source: ABdhPJzV7Z6kKvJpPf0/EKLZ2SR/67ZFHUSyKbWOtrxHb1803ZxJDk0fr92/CvRT8dsPTS2WzyJaua3XToEUNvff4bY=
X-Received: by 2002:a05:6e02:1447:: with SMTP id p7mr12795583ilo.93.1612186070191;
 Mon, 01 Feb 2021 05:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20210201115610.87808-1-laoar.shao@gmail.com> <20210201115610.87808-4-laoar.shao@gmail.com>
 <06481a01f551697d42c792506f3538d459ce8bdd.camel@perches.com>
In-Reply-To: <06481a01f551697d42c792506f3538d459ce8bdd.camel@perches.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 1 Feb 2021 21:27:14 +0800
Message-ID: <CALOAHbDz=BSuSrcxTTE9Xn+NTgi15jUDf9oW5VxUBDhr7dCzmA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in pGp
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
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
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 9:05 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2021-02-01 at 19:56 +0800, Yafang Shao wrote:
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
>
> While debugfs is not an ABI, this format is exported in debugfs to
> userspace via mm/page_owner.c read_page_owner/print_page_owner.
>

Right, the page_owner will be affected by this  change.

> Does changing the output format matter to anyone?
>

The user tools which parse the page_owner may be affected.
If we don't want to affect the userspace tools, I think we can make a
little change in page_owner as follows,

    unsigned long masked_flags = page->flags &  (BIT(NR_PAGEFLAGS) - 1);
    snprintf("..., %#lx(%pGp)\n", page->flags, &masked_flags);

> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> []
> > +static
> > +char *format_page_flags(char *buf, char *end, unsigned long page_flags)
> > +{
> > +     unsigned long flags = page_flags & ((1UL << NR_PAGEFLAGS) - 1);
> > +     int size = ARRAY_SIZE(pfl);
>
> There's no real value in used-once variables.
>
> > +     bool separator = false;
> > +     int i;
> > +
> > +     for (i = 0; i < size; i++) {
>
> Use ARRAY_SIZE here instead
>

Sure

>         for (i = 0; i < ARRAY_SIZE(pfl); i++) {
>
> > +             if (pfl[i].width == 0)
> > +                     continue;
> > +
> > +             if (separator) {
> > +                     if (buf < end)
> > +                             *buf = ',';
> > +                     buf++;
> > +             }
> > +
> > +
> > +             buf = string(buf, end, pfl[i].name, *pfl[i].spec);
> > +
> > +             buf = number(buf, end, (page_flags >> pfl[i].shift) & pfl[i].mask,
> > +                          *pfl[i].spec);
> > +             separator = true;
> > +     }
>
> Style question:
> Might this array be more intelligible with pointers instead of indexes?

Good suggestion!
I will change it in the next version.

> Something like:
>
>         struct page_flags_layout *p;
>
>         for (p = pfl; p < pfl + ARRAY_SIZE(pfl); p++) {
>                 if (p->width == 0)
>                         continue;
>

>                 if (p > pfl) {
>                         if (buf < end)
>                                 *buf = ',';
>                         buf++;
>                 }

It doesn't work, because there's a 'continue' above, meaning that the
p may be greater than pfl without doing anything.

>
>                 buf = string(buf, end, p->name, *p->spec);
>                 buf = number(buf, end, (page_flags >> p->shift) & p->mask, *p->spec);
>         }
>
> > +
> > +     if (flags) {
>
> Maybe:
>
>         if (page_flags & (BIT(NR_PAGEFLAGS) - 1)) {
>

Sure.

> > +             if (buf < end)
> > +                     *buf = ',';
> > +             buf++;
> > +     }
> > +
> > +     return buf;
> > +}
> > +
>
>


--
Thanks
Yafang
