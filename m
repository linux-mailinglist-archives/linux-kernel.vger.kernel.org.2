Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982D9416869
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 01:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbhIWXTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 19:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243572AbhIWXTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 19:19:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A9A160E94;
        Thu, 23 Sep 2021 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632439059;
        bh=aovSY1+j/p4VcwH3XgkVFJ6AKhHLQs9U16f85Ij55u4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HreHvNj6W8lCJitqQAcOFJ/XWQr05sDs5HuQ7X66Vdf3gsUyHKgag3fA4dbfRUa3P
         VzD1idLDZbHhW7AIY659g+7nJvtfq7baXXVHZ3F2rXF4VVoOwIm9kOkrCPRfqi+/zi
         vPKY14Gxk0h1tlB+Ejl//3om6d2xMbyc1vVDQHS8=
Date:   Thu, 23 Sep 2021 16:17:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH] mm/memory_failure: Fix the missing pte_unmap() call
Message-Id: <20210923161738.990b61933c96df78bc1bf96d@linux-foundation.org>
In-Reply-To: <20210923122642.4999-1-zhengqi.arch@bytedance.com>
References: <20210923122642.4999-1-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 20:26:42 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> The paired pte_unmap() call is missing before the
> dev_pagemap_mapping_shift() returns. So fix it.
> 
> ...
>
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -306,6 +306,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>  		struct vm_area_struct *vma)
>  {
>  	unsigned long address = vma_address(page, vma);
> +	unsigned long ret = 0;
>  	pgd_t *pgd;
>  	p4d_t *p4d;
>  	pud_t *pud;
> @@ -330,10 +331,12 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>  		return PMD_SHIFT;
>  	pte = pte_offset_map(pmd, address);
>  	if (!pte_present(*pte))
> -		return 0;
> +		goto unmap;
>  	if (pte_devmap(*pte))
> -		return PAGE_SHIFT;
> -	return 0;
> +		ret = PAGE_SHIFT;
> +unmap:
> +	pte_unmap(pte);
> +	return ret;
>  }
>  

This is neater?

+++ a/mm/memory-failure.c
@@ -330,11 +330,8 @@ static unsigned long dev_pagemap_mapping
 	if (pmd_devmap(*pmd))
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
-	if (!pte_present(*pte))
-		goto unmap;
-	if (pte_devmap(*pte))
+	if (pte_present(*pte) && pte_devmap(*pte))
 		ret = PAGE_SHIFT;
-unmap:
 	pte_unmap(pte);
 	return ret;
 }
_

