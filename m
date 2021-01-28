Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2301B3076B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhA1NH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhA1NHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:07:25 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A840C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:06:45 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n2so5457216iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5AmyTAxwdCn14G+u2C+YUTCaRy+e3KtKL++CDObPQY=;
        b=bIInvfI2erl556NcqE26CdvyZS1i0f2lZ4YQ+vrDzBAtJlAQjb0mG73aJqxbAUxrLd
         twuAXu/a9Tv9a+6hbn1q/eaFYy1yeP2NIRUIcTE+d6Qn+tI9BZn6mmaap9JjDlwCtOWs
         OCjBhsE7i6beC1aa4nskk1axlHfZPL0NDRFFh6FLshW7htvzO/eveACfWJ50IXjFwpkj
         C2Gz9CFEMxtk8ZOAIr3jtvIc78zT1CriL5AKz0n5956A2Pghzhd3vsrfGaC/HrBO+W7v
         dAIDB87NdgeMjoJImIRzQwwLT4TFIBvX+r7hmbKJQs35YcaF6D/ENo1tRokfBB9IduT9
         4Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5AmyTAxwdCn14G+u2C+YUTCaRy+e3KtKL++CDObPQY=;
        b=cJgSdKmJNlb8LNwfC6x9cBO8T3X1jiruUxu9Vm2yABP76syJWF3UP22T3SrY7+QFS3
         FU/EStmlmy6+WQ5sLo9TXucXqgIGKSA9K8xZl3PdFPQPsUknSv5ZLG1ymf539QiMXv5w
         bms/DESpix0mn+1+ez0cL3bgRX6QmQZI2WjqPT2oI3l1Ej3KqjK42qgMd/2+ft7TC9NJ
         hvyR8MIbOIAwRu31e+L8OQi3ZRMNwDK0PSqzXR31jiVEWHDLxg3WJNQihHzKjZcea5YZ
         77IIpTByGLWO6HLTM+wJU6I/EfAW5XpRDwVE7JW29zaMxT1Fw8ijDW5D+Nr6RBG4NFB/
         0J3w==
X-Gm-Message-State: AOAM5323qDhZIzZBL1FkEOtyfC2u4EQJ5c1zFtZQB6jG/hQF5Fnt0wdt
        MvPSTsl6lH7s/clsUd37D6QNS6UXTa/dbKnExDM=
X-Google-Smtp-Source: ABdhPJyNsoTx7kPhpc8DTZ+IGBwljtCc0WwblZh+zMI0ljNcvyzmIay/MEoZEU+D874v7s0hm9z1lQ7urL5rDUOhk1M=
X-Received: by 2002:a05:6602:224b:: with SMTP id o11mr11251520ioo.10.1611839205042;
 Thu, 28 Jan 2021 05:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20210128021947.22877-1-laoar.shao@gmail.com> <20210128021947.22877-3-laoar.shao@gmail.com>
 <0b2f4419-06a9-0b6c-067b-8d0848e78c33@suse.cz>
In-Reply-To: <0b2f4419-06a9-0b6c-067b-8d0848e78c33@suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 28 Jan 2021 21:06:09 +0800
Message-ID: <CALOAHbBb3ULnObisew=zv==6NdSD3aMqQ=pKRGOQUeWSghrpqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm, slub: don't combine pr_err with INFO
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

On Thu, Jan 28, 2021 at 6:35 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 3:19 AM, Yafang Shao wrote:
> > It is strange to combine "pr_err" with "INFO", so let's clean them up.
> > This patch is motivated by David's comment[1].
> >
> > - before the patch
> > [ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)
> >
> > - after the patch
> > [ 6312.639698] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(slab|head)
> >
> > [1]. https://lore.kernel.org/linux-mm/b9c0f2b6-e9b0-0c36-ebdd-2bc684c5a762@redhat.com/#t
> >
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> These are usually printed as part of slab_bug() with its prominent banner. In
> that sense it's additional details, thus INFO. The details itself are not error,
> thus ERR makes little sense imho. How about removing the prefix completely, or
> just replacing with an ident to make it visually part of the BUG report.
>

Thanks for the explanation. I will remove the prefix completely in the
next version.

> > ---
> >  mm/slub.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 4b9ab267afbc..18b4474c8fa2 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -615,7 +615,7 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
> >       if (!t->addr)
> >               return;
> >
> > -     pr_err("INFO: %s in %pS age=%lu cpu=%u pid=%d\n",
> > +     pr_err("ERR: %s in %pS age=%lu cpu=%u pid=%d\n",
> >              s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
> >  #ifdef CONFIG_STACKTRACE
> >       {
> > @@ -641,7 +641,7 @@ void print_tracking(struct kmem_cache *s, void *object)
> >
> >  static void print_page_info(struct page *page)
> >  {
> > -     pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
> > +     pr_err("ERR: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
> >              page, page->objects, page->inuse, page->freelist,
> >              page->flags, &page->flags);
> >
> > @@ -698,7 +698,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
> >
> >       print_page_info(page);
> >
> > -     pr_err("INFO: Object 0x%p @offset=%tu fp=0x%p\n\n",
> > +     pr_err("ERR: Object 0x%p @offset=%tu fp=0x%p\n\n",
> >              p, p - addr, get_freepointer(s, p));
> >
> >       if (s->flags & SLAB_RED_ZONE)
> > @@ -791,7 +791,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
> >               end--;
> >
> >       slab_bug(s, "%s overwritten", what);
> > -     pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> > +     pr_err("ERR: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> >                                       fault, end - 1, fault - addr,
> >                                       fault[0], value);
> >       print_trailer(s, page, object);
> > @@ -3855,7 +3855,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
> >       for_each_object(p, s, addr, page->objects) {
> >
> >               if (!test_bit(__obj_to_index(s, addr, p), map)) {
> > -                     pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
> > +                     pr_err("ERR: Object 0x%p @offset=%tu\n", p, p - addr);
> >                       print_tracking(s, p);
> >               }
> >       }
> >
>


-- 
Thanks
Yafang
