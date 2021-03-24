Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2CD346E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhCXBQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhCXBQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:16:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C9C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:16:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b7so30174088ejv.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmZtlOkzXKW+6Uymw8Z89AWwFd+oGjy+eP5xv5XjORQ=;
        b=jEZFAO6PtEX45puN+a6V92NL3n6JxqQ68ZVmiZ595EgF3s7VxmKYxN/ehbcb/Ap9Uw
         EsFnNdRsCPNW8kYTcmq5oTHWKW5kOEnEQULsmHpa/oc0QumzpRSmz4ll4FbAzUqI84RL
         Zu1UDyjg5QlIpR2hTOBdUFXDzaFr3MhaGBWoiyUfjb+P1aKZeZxN+CNYqb3AVQRskTPr
         Cn8bCmSg/Jc4AK5mt/ZIHBbTmDyPxOv4wfJAdFIUyBQRq+GJFErWR3O2tDLjZjJ5zfEo
         BDG0Y0FoXiBZAy3UT8QTkstQW7COTJzd9QYzk5e/t5vpRqoRXZWeOXwT7l1q0OoJPM+L
         08Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmZtlOkzXKW+6Uymw8Z89AWwFd+oGjy+eP5xv5XjORQ=;
        b=cCbjq+drJsbjhxDFn11MiBVa3gKKfB6URJAd6QynaNx3QuIjv26w6lQA4rmsVJHEX6
         FMMGIqe7kVwmj4hfBoF6i1jJXtjM5baJnC2VDgYHIDDuo+LdQuUrPNvdlejXt2s9ySKs
         23ongIZTohE+lhlOjCNudldmdUltND5xPxdJkKg7mqIOh0PFEEURYvFlGo+9to88+bCL
         cWvdoRlJFytJo52zF2mLwlSPvpcGR1un3f/2ndIeNZDZmBZKSCKahyradM9r3wlJ2faf
         uVUnivatIwsRV6ab6Ju0HhCQfXUBYzpJwisp1WrG7dvsrIpzHAtEF6VhVIPXxrEomNT8
         8LXA==
X-Gm-Message-State: AOAM530HtvTtM6824Rk/Ifpl2qktNZwWycC5Y/fHH73PVws0dZOPwAb/
        rEbocfufUBHhTvbJAHKtZzLU7ilJ5MsEOL1SvVc=
X-Google-Smtp-Source: ABdhPJzPlT93p22g0xEGPzonusBjb1xcTgpziEnVjBCeHKb30p1gDkf5S4cljaPUYc4jyqF75YlZken7f67/QV7OCI4=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr990221ejb.238.1616548582221;
 Tue, 23 Mar 2021 18:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210323135405.65059-1-linmiaohe@huawei.com> <20210323135405.65059-6-linmiaohe@huawei.com>
 <CAHbLzkoSsPWSdyZQBR03NbU8i3AG_DTL4P-efYULvuYmWzyYbg@mail.gmail.com>
In-Reply-To: <CAHbLzkoSsPWSdyZQBR03NbU8i3AG_DTL4P-efYULvuYmWzyYbg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 23 Mar 2021 18:16:10 -0700
Message-ID: <CAHbLzko11ygmDp3pRry8meo3PhdXwro1rid-aBomC=0+rm3u6Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm/migrate.c: fix potential deadlock in NUMA
 balancing shared exec THP case
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:17 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Mar 23, 2021 at 6:55 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >
> > Since commit c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA
> > balancing"), the NUMA balancing would skip shared exec transhuge page.
> > But this enhancement is not suitable for transhuge page. Because it's
> > required that page_mapcount() must be 1 due to no migration pte dance
> > is done here. On the other hand, the shared exec transhuge page will
> > leave the migrate_misplaced_page() with pte entry untouched and page
> > locked. Thus pagefault for NUMA will be triggered again and deadlock
> > occurs when we start waiting for the page lock held by ourselves.
>
> Thanks for catching this. By relooking the code I think the other
> important reason for removing this is
> migrate_misplaced_transhuge_page() actually can't see shared exec file
> THP at all since page_lock_anon_vma_read() is called before and if
> page is not anonymous page it will just restore the PMD without
> migrating anything.
>
> The pages for private mapped file vma may be anonymous pages due to
> COW but they can't be THP so it won't trigger THP numa fault at all. I
> think this is why no bug was reported. I overlooked this in the first
> place.
>
> Your fix is correct, and please add the above justification to your commit log.

BTW, I think you can just undo or revert commit c77c5cbafe54 ("mm:
migrate: skip shared exec THP for NUMA balancing").

Thanks,
Yang

>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
>
> >
> > Fixes: c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA balancing")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/migrate.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 5357a8527ca2..68bfa1625898 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2192,9 +2192,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
> >         int page_lru = page_is_file_lru(page);
> >         unsigned long start = address & HPAGE_PMD_MASK;
> >
> > -       if (is_shared_exec_page(vma, page))
> > -               goto out;
> > -
> >         new_page = alloc_pages_node(node,
> >                 (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
> >                 HPAGE_PMD_ORDER);
> > @@ -2306,7 +2303,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
> >
> >  out_unlock:
> >         unlock_page(page);
> > -out:
> >         put_page(page);
> >         return 0;
> >  }
> > --
> > 2.19.1
> >
