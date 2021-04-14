Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542C635F3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350909AbhDNM0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230221AbhDNM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618403186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjvQ4PU7h8Ys45H28LzMhxk+VXcHhNlEEIqxegZmOG0=;
        b=WRHcbk+eWvvFljfajpAplvDB6vmjbWrVcO0sDt5SWrkQuCifeI/XgKctM5AGS1psXhBweL
        nqU1NhYlQZ2VaVDcdhJVXcZx/Q0rkK7OEz8g+EmEzk7d8TAXJSKyOLm82XkWUdng552fJC
        P5Dt3n2GTfGfEUqtWWR4xI2EGe/hPkg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-Pt8ggj5uN362KhPgKJUT4A-1; Wed, 14 Apr 2021 08:26:24 -0400
X-MC-Unique: Pt8ggj5uN362KhPgKJUT4A-1
Received: by mail-wm1-f71.google.com with SMTP id o22-20020a1ca5160000b0290126af94672aso2022157wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UjvQ4PU7h8Ys45H28LzMhxk+VXcHhNlEEIqxegZmOG0=;
        b=TV6QFMKpY6UTwa12Gz9K4fpaEcpVhXoXxNlYU+Q4oD1wXe1Lw40GiQKCQ3nQrmHLHG
         hJjboKPNswo9UkeD0VGhhGA5jau84MXfUkqqCPEW4vnc/D7QD7eo//QvC/aG7WEJFUHQ
         hkvBxkWttUYczQlS1ZqVArq6dlf+03LylXLkzjIUh+Weu7k6s2ovJAs+D6mOZOz9D7tr
         ygSSbbEI2F51zmFSJ9nwYcHMN+hWWrbOYS3smHnQjih24RPUkTIv62Af1Ji55OcDzTit
         ibX6ah0J2nCFmS74AVPeDQdzCPlbDBtTAgeaOn+gJyiGU2uTSYv9WvDY2JtdKX/aanYr
         fvVA==
X-Gm-Message-State: AOAM530T2b6Bv3Rxz6aun2Ckr514ArZaYsgx5haW0slm/UY162hE1Ozs
        1n0uCrIpJhBK4YPe05UlepObBVWwdCRO/hXl4JPPjGujLW66plqkq0s9U8sJpKCP37I5sFvx+bL
        pDQCTmMdLYfXD3RKmQAE2EZGugjITmPeD1I3N2fHlpFg1GcrPfuim7+QlLGkpcBDz7OOMKqtp
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr21667866wrx.241.1618403183175;
        Wed, 14 Apr 2021 05:26:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykpy9sJEW82HUI1sEt030ZbzQcqkh5sA8XfLL7bnMgORWkn0Fgx/Msi8ndSe/1aeQGBcuFAA==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr21667817wrx.241.1618403182646;
        Wed, 14 Apr 2021 05:26:22 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id r5sm5270923wmr.15.2021.04.14.05.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 05:26:22 -0700 (PDT)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-6-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <71cce295-91d3-21d8-5075-04a2e828d0f2@redhat.com>
Date:   Wed, 14 Apr 2021 14:26:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210413104747.12177-6-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline int isolate_or_dissolve_huge_page(struct page *page)
> +{
> +	return -ENOMEM;

Without CONFIG_HUGETLB_PAGE, there is no way someone could possible pass 
in something valid. Although it doesn't matter too much, -EINVAL or 
similar sounds a bit better.

> +}
> +
>   static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
>   					   unsigned long addr,
>   					   int avoid_reserve)
> diff --git a/mm/compaction.c b/mm/compaction.c
> index eeba4668c22c..89426b6d1ea3 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -788,7 +788,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
>    * Isolate all pages that can be migrated from the range specified by
>    * [low_pfn, end_pfn). The range is expected to be within same pageblock.
>    * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
> - * or 0.
> + * -ENOMEM in case we could not allocate a page, or 0.
>    * cc->migrate_pfn will contain the next pfn to scan (which may be both less,
>    * equal to or more that end_pfn).
>    *
> @@ -809,6 +809,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   	bool skip_on_failure = false;
>   	unsigned long next_skip_pfn = 0;
>   	bool skip_updated = false;
> +	bool fatal_error = false;

Can't we use "ret == -ENOMEM" instead of fatal_error?

