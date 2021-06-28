Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9D43B5B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhF1Ja1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:30:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:9282 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhF1JaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:30:25 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GD2FZ26kZz1BSb5;
        Mon, 28 Jun 2021 17:22:42 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 17:27:59 +0800
Received: from huawei.com (10.174.179.206) by dggema753-chm.china.huawei.com
 (10.1.198.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 28
 Jun 2021 17:27:58 +0800
From:   Bin Wang <wangbin224@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <naoya.horiguchi@nec.com>,
        <wuxu.wu@huawei.com>
Subject: Re: Re: [PATCH v2] mm: hugetlb: add hwcrp_hugepages to record memory failure on hugetlbfs
Date:   Mon, 28 Jun 2021 17:27:52 +0800
Message-ID: <20210628092752.2135-1-wangbin224@huawei.com>
X-Mailer: git-send-email 2.29.2.windows.3
In-Reply-To: <c38e54ea-6aae-addf-0d6b-140b097a346b@oracle.com>
References: <c38e54ea-6aae-addf-0d6b-140b097a346b@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.206]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 926eeb9bf4eb..ffb6e7b6756b 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -986,8 +986,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
> >  	pgoff_t index = page->index;
> >  
> >  	remove_huge_page(page);
> > -	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
> > -		hugetlb_fix_reserve_counts(inode);
> 
> As mentioned, huge page reserve counts are not used to record number of
> poisioned pages.  The calls to hugetlb_unreserve_pages and possibly
> hugetlb_fix_reserve_counts are necessary for reserve accounting.  They
> can not be removed.

Thanks for your explanation very much. I didn't get the point of the
comments from the first patch. hugetlb_fix_reserve_counts() shouldn't
be removed and I will fix this.

> > +	hugetlb_fix_hwcrp_counts(page);
> 
> This new routine just counts memory errors on 'in use' huge pages.
> I do not see a call anywhere to count memory errors on huge pages
> not in use.

It's my oversight. I should have considered this situation. I tested
it with hwcrp_hugepages count, and this is the result:
# cat /proc/meminfo |grep -E 'HugePages_|Hard'
HardwareCorrupted:     0 kB
HugePages_Total:      64
HugePages_Free:       64
HugePages_Rsvd:        0
HugePages_Surp:        0
HugePages_Hwcrp:       0
No count changes, even the HardwareCorrupted. I'm not sure if this is
normal. This is what happens in kernel(stable master branch):
static int memory_failure_hugetlb(unsigned long pfn, int flags)
{
	...
	/* TestSetPageHWPoison return 0 */
	if (TestSetPageHWPoison(head)) {
		...
	}

	num_poisoned_pages_inc(); /* HardwareCorrupted += PAGE_SIZE */

	/* get_hwpoison_page() return 0 */
	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p, flags, 0)) {
		/*
		 * Check "filter hit" and "race with other subpage."
		 */
		lock_page(head);
		/* PageHWPoison() return 1 */
		if (PageHWPoison(head)) {
			/* (p != head && TestSetPageHWPoison(head)) is hit */
			if ((hwpoison_filter(p) && TestClearPageHWPoison(p))
			    || (p != head && TestSetPageHWPoison(head))) {
				/* HardwareCorrupted -= PAGE_SIZE */
				num_poisoned_pages_dec();
				unlock_page(head);
				return 0;
			}
		}
		...
	}
	...
}
It seems like that memory errors on huge pages not in use hit the
"race with other subpage". I think I shouldn't add hwcrp_hugepages in
this routine. Maybe we need more conditions to distinguish this.

> >  
> >  	return 0;
> >  }
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index f7ca1a3870ea..1d5bada80aa5 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -171,6 +171,7 @@ void putback_active_hugepage(struct page *page);
> >  void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
> >  void free_huge_page(struct page *page);
> >  void hugetlb_fix_reserve_counts(struct inode *inode);
> > +void hugetlb_fix_hwcrp_counts(struct page *page);
> >  extern struct mutex *hugetlb_fault_mutex_table;
> >  u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
> >  
> > @@ -602,12 +603,14 @@ struct hstate {
> >  	unsigned long free_huge_pages;
> >  	unsigned long resv_huge_pages;
> >  	unsigned long surplus_huge_pages;
> > +	unsigned long hwcrp_huge_pages;
> >  	unsigned long nr_overcommit_huge_pages;
> >  	struct list_head hugepage_activelist;
> >  	struct list_head hugepage_freelists[MAX_NUMNODES];
> >  	unsigned int nr_huge_pages_node[MAX_NUMNODES];
> >  	unsigned int free_huge_pages_node[MAX_NUMNODES];
> >  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> > +	unsigned int hwcrp_huge_pages_node[MAX_NUMNODES];
> 
> I understand your requirement to count the number of memory errors on
> hugetlb pages.  However, we need to think carefully about we represent
> that count.
> 
> Noaya, do you have opinions on where would be the best place to store
> this information?  The hugetlb memory error code has the comment 'needs
> work'.  Ideally, we could isolate memory errors to a single base (4K for
> x86) page and free the remaining base pages to buddy.  We could also
> potentially allocate a 'replacement' hugetlb page doing something like
> alloc_and_dissolve_huge_page.
> 
> If we get an error on a hugetlb page and can isolate it to a base page
> and replace the huge page, is it still a huge page memory error?
> 
> IMO, we should work on isolating memory errors to a base page and
> replacing the huge page.  Then, the existing count of base pages with
> memory errors would be sufficient?
> 
> This is something I would like to work, but I have higher priorities
> right now.

Yes, splitting the huge pages and isolating a base page is ideal. And
we do this with dissolve_free_huge_page() when page_mapping() return
NULL. I think there is a reason(but I do not get it) why we don't split
huge pags in hugetlbfs_error_remove_page() or after. So I choose to 
add a new count.

--
Bin Wang
