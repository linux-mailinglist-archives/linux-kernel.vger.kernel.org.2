Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE13A2E91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhFJOuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhFJOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623336515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ZGxu50Da0PK61lY+o4FmL9vUYFPvS0gTspd9dJ7Li4=;
        b=I8OqZYZODtS6+pAzLuSjeZOyC+3HWfNuWjydKMD+5xvj9c60qfWMK+Hhx/pJIaNOS6sWTh
        JRA6trwjxGFy0/6yLxgXu31uXbgXYo6bXMhhGEVj469YOUB+vgCIjhZmgbFVxLqWnOT+Q/
        sP1yamMiznl8uMGkXaowZYSVWjitoxc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-s_GBZaPvPfGMC9_NgVvXnw-1; Thu, 10 Jun 2021 10:48:34 -0400
X-MC-Unique: s_GBZaPvPfGMC9_NgVvXnw-1
Received: by mail-qt1-f197.google.com with SMTP id z17-20020ac86b910000b0290244cba55754so10849489qts.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ZGxu50Da0PK61lY+o4FmL9vUYFPvS0gTspd9dJ7Li4=;
        b=Kz6uxFMIpTp78V/xYGT+lPkreb/cphnL5X63o8r5iaAd/eOPTaHGFYqEB5M9vugy9Z
         uhUE38cG3ZMgxoqSkibo8RlX2q3gv2joPqmi8cLb6J66EZERsewXABCzgTV6fv+ZBGcz
         nmIRIhVKlac+gX3JLaRg7yGXg3t10AhfGEKXLXwjMa+M2ZaCIl5Ro2tGbJLno8FFWk3F
         IIZ8Y2mV0BglS51VFk5kiz7wJ2/PAyV58gpcOqPY/8A/1FIiMQBrB4gbIh19xqSN0bor
         9/7dmvnhUOiwOUpehubrT4+slK2eFB6eJ1mWAug4yWsWjwu9qy6caryAZnnEC6SRUcAe
         v8Eg==
X-Gm-Message-State: AOAM530F2mR3wHBYLW7CfebWy3jk0gxJKyev1JyG0lvvp5dwTo5DBs6p
        qgpgtPoVHJSEvf5nCPcppCQamUKgvhoUEjdvfvFAyjrkw5fd3zFSXvRz20KEvnGOBCuxs6QGxvV
        vl1E4ops0oa8YsgRKNmIU6V9j
X-Received: by 2002:a05:620a:4106:: with SMTP id j6mr2411680qko.452.1623336513772;
        Thu, 10 Jun 2021 07:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTi/u+Cp7bUZAv8lFoIKFSr8W7PdTXbg/s5lMh6T2XTw/Ta67B3OK7mKx57FiaQ/QslIoD5w==
X-Received: by 2002:a05:620a:4106:: with SMTP id j6mr2411668qko.452.1623336513567;
        Thu, 10 Jun 2021 07:48:33 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id d21sm2257461qtn.24.2021.06.10.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:48:33 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:48:31 -0400
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
Subject: Re: [PATCH 05/11] mm: page_vma_mapped_walk(): prettify
 PVMW_MIGRATION block
Message-ID: <YMImP5fXTDns47jn@t490s>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <378c8650-1488-2edf-9647-32a53cf2e21@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <378c8650-1488-2edf-9647-32a53cf2e21@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:42:12PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: rearrange the !pmd_present() block to
> follow the same "return not_found, return not_found, return true" pattern
> as the block above it (note: returning not_found there is never premature,
> since existence or prior existence of huge pmd guarantees good alignment).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/page_vma_mapped.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 81000dd0b5da..b96fae568bc2 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -201,24 +201,22 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			if (pmd_page(pmde) != page)
>  				return not_found(pvmw);
>  			return true;
> -		} else if (!pmd_present(pmde)) {
> -			if (thp_migration_supported()) {
> -				if (!(pvmw->flags & PVMW_MIGRATION))
> -					return not_found(pvmw);
> -				if (is_migration_entry(pmd_to_swp_entry(pmde))) {
> -					swp_entry_t entry = pmd_to_swp_entry(pmde);
> +		}
> +		if (!pmd_present(pmde)) {
> +			swp_entry_t entry;
>  
> -					if (migration_entry_to_page(entry) != page)
> -						return not_found(pvmw);
> -					return true;
> -				}
> -			}
> -			return not_found(pvmw);
> -		} else {
> -			/* THP pmd was split under us: handle on pte level */
> -			spin_unlock(pvmw->ptl);
> -			pvmw->ptl = NULL;
> +			if (!thp_migration_supported() ||
> +			    !(pvmw->flags & PVMW_MIGRATION))
> +				return not_found(pvmw);
> +			entry = pmd_to_swp_entry(pmde);
> +			if (!is_migration_entry(entry) ||
> +			    migration_entry_to_page(entry) != page)

We'll need to do s/migration_entry_to_page/pfn_swap_entry_to_page/, depending
on whether Alistair's series lands first or not I guess (as you mentioned in
the cover letter).

Thanks for the change, it does look much better.

Reviewed-by: Peter Xu <peterx@redhat.com>

> +				return not_found(pvmw);
> +			return true;
>  		}
> +		/* THP pmd was split under us: handle on pte level */
> +		spin_unlock(pvmw->ptl);
> +		pvmw->ptl = NULL;
>  	} else if (!pmd_present(pmde)) {
>  		/*
>  		 * If PVMW_SYNC, take and drop THP pmd lock so that we
> -- 
> 2.26.2
> 

-- 
Peter Xu

