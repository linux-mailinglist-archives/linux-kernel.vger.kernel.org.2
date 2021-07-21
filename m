Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7863D1A04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGUWQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbhGUWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626908224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nYPuiEUAoQnXgigA8gfgSsVvv5X/dh0PhyM763uouHg=;
        b=LSmatBYjWmcrkuKX+osf0LantQDULBIPoJTQ0oJI842u86SQ06Z6AhZnAo86SXn6lPn51G
        j3j8KGyn3/Ao63uWfivz53ZJxs5os/pWpPp1XsssS70eEdXs1XySbcluN/lTUEjodTW6S9
        8Fzd/uHvlDBoEDuhpB4RjXmqmhPET1o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-lkdNamdxMJ2Jed6PUu82kw-1; Wed, 21 Jul 2021 18:57:02 -0400
X-MC-Unique: lkdNamdxMJ2Jed6PUu82kw-1
Received: by mail-qt1-f197.google.com with SMTP id e7-20020ac84e470000b029025ca4fbcc12so2352476qtw.18
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYPuiEUAoQnXgigA8gfgSsVvv5X/dh0PhyM763uouHg=;
        b=Eb0fvIFkAkUMbr9q/qp0Vpqsqxta52CnIGau7UgAp2v0R6dClFHOyN83ffLNYibfBS
         ZbUM1sn0F7ytmI+DWE2HFUcPOXnzR0M9O4DlCA2RHhWlneP7sDoNvkjitSDfhR0SRIDJ
         sbJUPVEaXDzMuluLQlh6WlzurBcz0fj8lqn7pA0S2eBuUNPjykGEwEXrHRgYdmWg69of
         dcHsFmi21+b/iZ8cGNNPCVYkEUoffD9aOeGQTft9T/FPdtCvBLsrFZU/VpfaZdxw6zJW
         UY/khKgkGhADjdKQYe7P35avfHQJw2eHp1NF9uTHxVwI1gV0gdcz3Z0yUz/cCT7D/4lr
         HRuQ==
X-Gm-Message-State: AOAM5312XaI9ZjtDQ+8BKQzsB/T2kemcC2zygGjDBTD1RWftHGxFETe7
        wt4GASOV8ygSBFkGeyExvZ1gucKHAiTAh3FR3e3gqGFwZNjIfz3krrzOyISeLKJnJBI0KG8Ryw+
        uMn8M42y5rXwvvR/YrRJLm5hP
X-Received: by 2002:a37:af45:: with SMTP id y66mr27663718qke.466.1626908222361;
        Wed, 21 Jul 2021 15:57:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6cIXdiz0a5BMrUZSi6UQdK/SvtgxeRSmtDqXbf0AKl9xdYYxgvfL0PJqb8UPjnwOt+T5xAA==
X-Received: by 2002:a37:af45:: with SMTP id y66mr27663703qke.466.1626908222137;
        Wed, 21 Jul 2021 15:57:02 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p22sm9506044qtq.64.2021.07.21.15.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:57:01 -0700 (PDT)
Date:   Wed, 21 Jul 2021 18:57:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "ovzxemul@gmail.com" <ovzxemul@gmail.com>
Subject: Re: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Message-ID: <YPimPFvyH2MWLLp/@t490s>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com>
 <YPWiRsNaearMNB2g@t490s>
 <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com>
 <YPW8xaejtl68AYCk@t490s>
 <CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
 <5c3c84ee-02f6-a2af-13b8-5dcf70676641@redhat.com>
 <CY4PR0201MB3460AAED19F46CD184B2AB30E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
 <YPifc+eRNSs/rjv1@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPifc+eRNSs/rjv1@t490s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 06:28:03PM -0400, Peter Xu wrote:
