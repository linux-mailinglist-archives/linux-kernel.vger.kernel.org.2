Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC06734510D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhCVUoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhCVUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:43:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zjw6xHblWwTqInlnqr5esznSG2yRgKtw4cpscwnNITo=; b=OGCKIv7xBGkVve8+JeTApeYnvj
        3wbmkIqmwFsp3pPdWegP8YPwKY7C/Sc9zG/8ncUNvh9P0laRSC9tvS+O2DiWsx/CmG/8v908i5+bj
        5/hdhY5wYM5slJzaY/W5TzCMguAeIdIqFFl1UfChi155LO/q5JIJSR09tGLm7sn0mygyM3R7ARn2M
        j419ArRW2wUZfgnpbil+6iVSMKCijNLGYpb/O56SvUaP0U1BB92Ct57jjSgG+uitNgwfewnYN4e1c
        n7/Gj+dYkL2Vgk3O6zAir1eynHCFuP/3pTpQbggH5fRCVGkfPyWr8bljXjBGUhZbcAcZVmYzaGaQR
        8UZ35FTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOROA-00CWug-ME; Mon, 22 Mar 2021 20:43:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A36C304BAE;
        Mon, 22 Mar 2021 21:43:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30BB32BEF6765; Mon, 22 Mar 2021 21:43:00 +0100 (CET)
Date:   Mon, 22 Mar 2021 21:43:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
Message-ID: <YFkBVCcu/cmYD/hl@hirez.programming.kicks-ass.net>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
 <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
 <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2383057a-29dc-383b-720f-7cdcdd015e40@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:42:23AM -0700, Mike Kravetz wrote:
> Cc: Roman, Christoph
> 
> On 3/22/21 1:41 AM, Peter Zijlstra wrote:
> > On Fri, Mar 19, 2021 at 03:42:08PM -0700, Mike Kravetz wrote:
> >> The locks acquired in free_huge_page are irq safe.  However, in certain
> >> circumstances the routine update_and_free_page could sleep.  Since
> >> free_huge_page can be called from any context, it can not sleep.
> >>
> >> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
> >> new routine update_and_free_page_no_sleep provides this functionality
> >> and is only called from free_huge_page.
> >>
> >> Note that any 'pages' sent to the workqueue for deferred freeing have
> >> already been removed from the hugetlb subsystem.  What is actually
> >> deferred is returning those base pages to the low level allocator.
> > 
> > So maybe I'm stupid, but why do you need that work in hugetlb? Afaict it
> > should be in cma_release().
> 
> My thinking (which could be totally wrong) is that cma_release makes no
> claims about calling context.  From the code, it is pretty clear that it
> can only be called from task context with no locks held.  Although,
> there could be code incorrectly calling it today hugetlb does.  Since
> hugetlb is the only code with this new requirement, it should do the
> work.
> 
> Wait!!!  That made me remember something.
> Roman had code to create a non-blocking version of cma_release().
> https://lore.kernel.org/linux-mm/20201022225308.2927890-1-guro@fb.com/
> 
> There were no objections, and Christoph even thought there may be
> problems with callers of dma_free_contiguous.
> 
> Perhaps, we should just move forward with Roman's patches to create
> cma_release_nowait() and avoid this workqueue stuff?

Ha!, that basically does as I suggested. Using that page is unfortunate
in that it will destroy the contig range for allocations until the work
happens, but I'm not sure I see a nice alternative.
