Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17143B9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhJZSxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhJZSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:53:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2809C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:50:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j2so882384lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BP4NAe7ddaJVYhsIxokjyZQ5JW8fdTP3tJwi3u/Bta8=;
        b=OT/TeaF5L09lQEvDVMETii9ZF1FekcmI9FniessxiwaCY0/2c1/fU9X5X2m68fW9/U
         qzQVQDMGq77TMKFFikymTD2XE2u05CbKQGlQpbNI/BWvyvPveGGs3ngxEM5n2QOBeTHl
         mwF0G1HhAq6spGex+GCN3LXQEQ6VP23pvpQmFaEr/rN1tsQZ8Yqi/dZx6ZCN+kUbjYIx
         vEXsauZp23Pe2R112F8jObaUOfG3GygDQTUzRtanX4RtuwliVgXLR1IntFRHfOlF1pUk
         9dWQEtfBQTmHBrfKOPbY+vAeLSCf02bKk8pvLZk56yE4XTzHWKfi2qJK9H0uCUmhkA5i
         Zkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BP4NAe7ddaJVYhsIxokjyZQ5JW8fdTP3tJwi3u/Bta8=;
        b=Y/mhUzTXspa+PlWhB8GCkfYOG3hrsMzE9pCrWgAUf6QCPMb0YeFZMyiwAgsczvzMPh
         JoeM4Xx6X7Fvj6WLI4Thgnd0CqEyVhxPSrs4dJD9xGpJBCvTP7TZ/sDgERCz2dtJNZAT
         ldoayU/hfkvx11pEERkjy/xhBsNlno2nVX2+A9NHgmQxjSExYDaqS1WAFxCedtFCXhwh
         NxQ2EV/SzJlmtc5WyKkWCS2rtYrQynfka+8XuRHGFSScEbl5gE91lwThvrqz+Mm0/6Ez
         XUIQDA2LKz20fX6d8+bbBiNn05QNyzoVvx6smy/SrUpqq2/q1xlFxBn7Er62f16ruXYu
         D94Q==
X-Gm-Message-State: AOAM533bdMGvrw1wbsXaVhR6p3qhp8NUm5SPTrKlSV3cEtS9gE70n0+w
        IXg1dpOrv8hGxzOLJwvkKIaHfmt9cMy8Xi23gHSBMg==
X-Google-Smtp-Source: ABdhPJzK4Dha/q6HSrHHxcz81bIchY+vvTwR3f0p68xpNbHqCeDhn3qKld2X233U664gN+hNMB3NXO/CSZIYQpq8xAo=
X-Received: by 2002:ac2:59cc:: with SMTP id x12mr7735816lfn.501.1635274243249;
 Tue, 26 Oct 2021 11:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-3-pasha.tatashin@soleen.com> <57fbf167-b2e8-69f6-7f79-8e989162c889@oracle.com>
In-Reply-To: <57fbf167-b2e8-69f6-7f79-8e989162c889@oracle.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Oct 2021 14:50:06 -0400
Message-ID: <CA+CK2bBuU5_8PrT8zd-bAJ-zJW29+9MncnBMAyoJ+JwDHp=WyQ@mail.gmail.com>
Subject: Re: [RFC 2/8] mm/hugetlb: remove useless set_page_count()
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com, Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        weixugc@google.com, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 2:45 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/26/21 10:38 AM, Pasha Tatashin wrote:
> > prep_compound_gigantic_page() calls set_page_count(0, p), but it is not
> > needed because page_ref_freeze(p, 1) already sets refcount to 0.
> >
> > Using, set_page_count() is dangerous, because it unconditionally resets
> > refcount from the current value to unrestrained value, and therefore
> > should be minimized.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Thanks!
>
> My bad for not removing the set_page_count when adding the page_ref_freeze.
>
> FYI, there have been additional changes to this routine in Andrew's
> tree.  Not really sure if we want/need the VM_BUG_ON_PAGE as that would
> only check if there was a 'bug' in page_ref_freeze.

I would like to keep it. Part of the idea of this series is to reduce
reliance on comments such as:

/* No worries, refcount is A therefore we can do B */

And instead enforce that via VM_BUG_ON().  It should be able to
prevent existing and future _refcount related bugs from manifesting as
memory corruptions.

Pasha

>
> --
> Mike Kravetz
>
> > ---
> >  mm/hugetlb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 95dc7b83381f..7e3996c8b696 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1707,7 +1707,7 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
> >                       pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
> >                       goto out_error;
> >               }
> > -             set_page_count(p, 0);
> > +             VM_BUG_ON_PAGE(page_count(p), p);
> >               set_compound_head(p, page);
> >       }
> >       atomic_set(compound_mapcount_ptr(page), -1);
> >