> Hi, Ivan,
> 
> On Wed, Jul 21, 2021 at 07:54:44PM +0000, Ivan Teterevkov wrote:
> > On Wed, Jul 21, 2021 4:20 PM +0000, David Hildenbrand wrote:
> > > On 21.07.21 16:38, Ivan Teterevkov wrote:
> > > > On Mon, Jul 19, 2021 5:56 PM +0000, Peter Xu wrote:
> > > >> I'm also curious what would be the real use to have an accurate
> > > >> PM_SWAP accounting.  To me current implementation may not provide
> > > >> accurate value but should be good enough for most cases.  However not
> > > >> sure whether it's also true for your use case.
> > > >
> > > > We want the PM_SWAP bit implemented (for shared memory in the pagemap
> > > > interface) to enhance the live migration for some fraction of the
> > > > guest VMs that have their pages swapped out to the host swap. Once
> > > > those pages are paged in and transferred over network, we then want to
> > > > release them with madvise(MADV_PAGEOUT) and preserve the working set
> > > > of the guest VMs to reduce the thrashing of the host swap.
> > > 
> > > There are 3 possibilities I think (swap is just another variant of the page cache):
> > > 
> > > 1) The page is not in the page cache, e.g., it resides on disk or in a swap file.
> > > pte_none().
> > > 2) The page is in the page cache and is not mapped into the page table.
> > > pte_none().
> > > 3) The page is in the page cache and mapped into the page table.
> > > !pte_none().
> > > 
> > > Do I understand correctly that you want to identify 1) and indicate it via
> > > PM_SWAP?
> > 
> > Yes, and I also want to outline the context so we're on the same page.
> > 
> > This series introduces the support for userfaultfd-wp for shared memory
> > because once a shared page is swapped, its PTE is cleared. Upon retrieval
> > from a swap file, there's no way to "recover" the _PAGE_SWP_UFFD_WP flag
> > because unlike private memory it's not kept in PTE or elsewhere.
> > 
> > We came across the same issue with PM_SWAP in the pagemap interface, but
> > fortunately, there's the place that we could query: the i_pages field of
> > the struct address_space (XArray). In https://lkml.org/lkml/2021/7/14/595
> > we do it similarly to what shmem_fault() does when it handles #PF.
> > 
> > Now, in the context of this series, we were exploring whether it makes
> > any practical sense to introduce more brand new flags to the special
> > PTE to populate the pagemap flags "on the spot" from the given PTE.
> > 
> > However, I can't see how (and why) to achieve that specifically for
> > PM_SWAP even with an extra bit: the XArray is precisely what we need for
> > the live migration use case. Another flag PM_SOFT_DIRTY suffers the same
> > problem as UFFD_WP_SWP_PTE_SPECIAL before this patch series, but we don't
> > need it at the moment.
> > 
> > Hope that clarification makes sense?
> 
> Yes it helps, thanks.
> 
> So I can understand now on how that patch comes initially, even if it may not
> work for PM_SOFT_DIRTY but it seems working indeed for PM_SWAP.
> 
> However I have a concern that I raised also in the other thread: I think
> there'll be an extra and meaningless xa_load() for all the real pte_none()s
> that aren't swapped out but just having no page at the back from the very
> beginning.  That happens much more frequent when the memory being observed by
> pagemap is mapped in a huge chunk and sparsely mapped.
> 
> With old code we'll simply skip those ptes, but now I have no idea how much
> overhead would a xa_load() brings.
> 
> Btw, I think there's a way to implement such an idea similar to the swap
> special uffd-wp pte - when page reclaim of shmem pages, instead of putting a
> none pte there maybe we can also have one bit set in the none pte showing that
> this pte is swapped out.  When the page faulted back we just drop that bit.
> 
> That bit could be also scanned by pagemap code to know that this page was
> swapped out.  That should be much lighter than xa_load(), and that identifies
> immediately from a real none pte just by reading the value.
> 
> Do you think this would work?

Btw, I think that's what Tiberiu used to mention, but I think I just changed my
mind..  Sorry to have brought such a confusion.

So what I think now is: we can set it (instead of zeroing the pte) right at
unmapping the pte of page reclaim.  Code-wise, that can be a special flag
(maybe, TTU_PAGEOUT?) passed over to try_to_unmap() of shrink_page_list() to
differenciate from other try_to_unmap()s.

I think that bit can also be dropped correctly e.g. when punching a hole in the
file, then rmap_walk() can find and drop the marker (I used to suspect uffd-wp
bit could get left-overs, but after a second thought here similarly, it seems
it won't; as long as hole punching and vma unmapping will always be able to
scan those marker ptes, then it seems all right to drop them correctly).

But that's my wild thoughts; I could have missed something too.

Thanks,

-- 
Peter Xu

