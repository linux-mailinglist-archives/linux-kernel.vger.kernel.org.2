Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92B39E944
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhFGWF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:05:57 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45801 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGWFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:05:55 -0400
Received: by mail-ed1-f49.google.com with SMTP id r7so7794185edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOe4rQFtxBwGRN1K+AKPaoefxAAn3spLFX1ByOSM/mo=;
        b=itxlC5css5jLtTv9vn/LKgdTnt3i7NlF7vkViO9R2VSHBPx/qO5ad3w5XDOvR7Yhcq
         c7tzrMxpd0a9Xv6z0XTJonyS9y6OLDoocibZ8SZin3Q+x3CRqJKd/aOG+aRxXzKEKWdm
         TzP1Ly/35YzQrgXu5p/VfVetTEsYA++PSeF4K4e4fQG1vIzXGZseUgUT9BhAvJtgAAin
         /0yRw1WVQgtOI2Sqfu2pOgkTjLPmLvpjd5/32CpOW9s4kyPNUyPqd/BaG7A8qJ6jTSvL
         cN6PZk9rmCg/OjVoQhNQJi46gOiSIA+HUeotHA6mr0JT2/euSqavkM3G1Wh1d1EVyIEg
         atAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOe4rQFtxBwGRN1K+AKPaoefxAAn3spLFX1ByOSM/mo=;
        b=sIY2wlxhnXJKUIKreNKCaIGpGlh85bgKZlB5uORoBRjZ1zBD5Gr2l60Atqpyqc6RGP
         pGGqyL05fZp/awe0oAK6HeVMXd1UPXoeXcOWuIBhrkK0tqErFUqofEISHUtNTrGCvVRr
         jbyXqkwBaJVS9PUjdbkufXRZhD9MuS6ScwBLX1zuGJ0TetdKMANNsEBjfkama3mwTNVy
         SHsQ2jnArO2W2rreRYklKN+8MHa8qKo0a9aIcUWUxRGyl/B2YN6yjFtptEIF4LlIuZmB
         Udsv9L9hpAfg3WEAXmhf4hG2z0mhtCs1N1NgDVofkAxtYDbDP8DEc3cd0108+iCGH6rL
         19vA==
X-Gm-Message-State: AOAM531kqUA4eNjdKSjsNLSUPSiU5IOmg87aUKaV3oWu3EZn1WcCmLCJ
        D/3wJ0NUlXp35UqlI2h0QwCjIXLZXqzJQ6wyig+cR5BMmatssQ==
X-Google-Smtp-Source: ABdhPJx8Fxb9YF2ZLWBL0PAME1svLwLI3W+xko1ynG08vhVviDgvl2PG57GJXgJUskKdMp7ZUOND6Z1wUj6DxBccbMM=
X-Received: by 2002:aa7:cf0f:: with SMTP id a15mr19806266edy.313.1623103371320;
 Mon, 07 Jun 2021 15:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210604203513.240709-1-shy828301@gmail.com> <YL265A86DQe5Rgon@dhcp22.suse.cz>
 <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com> <YL5rvdzh9dou+uAz@dhcp22.suse.cz>
In-Reply-To: <YL5rvdzh9dou+uAz@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Jun 2021 15:02:39 -0700
Message-ID: <CAHbLzkooYAi=Hb0=oJ+2b6G=h5Sx4jnyo5L0nPYjDcBqBHnfug@mail.gmail.com>
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, nao.horiguchi@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 07-06-21 10:00:01, Yang Shi wrote:
> > On Sun, Jun 6, 2021 at 11:21 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 04-06-21 13:35:13, Yang Shi wrote:
> > > > When trying to migrate pages to obey mempolicy, the huge zero page is
> > > > split then the page table walk at PTE level just skips zero page.  So it
> > > > seems pointless to split huge zero page, it could be just skipped like
> > > > base zero page.
> > >
> > > My THP knowledge is not the best but this is incorrect AIACS. Huge zero
> > > page is not split. We do split the pmd which is mapping the said page. I
> > > suspect you refer to vm_normal_page when talking about a zero page but
> > > please be aware that huge zero page is not a normal zero page. It is
> > > allocated dynamically (see get_huge_zero_page).
> >
> > For a normal huge page, yes, split_huge_pmd() just splits pmd. But
> > actually the base zero pfn will be inserted to PTEs when splitting
> > huge zero pmd. Please check __split_huge_zero_page_pmd() out.
>
> My bad. I didn't have a look all the way down there. The naming
> suggested that this is purely page table operations and I have suspected
> that ptes just point to the offset of the THP.
>
> But I am obviously wrong here. Sorry about that.
>
> > I should make this point clearer in the commit log. Sorry for the confusion.
> >
> > >
> > > So in the end you patch disables mbind of zero pages to a target node
> > > and that is a regression.
> >
> > Do we really migrate zero page? IIUC zero page is just skipped by
> > vm_normal_page() check in queue_pages_pte_range(), isn't it?
>
> Yeah, normal zero pages are skipped indeed. I haven't studied why this
> is the case yet. It surely sounds a bit suspicious because this is an
> explicit request to migrate memory and if the zero page is misplaced it
> should be moved. On the hand this would increase RSS so maybe this is
> the point.

The zero page is a global shared page, I don't think "misplace"
applies to it. It doesn't make too much sense to migrate a shared
page. Actually there is page mapcount check in migrate_page_add() to
skip shared normal pages as well.

>
> > > Have you tested the patch?
> >
> > No, just build test. I thought this change was straightforward.
> >
> > >
> > > > Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
> > > > this case.
> > >
> > > Btw. this changelog is missing a problem statement. I suspect there is
> > > no actual problem that it should fix and it is likely driven by reading
> > > the code. Right?
> >
> > The actual problem is it is pointless to split a huge zero pmd. Yes,
> > it is driven by visual inspection.
>
> Is there any actual workload that cares? This is quite a subtle area so
> I would be careful to do changes just because...

I'm not sure whether there is measurable improvement for actual
workloads, but I believe this change does eliminate some unnecessary
work.

I think the test shown in the previous email gives us some confidence
that the change doesn't have regression.

> --
> Michal Hocko
> SUSE Labs
