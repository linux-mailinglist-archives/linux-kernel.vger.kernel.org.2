Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFDB344734
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhCVObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:31:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhCVObI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:31:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616423467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpPLEqSIKAx6LCad+2eiCBK8qg/o/11mDrcvfFKDJWk=;
        b=ji/kO1BsoNTVCCNONFSEuQtUw4jSzJX56+SiBHCRVIPO9jNqYTKgymtfAsQUNhLUtTmtI+
        +jn7603DyUTYfXgKFLoHf8nXm6iMZRMCjKAgT7OZZQr7eP84vLfG+Q/BAj5b1ap/kEL/J5
        vLfDBjllUTVr+bWf2pLvF5l6a6Pmvi4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3BDCAACA8;
        Mon, 22 Mar 2021 14:31:07 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:31:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 5/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
Message-ID: <YFiqJSGjMMG3diWp@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-6-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319224209.150047-6-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 15:42:06, Mike Kravetz wrote:
[...]
> @@ -2090,9 +2084,15 @@ static void return_unused_surplus_pages(struct hstate *h,
>  	while (nr_pages--) {
>  		h->resv_huge_pages--;
>  		unused_resv_pages--;
> -		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
> +		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
> +		if (!page)
>  			goto out;
> -		cond_resched_lock(&hugetlb_lock);
> +
> +		/* Drop lock and free page to buddy as it could sleep */
> +		spin_unlock(&hugetlb_lock);
> +		update_and_free_page(h, page);
> +		cond_resched();
> +		spin_lock(&hugetlb_lock);
>  	}
>  
>  out:

This is likely a matter of taste but the repeated pattern of unlock,
update_and_free_page, cond_resched and lock seems rather clumsy.
Would it be slightly better/nicer to remove_pool_huge_page into a
list_head under a single lock invocation and then free up the whole lot
after the lock is dropped?

-- 
Michal Hocko
SUSE Labs
