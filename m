Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277F63B2588
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFXDlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFXDlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:41:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC69C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:38:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c8so4020000pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVWElybcMrVlFZEvuz6VJdeudyns0hLjfyTboPZWo+0=;
        b=XRQ1UFVyRFNZNGRsxtPwmHKKKv5wVxnp/XI3NVo6+vchT/UyHu1vFPPdzzRvokNxLG
         pCjAQiKw6T46dmvvTHBd8cxsHPCuqgqwJfobh3x2Pn3V5fFXaoGL3FQ6Q7gAuFqw4g/D
         tHyT7ekx+HlC45ZkTmEdTxQ2S3Edq+hEQKa9UcLtjGj3L+KCxpw65+LgJxdbeweD1qm6
         ifnbOVkD2rV7+2X6cAgdcI+I6Bkj7IlJq9EVMEO+4FG5Mdoed5DQgbQrs6bCi4ESqf8H
         vUmwxrhS9EZq8WNUv5DD/bdo05sOqgG1WYeVN3N0M8BcKyCwVFqU3NFHda/WpBRNWiet
         o+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVWElybcMrVlFZEvuz6VJdeudyns0hLjfyTboPZWo+0=;
        b=YheDlDHmmrFLur3qUjs6qr3LCJqK3AO/XkPn7YAkBEg4kmLZYiCaetCywFoKB4/Uzu
         MT8JSKcMPdkhL9jLNKnqaXOpkN7CPgb+Q+F+QN90xwVB/b+L72MkVRnFG24UDOfswR1J
         Dxnt2K7xLvz+arJ+GV6RjCz/JBJ4icR+goyMvhn9nHsQx+GDkcNd5SSdclQw3fWG+VzC
         2KaVhLL/hgHj5BIN/Daav9bmdlufKsAkJTanSsPzJkRMyt6FY8UBHbB/cPk0ZcT6wqAd
         ZAXVHXm0f9QWvcHu1ghHZDOkZmvsAskmfDwiDqlBRX+VnEAcQDdLtveBSq7881HUeD2q
         pylg==
X-Gm-Message-State: AOAM532ft79J4SVsTjKC/lHSoV20eG9Zw5PLZb1IrVJcycNnhmj3Gdsr
        eeOVE7xbytPA8q8pKJnzdjGrTDH2QH0nkOzKpgwHfw==
X-Google-Smtp-Source: ABdhPJzJxUPsffBJjpirJgEDkvON8ayGRvsw6/E7EbW0LiXCMufsP62kGOVQtTg+y/PExUadM49df9OguzL68DfgwiE=
X-Received: by 2002:a65:63ce:: with SMTP id n14mr2725499pgv.273.1624505925137;
 Wed, 23 Jun 2021 20:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210622021423.154662-1-mike.kravetz@oracle.com>
 <20210622021423.154662-3-mike.kravetz@oracle.com> <CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com>
 <39674952-44fc-8386-39b7-9e0862aaa991@oracle.com>
