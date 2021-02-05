Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4E310700
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBEItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:49:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhBEIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612514845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtAB+E6c/TYBQZzlkX08yekPP1vLvgQfj0ltXVt2MOI=;
        b=CWAS3XiiybAR+cVuW/cvFs8IHdrRGDB+0VmnAbkEA0iO4io9vtZREyP9VmM+y8Wn29+xHU
        SYGIlR7yd2yPbXh/6V+OoOtyk2MQSAoiN/f4wjfS498SV+TDU9AkN5hqyUx14gYQ28HjnX
        j2WFUGj40BIRLxIKHdtcB3zoW+2MYrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-thrY_TvcNtuKmhP4wp5wyA-1; Fri, 05 Feb 2021 03:47:23 -0500
X-MC-Unique: thrY_TvcNtuKmhP4wp5wyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F75179EC2;
        Fri,  5 Feb 2021 08:47:22 +0000 (UTC)
Received: from [10.36.113.156] (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D855A5D9D3;
        Fri,  5 Feb 2021 08:47:20 +0000 (UTC)
Subject: Re: [PATCH] hugetlb_cgroup: use helper pages_per_huge_page() in
 hugetlb_cgroup
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210205084513.29624-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e1991759-c036-0b94-465f-fe9e58c1c322@redhat.com>
Date:   Fri, 5 Feb 2021 09:47:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210205084513.29624-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.02.21 09:45, Miaohe Lin wrote:
> We could use helper function pages_per_huge_page() to get the number of
> pages in a hstate to simplify the code slightly.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/hugetlb_cgroup.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 8909e075d441..86b5cc128584 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -113,7 +113,7 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
>   			rsvd_parent);
>   
>   		limit = round_down(PAGE_COUNTER_MAX,
> -				   1 << huge_page_order(&hstates[idx]));
> +				   pages_per_huge_page(&hstates[idx]));
>   
>   		ret = page_counter_set_max(
>   			hugetlb_cgroup_counter_from_cgroup(h_cgroup, idx),
> @@ -466,7 +466,7 @@ static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
>   	counter = &h_cg->hugepage[idx];
>   
>   	limit = round_down(PAGE_COUNTER_MAX,
> -			   1 << huge_page_order(&hstates[idx]));
> +			   pages_per_huge_page(&hstates[idx]));
>   
>   	switch (MEMFILE_ATTR(cft->private)) {
>   	case RES_RSVD_USAGE:
> @@ -513,7 +513,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
>   		return ret;
>   
>   	idx = MEMFILE_IDX(of_cft(of)->private);
> -	nr_pages = round_down(nr_pages, 1 << huge_page_order(&hstates[idx]));
> +	nr_pages = round_down(nr_pages, pages_per_huge_page(&hstates[idx]));
>   
>   	switch (MEMFILE_ATTR(of_cft(of)->private)) {
>   	case RES_RSVD_LIMIT:
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

