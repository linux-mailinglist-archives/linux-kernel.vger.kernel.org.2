Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9CF30C230
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhBBOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:43:08 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:61460 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbhBBOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612276876; x=1643812876;
  h=to:cc:reply-to:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=7cqYYP4R3zlI/x/sZSDd1rUQJzB7ynhIjJ2NKAncH6E=;
  b=cBgV+Ims3ttRvt3IuAvWRJ2dIHcCa/J9MpH/xS5ZChi9BXF1lJCJOxE8
   hqWdvJKIvQedPiPoslcu6AFFcCx3iJrtN4jt6YVViAOnui+/biII+z40V
   VYZDq5iByiXp6kcaOWy94wcmOm0VIj++eJkxOSWG638xbrqFFbk3NaK7B
   s=;
X-IronPort-AV: E=Sophos;i="5.79,395,1602547200"; 
   d="scan'208";a="79309769"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Feb 2021 14:40:53 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 39972A211B;
        Tue,  2 Feb 2021 14:40:47 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.94) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Feb 2021 14:40:38 +0000
To:     Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Zhang, Wei" <wzam@amazon.com>
Reply-To: <20200918161902.GX8409@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <27564187-4a08-f187-5a84-3df50009f6ca@amazon.com>
Date:   Tue, 2 Feb 2021 16:40:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.94]
X-ClientProxiedBy: EX13D04UWB004.ant.amazon.com (10.43.161.103) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 17, 2020 at 03:03:32PM -0400, Peter Xu wrote:
> 
>> Another side effect I can think of is that we'll bring some uncertainty to
>> fork() starting from when page_maybe_dma_pinned() is used, since it's sometimes
>> bogus (hpage_pincount_available()==false) so some COWs might be triggered
>> during fork() even when not necessary if we've got some normal pages with too
>> many refcounts (over GUP_PIN_COUNTING_BIAS).  But assuming that's not a big
>> deal since it should be extremely rare, or is it?..
> 
> Looking at this a bit more.. A complete implementation will have to
> touch all four places doing write protect during fork:
> 
> copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
> 		unsigned long addr, int *rss)
> {
> [..]
> 	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> 		ptep_set_wrprotect(src_mm, addr, src_pte);
> 		pte = pte_wrprotect(pte);
> 
> int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
> 		  struct vm_area_struct *vma)
> {
> [..]
> 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
> 	pmd = pmd_mkold(pmd_wrprotect(pmd));
> 
> int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
> 		  struct vm_area_struct *vma)
> {
> [..]
> 	pudp_set_wrprotect(src_mm, addr, src_pud);
> 	pud = pud_mkold(pud_wrprotect(pud));
> 
> int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                             struct vm_area_struct *vma)
> {
> [..]
>                         if (cow) {
>                                 huge_ptep_set_wrprotect(src, addr, src_pte);
> 
> As a regression I'm pretty sure we will hit only the PTE and PMD
> cases.
> 
> Most likely the other two could be done outside the rc cycle

Hi Peter & Jason,

It seems the hugetlb part was overlooked?
We're testing if the RDMA fork MADV_DONTFORK stuff can be removed on appropriate
kernels, but our tests still fail due to lacking explicit huge pages support [1].

Peter, was it left unchanged on purpose?
Are you planning to submit the hugetlb changes as well?

[1] https://github.com/linux-rdma/rdma-core/pull/883#issuecomment-770398171
