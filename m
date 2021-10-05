Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EFE422106
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhJEIow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:44:52 -0400
Received: from 232.88.17.95.dynamic.jazztel.es ([95.17.88.232]:57110 "EHLO
        suse.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232974AbhJEIou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:44:50 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 04:44:50 EDT
Received: by suse.de (Postfix, from userid 1000)
        id 92EAEA413; Tue,  5 Oct 2021 10:35:17 +0200 (CEST)
Date:   Tue, 5 Oct 2021 10:35:17 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/5] mm/cma: add cma_pages_valid to determine if pages
 are in CMA
Message-ID: <20211005083516.GA20090@linux>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001175210.45968-3-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:52:07AM -0700, Mike Kravetz wrote:
> +bool cma_pages_valid(struct cma *cma, const struct page *pages,
> +		     unsigned long count)
> +{
> +	unsigned long pfn;
> +
> +	if (!cma || !pages)
> +		return false;
> +
> +	pfn = page_to_pfn(pages);
> +
> +	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * cma_release() - release allocated pages
>   * @cma:   Contiguous memory region for which the allocation is performed.
> @@ -539,16 +555,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  {
>  	unsigned long pfn;
>  
> -	if (!cma || !pages)
> +	if (!cma_pages_valid(cma, pages, count))
>  		return false;
>  
>  	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
>  
>  	pfn = page_to_pfn(pages);
>  
> -	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> -		return false;
> -

Might be worth noting that after this change, the debug statement will not be
printed as before. Now, we back off before firing it.

You might want to point that out in the changelog in case someone wonders
why.

-- 
Oscar Salvador
SUSE Labs
