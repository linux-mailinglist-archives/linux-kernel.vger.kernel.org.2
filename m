Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1533F28F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCQO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:27:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhCQO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:26:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615991210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExqOnSIQiOaoWEYvwSez5xa/aq9YCVfc0lV3CL7i3iQ=;
        b=lFvXnQ53BOyeeG3ZK3sWgW7KPIFDixu0NEYiqeDN5ysIU0KPLSc4c83s0m3OkkjkRQxnBA
        Oz2ZTPv+COXa/ooVO0HYH3Nuqu6K6BO/fhzMWUPV/dU3qacvDfs0HxIKJn+o36Gb3pj+1H
        yrYwvUbenlh32OItwJOvu6FNnipE1iE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF1A5AD74;
        Wed, 17 Mar 2021 14:26:50 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:26:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YFIRqtEt4ecfu1TN@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-5-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317111251.17808-5-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 12:12:50, Oscar Salvador wrote:
> alloc_contig_range() will fail if it finds a HugeTLB page within the range,
> without a chance to handle them. Since HugeTLB pages can be migrated as any
> LRU or Movable page, it does not make sense to bail out without trying.
> Enable the interface to recognize in-use HugeTLB pages so we can migrate
> them, and have much better chances to succeed the call.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I am still not entirely happy about this
> @@ -2347,7 +2351,19 @@ int isolate_or_dissolve_huge_page(struct page *page)
>  	if (hstate_is_gigantic(h))
>  		return -ENOMEM;
>  
> -	return alloc_and_dissolve_huge_page(h, head);
> +retry:
> +	if (page_count(head) && isolate_huge_page(head, list)) {
> +		ret = 0;
> +	} else if (!page_count(head)) {
> +		ret = alloc_and_dissolve_huge_page(h, head);
> +
> +		if (ret == -EBUSY && try_again) {
> +			try_again = false;
> +			goto retry;
> +		}
> +	}
> +
> +	return ret;
>  }

it would be imho better to retry inside alloc_and_dissolve_huge_page
because it already has its retry logic implemented.

But not something I will insist on.

-- 
Michal Hocko
SUSE Labs
