Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EC35944A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhDIFF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233196AbhDIFF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:05:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03E8461165;
        Fri,  9 Apr 2021 05:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617944714;
        bh=6Wnuf9M102AXqzomv0irSR9VM7qEJdUXgl0COqC7FoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sIB/Ab+OVrLd8LJa3Fa7/1k1sipGOwUeWJcOn9PB0iN82g0tA+pkF4hnMJJ1dsr4c
         IU1Geh8uykg1KwgJcgh7k75vVCVAfduyRDDaWwVg4RhwHMOoRfhRfNl1tUPapUjttB
         wHUE2y87fP7zSPhCuZV8nqlfCEQaTRjAJtxGZLcw=
Date:   Thu, 8 Apr 2021 22:05:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 0/8] make hugetlb put_page safe for all calling
 contexts
Message-Id: <20210408220513.36b57e18f1f538213a315ab7@linux-foundation.org>
In-Reply-To: <YG6soiwXQJ6EEA+N@localhost.localdomain>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
        <01d8785f-efeb-553d-f075-6501c621ae20@oracle.com>
        <YG6soiwXQJ6EEA+N@localhost.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 09:11:30 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> But if It is going to be easier for Andrew, just pull them all out and I
> will resend the whole series once this work goes in.

I think so.

I shall drop these:

mmpage_alloc-bail-out-earlier-on-enomem-in-alloc_contig_migrate_range.patch
mmcompaction-let-isolate_migratepages_rangeblock-return-error-codes.patch
mmcompaction-let-isolate_migratepages_rangeblock-return-error-codes-fix.patch
mm-make-alloc_contig_range-handle-free-hugetlb-pages.patch
mm-make-alloc_contig_range-handle-in-use-hugetlb-pages.patch
mmpage_alloc-drop-unnecessary-checks-from-pfn_range_valid_contig.patch

and these:

mm-cma-change-cma-mutex-to-irq-safe-spinlock.patch
hugetlb-no-need-to-drop-hugetlb_lock-to-call-cma_release.patch
hugetlb-add-per-hstate-mutex-to-synchronize-user-adjustments.patch
hugetlb-create-remove_hugetlb_page-to-separate-functionality.patch
hugetlb-call-update_and_free_page-without-hugetlb_lock.patch
hugetlb-change-free_pool_huge_page-to-remove_pool_huge_page.patch
hugetlb-make-free_huge_page-irq-safe.patch
hugetlb-make-free_huge_page-irq-safe-fix.patch
hugetlb-add-lockdep_assert_held-calls-for-hugetlb_lock.patch

Along with notes-to-self that this:

  https://lkml.kernel.org/r/YGwnPCPaq1xKh/88@hirez.programming.kicks-ass.net

might need attention and that this:

  hugetlb-make-free_huge_page-irq-safe.patch

might need updating.
