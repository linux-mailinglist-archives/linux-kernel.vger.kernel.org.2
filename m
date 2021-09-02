Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594743FE9E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbhIBHVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242860AbhIBHVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630567209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHe29GsWYeThVgB4v24Lig4XybIq4Mhjph9NrrexDUI=;
        b=FIUeAZ+Z/PazulRkpmPT6AO1yRluYL5ltdppzMYdpANghkvXXRqqiX5kLV1iZ7pH6EHJTr
        +HacaPWTVfS+Km8Sce0At3GjZGRa7E3aGjfymytm7Nbic43E9LWXSQX+2TZArAyJQBdFJJ
        9cKhBg0dkcR5TaWayeUwudczMtei/XI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-IdnRNVsnMAWbXBM3GQmNjA-1; Thu, 02 Sep 2021 03:20:08 -0400
X-MC-Unique: IdnRNVsnMAWbXBM3GQmNjA-1
Received: by mail-wr1-f71.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso223792wrn.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 00:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yHe29GsWYeThVgB4v24Lig4XybIq4Mhjph9NrrexDUI=;
        b=TYSpGtyL4MYMxcT5BP40dVXAUKiVLv9Bx2lmWnn7U6VLEyi5Qw1vcClNzD+tMRqyx0
         OntwVsF0tJYJOLqKLBBpJUzgbA+lOMVV50ruOPR/NkvlijTKrfljwKkR9L4UUdSb7kUt
         2DT9CZ35T1ZAkjOXnSw+Ckd4Q9LaC4hkyLNzEo88ucB9FhgXOHHlr6Lcpd/AIJuE55s9
         vafaIGvcgmXoLF1nGSTolkURgm5POkNj6azPhyf3Xy5EfisM4s0WbYnr2pV8iIFNhkkI
         a2R3myhgxbvTA0gs5UW1aGkbLC295qO4uT/S92xZ6ATlXx8nMWA3ZX7NEWV/0usaX13z
         HPdA==
X-Gm-Message-State: AOAM5318e05c5+Y5ao+6EgiNfHBRzGDmJpzmRxbvP5xxnPwMivTRdTbQ
        Bm8afDVi8iTDKmzg/dSPY5Cr5VkYruIxo1WWBHgqPRWGof7dUS3psljuYmyBmqU546gmJztxa9B
        MKN784+oGqd3svfG4ELo+qdAj
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr1647331wmc.23.1630567207405;
        Thu, 02 Sep 2021 00:20:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsEKNjsbvVWbrQJsZ/T5V1paWGh4CBK2Z6E2eOCXZvlWYWIGVAIoAWJaVnEl44c1dqguLf3Q==
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr1647311wmc.23.1630567207205;
        Thu, 02 Sep 2021 00:20:07 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60bd.dip0.t-ipconnect.de. [91.12.96.189])
        by smtp.gmail.com with ESMTPSA id q13sm956103wrv.79.2021.09.02.00.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 00:20:06 -0700 (PDT)
Subject: Re: [PATCH 2/5] mm: Clear vmf->pte after pte_unmap_same() returns
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
References: <20210901205622.6935-1-peterx@redhat.com>
 <20210901205622.6935-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <51db1487-053f-7009-8321-9c28f9c5798b@redhat.com>
Date:   Thu, 2 Sep 2021 09:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901205622.6935-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 22:56, Peter Xu wrote:
> pte_unmap_same() will always unmap the pte pointer.  After the unmap, vmf->pte
> will not be valid any more, we should clear it.
> 
> It was safe only because no one is accessing vmf->pte after pte_unmap_same()
> returns, since the only caller of pte_unmap_same() (so far) is do_swap_page(),
> where vmf->pte will in most cases be overwritten very soon.
> 
> Directly pass in vmf into pte_unmap_same() and then we can also avoid the long
> parameter list too, which should be a nice cleanup.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/memory.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 25fc46e87214..204141e8a53d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2724,19 +2724,20 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
>    * proceeding (but do_wp_page is only called after already making such a check;
>    * and do_anonymous_page can safely check later on).
>    */
> -static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
> -				pte_t *page_table, pte_t orig_pte)
> +static inline int pte_unmap_same(struct vm_fault *vmf)
>   {
>   	int same = 1;
>   #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
>   	if (sizeof(pte_t) > sizeof(unsigned long)) {
> -		spinlock_t *ptl = pte_lockptr(mm, pmd);
> +		spinlock_t *ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
>   		spin_lock(ptl);
> -		same = pte_same(*page_table, orig_pte);
> +		same = pte_same(*vmf->pte, vmf->orig_pte);
>   		spin_unlock(ptl);
>   	}
>   #endif
> -	pte_unmap(page_table);
> +	pte_unmap(vmf->pte);
> +	/* After unmap of pte, the pointer is invalid now - clear it. */

I'd just drop the comment, it's what we do in similar code.

> +	vmf->pte = NULL;
>   	return same;
>   }
>   
> @@ -3487,7 +3488,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	vm_fault_t ret = 0;
>   	void *shadow = NULL;
>   
> -	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
> +	if (!pte_unmap_same(vmf))
>   		goto out;

Funny, I prototyped something similar yesterday. I did it via


same = pte_lock_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte);
pte_unmap(vmf->pte);
vmf->pte = NULL;
if (!same)
	goto out;

To just move handling to the caller.


But this also looks fine, whatever you prefer.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

