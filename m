Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5812F3FC648
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbhHaKul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhHaKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:50:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C79C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:49:45 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b64so19104779qkg.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=OEcToZkoYKuiFE41/6lTPV4K6JQy3+Js7pUHU25j4eU=;
        b=Wnnse1+HsQN/3SGu5RdMmE/PZiJylJm1QdEcT4L4g9aH2VoryKml8B8CFtYjJqAiIX
         YIP4aw07Di5gL/seCqODFg7zil6lhe8jdJPaMX1ULiFP06haNBBxCzjUhJKU+f0AwdCF
         9arDr1Y4YuQmh0yQGJStjPGmgfh+EoQXbjwu5CNVmZYDpkCQCASSqw4UuJ/otKAs0vjj
         MQF6d5vrWOmkPgl5uDCCwARBnigAxJfI0g7GhS11ln/8x1vxfyL8OdcThIPFRZkgp5/4
         JBzQ0ot7Co/uohYdIDHOk2bU2deDOTxvS1W7bUTwy9da/bCRFHZ0pLXZhkozOM9HJ6PJ
         1uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=OEcToZkoYKuiFE41/6lTPV4K6JQy3+Js7pUHU25j4eU=;
        b=nDo8SFQYZ2AA5Q4rtPDQ3Lv0zDBFttpqPooF1xCCTGWWcpGp6JU+yIOm3BTcqWCrOK
         y6os0TL8c5Y0GI+ndcZqSEle6VQ886I3cSGwkhH+R2PgwV2W9opU6Xj7uisx3SsTLzu5
         YS6EeFLRoXH3a1AfkkoV3LUEsFYgALIPGs7oB+H1PQ2PykuZdBDcFUr8rCkl/+94nB0m
         RLoTfIKzMGaHeqowMd+snJwlBixQOVal/AnS+LJDD9gXZW469Vde1zKpZNxfOZkpXs/E
         17FLZYQ2PFNfNQFMXpLy7mGeUByWbKgU4GkdPIwcj0XeTe+Onkrzhqdyy/h9RYkEjJ96
         myrw==
X-Gm-Message-State: AOAM533CwxJmMywYheT0LDxIeI7cHib8U02JssBU6xbLiVavldsNA7iz
        /4nO8n//QN/EK8SCYvINO/iTB3zA2mA=
X-Google-Smtp-Source: ABdhPJxAKIBK9A1UOFgS++UF4eioWqxVcF46SznqJgGvEXkIFja7qi2DqSMA+IsbzPdyb/SxwKJFlg==
X-Received: by 2002:ae9:ea19:: with SMTP id f25mr2232651qkg.341.1630406984666;
        Tue, 31 Aug 2021 03:49:44 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id f29sm10117673qtv.34.2021.08.31.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:49:44 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org,
        markubo@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] mm/damon/vaddr: Safely walk page table
