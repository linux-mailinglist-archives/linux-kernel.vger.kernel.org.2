Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A0C3CA936
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhGOTFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241908AbhGOS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626375188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yg+McKtY+ffqfI/EBeh9njvAeqTf7g8vxO6g9PiL1aI=;
        b=LMYjCpP1VvV+HFCUEurW9AAOLcrzBmPhtN2vbZfbQeHS99G+NkbvhYIDMc06tzfeTU/CSq
        8o2UCq8vArhWxlWjZlSgb0WmcXPT7LeCgRrqrTSZSafWFaduq12Xw9BhWVgeLG0onvlg2Q
        9wm12w6O4cKlAuzXLRqK/X187piwJb0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-hWdZ9XsQOTi1OY_6Xf3Ojg-1; Thu, 15 Jul 2021 14:53:07 -0400
X-MC-Unique: hWdZ9XsQOTi1OY_6Xf3Ojg-1
Received: by mail-qt1-f198.google.com with SMTP id e7-20020ac84e470000b029025ca4fbcc12so4470831qtw.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yg+McKtY+ffqfI/EBeh9njvAeqTf7g8vxO6g9PiL1aI=;
        b=p9U2XxtkkYn7KkedzgNTjR8YXn7y/4Bhj4s8x7/Wa2n8yxO8oL0s2g7yBokO9hUcly
         dUgY8sjLjh3U2b6RJ01lev6f34TaNh+2X1neILxs47MZCTqfFMb7Etx/EUnxl0uHr+by
         2PloI++5winWiaVb9cuIWqj9qTOZfQaSz1y0eCyDl9igzrrY+icUR4HkxchjtpT7c6I8
         DuysBtR/DJKB0TB108ngHslo3B/wTPkcB2cLjnYc2/v+8zyAHtCuqiVK0uK5j8ZuxHqA
         J73jF5i3zHAG/5Jlya68Vcdf12AGuOCOpgsimy3NkFpluWhX22i8awRvPmq4XKNbONGI
         4kFg==
X-Gm-Message-State: AOAM5317cVeyyWSMcNqPVNutXNghMteKOZXBlxKl7kTUxygDT4AhwiU6
        NsvgQMGM731tuRmN6O5Y3hMKujEuMdIDZ06X24kUOoNM2qgdw9HsNXHsodNT6Xcm3KGA4bDrc+X
        nQ5s7P98REwYpDI0WVvrgEHiH
X-Received: by 2002:a37:d52:: with SMTP id 79mr5514260qkn.227.1626375186745;
        Thu, 15 Jul 2021 11:53:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFn/kyYeNabdBvl7tuz6UF6JuSS6vuXIR6kxmTX6+CQPqQIBUCrdxm4EVuDL2y71/qvenx1g==
X-Received: by 2002:a37:d52:: with SMTP id 79mr5514242qkn.227.1626375186571;
        Thu, 15 Jul 2021 11:53:06 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id d11sm2312768qtx.37.2021.07.15.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:53:06 -0700 (PDT)
Date:   Thu, 15 Jul 2021 14:53:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH] mm/hugetlb: __unmap_hugepage_range() can be static
Message-ID: <YPCEEHEAA9ifubts@t490s>
References: <20210714222450.48840-1-peterx@redhat.com>
 <20210715170524.GA48547@78ef4ef0cd6c>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210715170524.GA48547@78ef4ef0cd6c>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 01:05:24AM +0800, kernel test robot wrote:
> mm/hugetlb.c:4334:6: warning: symbol '__unmap_hugepage_range' was not declared. Should it be static?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>  hugetlb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 924553aa8f789ad..4bdd637b0c29a95 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4331,9 +4331,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	return ret;
>  }
>  
> -void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> -			    unsigned long start, unsigned long end,
> -			    struct page *ref_page)
> +static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +				   unsigned long start, unsigned long end,
> +				   struct page *ref_page)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long address;

Will squash this change into the patch.  Thanks.

-- 
Peter Xu

