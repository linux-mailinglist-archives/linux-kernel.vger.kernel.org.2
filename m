Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD531DFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhBQTqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232906AbhBQTqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613591083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DKRCGD5cZBFDckHkhQGxjYspyMuPSVpV7imvsh15Fwg=;
        b=LvGc2Xeq00G5rRjv8YGkcyP3GGm1FCE8PPl+Wtt8UQoU7Dyg5FaSMv/Yi8RGsrs+Hvq+Uz
        LFhXuhAOXe2Qfih269F5mjw2iV/aEroh2+zffIjCDGY0rfWZ5BlgdRSJbRyFebE5XSSZgd
        iQj0I/ZRKs/lL4GfCSKU09bag2ebIj8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-vHE8ANtaP5umAsdXQFl6qA-1; Wed, 17 Feb 2021 14:44:39 -0500
X-MC-Unique: vHE8ANtaP5umAsdXQFl6qA-1
Received: by mail-qv1-f71.google.com with SMTP id p4so10676065qvn.23
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 11:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DKRCGD5cZBFDckHkhQGxjYspyMuPSVpV7imvsh15Fwg=;
        b=gJbM4ca/vFEGkQNXvBC7tBiAzB++7irki+LvlyzTb/kN6c31E6o1pLiwZQ0KTlLHHQ
         lDHT0Tl94f3+dRMOvK3g/NCjbnGGStPGPJm7UgpZzQkr9jR3i+txww1de/JtTxp4uAm0
         pJwn23x7v8IaCiOtoN0vCZMZa8LpdiHLaW8F+n2fm2BzW3JsfU84vi+QwiLZOGAKmLWP
         U1NXwKjmWTbMtbAJgWwzdp5+yPjZI2d67scj25fG63Kc/oLLN7etgyddDH7VpN/djlG9
         2jdNi+zGtdspfV85jeB7Ef5/nPGddjHXCcdlDBxgdMown8Xl6TO2XBBPgc8H/a0o2sI6
         qH9g==
X-Gm-Message-State: AOAM530TZBJnaHO7vkmUCiq7GbBmoUPCOYKzrthzIHKkfBOBOnxSmb7Z
        KhfdMoFuJ5FhX/hX8W9ISagM254Bv+JDqjOBM7ptEY8Tzjim8xiCM1hUXf/3oNFKOJzWBkJAtVa
        Hf915CIW8wkleTKLQnQKwCyNd
X-Received: by 2002:a37:e20b:: with SMTP id g11mr832453qki.292.1613591078916;
        Wed, 17 Feb 2021 11:44:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmn0YnwZ3NDVqO0cMhaXsErwcpE5p4rLVKMLyL5IWYZzrdUFReeIRZBso5fLx1tUu0zEu6dg==
X-Received: by 2002:a37:e20b:: with SMTP id g11mr832433qki.292.1613591078685;
        Wed, 17 Feb 2021 11:44:38 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id k187sm2318732qkc.74.2021.02.17.11.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:44:38 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:44:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, shu wang <malate_wangshu@hotmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 4/5] hugetlb: don't permit pmd sharing if soft dirty
 in use
Message-ID: <20210217194436.GD6519@xz-x1>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
 <20210211000322.159437-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211000322.159437-5-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 04:03:21PM -0800, Mike Kravetz wrote:
> If page modifications are being monitoried with the soft dirty mechanism,
> then this information is contained in page table entries.  Tracking is
> enabled on a 'per-process' basis.  hugetlb pmd sharing allows processes
> to share page table entries.  This makes pmd sharing incompatible with
> soft dirty monitoring.  So, pmd sharing must be disabled if soft dirty
> tracking is in use.
> 
> The VM_SOFTDIRTY flag is set in all vma's by default.  When soft dirty
> monitoring is started, the flag is cleared.  We can therefore allow pmd
> sharing in vmas with the VM_SOFTDIRTY flag set.  Check this when deciding
> to perform pmd sharing.
> 
> A subsequent patch will add code to allow soft dirty monitoring for hugetlb
> vmas.  Any existing pmd sharing will be undone at that time.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b561b6867ec1..cf4aa63be9b1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5285,6 +5285,13 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  	unsigned long base = addr & PUD_MASK;
>  	unsigned long end = base + PUD_SIZE;
>  
> +	/*
> +	 * Do not allow pmd sharing if soft dirty tracking is in use.
> +	 */
> +	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) &&
> +				!(vma->vm_flags & VM_SOFTDIRTY))
> +		return false;
> +

Reviewed-by: Peter Xu <peterx@redhat.com>

The indent of using three tabs is a bit weird to me, though.. I do see this
happen somewhere else in the repo too, so maybe it's a way to indent that I
don't know.

Thanks,

-- 
Peter Xu

