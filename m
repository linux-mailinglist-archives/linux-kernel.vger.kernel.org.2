Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE667349EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCZBm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:42:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14881 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhCZBmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:42:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F64Rq6LNJz9tDK;
        Fri, 26 Mar 2021 09:40:39 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 09:42:37 +0800
Subject: Re: [PATCH 0/8] make hugetlb put_page safe for all calling contexts
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        "Hillf Danton" <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7c74ca0d-59fc-9dc2-6e4c-4357ad76649f@huawei.com>
Date:   Fri, 26 Mar 2021 09:42:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210325002835.216118-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/3/25 8:28, Mike Kravetz wrote:
> This effort is the result a recent bug report [1].  In subsequent
> discussions [2], it was deemed necessary to properly fix the hugetlb

Many thanks for the effort. I have read the discussions and it is pretty long.
Maybe it would be helpful if you give a brief summary here?

> put_page path (free_huge_page).  This RFC provides a possible way to

trival: Not RFC here.

> address the issue.  Comments are welcome/encouraged as several attempts
> at this have been made in the past.
> > This series is based on v5.12-rc3-mmotm-2021-03-17-22-24.  At a high
> level, the series provides:
> - Patches 1 & 2 from Roman Gushchin provide cma_release_nowait()

trival: missing description of the Patches 3 ?

> - Patches 4, 5 & 6 are aimed at reducing lock hold times.  To be clear
>   the goal is to eliminate single lock hold times of a long duration.
>   Overall lock hold time is not addressed.
> - Patch 7 makes hugetlb_lock and subpool lock IRQ safe.  It also reverts
>   the code which defers calls to a workqueue if !in_task.
> - Patch 8 adds some lockdep_assert_held() calls
> 
> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
> [2] http://lkml.kernel.org/r/20210311021321.127500-1-mike.kravetz@oracle.com
> 
> RFC -> v1
> - Add Roman's cma_release_nowait() patches.  This eliminated the need
>   to do a workqueue handoff in hugetlb code.
> - Use Michal's suggestion to batch pages for freeing.  This eliminated
>   the need to recalculate loop control variables when dropping the lock.
> - Added lockdep_assert_held() calls
> - Rebased to v5.12-rc3-mmotm-2021-03-17-22-24
> 
> Mike Kravetz (6):
>   hugetlb: add per-hstate mutex to synchronize user adjustments
>   hugetlb: create remove_hugetlb_page() to separate functionality
>   hugetlb: call update_and_free_page without hugetlb_lock
>   hugetlb: change free_pool_huge_page to remove_pool_huge_page
>   hugetlb: make free_huge_page irq safe
>   hugetlb: add lockdep_assert_held() calls for hugetlb_lock
> 
> Roman Gushchin (2):
>   mm: cma: introduce cma_release_nowait()
>   mm: hugetlb: don't drop hugetlb_lock around cma_release() call
> 
>  include/linux/cma.h     |   2 +
>  include/linux/hugetlb.h |   1 +
>  mm/cma.c                |  93 +++++++++++
>  mm/cma.h                |   5 +
>  mm/hugetlb.c            | 354 +++++++++++++++++++++-------------------
>  mm/hugetlb_cgroup.c     |   8 +-
>  6 files changed, 294 insertions(+), 169 deletions(-)
> 

