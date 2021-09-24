Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD39416F62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbhIXJqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245350AbhIXJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632476667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNWsaIW5r8Ia/jf0bDP1uX9hKz27LYVjBxSxbvymjgk=;
        b=LyqXKLiwrbvyy05brh/me8eFhv+MQmEqRzSHXo3JdkWT2Oyx27eI9LDQmY86APRmALLA8W
        XDu8ASp4FVcRe3ZggWDnfw5O+ASJQFMgit9r0wImZC0BZFXunlheRLXtzEeX9DNVcWVHSO
        uWX0xeBGuREO/cXgON1Ssta2Ai/L3XM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-GvHIgBkXO4atxYzzzW15gw-1; Fri, 24 Sep 2021 05:44:26 -0400
X-MC-Unique: GvHIgBkXO4atxYzzzW15gw-1
Received: by mail-wr1-f70.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so7567851wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wNWsaIW5r8Ia/jf0bDP1uX9hKz27LYVjBxSxbvymjgk=;
        b=g19ZUaPMDp6m9aYtxp8tDw3jpXoWUXMvcfOd+I9T6dBDT1NN6jboaRsHxv3f0QBynq
         7IUqSubmD9xNJ/346wzdmPgfD4CDKCQ8BKMgbxzbQY36rVchqX0ID8WQKVABxrs8iU0Y
         fJ1RNuVaPdKxjXXBFCvBzUrusFabX9fgbjSKIiOuTrIRXuJNyc5rTTLhiRd8cra7RtAx
         zWeV6oUw97HO4EBxoyfhlGX4jJMB+VofShZveMia1CiTTOt0oDzCSXVsjCxaAtoNAqDt
         NhJ2+R6I7eNFFmY70PsOZ38e3xKCw+KGQ2KVHP4mxSQborI5QBRPFJxrTL9hDJLsAMyD
         Qikg==
X-Gm-Message-State: AOAM530mHYEK25jviNHUo2aKyHWDY9R8xLdkaLQaX+TjrQHkhutHsb8t
        FkLap7VsQjWtFl4EMhKgOsv8TgkwEXt4mriec4fVG+k/q0ghjKUC9pNkKO2IVHgnbTw3M9VEyAT
        NpAEVXGGW8NnWEYTPdK6uPJPE
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr354457wml.124.1632476665448;
        Fri, 24 Sep 2021 02:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdW7sWPgbbBwY9n5QOJ/gMNSMpTCj1JwaIK9DIeDuWdOR19QGhwBMDORZZwrtO17Jpp8mfkw==
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr354438wml.124.1632476665259;
        Fri, 24 Sep 2021 02:44:25 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id h125sm8132304wmh.9.2021.09.24.02.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 02:44:24 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] hugetlb: add hugetlb demote page support
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-5-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9f469308-3c1c-dd9e-2c47-fcbd26b197df@redhat.com>
Date:   Fri, 24 Sep 2021 11:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210923175347.10727-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.21 19:53, Mike Kravetz wrote:
> Demote page functionality will split a huge page into a number of huge
> pages of a smaller size.  For example, on x86 a 1GB huge page can be
> demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
> splitting the huge page.
> 
> Added '*_for_demote' wrappers for remove_hugetlb_page,
> destroy_compound_gigantic_page and prep_compound_gigantic_page for use
> by demote code.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 75 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2317d411243d..ab7bd0434057 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1260,7 +1260,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>   		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
>   		nr_nodes--)
>   
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> +/* used to demote non-gigantic_huge pages as well */
>   static void __destroy_compound_gigantic_page(struct page *page,
>   					unsigned int order, bool demote)
>   {
> @@ -1283,6 +1283,13 @@ static void __destroy_compound_gigantic_page(struct page *page,
>   	__ClearPageHead(page);
>   }
>   
> +static void destroy_compound_gigantic_page_for_demote(struct page *page,
> +					unsigned int order)
> +{
> +	__destroy_compound_gigantic_page(page, order, true);
> +}
> +
> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>   static void destroy_compound_gigantic_page(struct page *page,
>   					unsigned int order)
>   {
> @@ -1428,6 +1435,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>   	__remove_hugetlb_page(h, page, adjust_surplus, false);
>   }
>   
> +static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
> +							bool adjust_surplus)
> +{
> +	__remove_hugetlb_page(h, page, adjust_surplus, true);
> +}
> +
>   static void add_hugetlb_page(struct hstate *h, struct page *page,
>   			     bool adjust_surplus)
>   {
> @@ -1777,6 +1790,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
>   	return __prep_compound_gigantic_page(page, order, false);
>   }
>   
> +static bool prep_compound_gigantic_page_for_demote(struct page *page,
> +							unsigned int order)
> +{
> +	return __prep_compound_gigantic_page(page, order, true);
> +}
> +
>   /*
>    * PageHuge() only returns true for hugetlbfs pages, but not for normal or
>    * transparent huge pages.  See the PageTransHuge() documentation for more
> @@ -3298,9 +3317,55 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>   	return 0;
>   }
>   
> +static int demote_free_huge_page(struct hstate *h, struct page *page)
> +{
> +	int i, nid = page_to_nid(page);
> +	struct hstate *target_hstate;
> +	bool cma_page = HPageCma(page);
> +
> +	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
> +
> +	remove_hugetlb_page_for_demote(h, page, false);
> +	spin_unlock_irq(&hugetlb_lock);
> +
> +	if (alloc_huge_page_vmemmap(h, page)) {
> +		/* Allocation of vmemmmap failed, we can not demote page */
> +		spin_lock_irq(&hugetlb_lock);
> +		set_page_refcounted(page);
> +		add_hugetlb_page(h, page, false);

I dislike using 0/1 as return values as it will just hide the actual issue.

This here would be -ENOMEM, right?



-- 
Thanks,

David / dhildenb

