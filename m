Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE33FC6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbhHaL5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhHaL5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:57:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD774C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 04:56:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u21so14300385qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=/qgET+A7r0hyQOZDWYy+y+LUsNgXLBMnDStSzTkREWY=;
        b=hfJz1rO+jzVQq5uybfBUSz6W/xOnuu0b/MEtCrJeYy0HDHFq0APXJi26yEYWFtqAMC
         E85m22NQL8SBFFV5djhgPOyL209CjZ+qVH6lwCbn86JDoyDmrclc5RwGAVfPrVbqzHa1
         hStabMNH6AOij+3iUztXXjF90Ih+IwY7VjZKj7xMYvh0Wtt2wWhv2tFs7KHgD0ZeiHYM
         rG+oeDThVt7kC42gMndq8yqQWE6ztRZjB1jG8j3+ZDKVkFR3jvyRHXGKYdNJFcZ+LVBQ
         1a+bWEhkJbwZCP4UefB15Blucns9qg9RQNJ9uBDaMJ5SEGRpx8BqqHJiSwv44RVc7U7T
         +ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=/qgET+A7r0hyQOZDWYy+y+LUsNgXLBMnDStSzTkREWY=;
        b=CrnAfpXZxJ7MHeRatbbQTFnPFtUv5Jz9NAH0nNcp8w+MjlMGFtwuzv9jWl4TcQSzpQ
         3nvSfuzpD8Q8dNWXxH/fCMGYXUxbW/LHjXrQK2eS54E480AP1B9vHompqcyUhOdO/ynj
         EheVptlUQNphYdl4lp6csBZlGG1FN7dYQ5epBNuvrC5QlFooYBz1DhuF5eKCvuiMhkEc
         Gqr2Res4+bKuzdBeFjZbU4C7vYW3IDjterQvgxjQrwArMvDw/f374LwB5VHYHgRUhxVA
         T1lx5Z0QpY1Rqej1J2Q+MMIEKbl3eWHSsrnu0NM/T1IaeJjoeJJCpTBCSZjPenXLNXQ1
         1znQ==
X-Gm-Message-State: AOAM532PICI1QTjomN+zTDqD7+639tGJ8ZeaBZwXz2LEkNkiXvJyGNB2
        1XaPhbLOyRmqF/AHci2tL4g=
X-Google-Smtp-Source: ABdhPJzl0GUqA/eNFWRzz0snX8chK0MWAfZ0oujA9Z4H1yiySPm5dtylK6wLRvlEQQAMQARajr8k4w==
X-Received: by 2002:a05:622a:2d1:: with SMTP id a17mr2327894qtx.236.1630410968911;
        Tue, 31 Aug 2021 04:56:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id l7sm5169107qki.99.2021.08.31.04.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 04:56:08 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org,
        markubo@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] mm/damon/vaddr: Safely walk page table
