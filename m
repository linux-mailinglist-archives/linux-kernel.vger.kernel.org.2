Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B433609A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhDOMmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhDOMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618490544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ar7jE+OGjgWhr4Cr/7k8/to/kgomCc9gO1itsRhfVjo=;
        b=EP9jyR0vxQhkoqXFevQtJFSImtQA2+hHYMeMy9eFDnC47W0M9nHPDkWRlrWLpqFVdd3HFB
        szecMVZbJLsLq8QTNWHIFsGkjvvdRZ7iktuW8Cfd5MuokgJU84FzDadyMyD+aD1EzgHxXy
        zKqLqDO0KwJTqLQ6QFnVgjK2NbFuynw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-NBlR8yVuOSCISeXUZS5MTg-1; Thu, 15 Apr 2021 08:42:22 -0400
X-MC-Unique: NBlR8yVuOSCISeXUZS5MTg-1
Received: by mail-wr1-f69.google.com with SMTP id d15-20020a5d538f0000b02901027c18c581so2679643wrv.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ar7jE+OGjgWhr4Cr/7k8/to/kgomCc9gO1itsRhfVjo=;
        b=kfNMpx0pmwpJPNQj5EFHnX/Kn2XTfK+FWraSf0AgZ5tVWrA++qgE0Or1uHptTLB7wO
         6V8m8CsmVqttKFefE+SvqyqAICl9SFgnQ+6sUsnMymdJCAcr5qwI2ZEjFxwUDYwNdxUZ
         URkx0uXHIwxHgVeLz2iBciUEWx0CfoYL3lSycp/wSB9gHNQynke+N8zJ/WRML50hbOxh
         JxaML6e6Qd+Zbs0rcf4KoC4FdQvbTOIKFF+KP/9/TASus/u6vuwTV/pttaSIash59dHd
         Qk7jT0knasWoZBf0pnYZ2YZrnstTE2nnFmdkek+Nl3NVkrgpOr8PtWohh8JGAGPFzmIE
         sXLw==
X-Gm-Message-State: AOAM532HIAzS1MCFwUMVAnfMgjolm+IKj7bxgB9YdoXEpg20Stb8BnAS
        5K35g4Gex++MQRggjOx6oOGX6UMFHXV7LT+nnkj8Scm6hdg0Pz1rv+yTxg8t83t5W/oy+3veshJ
        ZfGYw1otvqib8KD+sZlqNmomb
X-Received: by 2002:a5d:658c:: with SMTP id q12mr3398347wru.30.1618490541374;
        Thu, 15 Apr 2021 05:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy70NNG0NvXrtbxBSPuoc+/nExBGycC8ugDorCmUYmJFJyQFhnrWCbd70HcbUQjCzoKdJC/+A==
X-Received: by 2002:a5d:658c:: with SMTP id q12mr3398324wru.30.1618490541195;
        Thu, 15 Apr 2021 05:42:21 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6392.dip0.t-ipconnect.de. [91.12.99.146])
        by smtp.gmail.com with ESMTPSA id w4sm2848464wrp.58.2021.04.15.05.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 05:42:20 -0700 (PDT)
Subject: Re: [PATCH v8 4/7] mm,hugetlb: Split prep_new_huge_page functionality
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
References: <20210415103544.6791-1-osalvador@suse.de>
 <20210415103544.6791-5-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <021eb32f-9664-8a1b-c3eb-9d51ca4fe21a@redhat.com>
Date:   Thu, 15 Apr 2021 14:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415103544.6791-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.21 12:35, Oscar Salvador wrote:
> Currently, prep_new_huge_page() performs two functions.
> It sets the right state for a new hugetlb, and increases the hstate's
> counters to account for the new page.
> 
> Let us split its functionality into two separate functions, decoupling
> the handling of the counters from initializing a hugepage.
> The outcome is having __prep_new_huge_page(), which only
> initializes the page , and __prep_account_new_huge_page(), which adds
> the new page to the hstate's counters.
> 
> This allows us to be able to set a hugetlb without having to worry
> about the counter/locking. It will prove useful in the next patch.
> prep_new_huge_page() still calls both functions.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2cb9fa79cbaa..6f39ec79face 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1483,16 +1483,30 @@ void free_huge_page(struct page *page)
>   	}
>   }
>   
> -static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> +/*
> + * Must be called with the hugetlb lock held
> + */
> +static void __prep_account_new_huge_page(struct hstate *h, int nid)
> +{
> +	lockdep_assert_held(&hugetlb_lock);
> +	h->nr_huge_pages++;
> +	h->nr_huge_pages_node[nid]++;
> +}
> +
> +static void __prep_new_huge_page(struct page *page)
>   {
>   	INIT_LIST_HEAD(&page->lru);
>   	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>   	hugetlb_set_page_subpool(page, NULL);
>   	set_hugetlb_cgroup(page, NULL);
>   	set_hugetlb_cgroup_rsvd(page, NULL);
> +}
> +
> +static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> +{
> +	__prep_new_huge_page(page);
>   	spin_lock_irq(&hugetlb_lock);
> -	h->nr_huge_pages++;
> -	h->nr_huge_pages_node[nid]++;
> +	__prep_account_new_huge_page(h, nid);
>   	spin_unlock_irq(&hugetlb_lock);
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