In-Reply-To: <39674952-44fc-8386-39b7-9e0862aaa991@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 24 Jun 2021 11:38:08 +0800
Message-ID: <CAMZfGtXQg__eDh39g0aXhvtD-91PkXJGeNFY_cJgC8X8q-11tA@mail.gmail.com>
Subject: Re: [External] [PATCH 2/2] hugetlb: address ref count racing in prep_compound_gigantic_page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 8:26 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Cc: Naoya
>
> On 6/23/21 1:00 AM, Muchun Song wrote:
> > On Tue, Jun 22, 2021 at 10:15 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> In [1], Jann Horn points out a possible race between
> >> prep_compound_gigantic_page and __page_cache_add_speculative.  The
> >> root cause of the possible race is prep_compound_gigantic_page
> >> uncondittionally setting the ref count of pages to zero.  It does this
> >> because prep_compound_gigantic_page is handed a 'group' of pages from an
> >> allocator and needs to convert that group of pages to a compound page.
> >> The ref count of each page in this 'group' is one as set by the
> >> allocator.  However, the ref count of compound page tail pages must be
> >> zero.
> >>
> >> The potential race comes about when ref counted pages are returned from
> >> the allocator.  When this happens, other mm code could also take a
> >> reference on the page.  __page_cache_add_speculative is one such
> >> example.  Therefore, prep_compound_gigantic_page can not just set the
> >> ref count of pages to zero as it does today.  Doing so would lose the
> >> reference taken by any other code.  This would lead to BUGs in code
> >> checking ref counts and could possibly even lead to memory corruption.
> >
> > Hi Mike,
> >
> > Well. It takes me some time to get the race. It also makes me think more
> > about this. See the below code snippet in gather_surplus_pages().
> >
> >         zeroed = put_page_testzero(page);
> >        VM_BUG_ON_PAGE(!zeroed, page);
> >         enqueue_huge_page(h, page);
> >
> > The VM_BUG_ON_PAGE() can be triggered because of the similar
> > race, right? IIUC, we also should fix this.
>
> Thanks for taking a look at this Muchun.
>
> I believe you are correct.  Page allocators (even buddy) will hand back
> a ref counted head page.  Any other code 'could' take a reference on the
> head page before the pages are made into a hugetlb page.  Once the pages
> becomes a hugetlb page (PageHuge() true), then only hugetlb specific
> code should be modifying the ref count.  So, it seems the 'race window'
> is from the time the pages are returned from a low level allocator until
> the time the pages become a hugetlb page.  Does that sound correct?

I have a question about this, why should the ref count of the hugetlb page
be managed by the hugetlb specific code? What if we broke this rule? If so,
we can fix this issue easily.

CPU0:                                   CPU1:
page = xas_load()
// the page is freed to the buddy
                                        page = alloc_surplus_huge_page()
                                        if (put_page_testzero(page))
                                                enqueue_huge_page(h, page)
page_cache_get_speculative(page)
if (unlikely(page != xas_reload(&xas)))
        // this can help us free the hugetlb page to pool
        put_page(page)

If someone gets the page successfully before we put the page in the
gather_surplus_pages, then it will help us add the hugetlb page
to the pool when it calls put_page().

>
> If we want to check for and handle such a race, we would need to do so
> in prep_new_huge_page.  After setting the descructor we would need to
> check for an increased ref count (> 1).  Not sure if we would need a
> memory barrier or some other type synchronization for this?  This of
> course means that prep_new_huge_page could return an error, and we would
> need to deal with that in all callers.

As described above, IIUC, we do not need to change the behavior
of prep_new_huge_page. We just need to change gather_surplus_pages
like below. Just my thoughts about this, maybe I am wrong.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c3b2a8a494d6..8a1a75534543 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2160,17 +2160,11 @@ static int gather_surplus_pages(struct hstate
*h, long delta)

        /* Free the needed pages to the hugetlb pool */
        list_for_each_entry_safe(page, tmp, &surplus_list, lru) {
-               int zeroed;
-
                if ((--needed) < 0)
                        break;
-               /*
-                * This page is now managed by the hugetlb allocator and has
-                * no users -- drop the buddy allocator's reference.
-                */
-               zeroed = put_page_testzero(page);
-               VM_BUG_ON_PAGE(!zeroed, page);
-               enqueue_huge_page(h, page);
+
+               if (put_page_testzero(page))
+                       enqueue_huge_page(h, page);
        }
 free:
        spin_unlock_irq(&hugetlb_lock);


>
> I went back and looked at those lines in gather_surplus_pages
>
>                 zeroed = put_page_testzero(page);
>                 VM_BUG_ON_PAGE(!zeroed, page);
>                 enqueue_huge_page(h, page);
>
> They were first added as part of alloc_buddy_huge_page with commit
> 2668db9111bb - hugetlb: correct page count for surplus huge pages.
> It appears the reason for the VM_BUG_ON is because prior hugetlb code
> forgot to account for the ref count provided by the buddy allocator.
> The VM_BUG_ON may have been added mostly as a sanity check for hugetlb
> ref count management.
>
> I wonder if we have ever hit that VM_BUG_ON in the 13 years it has been
> in the code?  I know you recently spotted the potential race with memory
> error handling and Naoya fixed up the memory error code.
>
> I'm OK with modifying prep_new_huge_page, but it is going to be a bit
> messy (like this patch).  I wonder if there are other less intrusive
> ways to address this potential issue?
> --
> Mike Kravetz
