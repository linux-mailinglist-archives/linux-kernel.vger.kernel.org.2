Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989534F6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhCaCoI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Mar 2021 22:44:08 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:18398 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhCaCn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:43:57 -0400
X-AuditID: 0a580157-2cfff7000006b36a-db-6063e1e84d7d
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 6E.51.45930.8E1E3606; Wed, 31 Mar 2021 10:43:52 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 31 Mar
 2021 10:43:52 +0800
Date:   Wed, 31 Mar 2021 10:43:36 +0800
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
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
Message-ID: <20210331104303.145aea53@alex-virtual-machine>
In-Reply-To: <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
References: <20210317163714.328a038d@alex-virtual-machine>
        <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
        <20210318044600.GJ3420@casper.infradead.org>
        <20210318133412.12078eb7@alex-virtual-machine>
        <20210319104437.6f30e80d@alex-virtual-machine>
        <20210320003516.GC3420@casper.infradead.org>
        <20210322193318.377c9ce9@alex-virtual-machine>
        <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
        <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
        <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXCFcHor/viYXKCwZW96hZz1q9hs/i6/hez
        xeVdc9gs7q35z2rxcX+wxcXGA4wWZ6YVWfz+MYfNgcNj8wotj02fJrF7nJjxm8XjxdWNLB4f
        n95i8Xi/7yqbx+bT1R6fN8kFcERx2aSk5mSWpRbp2yVwZZz4cpW1YJJyxazLRxkbGG9KdzFy
        ckgImEhc3LCcsYuRi0NIYDqTRMPCZVDOK0aJ58/OMINUsQioSjxY38oEYrMB2bvuzWIFsUUE
        kiQWz/7KBNLALHCYWeLd/cPsIAlhAQ+JIytOgNm8AlYSfw4+BWvgFHCUWNPczgSx4R+zxMHX
        ixlBEvwCYhK9V/4zQdxkL9G2ZREjRLOgxMmZT1hAbGYBTYnW7b/ZIWxtiWULX4NdJySgKHF4
        yS92iF4liSPdM9gg7FiJpgO32CYwCs9CMmoWklGzkIxawMi8ipGlODfdcBMjJGLCdzDOa/qo
        d4iRiYPxEKMEB7OSCK/wgcQEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry8D5MShATSE0tSs1NT
        C1KLYLJMHJxSDUzrDrGrhe12+fVV/1mES0abtaVAldaksoXpkTuUDPkXKKVw/jyownAgOfdg
        X+2Kje/vaOZGy/2eOeXM/RVl5oncEtNOTtmkeUo/7xNL+/JNfhJu/K7/2nov1ZtcWhKd9fVC
        7I8aQx+tQpWoD9sPdh+bMeP+ky0JejvXREw833XQksP9xDbptNMvTq/JiXTnOvDlIXP2P8m2
        DSIqh+P6Zb/2Muf7L4mU43Xt2Wi1bYKnSLPJusJ1at8ZfRpqJYQ3K+dHKj7jldWseZGZlGIX
        wX09la1ia596VucV0X6NxNv6ZYVrQ4o7My7weHRU5a/7Ibrh96XNAuxcWdePNz1SVJpS/mPC
        NN+Fm9SfKwqlK7EUZyQaajEXFScCAMnRq1QHAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 01:52:59 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Fri, Mar 26, 2021 at 03:22:49PM +0100, David Hildenbrand wrote:
> > On 26.03.21 15:09, David Hildenbrand wrote:  
> > > On 22.03.21 12:33, Aili Yao wrote:  
> > > > When we do coredump for user process signal, this may be one SIGBUS signal
> > > > with BUS_MCEERR_AR or BUS_MCEERR_AO code, which means this signal is
> > > > resulted from ECC memory fail like SRAR or SRAO, we expect the memory
> > > > recovery work is finished correctly, then the get_dump_page() will not
> > > > return the error page as its process pte is set invalid by
> > > > memory_failure().
> > > > 
> > > > But memory_failure() may fail, and the process's related pte may not be
> > > > correctly set invalid, for current code, we will return the poison page,
> > > > get it dumped, and then lead to system panic as its in kernel code.
> > > > 
> > > > So check the hwpoison status in get_dump_page(), and if TRUE, return NULL.
> > > > 
> > > > There maybe other scenario that is also better to check hwposion status
> > > > and not to panic, so make a wrapper for this check, Thanks to David's
> > > > suggestion(<david@redhat.com>).
> > > > 
> > > > Link: https://lkml.kernel.org/r/20210319104437.6f30e80d@alex-virtual-machine
> > > > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> > > > Cc: David Hildenbrand <david@redhat.com>
> > > > Cc: Matthew Wilcox <willy@infradead.org>
> > > > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > > Cc: Oscar Salvador <osalvador@suse.de>
> > > > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > > > Cc: Aili Yao <yaoaili@kingsoft.com>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > ---
> > > >    mm/gup.c      |  4 ++++
> > > >    mm/internal.h | 20 ++++++++++++++++++++
> > > >    2 files changed, 24 insertions(+)
> > > > 
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index e4c224c..6f7e1aa 100644
> > > > --- a/mm/gup.c
> > > > +++ b/mm/gup.c
> > > > @@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
> > > >    				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
> > > >    	if (locked)
> > > >    		mmap_read_unlock(mm);  
> > > 
> > > Thinking again, wouldn't we get -EFAULT from __get_user_pages_locked()
> > > when stumbling over a hwpoisoned page?
> > > 
> > > See __get_user_pages_locked()->__get_user_pages()->faultin_page():
> > > 
> > > handle_mm_fault()->vm_fault_to_errno(), which translates
> > > VM_FAULT_HWPOISON to -EFAULT, unless FOLL_HWPOISON is set (-> -EHWPOISON)
> > > 
> > > ?  
> 
> We could get -EFAULT, but sometimes not (depends on how memory_failure() fails).
> 
> If we failed to unmap, the page table is not converted to hwpoison entry,
> so __get_user_pages_locked() get the hwpoisoned page.
> 
> If we successfully unmapped but failed in truncate_error_page() for example,
> the processes mapping the page would get -EFAULT as expected.  But even in
> this case, other processes could reach the error page via page cache and
> __get_user_pages_locked() for them could return the hwpoisoned page.
> 
> > 
> > Or doesn't that happen as you describe "But memory_failure() may fail, and
> > the process's related pte may not be correctly set invalid" -- but why does
> > that happen?  
> 
> Simply because memory_failure() doesn't handle some page types like ksm page
> and zero page. Or maybe shmem thp also belongs to this class.
> 
> > 
> > On a similar thought, should get_user_pages() never return a page that has
> > HWPoison set? E.g., check also for existing PTEs if the page is hwpoisoned?  
> 
> Make sense to me. Maybe inserting hwpoison check into follow_page_pte() and
> follow_huge_pmd() would work well.

I think we should take more care to broadcast the hwpoison check to other cases,
SIGBUS coredump is such a case that it is supposed to not touch the poison page, 
and if we return NULL for this, the coredump process will get a successful finish.

Other cases may also meet the requirements like coredump, but we need to identify it,
that's the poison check wrapper's purpose. If not, we may break the integrity of the
related action, which may be no better than panic.

-- 
Thanks!
Aili Yao