>   	int ret = 0;
>   
>   	cc->migrate_pfn = low_pfn;
> @@ -907,6 +908,33 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			valid_page = page;
>   		}
>   
> +		if (PageHuge(page) && cc->alloc_contig) {
> +			ret = isolate_or_dissolve_huge_page(page);
> +
> +			/*
> +			 * Fail isolation in case isolate_or_dissolve_huge_page
> +			 * reports an error. In case of -ENOMEM, abort right away.
> +			 */
> +			if (ret < 0) {
> +				/*
> +				 * Do not report -EBUSY down the chain.
> +				 */
> +				if (ret == -ENOMEM)
> +					fatal_error = true;
> +				else
> +					ret = 0;
> +				low_pfn += (1UL << compound_order(page)) - 1;
> +				goto isolate_fail;
> +			}
> +
> +			/*
> +			 * Ok, the hugepage was dissolved. Now these pages are
> +			 * Buddy and cannot be re-allocated because they are
> +			 * isolated. Fall-through as the check below handles
> +			 * Buddy pages.
> +			 */
> +		}
> +
>   		/*
>   		 * Skip if free. We read page order here without zone lock
>   		 * which is generally unsafe, but the race window is small and
> @@ -1066,7 +1094,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		put_page(page);
>   
>   isolate_fail:
> -		if (!skip_on_failure)
> +		if (!skip_on_failure && !fatal_error)
>   			continue;
>   
>   		/*
> @@ -1092,6 +1120,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			 */
>   			next_skip_pfn += 1UL << cc->order;
>   		}
> +
> +		if (fatal_error)
> +			break;
>   	}
>   
>   	/*
> @@ -1145,7 +1176,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>    * @end_pfn:   The one-past-last PFN.
>    *
>    * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
> - * or 0.
> + * -ENOMEM in case we could not allocate a page, or 0.
>    */
>   int
>   isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0607b2b71ac6..4a664d6e82c1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2266,6 +2266,121 @@ static void restore_reserve_on_error(struct hstate *h,
>   	}
>   }
>   
> +/*
> + * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
> + * @h: struct hstate old page belongs to
> + * @old_page: Old page to dissolve
> + * Returns 0 on success, otherwise negated error.
> + */
> +
> +static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
> +{
> +	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +	int nid = page_to_nid(old_page);
> +	struct page *new_page;
> +	int ret = 0;
> +
> +	/*
> +	 * Before dissolving the page, we need to allocate a new one for the
> +	 * pool to remain stable. Using alloc_buddy_huge_page() allows us to
> +	 * not having to deal with prep_new_page() and avoids dealing of any
> +	 * counters. This simplifies and let us do the whole thing under the
> +	 * lock.
> +	 */
> +	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
> +	if (!new_page)
> +		return -ENOMEM;
> +
> +retry:
> +	spin_lock_irq(&hugetlb_lock);
> +	if (!PageHuge(old_page)) {
> +		/*
> +		 * Freed from under us. Drop new_page too.
> +		 */
> +		goto free_new;
> +	} else if (page_count(old_page)) {
> +		/*
> +		 * Someone has grabbed the page, fail for now.
> +		 */
> +		ret = -EBUSY;
> +		goto free_new;
> +	} else if (!HPageFreed(old_page)) {
> +		/*
> +		 * Page's refcount is 0 but it has not been enqueued in the
> +		 * freelist yet. Race window is small, so we can succeed here if
> +		 * we retry.
> +		 */
> +		spin_unlock_irq(&hugetlb_lock);
> +		cond_resched();
> +		goto retry;
> +	} else {
> +		/*
> +		 * Ok, old_page is still a genuine free hugepage. Remove it from
> +		 * the freelist and decrease the counters. These will be
> +		 * incremented again when calling __prep_account_new_huge_page()
> +		 * and enqueue_huge_page() for new_page. The counters will remain
> +		 * stable since this happens under the lock.
> +		 */
> +		remove_hugetlb_page(h, old_page, false);
> +
> +		/*
> +		 * Call __prep_new_huge_page() to construct the hugetlb page, and
> +		 * enqueue it then to place it in the freelists. After this,
> +		 * counters are back on track. Free hugepages have a refcount of 0,
> +		 * so we need to decrease new_page's count as well.
> +		 */
> +		__prep_new_huge_page(new_page);
> +		__prep_account_new_huge_page(h, nid);
> +		page_ref_dec(new_page);
> +		enqueue_huge_page(h, new_page);
> +
> +		/*
> +		 * Pages have been replaced, we can safely free the old one.
> +		 */
> +		spin_unlock_irq(&hugetlb_lock);
> +		update_and_free_page(h, old_page);
> +	}
> +
> +	return ret;
> +
> +free_new:
> +	spin_unlock_irq(&hugetlb_lock);
> +	__free_pages(new_page, huge_page_order(h));
> +
> +	return ret;
> +}
> +
> +int isolate_or_dissolve_huge_page(struct page *page)
> +{
> +	struct hstate *h;
> +	struct page *head;
> +
> +	/*
> +	 * The page might have been dissolved from under our feet, so make sure
> +	 * to carefully check the state under the lock.
> +	 * Return success when racing as if we dissolved the page ourselves.
> +	 */
> +	spin_lock_irq(&hugetlb_lock);
> +	if (PageHuge(page)) {
> +		head = compound_head(page);
> +		h = page_hstate(head);
> +	} else {
> +		spin_unlock(&hugetlb_lock);
> +		return 0;
> +	}
> +	spin_unlock_irq(&hugetlb_lock);
> +
> +	/*
> +	 * Fence off gigantic pages as there is a cyclic dependency between
> +	 * alloc_contig_range and them. Return -ENOME as this has the effect

s/-ENOME/-ENOMEM/

> +	 * of bailing out right away without further retrying.
> +	 */
> +	if (hstate_is_gigantic(h))
> +		return -ENOMEM;
> +
> +	return alloc_and_dissolve_huge_page(h, head);
> +}
> +
>   struct page *alloc_huge_page(struct vm_area_struct *vma,
>   				    unsigned long addr, int avoid_reserve)
>   {
> 

Complicated stuff, but looks good to me.

-- 
Thanks,

David / dhildenb