Date:   Tue, 31 Aug 2021 11:56:03 +0000
Message-Id: <20210831115603.28974-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d92a357b-c64c-aaf8-a69a-f00f93022013@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 31 Aug 2021 13:46:42 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 31.08.21 12:49, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > On Tue, 31 Aug 2021 11:53:05 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> On 27.08.21 17:04, SeongJae Park wrote:
> >>> From: SeongJae Park <sjpark@amazon.de>
> >>>
> >>> Commit d7f647622761 ("mm/damon: implement primitives for the virtual
> >>> memory address spaces") of linux-mm[1] tries to find PTE or PMD for
> >>> arbitrary virtual address using 'follow_invalidate_pte()' without proper
> >>> locking[2].  This commit fixes the issue by using another page table
> >>> walk function for more general use case under proper locking.
> >>>
> >>> [1] https://github.com/hnaz/linux-mm/commit/d7f647622761
> >>> [2] https://lore.kernel.org/linux-mm/3b094493-9c1e-6024-bfd5-7eca66399b7e@redhat.com
> >>>
> >>> Fixes: d7f647622761 ("mm/damon: implement primitives for the virtual memory address spaces")
> >>> Reported-by: David Hildenbrand <david@redhat.com>
> >>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> >>> ---
> >>>    mm/damon/vaddr.c | 81 +++++++++++++++++++++++++++++++++++++++++++-----
> >>>    1 file changed, 74 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> >>> index 230db7413278..b3677f2ef54b 100644
> >>> --- a/mm/damon/vaddr.c
> >>> +++ b/mm/damon/vaddr.c
> >>> @@ -8,10 +8,12 @@
> >>>    #define pr_fmt(fmt) "damon-va: " fmt
> >>>    
> >>>    #include <linux/damon.h>
> >>> +#include <linux/hugetlb.h>
> >>>    #include <linux/mm.h>
> >>>    #include <linux/mmu_notifier.h>
> >>>    #include <linux/highmem.h>
> >>>    #include <linux/page_idle.h>
> >>> +#include <linux/pagewalk.h>
> >>>    #include <linux/random.h>
> >>>    #include <linux/sched/mm.h>
> >>>    #include <linux/slab.h>
> >>> @@ -446,14 +448,69 @@ static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
> >>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >>>    }
> >>>    
> >>> +struct damon_walk_private {
> >>> +	pmd_t *pmd;
> >>> +	pte_t *pte;
> >>> +	spinlock_t *ptl;
> >>> +};
> >>> +
> >>> +static int damon_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> >>> +		struct mm_walk *walk)
> >>> +{
> >>> +	struct damon_walk_private *priv = walk->private;
> >>> +
> >>> +	if (pmd_huge(*pmd)) {
> >>> +		priv->ptl = pmd_lock(walk->mm, pmd);
> >>> +		if (pmd_huge(*pmd)) {
> >>> +			priv->pmd = pmd;
> >>> +			return 0;
> >>> +		}
> >>> +		spin_unlock(priv->ptl);
> >>> +	}
> >>> +
> >>> +	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
> >>> +		return -EINVAL;
> >>> +	priv->pte = pte_offset_map_lock(walk->mm, pmd, addr, &priv->ptl);
> >>> +	if (!pte_present(*priv->pte)) {
> >>> +		pte_unmap_unlock(priv->pte, priv->ptl);
> >>> +		priv->pte = NULL;
> >>> +		return -EINVAL;
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static struct mm_walk_ops damon_walk_ops = {
> >>> +	.pmd_entry = damon_pmd_entry,
> >>> +};
> >>> +
> >>> +int damon_follow_pte_pmd(struct mm_struct *mm, unsigned long addr,
> >>> +		struct damon_walk_private *private)
> >>> +{
> >>> +	int rc;
> >>> +
> >>> +	private->pte = NULL;
> >>> +	private->pmd = NULL;
> >>> +	rc = walk_page_range(mm, addr, addr + 1, &damon_walk_ops, private);
> >>> +	if (!rc && !private->pte && !private->pmd)
> >>> +		return -EINVAL;
> >>> +	return rc;
> >>> +}
> >>> +
> >>>    static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> >>>    {
> >>> -	pte_t *pte = NULL;
> >>> -	pmd_t *pmd = NULL;
> >>> +	struct damon_walk_private walk_result;
> >>> +	pte_t *pte;
> >>> +	pmd_t *pmd;
> >>>    	spinlock_t *ptl;
> >>>    
> >>> -	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
> >>> +	mmap_write_lock(mm);
> >>
> >> Can you elaborate why mmap_read_lock() isn't sufficient for your use
> >> case? The write mode might heavily affect damon performance and workload
> >> impact.
> > 
> > Because as you also mentioned in the previous mail, 'we can walk page tables
> > ignoring VMAs with the mmap semaphore held in write mode', and in this case we
> > don't know to which VMA the address is belong.  I thought the link to the mail
> > can help people understanding the reason.  But, as you are suggesting, I now
> > think putting an elaborated explanation here would be much better.  I will also
> > put a warning for the possible performance impact.
> 
> walk_page_range() make sure to skip any VMA holes and only walks ranges 
> within VMAs. With the mmap sem in read mode, the VMA layout (mostly) 
> cannot change, so calling walk_page_range() is fine. So pagewalk.c 
> properly takes care of VMAs.
> 
> As an example, take a look at MADV_COLD handling in mm/madvise.c.
> 
> madvise_need_mmap_write() returns "0", and we end up calling 
> madvise_cold()->...->walk_page_range() with mmap_lock_read().

Oops, can't believe how I missed that.  I will hold only mmap read lock...


Thanks,
SJ

> 
> You can exclude any VMAs you don't care about in the test_walk() 
> callback, if required.
> 
> -- 
> Thanks,
> 
> David / dhildenb
