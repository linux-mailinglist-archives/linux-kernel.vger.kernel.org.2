Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170D6414FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhIVSXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236973AbhIVSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632334903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxWqvwn1W60zGEVdo9pDaah3Bkr4kJeRG9VF7vjOA+0=;
        b=BJFJ7Hnfa0slVb4xA+5GeoPFcn+AGPnBwU/s/XCfbl56BfYxcnwh7Fgbs9oL0HauND8uin
        JKMRp0Tf3uZ5dLaSQJPhGe3vCNVq271QxFoY0csvF+wdmOXsK6E5scvVQTSLEtIVK+HgI1
        jyBd4BPi8JVKB4blJZK6lLo8xG4bQNk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-npbwF4-qNCaUlloGoHkdZw-1; Wed, 22 Sep 2021 14:21:42 -0400
X-MC-Unique: npbwF4-qNCaUlloGoHkdZw-1
Received: by mail-wr1-f72.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so2971751wrf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HxWqvwn1W60zGEVdo9pDaah3Bkr4kJeRG9VF7vjOA+0=;
        b=bTWepEFkQ9UfsuQjZClCWijdDNEvaotYO6kuThvec5vXUeSuhfNzxHL8dhlNo6DXNC
         Aj4IHQF29Bbk19n7huq8KEgPnAVy89UorZXRmHAV94psZUd0O9vk4RyAUXPsQMKQ5nXa
         rVlz6fgvzvfGhJpwY1aEQX9kp0WBP29icKzGVHdESwyMhnfAXe2AtNsEMbX4nsuXciV2
         7g6pCnzNX6j4YxPav33iPlsnao5NDPiOTj8SwE02rBW2oeqrh3mHAMzzAbMuz3Bj3snW
         0YHgg9KlhwWvfQ68KWKVAa2+Tl1BEYsxPTWboTc4J07l+BiywV+qKLRw/yCDVcL1UVF2
         WWxQ==
X-Gm-Message-State: AOAM532LdREXA36PDgH+fDMVIqnt9vWaot7AjsA9UYTGgRaLURgQ3kyN
        naGmJPjqVZSWWp8BTyzOrv67t5gSlZBISRPmYiwExGPwmM7yDQxZ64VnTw+uYRlWyfqPhfpQZf4
        ac+1JUutAVUaklPa9U885u85b
X-Received: by 2002:adf:a2c4:: with SMTP id t4mr480805wra.258.1632334901606;
        Wed, 22 Sep 2021 11:21:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqZUcKBGyxg7Q7AiGxVq/7ww3aUAcI8z15wqMjB9dBOckRdHvxLQFjM28R9kkO/82pI55VNA==
X-Received: by 2002:adf:a2c4:: with SMTP id t4mr480793wra.258.1632334901361;
        Wed, 22 Sep 2021 11:21:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64dd.dip0.t-ipconnect.de. [91.12.100.221])
        by smtp.gmail.com with ESMTPSA id g131sm2717348wme.22.2021.09.22.11.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 11:21:40 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20210922175156.130228-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <6bbb8e29-9e21-dfbe-d23d-61de7e3cc6db@redhat.com>
Date:   Wed, 22 Sep 2021 20:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922175156.130228-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.21 19:51, Peter Xu wrote:
> We forbid merging thps for uffd-wp enabled regions, by breaking the khugepaged
> scanning right after we detected a uffd-wp armed pte (either present, or swap).
> 
> It works, but it's less efficient, because those ptes only exist for VM_UFFD_WP
> enabled VMAs.  Checking against the vma flag would be more efficient, and good
> enough.  To be explicit, we could still be able to merge some thps for
> VM_UFFD_WP regions before this patch as long as they have zero uffd-wp armed
> ptes, however that's not a major target for thp collapse anyways.
> 

Hm, are we sure there are no users that could benefit from the current 
handling?

