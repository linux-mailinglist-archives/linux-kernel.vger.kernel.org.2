Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CFC3FC6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbhHaLrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232804AbhHaLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630410406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwvZYJk8XnuIWqXzPVZ+2IXhoVvLrsO62Vmv5jU4cQA=;
        b=Da3TOxSSA5kLocG9us+zaYf/tCm0FcMIYNV9bHIohWDclAmMugddpUdJ7VvEsCCEpXl1ho
        xDdOTG4lWYebPvre8oK6Qru4MjcAPZlKuvmMO8lFgyWjdL+acatRBH2oBg3mMGggf+HUZS
        M7wErEoQe2BUJvDc6TIBDQ0axTOr6Vs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-KPNDz1uJMx-NgYcQO205zA-1; Tue, 31 Aug 2021 07:46:45 -0400
X-MC-Unique: KPNDz1uJMx-NgYcQO205zA-1
Received: by mail-wr1-f72.google.com with SMTP id r11-20020a5d4e4b000000b001575c5ed4b4so3962716wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 04:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dwvZYJk8XnuIWqXzPVZ+2IXhoVvLrsO62Vmv5jU4cQA=;
        b=BdjyRgfQIvI/1GR1pL/BlMq5qmRUxaMcMv0ZpqGjNngJv49pBLYuwAa/Nbs3RRYrlg
         nXd16PQT9V73HHwh8MuHp0/nT1bn/64JF4LLp1ufq8vZ6ptQyftzHBqeLuTfzjLvMfWd
         OvXhetZNW7VnoWSWZFegIT1XJmhCe8skjRzY2jBJcbbD0+pwg/pJFoIfB5WeN3t71+6t
         rrKyRdeeNtPUKicnT7sp1RoQ30U/8DYaeFbUkvKpRhGDtk9WkXcbjmmxhoDSDVcskyPT
         iGQhehh0yHLxpMjjc3dfSShSlhUpRUZpMwNwS8xT1ky2geyul+HPRj6l9fujPdZL0ji9
         9clA==
X-Gm-Message-State: AOAM531v4lWhB1TkWuhno1OO1amIGvviIXtuSQWjG2DvYlrmQxbZFyYe
        KxykJBr3jRnwXSQIcdI8Mriz0e3rEmQAZsOqActVxdXOeY8Bobgexd13g8JQ2E2viKvGYFK4CDr
        1giPorupdxH7ZVslkFihW3adJ
X-Received: by 2002:a5d:6ca4:: with SMTP id a4mr31737895wra.140.1630410403903;
        Tue, 31 Aug 2021 04:46:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWivN3ytOnBv6WhYZLuUsIybCSCSVJtoThZlRY4JzF7a/aXHDCKKGjMNxUq57IcbWNKpMzHg==