Date:   Tue, 31 Aug 2021 10:49:38 +0000
Message-Id: <20210831104938.33548-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <daa567fe-3026-669a-d4a4-bdbaff036fe6@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 31 Aug 2021 11:53:05 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 27.08.21 17:04, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Commit d7f647622761 ("mm/damon: implement primitives for the virtual
> > memory address spaces") of linux-mm[1] tries to find PTE or PMD for
> > arbitrary virtual address using 'follow_invalidate_pte()' without proper
> > locking[2].  This commit fixes the issue by using another page table
> > walk function for more general use case under proper locking.
> > 
> > [1] https://github.com/hnaz/linux-mm/commit/d7f647622761
> > [2] https://lore.kernel.org/linux-mm/3b094493-9c1e-6024-bfd5-7eca66399b7e@redhat.com
> > 
> > Fixes: d7f647622761 ("mm/damon: implement primitives for the virtual memory address spaces")
> > Reported-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >   mm/damon/vaddr.c | 81 +++++++++++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 74 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 230db7413278..b3677f2ef54b 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -8,10 +8,12 @@
> >   #define pr_fmt(fmt) "damon-va: " fmt
> >   
> >   #include <linux/damon.h>
> > +#include <linux/hugetlb.h>
> >   #include <linux/mm.h>
> >   #include <linux/mmu_notifier.h>
> >   #include <linux/highmem.h>
> >   #include <linux/page_idle.h>
> > +#include <linux/pagewalk.h>
> >   #include <linux/random.h>
> >   #include <linux/sched/mm.h>
> >   #include <linux/slab.h>
> > @@ -446,14 +448,69 @@ static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
> >   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >   }
> >   
> > +struct damon_walk_private {
> > +	pmd_t *pmd;
> > +	pte_t *pte;
> > +	spinlock_t *ptl;
> > +};
> > +
> > +static int damon_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> > +		struct mm_walk *walk)
> > +{
> > +	struct damon_walk_private *priv = walk->private;
> > +
> > +	if (pmd_huge(*pmd)) {
> > +		priv->ptl = pmd_lock(walk->mm, pmd);
> > +		if (pmd_huge(*pmd)) {
> > +			priv->pmd = pmd;
> > +			return 0;
> > +		}
> > +		spin_unlock(priv->ptl);
> > +	}
> > +
> > +	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
> > +		return -EINVAL;
> > +	priv->pte = pte_offset_map_lock(walk->mm, pmd, addr, &priv->ptl);
> > +	if (!pte_present(*priv->pte)) {
> > +		pte_unmap_unlock(priv->pte, priv->ptl);
> > +		priv->pte = NULL;
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static struct mm_walk_ops damon_walk_ops = {
> > +	.pmd_entry = damon_pmd_entry,
> > +};
> > +
> > +int damon_follow_pte_pmd(struct mm_struct *mm, unsigned long addr,
> > +		struct damon_walk_private *private)
> > +{
> > +	int rc;
> > +
> > +	private->pte = NULL;
> > +	private->pmd = NULL;
> > +	rc = walk_page_range(mm, addr, addr + 1, &damon_walk_ops, private);
> > +	if (!rc && !private->pte && !private->pmd)
> > +		return -EINVAL;
> > +	return rc;
> > +}
> > +
> >   static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> >   {
> > -	pte_t *pte = NULL;
> > -	pmd_t *pmd = NULL;
> > +	struct damon_walk_private walk_result;
> > +	pte_t *pte;
> > +	pmd_t *pmd;
> >   	spinlock_t *ptl;
> >   
> > -	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
> > +	mmap_write_lock(mm);
> 
> Can you elaborate why mmap_read_lock() isn't sufficient for your use 
> case? The write mode might heavily affect damon performance and workload 
> impact.

Because as you also mentioned in the previous mail, 'we can walk page tables
ignoring VMAs with the mmap semaphore held in write mode', and in this case we
don't know to which VMA the address is belong.  I thought the link to the mail
can help people understanding the reason.  But, as you are suggesting, I now
think putting an elaborated explanation here would be much better.  I will also
put a warning for the possible performance impact.

> 
> 
> Also, I wonder if it wouldn't be much easier and cleaner to just handle 
> it completely in the .pmd_entry callback, instead of returning PMDs, 
> PTEs, LOCKs, ... here.
> 
> You could have
> 
> static struct mm_walk_ops damon_mkold_ops = {
> 	.pmd_entry = damon_mkold_pmd_entry,
> };
> 
> and
> 
> static struct mm_walk_ops damon_young_ops = {
> 	.pmd_entry = damon_young_pmd_entry,
> };
> 
> And then just handle everything completely inside the callback, avoiding 
> having to return locked PTEs, PMDs, .... and instead handling it at a 
> single location. Simply forward the page_sz pointer in the latter case 
> to damon_young_ops.
> 
> 
> damon_va_mkold()/damon_va_young() would mostly only call 
> walk_page_range() with the right ops and eventually convert some return 
> values.

I just wanted to make the change as small as possible, but you're right.  That
must be much cleaner.  I will post the next version soon.


Thanks,
SeongJae Park

> 
> -- 
> Thanks,
> 
> David / dhildenb
