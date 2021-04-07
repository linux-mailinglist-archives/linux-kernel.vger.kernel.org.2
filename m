Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CEF356806
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350095AbhDGJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243648AbhDGJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617787716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ozcnQwHUu8p4zYE+iIFxAZOxz9lcMS0/tDJHr1riY2Q=;
        b=bgmDelG1FOABIXSF6dt3g8IW7/eBjOQ+tAH0OvHrBZhpVvAydqSlgoYp7J5gfS2TsvwDuO
        5YAawuZgCQ1Ri90S+VK0VahaAb0AKyMuo98XAYDi/GwB2YDtvghAbVTnUBU3x3p+rDc5h2
        Oy5JUsvCq5q1kM8p/m87TAyj/kxtjtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-hVPpjPlvPA-97rcJg60t-A-1; Wed, 07 Apr 2021 05:28:33 -0400
X-MC-Unique: hVPpjPlvPA-97rcJg60t-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B99B010054F6;
        Wed,  7 Apr 2021 09:28:30 +0000 (UTC)
Received: from [10.36.114.68] (ovpn-114-68.ams2.redhat.com [10.36.114.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F25E4100164A;
        Wed,  7 Apr 2021 09:28:18 +0000 (UTC)
Subject: Re: [PATCH v4 3/8] hugetlb: add per-hstate mutex to synchronize user
 adjustments
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-4-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ee2a4ec1-9a44-5870-fb66-f48a14a518e8@redhat.com>
Date:   Wed, 7 Apr 2021 11:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210405230043.182734-4-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.21 01:00, Mike Kravetz wrote:
> The helper routine hstate_next_node_to_alloc accesses and modifies the
> hstate variable next_nid_to_alloc.  The helper is used by the routines
> alloc_pool_huge_page and adjust_pool_surplus.  adjust_pool_surplus is
> called with hugetlb_lock held.  However, alloc_pool_huge_page can not
> be called with the hugetlb lock held as it will call the page allocator.
> Two instances of alloc_pool_huge_page could be run in parallel or
> alloc_pool_huge_page could run in parallel with adjust_pool_surplus
> which may result in the variable next_nid_to_alloc becoming invalid
> for the caller and pages being allocated on the wrong node.
> 
> Both alloc_pool_huge_page and adjust_pool_surplus are only called from
> the routine set_max_huge_pages after boot.  set_max_huge_pages is only
> called as the reusult of a user writing to the proc/sysfs nr_hugepages,
> or nr_hugepages_mempolicy file to adjust the number of hugetlb pages.
> 
> It makes little sense to allow multiple adjustment to the number of
> hugetlb pages in parallel.  Add a mutex to the hstate and use it to only
> allow one hugetlb page adjustment at a time.  This will synchronize
> modifications to the next_nid_to_alloc variable.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   include/linux/hugetlb.h | 1 +
>   mm/hugetlb.c            | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d9b78e82652f..b92f25ccef58 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -566,6 +566,7 @@ HPAGEFLAG(Freed, freed)
>   #define HSTATE_NAME_LEN 32
>   /* Defines one hugetlb page size */
>   struct hstate {
> +	struct mutex resize_lock;
>   	int next_nid_to_alloc;
>   	int next_nid_to_free;
>   	unsigned int order;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1d62f0492e7b..8497a3598c86 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2730,6 +2730,11 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>   	else
>   		return -ENOMEM;
>   
> +	/*
> +	 * resize_lock mutex prevents concurrent adjustments to number of
> +	 * pages in hstate via the proc/sysfs interfaces.
> +	 */
> +	mutex_lock(&h->resize_lock);
>   	spin_lock(&hugetlb_lock);
>   
>   	/*
> @@ -2762,6 +2767,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>   	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>   		if (count > persistent_huge_pages(h)) {
>   			spin_unlock(&hugetlb_lock);
> +			mutex_unlock(&h->resize_lock);
>   			NODEMASK_FREE(node_alloc_noretry);
>   			return -EINVAL;
>   		}
> @@ -2836,6 +2842,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>   out:
>   	h->max_huge_pages = persistent_huge_pages(h);
>   	spin_unlock(&hugetlb_lock);
> +	mutex_unlock(&h->resize_lock);
>   
>   	NODEMASK_FREE(node_alloc_noretry);
>   
> @@ -3323,6 +3330,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>   	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
>   	BUG_ON(order == 0);
>   	h = &hstates[hugetlb_max_hstate++];
> +	mutex_init(&h->resize_lock);
>   	h->order = order;
>   	h->mask = ~(huge_page_size(h) - 1);
>   	for (i = 0; i < MAX_NUMNODES; ++i)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

