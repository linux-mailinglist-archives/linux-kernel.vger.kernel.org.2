Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D596436ECEC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhD2PD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhD2PDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619708557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdMySnQAmB6rNT6+jogSDdKQ2HhVWfHBEjIsczqBe4Y=;
        b=SLDM1KxIGlAZZJYOyZfLfj0dAST0TC6HXQUI07W6pQJ3g1mVttrcpsRDsX2/qRL/TAmswA
        c3pfRjnmfxpX3Jz2mQ4OECrKS8o/StriNSTJ3UoERk2Heon34G00wJeATVl9HAr55IC/vy
        BRrDBOnH6X5wrvaVuvuuI/eeyFq1Vp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-nJBefy6qN4yuf7M4tpL6eA-1; Thu, 29 Apr 2021 11:02:33 -0400
X-MC-Unique: nJBefy6qN4yuf7M4tpL6eA-1
Received: by mail-wm1-f71.google.com with SMTP id y184-20020a1ce1c10000b0290143299f39d7so2924840wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xdMySnQAmB6rNT6+jogSDdKQ2HhVWfHBEjIsczqBe4Y=;
        b=WMEAoUJlVBVJFxTdpe3HVuq5VPZ2j5W2xpDQpwWF9etybhJbuPdmu4zEGfvcmzhAAV
         J/qfE4q/W7qeKe5DhxTZ/91U6Jpned2RtezF0FSmB34EuOxGtdpQ5YWTMI8xfKS8Gbzm
         9vCLw8n8SmJ5MC/p1/3NSh6EgtYHd2xgit1DEaqmM0nvvB0SckCX2fNyf3linPc83JSN
         9nQQ9q7YMDlBI3hFicv/g2S5uBUBhJRGRlfZp6AZOKaieSRm56jocd4XK+ASFVTRz+d/
         tJtKfFP4N48s1mEd9wrq9nT/Q/fgF4TEh7mqH+opili3yhKVpON9Qk1s0zYshwppyR3F
         H2CA==
X-Gm-Message-State: AOAM530EK92LK+hCI+JofEFMJgX+NmyiEdEKXCGZp3C/9wqj3vV+U0DK
        Xac3mxBX8G6fmjm2CJWtiqmWm/UpXZ4qNXhtGDae2N0RXzJ1hSR6bpwQRfVLDlt+l0Sis3dMJTi
        82qg8Q8ff+gwr+NmxPMQLa/Cq
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr433355wmj.175.1619708552046;
        Thu, 29 Apr 2021 08:02:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVmC0YQ8yWtx9WOhJSq1hs5RMGemUIOou6z5QyX84IKGnzum5fv69U4+GLRPkiN4uR3v6sYg==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr433332wmj.175.1619708551792;
        Thu, 29 Apr 2021 08:02:31 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6158.dip0.t-ipconnect.de. [91.12.97.88])
        by smtp.gmail.com with ESMTPSA id l5sm317821wmh.0.2021.04.29.08.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 08:02:31 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] mm/huge_memory.c: remove unnecessary
 tlb_remove_page_size() for huge zero pmd
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Aaron Lu <aaron.lu@intel.com>
References: <20210429132648.305447-1-linmiaohe@huawei.com>
 <20210429132648.305447-5-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f1390cf8-6428-fd17-794b-cc2336cf238d@redhat.com>
Date:   Thu, 29 Apr 2021 17:02:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429132648.305447-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 15:26, Miaohe Lin wrote:
> Commit aa88b68c3b1d ("thp: keep huge zero page pinned until tlb flush")
> introduced tlb_remove_page() for huge zero page to keep it pinned until
> flush is complete and prevents the page from being split under us. But
> huge zero page is kept pinned until all relevant mm_users reach zero since
> the commit 6fcb52a56ff6 ("thp: reduce usage of huge zero page's atomic
> counter"). So tlb_remove_page_size() for huge zero pmd is unnecessary now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/huge_memory.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e24a96de2e37..af30338ac49c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1680,12 +1680,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		if (arch_needs_pgtable_deposit())
>   			zap_deposited_table(tlb->mm, pmd);
>   		spin_unlock(ptl);
> -		if (is_huge_zero_pmd(orig_pmd))
> -			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
>   	} else if (is_huge_zero_pmd(orig_pmd)) {
>   		zap_deposited_table(tlb->mm, pmd);
>   		spin_unlock(ptl);
> -		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
>   	} else {
>   		struct page *page = NULL;
>   		int flush_needed = 1;
> 

This sounds sane to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

