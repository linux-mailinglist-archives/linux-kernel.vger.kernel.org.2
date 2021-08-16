Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA33ED854
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhHPOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhHPOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:00:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DFC0617AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6q1+UdtYiO8s6rj0/c/nQ3ECy5RSEzhQllvM+6vQdJ8=; b=cQ2mlhP60SgjrOH7VyYtCbZ6xq
        BElSBir7HnhCbahWGm9ukBCQ1FrwUhWmD3PhURPAtDmJZYoNuANE+GX3rfZQoZ2sNi6yBjV2gBwIH
        86aCmG4mhqhk9y/NXlAf9QjNMYjhzUrBWu5dnINkMZUkRlQ+EwbfMRsBvviiZAAiBXY4R3GGqmX1q
        BVhZs0/rkDTmxDgn34gPwIs7NG5YAxxN/CZ4v5yNcRpYMEPDIuM5KDgQxrkIKav0+K1H/DCSoEcU8
        1skTS2TpbEuLWokUS0rWhiM/SAixCyjNIhe31z/Lm2o4HRrN/vR7Ha4uFeEapzRwt0198hV7Ka/Nk
        +f1oEBYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFciu-001PhE-KG; Mon, 16 Aug 2021 13:32:41 +0000
Date:   Mon, 16 Aug 2021 14:32:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <YRpo4EAJSkY7hI7Q@casper.infradead.org>
References: <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <ca2d4ea4-e875-475a-6094-1ac58bc0b544@redhat.com>
 <YRpeHnP7QDNJRA8Y@casper.infradead.org>
 <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88884f55-4991-11a9-d330-5d1ed9d5e688@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:24:38PM +0200, David Hildenbrand wrote:
> On 16.08.21 14:46, Matthew Wilcox wrote:
> > On Mon, Aug 16, 2021 at 02:20:43PM +0200, David Hildenbrand wrote:
> > > On 16.08.21 14:07, Matthew Wilcox wrote:
> > > > On Mon, Aug 16, 2021 at 10:02:22AM +0200, David Hildenbrand wrote:
> > > > > > Mappings within this address range behave as if they were shared
> > > > > > between threads, so a write to a MAP_PRIVATE mapping will create a
> > > > > > page which is shared between all the sharers. The first process that
> > > > > > declares an address range mshare'd can continue to map objects in the
> > > > > > shared area. All other processes that want mshare'd access to this
> > > > > > memory area can do so by calling mshare(). After this call, the
> > > > > > address range given by mshare becomes a shared range in its address
> > > > > > space. Anonymous mappings will be shared and not COWed.
> > > > > 
> > > > > Did I understand correctly that you want to share actual page tables between
> > > > > processes and consequently different MMs? That sounds like a very bad idea.
> > > > 
> > > > That is the entire point.  Consider a machine with 10,000 instances
> > > > of an application running (process model, not thread model).  If each
> > > > application wants to map 1TB of RAM using 2MB pages, that's 4MB of page
> > > > tables per process or 40GB of RAM for the whole machine.
> > > 
> > > What speaks against 1 GB pages then?
> > 
> > Until recently, the CPUs only having 4 1GB TLB entries.  I'm sure we
> > still have customers using that generation of CPUs.  2MB pages perform
> > better than 1GB pages on the previous generation of hardware, and I
> > haven't seen numbers for the next generation yet.
> 
> I read that somewhere else before, yet we have heavy 1 GiB page users,
> especially in the context of VMs and DPDK.

I wonder if those users actually benchmarked.  Or whether the memory
savings worked out so well for them that the loss of TLB performance
didn't matter.

> So, it only works for hugetlbfs in case uffd is not in place (-> no
> per-process data in the page table) and we have an actual shared mappings.
> When unsharing, we zap the PUD entry, which will result in allocating a
> per-process page table on next fault.

I think uffd was a huge mistake.  It should have been a filesystem
instead of a hack on the side of anonymous memory.

> I will rephrase my previous statement "hugetlbfs just doesn't raise these
> problems because we are special casing it all over the place already". For
> example, not allowing to swap such pages. Disallowing MADV_DONTNEED. Special
> hugetlbfs locking.

Sure, that's why I want to drag this feature out of "oh this is a
hugetlb special case" and into "this is something Linux supports".
