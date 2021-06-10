Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28823A2DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhFJOTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230387AbhFJOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623334659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ettsBbd343DElYNQaOh/2OpHE71CrjjsdmVGaKy6xw=;
        b=UOE1Jj3Hh9z2MsSSyVHJWTuTEvfi35bRA437/ZcEHZTqo3P1G64yPcDZ+vBlm42qgOQEV+
        mMNh/rgT9LbGNIl0V6Guwyq+WeYQNc1Q8Lld9l6BzYYp82RTuKz6w+IpmUWYSiEboNWzwW
        n6ywapyHqbomghBjmMKIR7Fdx1nTFvY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-CvN1yRumOnmgnNpKuchCMA-1; Thu, 10 Jun 2021 10:17:36 -0400
X-MC-Unique: CvN1yRumOnmgnNpKuchCMA-1
Received: by mail-qv1-f69.google.com with SMTP id ce7-20020a05621403c7b0290238a4eac5c4so5565259qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ettsBbd343DElYNQaOh/2OpHE71CrjjsdmVGaKy6xw=;
        b=Lb1lTOnMmMD634Iq/2eA3g+JF1YhgLqiVRw2otjF8bFlKYRCVwRojhC5fBmA5mE34M
         gmVUOJIAeiKlZWNjJZF5xaLHH28fWSASKLsVGRn89PX6yYPErfQSOoc39THPwBDlSa0Y
         /8C4gfILWCA9pyCpylitOWTXR+FQzIy9+wZSa5Bh3vOwFVWDALboVFvbjWSlZrw/dN7U
         8eXb3cPeEqRwkYo6uA1KQpp/hE63t/aJp2R2TBuPeA5MjrryIcABzBbJWzoyIqvemGzG
         8/I5X8kaT2Egvj0JX1jfPnmPrZSuIgpfiCWSYT0943Acn/fKA3N03/m585GRnL7opna0
         Gl9A==
X-Gm-Message-State: AOAM530+cZg4KNnw48OgnpkjCnbc/sqU8XrlNag+n6jawT01F58TUefe
        tQ1dJMoM3LrwGDafnEMorsrftyjtERIzLLMMarkbJa/qbN/+ScBF09JllWg2ajAPoHA7Z2NE7Bt
        mEhq+afikhXSNOtSzjOEeSzWK
X-Received: by 2002:a37:2fc3:: with SMTP id v186mr4893540qkh.28.1623334656091;
        Thu, 10 Jun 2021 07:17:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5juRO0nS6UGUfzZy9UuXFLrxmwuTJ0ipKNPqy4Doeu+Jg0pREfqsFhkhccahOFDRbBsOHcA==
X-Received: by 2002:a37:2fc3:: with SMTP id v186mr4893513qkh.28.1623334655890;
        Thu, 10 Jun 2021 07:17:35 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id q18sm2271315qkc.27.2021.06.10.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:17:35 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:17:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] mm: page_vma_mapped_walk(): settle PageHuge on
 entry
Message-ID: <YMIe/mn9TKpK3n4K@t490s>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <e31a483c-6d73-a6bb-26c5-43c3b880a2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e31a483c-6d73-a6bb-26c5-43c3b880a2@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:36:36PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: get the hugetlbfs PageHuge case
> out of the way at the start, so no need to worry about it later.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/page_vma_mapped.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index a6dbf714ca15..7c0504641fb8 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -153,10 +153,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  	if (pvmw->pmd && !pvmw->pte)
>  		return not_found(pvmw);
>  
> -	if (pvmw->pte)
> -		goto next_pte;
> -
>  	if (unlikely(PageHuge(page))) {
> +		/* The only possible mapping was handled on last iteration */
> +		if (pvmw->pte)
> +			return not_found(pvmw);
> +
>  		/* when pud is not present, pte will be NULL */
>  		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
>  		if (!pvmw->pte)

Would it be even nicer to move the initial check to be after PageHuge() too?

	if (pvmw->pmd && !pvmw->pte)
		return not_found(pvmw);

It looks already better, so no strong opinion.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

