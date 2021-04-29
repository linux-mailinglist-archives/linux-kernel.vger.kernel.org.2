Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3936E684
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbhD2IE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239881AbhD2IEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619683442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yROuGbeUEgCGpxT1QPFa4L1x3UhTY7TTPslf1Y0MM/A=;
        b=Aw28oMvZ0vZIUm4lpse3bI2vvcDtghaFCn/o1WETqdIjURsUtdX9cRACUmFYJ6Rb04Yl1y
        E3rWMCl0GugRXoiRV7jgnnB2pu2FJfwBd+jWf1LgVP+kgte6ThRITw5A8xOXLYGaI8e7ge
        VHipEgsEE08GUjm2LRsMbLfHzY6Ioss=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-e76buzZQPeyOvFrpnDPirw-1; Thu, 29 Apr 2021 04:04:00 -0400
X-MC-Unique: e76buzZQPeyOvFrpnDPirw-1
Received: by mail-wr1-f69.google.com with SMTP id 4-20020adf80040000b029010cab735fdeso5205786wrk.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yROuGbeUEgCGpxT1QPFa4L1x3UhTY7TTPslf1Y0MM/A=;
        b=aB3MR6I5RDm7BLlLFuWL06SGg7kfT3gsbK3+olZ8QExmvSIs0fkwNdX/wN8/bDYUHJ
         CbnKmK/n1ziCwJkcC+nyVoqC9T0FJgEyYaXXhdJZ8WSw2IdbliP043Y8tjKmyDUgx3aa
         l0pEfBEsOXFVW504jfMvTZNfaPO41XK/YpvIo8UTGZHjTXExuP9I6OA8yw7/wGH9/zF/
         2a7rjtb9UUhsuFGuKWQ7x2EQKEb8zoU1JyaLoAyqEfukNJoWZP4erDOSj29iu98/EWKw
         IwXFGd6/fgK5+pysRO1ssZiWSP8Rwpxi5evbhMFxrvYVVXsE/b0JU8MtmQnUJpKy1QlA
         p+wg==
X-Gm-Message-State: AOAM530IVs87m676U6RX7+q1G7ZuHiULzOL51ELwEcUW2zcjlhe2OdP8
        2FYkewyFxqsHOx6Z2rN5QM6bMnYx2UEigQh3W7vxuhIqi3WV/YjnzfJyiGF6PB28n0LA0SKTLVw
        i5818qFrIa0J3rN+j4vON9EZC
X-Received: by 2002:adf:dd50:: with SMTP id u16mr42623904wrm.380.1619683438939;
        Thu, 29 Apr 2021 01:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuQnzH7+LlnvNv1KQ6IDmWoKufQpseUTeodtg+n2IDhGUZTQyY3Wf+IV7GlJMBU8uHpNc21g==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr42623874wrm.380.1619683438660;
        Thu, 29 Apr 2021 01:03:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6158.dip0.t-ipconnect.de. [91.12.97.88])
        by smtp.gmail.com with ESMTPSA id r19sm8770567wmq.33.2021.04.29.01.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 01:03:58 -0700 (PDT)
Subject: Re: [PATCH 1/6] mm/thp: Simplify copying of huge zero page pmd when
 fork
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
References: <20210428225030.9708-1-peterx@redhat.com>
 <20210428225030.9708-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <fda0fbd3-dcbc-f461-6f08-f0de93c3d30b@redhat.com>
Date:   Thu, 29 Apr 2021 10:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210428225030.9708-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 00:50, Peter Xu wrote:
> Huge zero page is handled in a special path in copy_huge_pmd(), however it
> should share most codes with a normal thp page.  Trying to share more code with
> it by removing the special path.  The only leftover so far is the huge zero
> page refcounting (mm_get_huge_zero_page()), because that's separately done with
> a global counter.
> 
> This prepares for a future patch to modify the huge pmd to be installed, so
> that we don't need to duplicate it explicitly into huge zero page case too.
> 
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/huge_memory.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 98456017744d6..22bf2d0fff79b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1076,17 +1076,13 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   	 * a page table.
>   	 */
>   	if (is_huge_zero_pmd(pmd)) {
> -		struct page *zero_page;
>   		/*
>   		 * get_huge_zero_page() will never allocate a new page here,
>   		 * since we already have a zero page to copy. It just takes a
>   		 * reference.
>   		 */
> -		zero_page = mm_get_huge_zero_page(dst_mm);
> -		set_huge_zero_page(pgtable, dst_mm, vma, addr, dst_pmd,
> -				zero_page);
> -		ret = 0;
> -		goto out_unlock;
> +		mm_get_huge_zero_page(dst_mm);
> +		goto out_zero_page;
>   	}
>   
>   	src_page = pmd_page(pmd);
> @@ -1110,6 +1106,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   	get_page(src_page);
>   	page_dup_rmap(src_page, true);
>   	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +out_zero_page:
>   	mm_inc_nr_ptes(dst_mm);
>   	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
>   
> 

AFAIKs, the only change is that we're now doing an additional

pmdp_set_wrprotect(src_mm, addr, src_pmd)
pmd = pmd_mkold(pmd_wrprotect(pmd));

But as we are copying the zeropage, it should already be 
write-protected, so no effective change.

LGTM

-- 
Thanks,

David / dhildenb

