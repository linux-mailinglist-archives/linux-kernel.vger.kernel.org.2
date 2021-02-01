Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE530A5F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhBAK4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233300AbhBAK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612176895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DD4mokRPZD1wfFQpRszoR6T0yfqXsqqAJBdhLKkcJOY=;
        b=WnytMSfNg1PUOBasQ/4+oanLqCfWHUbb5UG1PIK/Wa4WwzLRBr4/Id/ceb4a5Nx4sGIi3o
        E9viuv6fhvdH4WBGYQFZhgYEFrKOqkaO260zvfcGRRguCZrk+/nor+mylOD2ZXQmXp0cPa
        Fqwcot6TWTkXGEag4MLSc5MqnDwqBm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-hjen9oOgOcKNMV0I7C0dKg-1; Mon, 01 Feb 2021 05:54:53 -0500
X-MC-Unique: hjen9oOgOcKNMV0I7C0dKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B42B1005504;
        Mon,  1 Feb 2021 10:54:52 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8A721840B;
        Mon,  1 Feb 2021 10:54:51 +0000 (UTC)
Subject: Re: [PATCH] mm/huge_memory.c: use helper range_in_vma() in
 __split_huge_p[u|m]d_locked()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210201093259.52798-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b3b4aabb-f98b-6514-61ac-03f0c62f4b0a@redhat.com>
Date:   Mon, 1 Feb 2021 11:54:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210201093259.52798-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.21 10:32, Miaohe Lin wrote:
> The helper range_in_vma() is introduced via commit 017b1660df89 ("mm:
> migration: fix migration of huge PMD shared pages"). But we forgot to
> use it in __split_huge_pud_locked() and __split_huge_pmd_locked().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/huge_memory.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 987cf5e4cf90..33353a4f95fb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1959,8 +1959,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>   		unsigned long haddr)
>   {
>   	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
> -	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
> -	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
> +	VM_BUG_ON_VMA(!range_in_vma(vma, haddr, haddr + HPAGE_PUD_SIZE), vma);
>   	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
>   
>   	count_vm_event(THP_SPLIT_PUD);
> @@ -2039,8 +2038,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   	int i;
>   
>   	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
> -	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
> -	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
> +	VM_BUG_ON_VMA(!range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE), vma);
>   	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
>   				&& !pmd_devmap(*pmd));
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

