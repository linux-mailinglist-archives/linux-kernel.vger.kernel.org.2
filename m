Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2940F9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhIQOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242097AbhIQOAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:00:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7892611C3;
        Fri, 17 Sep 2021 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631887148;
        bh=em7tfOdoqqzx6DYhxHC4BEgcII1sZaKQpkbYD/MwIso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0Og+B7AXeoKXtrW8hnQE39HMjCZRg8n6XDJ4j+rMTaP5kheDlzuJQyT8YEakxClK
         EYLpSblEotfhuyZ7lZGzgJt14WfmJEG1NTfDj5GPiNjTmbZIRtaSlklWwdD1Q4z3uE
         ca83i62PdVWj6K+SAYWfi46F3+pzOWz1xNc7pMeK3Sn28prY+zWMRy5ERta8nXhZWS
         plqTrBFty+m8pKCxg+LeymJptpNJl0llSnmZUZum6nCjD6SjiUfY8OqIgjjrIA1A5d
         Ayxs/SyZuzbS9+LTSRbPA+eCM6UfYUS2+taExPCvy7CBas+GnrncNc1qo5pkk5XJGv
         hLCnNWm5mvtxg==
Date:   Fri, 17 Sep 2021 16:59:01 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     zhenguo yao <yaozhenguo1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        yaozhenguo@jd.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v4] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
Message-ID: <YUSfJRnvYmGbIl1f@kernel.org>
References: <20210909141655.87821-1-yaozhenguo1@gmail.com>
 <20210914205001.7ccc7ef3dd76a9ec551b370e@linux-foundation.org>
 <CA+WzARmsPT46ck17-96cJVWE-=QEK8QobRFnCnEcNxsd42zNTw@mail.gmail.com>
 <c55f0be5-f68d-1a33-a9e4-5890a2887a15@oracle.com>
 <98a8ea20-5642-d332-d7b4-18e075a594fb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98a8ea20-5642-d332-d7b4-18e075a594fb@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Sep 15, 2021 at 03:05:41PM -0700, Mike Kravetz wrote:
> Now, really CC'ing Mike, and sorry for misspelling your name
> 
> On 9/15/21 3:03 PM, Mike Kravetz wrote:
> > On 9/15/21 6:11 AM, zhenguo yao wrote:
> >> Andrew Morton <akpm@linux-foundation.org> 于2021年9月15日周三 上午11:50写道：
> >>>
> >>> On Thu,  9 Sep 2021 22:16:55 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:
> >>>
> >>>> We can specify the number of hugepages to allocate at boot. But the
> >>>> hugepages is balanced in all nodes at present. In some scenarios,
> >>>> we only need hugepages in one node. For example: DPDK needs hugepages
> >>>> which are in the same node as NIC. if DPDK needs four hugepages of 1G
> >>>> size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
> >>>> in kernel cmdline. But, only four hugepages are used. The others should
> >>>> be free after boot. If the system memory is low(for example: 64G), it will
> >>>> be an impossible task. So, Extending hugepages parameter to support
> >>>> specifying hugepages at a specific node.
> >>>> For example add following parameter:
> >>>>
> >>>> hugepagesz=1G hugepages=0:1,1:3
> >>>>
> >>>> It will allocate 1 hugepage in node0 and 3 hugepages in node1.
> >>>>
> >>>> ...
> >>>>
> >>>> @@ -2842,10 +2843,75 @@ static void __init gather_bootmem_prealloc(void)
> >>>>       }
> >>>>  }
> >>>>
> >>>> +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> >>>> +{
> >>>> +     unsigned long i;
> >>>> +     char buf[32];
> >>>> +
> >>>> +     for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
> >>>> +             if (hstate_is_gigantic(h)) {
> >>>> +                     struct huge_bootmem_page *m;
> >>>> +                     void *addr;
> >>>> +
> >>>> +                     addr = memblock_alloc_try_nid_raw(
> >>>> +                                     huge_page_size(h), huge_page_size(h),
> >>>> +                                     0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >>>> +                     if (!addr)
> >>>> +                             break;
> >>>> +                     m = addr;
> >>>> +                     BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
> >>>
> >>> We try very hard to avoid adding BUG calls.  Is there any way in which
> >>> this code can emit a WARNing then permit the kernel to keep operating?
> >>>
> >> Maybe we can rewrite it as below:
> >>                         if (WARN(!IS_ALIGNED(virt_to_phys(m),
> >> huge_page_size(h)),
> >>                                 "HugeTLB: page addr:%p is not aligned\n", m))
> >>                                 break;
> >> @Mike,  Do you think it's OK?
> > 
> > Sorry, I have not yet reviewed the latest version of this patch.
> > Quick thought on this question.
> > 
> > The required alignment passed to memblock_alloc_try_nid_raw() is
> > huge_page_size(h).  Therefore, we know the virtual address m is
> > huge_page_size(h) aligned.  The BUG is just checking to make sure
> > the physical address associated with the virtual address is aligned
> > the same.  I really do not see how this could not be the case.
> > In fact, the memblock allocator finds a physical address with the
> > required alignment and then returns phys_to_virt(alloc).
> > Someone please correct me if I am wrong.  Otherwise, we can drop
> > the BUG.

I agree with your analysis and I also think the BUG() can be dropped
entirely as well as the BUG() in __alloc_bootmem_huge_page().

> > Adding Mike Rapport on Cc:
> > 
> > This allocation code and the associated BUG was copied from
> > __alloc_bootmem_huge_page().  The BUG was added 12 years ago before
> > the memblock allocator existed and we were using the bootmem allocator.
> > If there is no need for a BUG in hugetlb_hstate_alloc_pages_onenode,
> > there is no need for one in __alloc_bootmem_huge_page.

Hmm, even bootmem had alignment guaranties so it seems to me that the BUG()
was over-protective even then.

-- 
Sincerely yours,
Mike.
