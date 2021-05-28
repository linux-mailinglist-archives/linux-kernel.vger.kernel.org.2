Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EC4394760
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhE1TFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE1TFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 15:05:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 12:04:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z12so6976327ejw.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3H90fqd+5UIDXvwPduQkwVIcuzpQwHpH8WcJ/XTN58=;
        b=f9PPfhW0iQtgLGQ95NRFdhS6hXDLrp9kdp62Yc7Q4GjJWv8L6503aRkRgsiGsPbADY
         gUx3QeLFxcJoQhts6rQwFyKkiEiinwUOgb1oanNyKrVvg5Ds6xq+LDOujEXr/tIcipUw
         ME3PxxraN255yw6GAPgqZyA8XnHKqGqqBLOpR1+UIQWF9Kb/lPg1nibiKcb24qkWcV9h
         ONIuiwVAOqFzlaEswMGnBzdHlJLNHjRX4qYdd0ZfxUweeoGQOM3EDt+fdJTKp8RwR4Dy
         DKtPhM6jVCUJyLm8uOoX6GerJIgF2nO0Ui1ZD3b88pT8XztVnlFR5w12zgUStlLM8f4W
         PrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3H90fqd+5UIDXvwPduQkwVIcuzpQwHpH8WcJ/XTN58=;
        b=tNAQFfGS0PPkfAICsYicRVROI1jZbHtIoVeu4bqdSlhceovIhJ/21njrJNbgtUpYSP
         VlDKvFmJvPp3HooTpJn3VlWipSO9b9UZJT0igjAXBTcOn8jDXnJiwjbJBF+xSilTFOFA
         iGyRsMUBw+hyXwTA/nkz8/LnPIY6iQ0GUtE+3Bo1pzF8oWfd8NTRObllDzzNYB9BwWmG
         WsrifBdenyNXOduJoN+RZtRnC1N/Xq0GSfuUQHzHy729qdta1KGy+xknG9HwgdfJDGm4
         Bx8Q/Ty7G8cj1bOh22nxwzyrroT27uwac/uygQT1xjVwm4M/Uek101FGwMMYDmnmpfoJ
         wNqA==
X-Gm-Message-State: AOAM533SuOomPBW7yTK8yo4uTM7PXPBY9GuRseA/H1/uj318QMwXmeNW
        j2utfY9xfbT1YAVTn431sHYs21cl4IppTEj2SeM=
X-Google-Smtp-Source: ABdhPJwV7Hfd6Mr8wlrF/s9IrFSINeflplJc5OMPKGg7aGzc+OU7DcQjJJ40kOLXRk72q9E+KbkNQPrtCVpCk+UIoFQ=
X-Received: by 2002:a17:906:1699:: with SMTP id s25mr10275556ejd.238.1622228644942;
 Fri, 28 May 2021 12:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210528175403.4506-1-shy828301@gmail.com> <ffc5612f-9403-9bc9-316f-fa50199769b2@nvidia.com>
