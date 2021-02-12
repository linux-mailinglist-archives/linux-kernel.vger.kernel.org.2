Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869AF319C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhBLJvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhBLJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613123409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibCpcRXbNGbZ0c4IJYIhAiMzMee7fTcrcQjumXKkexE=;
        b=ZiPggyrEGf1jhQUX+rjvXoRpeU2gKJo1xHhC2Xb7lb9AVaZY9WDugyuqlkOgZIGDRyMn6p
        FTVT3iywiNxv3Kx6t6LBGTAkbCW8P85McYp3rc3hDbJo80/QDUqRCPctu+eHIiG68nLhHD
        yYEfAEMfQBqngb3r6MR1SAlEh12cegA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-f0X1JRbpNYaYzLEOwMoXZA-1; Fri, 12 Feb 2021 04:50:05 -0500
X-MC-Unique: f0X1JRbpNYaYzLEOwMoXZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D89801975;
        Fri, 12 Feb 2021 09:50:04 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10FCC1F45B;
        Fri, 12 Feb 2021 09:50:02 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: use helper huge_page_size() to get
 hugepage size
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210209021803.49211-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <357ade66-8176-8ea6-92bd-f18fa540af93@redhat.com>
Date:   Fri, 12 Feb 2021 10:50:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210209021803.49211-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 03:18, Miaohe Lin wrote:
> We can use helper huge_page_size() to get the hugepage size directly to
> simplify the code slightly.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v1 -> v2
> 	change huge_page_size(h) >> 10 to huge_page_size(h) / SZ_1K
> 	collect Reviewed-by tag
> ---
>   mm/hugetlb.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18628f8dbfb0..06719fdf9fd6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3199,7 +3199,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>   	BUG_ON(order == 0);
>   	h = &hstates[hugetlb_max_hstate++];
>   	h->order = order;
> -	h->mask = ~((1ULL << (order + PAGE_SHIFT)) - 1);
> +	h->mask = ~(huge_page_size(h) - 1);
>   	for (i = 0; i < MAX_NUMNODES; ++i)
>   		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
>   	INIT_LIST_HEAD(&h->hugepage_activelist);
> @@ -3474,7 +3474,7 @@ void hugetlb_report_meminfo(struct seq_file *m)
>   	for_each_hstate(h) {
>   		unsigned long count = h->nr_huge_pages;
>   
> -		total += (PAGE_SIZE << huge_page_order(h)) * count;
> +		total += huge_page_size(h) * count;
>   
>   		if (h == &default_hstate)
>   			seq_printf(m,
> @@ -3487,10 +3487,10 @@ void hugetlb_report_meminfo(struct seq_file *m)
>   				   h->free_huge_pages,
>   				   h->resv_huge_pages,
>   				   h->surplus_huge_pages,
> -				   (PAGE_SIZE << huge_page_order(h)) / 1024);
> +				   huge_page_size(h) / SZ_1K);
>   	}
>   
> -	seq_printf(m, "Hugetlb:        %8lu kB\n", total / 1024);
> +	seq_printf(m, "Hugetlb:        %8lu kB\n", total / SZ_1K);
>   }
>   
>   int hugetlb_report_node_meminfo(char *buf, int len, int nid)
> @@ -3524,7 +3524,7 @@ void hugetlb_show_meminfo(void)
>   				h->nr_huge_pages_node[nid],
>   				h->free_huge_pages_node[nid],
>   				h->surplus_huge_pages_node[nid],
> -				1UL << (huge_page_order(h) + PAGE_SHIFT - 10));
> +				huge_page_size(h) / SZ_1K);
>   }
>   
>   void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
> @@ -3647,9 +3647,7 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>   
>   static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
>   {
> -	struct hstate *hstate = hstate_vma(vma);
> -
> -	return 1UL << huge_page_shift(hstate);
> +	return huge_page_size(hstate_vma(vma));
>   }
>   
>   /*
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