I'm thinking about long-term uffd-wp users that effectively end up 
wp-ing on only a small fraction of a gigantic vma, or always wp complete 
blocks in a certain granularity in the range of THP.

Databases come to mind ...

In the past, I played with the idea of using uffd-wp to protect access 
to logically unplugged memory regions part of virtio-mem devices in QEMU 
-- which would exactly do something as described above. But I'll most 
probably be using ordinary uffd once any users that might read such 
logically unplugged memory have been "fixed".

The change itself looks sane to me AFAIKT.

> This mostly reverts commit e1e267c7928fe387e5e1cffeafb0de2d0473663a, but
> instead we do the same check at vma level, so it's not a bugfix.
> 
> This also paves the way for file-backed uffd-wp support, as the VM_UFFD_WP flag
> will work for file-backed too.
> 
> After this patch, the error for khugepaged for these regions will switch from
> SCAN_PTE_UFFD_WP to SCAN_VMA_CHECK.
> 
> Since uffd minor mode should not allow thp as well, do the same thing for minor
> mode to stop early on trying to collapse pages in khugepaged.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> Axel: as I asked in the other thread, please help check whether minor mode will
> work properly with shmem thp enabled.  If not, I feel like this patch could be
> part of that effort at last, but it's also possible that I missed something.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/trace/events/huge_memory.h |  1 -
>   mm/khugepaged.c                    | 26 +++-----------------------
>   2 files changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 4fdb14a81108..53532f5925c3 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -15,7 +15,6 @@
>   	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
>   	EM( SCAN_EXCEED_SHARED_PTE,	"exceed_shared_pte")		\
>   	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
> -	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
>   	EM( SCAN_PAGE_RO,		"no_writable_page")		\
>   	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
>   	EM( SCAN_PAGE_NULL,		"page_null")			\
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 045cc579f724..3afe66d48db0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -31,7 +31,6 @@ enum scan_result {
>   	SCAN_EXCEED_SWAP_PTE,
>   	SCAN_EXCEED_SHARED_PTE,
>   	SCAN_PTE_NON_PRESENT,
> -	SCAN_PTE_UFFD_WP,
>   	SCAN_PAGE_RO,
>   	SCAN_LACK_REFERENCED_PAGE,
>   	SCAN_PAGE_NULL,
> @@ -467,6 +466,9 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>   		return false;
>   	if (vma_is_temporary_stack(vma))
>   		return false;
> +	/* Don't allow thp merging for wp/minor enabled uffd regions */
> +	if (userfaultfd_wp(vma) || userfaultfd_minor(vma))
> +		return false;
>   	return !(vm_flags & VM_NO_KHUGEPAGED);
>   }
>   
> @@ -1246,15 +1248,6 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   		pte_t pteval = *_pte;
>   		if (is_swap_pte(pteval)) {
>   			if (++unmapped <= khugepaged_max_ptes_swap) {
> -				/*
> -				 * Always be strict with uffd-wp
> -				 * enabled swap entries.  Please see
> -				 * comment below for pte_uffd_wp().
> -				 */
> -				if (pte_swp_uffd_wp(pteval)) {
> -					result = SCAN_PTE_UFFD_WP;
> -					goto out_unmap;
> -				}
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_SWAP_PTE;
> @@ -1270,19 +1263,6 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>   				goto out_unmap;
>   			}
>   		}
> -		if (pte_uffd_wp(pteval)) {
> -			/*
> -			 * Don't collapse the page if any of the small
> -			 * PTEs are armed with uffd write protection.
> -			 * Here we can also mark the new huge pmd as
> -			 * write protected if any of the small ones is
> -			 * marked but that could bring unknown
> -			 * userfault messages that falls outside of
> -			 * the registered range.  So, just be simple.
> -			 */
> -			result = SCAN_PTE_UFFD_WP;
> -			goto out_unmap;
> -		}
>   		if (pte_write(pteval))
>   			writable = true;
>   
> 


-- 
Thanks,

David / dhildenb