In-Reply-To: <ffc5612f-9403-9bc9-316f-fa50199769b2@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 28 May 2021 12:03:53 -0700
Message-ID: <CAHbLzkpMFq4955wOq9bANxtonm3cM+yFPh_gfr8nJmnXu9_fgg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: dump_page: print total mapcount for compound page
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:26 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 5/28/21 10:54 AM, Yang Shi wrote:
> > The total mapcount is a useful information for debugging, but we can't
> > call total_mapcount() directly since it calls some assertions which may
> > be triggered as commit 6dc5ea16c86f ("mm,
> > dump_page: do not crash with bad compound_mapcount()") met.
> >
> > We could implement yet another implementation for dump_page() but
> > it has the limitation when individual mapcount of subpages is corrupted.
> >
> > Actually the total mapcount could be decoded from refcount, pincount and
> > compound mapcount although it may be not very precise due to some
> > transient references.
>
> If the mapcount calculation were in a separate routine, *and* if something
> else in addition to dump_page() used it, then I'd be interested in
> calling it from dump_page().

There is. The total_mapcount() is used by mm code. But as I mentioned
in the commit log and that discussion email, it is not safe to call it
directly in dump_page() path.

>
> But, just adding a calculation glob like this is not a good idea. If
> the reader really needs the calculation, then that person can, as you
> say, work it out from the other information.
>
> Debug and dump routines are actually supposed to remain fairly simple,
> so that they themselves do not end up with bugs, or stale assumptions
> (which this calculation is very much susceptible to). This goes in the
> wrong direction.
>
> So best to just not do this, IMHO.
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> > I think we are on the same page that the total mapcount is useful
> > information and it would be ideal to print this information when dumpping
> > page if possible.  But how to implement it safely seems controversial.
> > Some ideas and potential problems have been discussed by
> > https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2105261733110.16920@eggly.anvils/.
> >
> > So I prepared this patch to show a possible approach to get some
> > feedback.  The same thing could be decoded by the reader of page dump
> > as well by using the same formula used by this patch.  However it sounds
> > more convenient to have kernel do the math.
> >
> >   mm/debug.c | 35 +++++++++++++++++++++++++++++------
> >   1 file changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/debug.c b/mm/debug.c
> > index e73fe0a8ec3d..129efcfcaf79 100644
> > --- a/mm/debug.c
> > +++ b/mm/debug.c
> > @@ -54,8 +54,13 @@ static void __dump_page(struct page *page)
> >        * inaccuracy here due to racing.
> >        */
> >       bool page_cma = is_migrate_cma_page(page);
> > -     int mapcount;
> > +     int mapcount, total_mapcount;
> > +     int nr;
> > +     int refcount;
> > +     int pincount = 0;
> > +     int comp_mapcnt;
> >       char *type = "";
> > +     bool is_slab = PageSlab(head);
> >
> >       if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
> >               /*
> > @@ -82,22 +87,40 @@ static void __dump_page(struct page *page)
> >        * page->_mapcount space in struct page is used by sl[aou]b pages to
> >        * encode own info.
> >        */
> > -     mapcount = PageSlab(head) ? 0 : page_mapcount(page);
> > +     mapcount = is_slab ? 0 : page_mapcount(page);
> > +
> > +     refcount = page_ref_count(head);
> >
> >       pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
> > -                     page, page_ref_count(head), mapcount, mapping,
> > +                     page, refcount, mapcount, mapping,
> >                       page_to_pgoff(page), page_to_pfn(page));
> >       if (compound) {
> > +             comp_mapcnt = head_compound_mapcount(head);
> >               if (hpage_pincount_available(page)) {
> > +                     pincount = head_compound_pincount(head);
> >                       pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
> >                                       head, compound_order(head),
> > -                                     head_compound_mapcount(head),
> > -                                     head_compound_pincount(head));
> > +                                     comp_mapcnt, pincount);
> >               } else {
> >                       pr_warn("head:%p order:%u compound_mapcount:%d\n",
> >                                       head, compound_order(head),
> > -                                     head_compound_mapcount(head));
> > +                                     comp_mapcnt);
> > +             }
> > +
> > +             nr = compound_nr(head);
> > +             if (is_slab)
> > +                     total_mapcount = 0;
> > +             else if (PageHuge(head))
> > +                     total_mapcount = comp_mapcnt;
> > +             else {
> > +                     if (mapping) {
> > +                             if (!PageAnon(head))
> > +                                     nr = nr * (comp_mapcnt + 1) - comp_mapcnt;
> > +                     } else
> > +                             nr = 0;
> > +                     total_mapcount = refcount - pincount - nr;
> >               }
> > +             pr_warn("total_mapcount(estimated):%d\n", total_mapcount);
> >       }
> >
> >   #ifdef CONFIG_MEMCG
> >
>
