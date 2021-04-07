Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6313567F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbhDGJ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234982AbhDGJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617787575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZ6F1n0wTtnlMAc/tCrCPKwUwC4ZUSP/WUpt6+RgyCY=;
        b=eva5I2EUAqT/4bV3K4CJ5DGSDlmwcWOXB/0JRLH0RvuZY8E9JKqlFgQ1Qej4WjP9vRmqc1
        BmCzOsU4g1cAQWvXp3AQTr7ZpuOHuyeaZRDT3x6GAqIb5LS2l8g2DWo56hW+9c7oLXtq7+
        oLnbH1RlkBhK2u1qrm7ht97KgfJBvT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-p6gOa0MsNPGlWpLQAU0gZQ-1; Wed, 07 Apr 2021 05:26:11 -0400
X-MC-Unique: p6gOa0MsNPGlWpLQAU0gZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C00558030CA;
        Wed,  7 Apr 2021 09:26:08 +0000 (UTC)
Received: from [10.36.114.68] (ovpn-114-68.ams2.redhat.com [10.36.114.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4720510023AF;
        Wed,  7 Apr 2021 09:26:03 +0000 (UTC)
Subject: Re: [PATCH v4 2/8] hugetlb: no need to drop hugetlb_lock to call
 cma_release
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
 <20210405230043.182734-3-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ab98837b-30b9-2fce-999b-ac4fc90115d6@redhat.com>
Date:   Wed, 7 Apr 2021 11:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210405230043.182734-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.21 01:00, Mike Kravetz wrote:
> Now that cma_release is non-blocking and irq safe, there is no need to
> drop hugetlb_lock before calling.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>   mm/hugetlb.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3c3e4baa4156..1d62f0492e7b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1353,14 +1353,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>   	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>   	set_page_refcounted(page);
>   	if (hstate_is_gigantic(h)) {
> -		/*
> -		 * Temporarily drop the hugetlb_lock, because
> -		 * we might block in free_gigantic_page().
> -		 */
> -		spin_unlock(&hugetlb_lock);
>   		destroy_compound_gigantic_page(page, huge_page_order(h));
>   		free_gigantic_page(page, huge_page_order(h));
> -		spin_lock(&hugetlb_lock);
>   	} else {
>   		__free_pages(page, huge_page_order(h));
>   	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

