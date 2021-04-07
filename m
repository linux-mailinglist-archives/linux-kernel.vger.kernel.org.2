Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE23565C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346902AbhDGHso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Apr 2021 03:48:44 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:20259 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346805AbhDGHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:48:43 -0400
X-AuditID: 0a580155-b7dff7000000169b-51-606d63d06f33
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id F8.13.05787.0D36D606; Wed,  7 Apr 2021 15:48:32 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 7 Apr 2021
 15:48:31 +0800
Date:   Wed, 7 Apr 2021 15:48:31 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v7] mm/gup: check page hwpoison status for memory
 recovery failures.
Message-ID: <20210407154831.66524e0a@alex-virtual-machine>
In-Reply-To: <20210407015428.GA26707@hori.linux.bs1.fc.nec.co.jp>
References: <20210320003516.GC3420@casper.infradead.org>
        <20210322193318.377c9ce9@alex-virtual-machine>
        <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
        <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
        <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
        <20210331104303.145aea53@alex-virtual-machine>
        <20210331043231.GA26013@hori.linux.bs1.fc.nec.co.jp>
        <9f49c415-a75a-1ea3-b80c-5ba512331de6@redhat.com>
        <20210406102346.3890ceb2@alex-virtual-machine>
        <20210406104123.451ee3c3@alex-virtual-machine>
        <20210407015428.GA26707@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXCFcHor3shOTfBYM8uZos569ewWXxd/4vZ
        4vKuOWwW99b8Z7X4uD/Y4mLjAUaLM9OKLH7/mMPmwOGxeYWWx6ZPk9g9Tsz4zeLx4upGFo+P
        T2+xeLzfd5XNY/Ppao/Pm+QCOKK4bFJSczLLUov07RK4MrYc3sda8FKt4v6xl+wNjEfluhg5
        OSQETCQe/OpkA7GFBKYzSbTes+xi5AKyXzJKrF66kBkkwSKgItF8YgmYzSagKrHr3ixWEFtE
        IEli8eyvTCANzAKHmSXe3T/MDpIQFoiS+NXbxdLFyMHBK2Alcf+nGkiYU8BR4sW008wQC/ay
        SMyaNwtsKL+AmETvlf9MEBfZS7RtWcQIYvMKCEqcnPmEBcRmFtCUaN3+mx3C1pZYtvA1M8TV
        ihKHl/xih+hVkjjSPYMNwo6VaDpwi20Co/AsJKNmIRk1C8moBYzMqxhZinPTjTYxQqIldAfj
        jKaPeocYmTgYDzFKcDArifDu6M1OEOJNSaysSi3Kjy8qzUktPsQozcGiJM4rp5qbICSQnliS
        mp2aWpBaBJNl4uCUamDqDLh9z2BKk4OyVOezrLJv184XpN9YLaO5ympb9ZKz0zmEeJ67fy1b
        /NT+ldplc3mrTauOb35+qKbF0+nWroO+3PMY9SQ5G1NWpJfNP/E3Y0LV7Lvh1rWh+jc/fQq8
        l9LLvyjPv/zNwbzOLj7/k29XZrTO2MnZfGDlzCf1yzaXe0a+iO//F+7L9Pq5zz+3y1ecI+6f
        sHdcvp919kEe2ayY+vWpSlpSK4/yX1to/WQy1+XqNbP6d0zcJSnqtFNcI2Vj55QT+cKh8p08
        y7qSVwQYBtz96TL1kOiS/MlLN1rK9nnEXHA6dj6k8vr5D+nT1+99VfQ+Xm2S/a9FjB8Ufi8R
        eCp/SeRr9fV3eZozS7dNUmIpzkg01GIuKk4EADA6OqgFAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 01:54:28 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Tue, Apr 06, 2021 at 10:41:23AM +0800, Aili Yao wrote:
> > When we call get_user_pages() to pin user page in memory, there may be
> > hwpoison page, currently, we just handle the normal case that memory
> > recovery jod is correctly finished, and we will not return the hwpoison
> > page to callers, but for other cases like memory recovery fails and the
> > user process related pte is not correctly set invalid, we will still
> > return the hwpoison page, and may touch it and lead to panic.
> > 
> > In gup.c, for normal page, after we call follow_page_mask(), we will
> > return the related page pointer; or like another hwpoison case with pte
> > invalid, it will return NULL. For NULL, we will handle it in if (!page)
> > branch. In this patch, we will filter out the hwpoison page in
> > follow_page_mask() and return error code for recovery failure cases.
> > 
> > We will check the page hwpoison status as soon as possible and avoid doing
> > followed normal procedure and try not to grab related pages.
> > 
> > Changes since v6:
> > - Fix wrong page pointer check in follow_trans_huge_pmd();
> > 
> > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/gup.c         | 27 +++++++++++++++++++++++----
> >  mm/huge_memory.c | 11 ++++++++---
> >  mm/hugetlb.c     |  8 +++++++-
> >  mm/internal.h    | 13 +++++++++++++
> >  4 files changed, 51 insertions(+), 8 deletions(-)  
> 
> Thank you for the work.
> 
> Looking through this patch, the internal of follow_page_mask() is
> very complicated so it's not easy to make this hwpoison-aware.
> Now I'm getting unsure to judge that this is the best approach.
> What actually I imagined might be like below (which is totally
> untested, and I'm sorry about my previous misleading comments):
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e40579624f10..a60a08fc7668 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1090,6 +1090,11 @@ static long __get_user_pages(struct mm_struct *mm,
>  		} else if (IS_ERR(page)) {
>  			ret = PTR_ERR(page);
>  			goto out;
> +		} else if (gup_flags & FOLL_HWPOISON && PageHWPoison(page)) {
> +			if (gup_flags & FOLL_GET)
> +				put_page(page);
> +			ret = -EHWPOISON;
> +			goto out;
>  		}
>  		if (pages) {
>  			pages[i] = page;
> @@ -1532,7 +1537,7 @@ struct page *get_dump_page(unsigned long addr)
>  	if (mmap_read_lock_killable(mm))
>  		return NULL;
>  	ret = __get_user_pages_locked(mm, addr, 1, &page, NULL, &locked,
> -				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
> +				      FOLL_FORCE | FOLL_DUMP | FOLL_GET | FOLL_HWPOISON);
>  	if (locked)
>  		mmap_read_unlock(mm);
>  	return (ret == 1) ? page : NULL;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a86a58ef132d..03c3d3225c0d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4949,6 +4949,14 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			continue;
>  		}
>  
> +		if (flags & FOLL_HWPOISON && PageHWPoison(page)) {
> +			vaddr += huge_page_size(h);
> +			remainder -= pages_per_huge_page(h);
> +			i += pages_per_huge_page(h);
> +			spin_unlock(ptl);
> +			continue;
> +		}
> +
>  		refs = min3(pages_per_huge_page(h) - pfn_offset,
>  			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
>  
> 
> We can surely say that this change only affects get_user_pages() callers
> with FOLL_HWPOISON set, so this should pinpoint the current problem only.
> A side note is that the above change on follow_hugetlb_page() has a room of
> refactoring to reduce duplicated code.
> 
> Could you try to test and complete it?

Got it, I will try to complete it and test it.

For the code:

long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			continue;
>  		}
>  
> +		if (flags & FOLL_HWPOISON && PageHWPoison(page)) {
> +			vaddr += huge_page_size(h);
> +			remainder -= pages_per_huge_page(h);
> +			i += pages_per_huge_page(h);
> +			spin_unlock(ptl);
> +			continue;
> +		}
> +

I am wondering if we still need to continue the loop in follow_hugetlb_page()?  This function
seems mainly for prerparation of vmas and grab the hugepage, if we meet one hwpoison hugetlb page,
we will check it after follow_page_mask() return, then we will quit the total loop
and the num of page or error code will be returned, and the vmas after the hwpoison one will
not be needed?

-- 
Thanks!
Aili Yao
