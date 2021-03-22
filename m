Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233B0343BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVIlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhCVIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:41:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=11+UFgsBMO5aIIt0nyFMZFMoj2kZkZa2BFIWC1a/WoM=; b=lV8HIkXzu0t34CZyUyWjYUlW1B
        p91isxG3kwk5Bp3ePNYJJohdUvAsHlifP2q3uAK4GHOLjPo3MVVgSEX60wHv4WCZrlg+MyKtEQ7rN
        S3UCYNKBoivSNroKkqQY2QT4eoP+D/0FfoDM9EE4q1qKgi9umPBtU4AKnZ6RZ5AUeZJMeZT4BihaX
        9Q6ebwb7mU/ckMvLohB2zVYNNii3S1jdJfW5iHQOnA6MD81ZIf31Hn3jneezHCgmW8+84LZtV/WPs
        9smOMK1kWXdDHMtTf3+QZAvRsNNFOv5dOsjqf1ruzuv6JbNlTJtozfDKGyHa8SSzW5OgnQi59OpR8
        nbMqtWGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOG7S-00BC0d-ND; Mon, 22 Mar 2021 08:41:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58B8E30377D;
        Mon, 22 Mar 2021 09:41:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FDCE2CE3915C; Mon, 22 Mar 2021 09:41:01 +0100 (CET)
Date:   Mon, 22 Mar 2021 09:41:01 +0100
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
Message-ID: <YFhYHZ9onwdZMeDi@hirez.programming.kicks-ass.net>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-8-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319224209.150047-8-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 03:42:08PM -0700, Mike Kravetz wrote:
> The locks acquired in free_huge_page are irq safe.  However, in certain
> circumstances the routine update_and_free_page could sleep.  Since
> free_huge_page can be called from any context, it can not sleep.
> 
> Use a waitqueue to defer freeing of pages if the operation may sleep.  A
> new routine update_and_free_page_no_sleep provides this functionality
> and is only called from free_huge_page.
> 
> Note that any 'pages' sent to the workqueue for deferred freeing have
> already been removed from the hugetlb subsystem.  What is actually
> deferred is returning those base pages to the low level allocator.

So maybe I'm stupid, but why do you need that work in hugetlb? Afaict it
should be in cma_release().

Also, afaict cma_release() does free_contig_range() *first*, and then
does the 'difficult' bits. So how about you re-order
free_gigantic_page() a bit to make it unconditionally do
free_contig_range() and *then* call into CMA, which can then do a
workqueue thingy if it feels like it.

That way none of the hugetlb accounting is delayed, and only CMA gets to
suffer.