X-Received: by 2002:a5d:6ca4:: with SMTP id a4mr31737878wra.140.1630410403669;
        Tue, 31 Aug 2021 04:46:43 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id p11sm2312570wma.16.2021.08.31.04.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 04:46:43 -0700 (PDT)
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     akpm@linux-foundation.org, markubo@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
References: <20210831104938.33548-1-sjpark@amazon.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/damon/vaddr: Safely walk page table
Message-ID: <d92a357b-c64c-aaf8-a69a-f00f93022013@redhat.com>
Date:   Tue, 31 Aug 2021 13:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831104938.33548-1-sjpark@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.21 12:49, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> On Tue, 31 Aug 2021 11:53:05 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 27.08.21 17:04, SeongJae Park wrote:
>>> From: SeongJae Park <sjpark@amazon.de>
>>>
>>> Commit d7f647622761 ("mm/damon: implement primitives for the virtual
>>> memory address spaces") of linux-mm[1] tries to find PTE or PMD for
>>> arbitrary virtual address using 'follow_invalidate_pte()' without proper
>>> locking[2].  This commit fixes the issue by using another page table
>>> walk function for more general use case under proper locking.
>>>
>>> [1] https://github.com/hnaz/linux-mm/commit/d7f647622761
>>> [2] https://lore.kernel.org/linux-mm/3b094493-9c1e-6024-bfd5-7eca66399b7e@redhat.com
>>>
>>> Fixes: d7f647622761 ("mm/damon: implement primitives for the virtual memory address spaces")
>>> Reported-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
>>> ---
>>>    mm/damon/vaddr.c | 81 +++++++++++++++++++++++++++++++++++++++++++-----
>>>    1 file changed, 74 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>>> index 230db7413278..b3677f2ef54b 100644
>>> --- a/mm/damon/vaddr.c
>>> +++ b/mm/damon/vaddr.c
>>> @@ -8,10 +8,12 @@
>>>    #define pr_fmt(fmt) "damon-va: " fmt
>>>    
>>>    #include <linux/damon.h>
>>> +#include <linux/hugetlb.h>
>>>    #include <linux/mm.h>
>>>    #include <linux/mmu_notifier.h>
>>>    #include <linux/highmem.h>
>>>    #include <linux/page_idle.h>
>>> +#include <linux/pagewalk.h>
>>>    #include <linux/random.h>
>>>    #include <linux/sched/mm.h>
>>>    #include <linux/slab.h>
>>> @@ -446,14 +448,69 @@ static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
>>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>    }
>>>    
>>> +struct damon_walk_private {
>>> +	pmd_t *pmd;
>>> +	pte_t *pte;
>>> +	spinlock_t *ptl;
>>> +};
>>> +
>>> +static int damon_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
>>> +		struct mm_walk *walk)
>>> +{
>>> +	struct damon_walk_private *priv = walk->private;
>>> +
>>> +	if (pmd_huge(*pmd)) {
>>> +		priv->ptl = pmd_lock(walk->mm, pmd);
>>> +		if (pmd_huge(*pmd)) {
>>> +			priv->pmd = pmd;
>>> +			return 0;
>>> +		}
>>> +		spin_unlock(priv->ptl);
>>> +	}
>>> +
>>> +	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
>>> +		return -EINVAL;
>>> +	priv->pte = pte_offset_map_lock(walk->mm, pmd, addr, &priv->ptl);
>>> +	if (!pte_present(*priv->pte)) {
>>> +		pte_unmap_unlock(priv->pte, priv->ptl);
>>> +		priv->pte = NULL;
>>> +		return -EINVAL;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static struct mm_walk_ops damon_walk_ops = {
>>> +	.pmd_entry = damon_pmd_entry,
>>> +};
>>> +
>>> +int damon_follow_pte_pmd(struct mm_struct *mm, unsigned long addr,
>>> +		struct damon_walk_private *private)
>>> +{
>>> +	int rc;
>>> +
>>> +	private->pte = NULL;
>>> +	private->pmd = NULL;
>>> +	rc = walk_page_range(mm, addr, addr + 1, &damon_walk_ops, private);
>>> +	if (!rc && !private->pte && !private->pmd)
>>> +		return -EINVAL;
>>> +	return rc;
>>> +}
>>> +
>>>    static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
>>>    {
>>> -	pte_t *pte = NULL;
>>> -	pmd_t *pmd = NULL;
>>> +	struct damon_walk_private walk_result;
>>> +	pte_t *pte;
>>> +	pmd_t *pmd;
>>>    	spinlock_t *ptl;
>>>    
>>> -	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
>>> +	mmap_write_lock(mm);
>>
>> Can you elaborate why mmap_read_lock() isn't sufficient for your use
>> case? The write mode might heavily affect damon performance and workload
>> impact.
> 
> Because as you also mentioned in the previous mail, 'we can walk page tables
> ignoring VMAs with the mmap semaphore held in write mode', and in this case we
> don't know to which VMA the address is belong.  I thought the link to the mail
> can help people understanding the reason.  But, as you are suggesting, I now
> think putting an elaborated explanation here would be much better.  I will also
> put a warning for the possible performance impact.

walk_page_range() make sure to skip any VMA holes and only walks ranges 
within VMAs. With the mmap sem in read mode, the VMA layout (mostly) 
cannot change, so calling walk_page_range() is fine. So pagewalk.c 
properly takes care of VMAs.

As an example, take a look at MADV_COLD handling in mm/madvise.c.

madvise_need_mmap_write() returns "0", and we end up calling 
madvise_cold()->...->walk_page_range() with mmap_lock_read().

You can exclude any VMAs you don't care about in the test_walk() 
callback, if required.

-- 
Thanks,

David / dhildenb

