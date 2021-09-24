Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB54168F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhIXAcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:32:45 -0400
Received: from out2.migadu.com ([188.165.223.204]:32176 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232143AbhIXAco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:32:44 -0400
Date:   Fri, 24 Sep 2021 09:31:02 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632443470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zjfLAfWSo5szBRHYcbTSavPrNdYVRR33+yO7EWtRlRM=;
        b=MFbSUTUXaAniZtOK418Rkutp3rZOsdXuttey/8upAfNJ+HTu+GvLj2uXRO9GaGdBI5BxLP
        C5qyaUPxFM0NgqvT2SFkRcW4jUAkU1iYC5KyGA/Lb4AKyqdGRwFYJ4+mQdau4YOVOIRa75
        8yXS+pJu1cNwmzW8Y50F2WhWIY9my8o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] mm/memory_failure: Fix the missing pte_unmap() call
Message-ID: <20210924003102.GA974757@u2004>
References: <20210923122642.4999-1-zhengqi.arch@bytedance.com>
 <20210923161738.990b61933c96df78bc1bf96d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923161738.990b61933c96df78bc1bf96d@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:17:38PM -0700, Andrew Morton wrote:
> On Thu, 23 Sep 2021 20:26:42 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> > The paired pte_unmap() call is missing before the
> > dev_pagemap_mapping_shift() returns. So fix it.
> > 
> > ...
> >
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -306,6 +306,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
> >  		struct vm_area_struct *vma)
> >  {
> >  	unsigned long address = vma_address(page, vma);
> > +	unsigned long ret = 0;
> >  	pgd_t *pgd;
> >  	p4d_t *p4d;
> >  	pud_t *pud;
> > @@ -330,10 +331,12 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
> >  		return PMD_SHIFT;
> >  	pte = pte_offset_map(pmd, address);
> >  	if (!pte_present(*pte))
> > -		return 0;
> > +		goto unmap;
> >  	if (pte_devmap(*pte))
> > -		return PAGE_SHIFT;
> > -	return 0;
> > +		ret = PAGE_SHIFT;
> > +unmap:
> > +	pte_unmap(pte);
> > +	return ret;
> >  }
> >  
> 
> This is neater?
> 
> +++ a/mm/memory-failure.c
> @@ -330,11 +330,8 @@ static unsigned long dev_pagemap_mapping
>  	if (pmd_devmap(*pmd))
>  		return PMD_SHIFT;
>  	pte = pte_offset_map(pmd, address);
> -	if (!pte_present(*pte))
> -		goto unmap;
> -	if (pte_devmap(*pte))
> +	if (pte_present(*pte) && pte_devmap(*pte))
>  		ret = PAGE_SHIFT;
> -unmap:

This neater one looks good to me.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
