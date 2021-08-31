Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2859D3FC538
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbhHaJyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240676AbhHaJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adPlHXi23O+FflMxYXwYC0KWMEstkM3rAyfgF/lEnWk=;
        b=cHlgRhSXWi0CNAuPe2Q9lRtQHkv1BVRX66XDYgmcg9SkG0nya5hRBQgsjR88VUbjdl9pdj
        utLww7gkWLQ43uPMfUADrjDhPv4TJLLGmzXmWB3LfLv7cenArgfvN1YaW4GYZXXRITi/fl
        qn00iif5rxDXnmI6AaHFg+Y1AO26vL0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-OGafm1deP6i7u6HLYssE5A-1; Tue, 31 Aug 2021 05:53:08 -0400
X-MC-Unique: OGafm1deP6i7u6HLYssE5A-1
Received: by mail-wr1-f72.google.com with SMTP id p1-20020adfcc81000000b001576cccf12cso3894096wrj.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=adPlHXi23O+FflMxYXwYC0KWMEstkM3rAyfgF/lEnWk=;
        b=MYBm3PaPU5HYTKPgOKdUPtB2LPgJVTmXXeDxrnguqaI4152U1jybtLlev7QweTiefs
         J6gU19/W106sn3DJ41fXDz0yiyVi86iXy5agFn+gmqUlQAiDw/P7NVavn37zbSH52fFq
         uygAaPRdVgKRsxD3c5j3fGdUtqund1EqrnhfNFcVlynK7+EIjPTDhxInEZWEyp8x7/P/
         w06Nmao1AiIdg4pMZEY/WSS5MlJ6je+cb4sVCGaiqTA5/jGCAgi18TAdEN+yiD87YcGV
         pp0KhLWJWFGjFffeuGYeEXPE8RqafcwbqJma+lZAAeC4/hJutxfTX8GZ1qsJrUylQhTP
         PY+A==
X-Gm-Message-State: AOAM531Qi09/sZLOQ6bfCv+ANeBm1qqcn/uYc/wy8Kn+Zn66uOOKruXN
        Se9N8SBB6IcW8G8oeKOzW4385DyndBj2b7JEwOPRawPVYm+RqaMwCkCq5D2YZLZVDoyuUxR49AF
        AAQP/ELAEXjBd2Pn57B7xcD1q
X-Received: by 2002:a1c:2289:: with SMTP id i131mr3286004wmi.179.1630403587347;
        Tue, 31 Aug 2021 02:53:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVJc8ZHngkq/rrH5Ya3sDKRqcKDY6u7TUfy3abVk7wXx7rhAj7yK8yyPOS0sADozq8JQN0Ag==
X-Received: by 2002:a1c:2289:: with SMTP id i131mr3285982wmi.179.1630403587101;
        Tue, 31 Aug 2021 02:53:07 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id f17sm1944177wmf.4.2021.08.31.02.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 02:53:06 -0700 (PDT)
To:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org
Cc:     markubo@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
References: <20210827150400.6305-1-sj38.park@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/damon/vaddr: Safely walk page table
Message-ID: <daa567fe-3026-669a-d4a4-bdbaff036fe6@redhat.com>
Date:   Tue, 31 Aug 2021 11:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827150400.6305-1-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.21 17:04, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Commit d7f647622761 ("mm/damon: implement primitives for the virtual
> memory address spaces") of linux-mm[1] tries to find PTE or PMD for
> arbitrary virtual address using 'follow_invalidate_pte()' without proper
> locking[2].  This commit fixes the issue by using another page table
> walk function for more general use case under proper locking.
> 
> [1] https://github.com/hnaz/linux-mm/commit/d7f647622761
> [2] https://lore.kernel.org/linux-mm/3b094493-9c1e-6024-bfd5-7eca66399b7e@redhat.com
> 
> Fixes: d7f647622761 ("mm/damon: implement primitives for the virtual memory address spaces")
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>   mm/damon/vaddr.c | 81 +++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 230db7413278..b3677f2ef54b 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -8,10 +8,12 @@
>   #define pr_fmt(fmt) "damon-va: " fmt
>   
>   #include <linux/damon.h>
> +#include <linux/hugetlb.h>
>   #include <linux/mm.h>
>   #include <linux/mmu_notifier.h>
>   #include <linux/highmem.h>
>   #include <linux/page_idle.h>
> +#include <linux/pagewalk.h>
>   #include <linux/random.h>
>   #include <linux/sched/mm.h>
>   #include <linux/slab.h>
> @@ -446,14 +448,69 @@ static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   }
>   
> +struct damon_walk_private {
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	spinlock_t *ptl;
> +};
> +
> +static int damon_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> +		struct mm_walk *walk)
> +{
> +	struct damon_walk_private *priv = walk->private;
> +
> +	if (pmd_huge(*pmd)) {
> +		priv->ptl = pmd_lock(walk->mm, pmd);
> +		if (pmd_huge(*pmd)) {
> +			priv->pmd = pmd;
> +			return 0;
> +		}
> +		spin_unlock(priv->ptl);
> +	}
> +
> +	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
> +		return -EINVAL;
> +	priv->pte = pte_offset_map_lock(walk->mm, pmd, addr, &priv->ptl);
> +	if (!pte_present(*priv->pte)) {
> +		pte_unmap_unlock(priv->pte, priv->ptl);
> +		priv->pte = NULL;
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static struct mm_walk_ops damon_walk_ops = {
> +	.pmd_entry = damon_pmd_entry,
> +};
> +
> +int damon_follow_pte_pmd(struct mm_struct *mm, unsigned long addr,
> +		struct damon_walk_private *private)
> +{
> +	int rc;
> +
> +	private->pte = NULL;
> +	private->pmd = NULL;
> +	rc = walk_page_range(mm, addr, addr + 1, &damon_walk_ops, private);
> +	if (!rc && !private->pte && !private->pmd)
> +		return -EINVAL;
> +	return rc;
> +}
> +
>   static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
>   {
> -	pte_t *pte = NULL;
> -	pmd_t *pmd = NULL;
> +	struct damon_walk_private walk_result;
> +	pte_t *pte;
> +	pmd_t *pmd;
>   	spinlock_t *ptl;
>   
> -	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
> +	mmap_write_lock(mm);

Can you elaborate why mmap_read_lock() isn't sufficient for your use 
case? The write mode might heavily affect damon performance and workload 
impact.


Also, I wonder if it wouldn't be much easier and cleaner to just handle 
it completely in the .pmd_entry callback, instead of returning PMDs, 
PTEs, LOCKs, ... here.

You could have

static struct mm_walk_ops damon_mkold_ops = {
	.pmd_entry = damon_mkold_pmd_entry,
};

and

static struct mm_walk_ops damon_young_ops = {
	.pmd_entry = damon_young_pmd_entry,
};

And then just handle everything completely inside the callback, avoiding 
having to return locked PTEs, PMDs, .... and instead handling it at a 
single location. Simply forward the page_sz pointer in the latter case 
to damon_young_ops.


damon_va_mkold()/damon_va_young() would mostly only call 
walk_page_range() with the right ops and eventually convert some return 
values.

-- 
Thanks,

David / dhildenb

