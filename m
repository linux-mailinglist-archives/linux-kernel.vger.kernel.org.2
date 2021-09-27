Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46156419166
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhI0JSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhI0JSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:18:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE122C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:17:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y28so73937125lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XM3IPd5Y/B3XydJlqavKkI7QaMPjEtgvkFbwbgV1/iA=;
        b=1Q6708tvyLCT+ef9O4jgFQMKEEc7HbJpaH/zXY3a37umoGOMBeZVmoGrsut1XykdFw
         Jmh0iITH0gc8KQFV8t9wWRNaNfo9z/wfSe/uMb+ch/oemogWJ9AgUkmaD2wUt/WvEqNO
         n31QGdgKiAsMMUE9oh/KX0l1yJzQq8Nya3do21ITVU6O2pcfYQcgswlYcwIcSJjFLiFi
         GGP+FDWdcu2ULdUVR1FPEBn1ZdrruYUOrEqn/pEsTCkOmpujwSvlR4gsbjIMhk11lDHL
         TfEswBQ27FmZMREtaCmLUYjPs3Xs2pji+Rspo5aE5LcyjUm6Sijxdl4k+3TFu1Rtpq+Z
         ycSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XM3IPd5Y/B3XydJlqavKkI7QaMPjEtgvkFbwbgV1/iA=;
        b=Mjtt8DLFuwPUSi2dozaD7/uT3PSuj0w+KJFFByrhhjRZa70dwNOI+d0WwF8AfpH1gS
         7fSmZuml6isv6gKim8haaie9fgsVIgjRpG/MCz9UABRBLDZ1vhovoszE5ZdkCikp8aX8
         5aVg3fSEjyP+oLFAgb1Kw8aXqE5Awj4VPIPFlBUmfoEdhzyBCtxrjyNKdOerdJRPuF8R
         xyEtw6dMOe7L3VIc6MoFq/m/7kOaBuihbdafvjx/Wfw5gJAqh/l0z/CTzUP+iyYkj4VT
         AOyKWuIwq8zBbm+Cf/ReAF7crGDSlqDeNl4ge0Lh1zCXEmSJtKkDOaA6s7dniL4O9YYS
         9O0A==
X-Gm-Message-State: AOAM530L83B9XS52AXcCL8ylCrnAT2xkda5xJA8s51GAzo9BfpQzV5fs
        1yHE4eSPEVjDkuUBU5h++8BAjQ==
X-Google-Smtp-Source: ABdhPJyz8uOfrsdc9H8zpTerjSbSsa5CUwJBTezYs+Mz79tiJ2/wjNLzHO9OqKjyaWJnt4XJcDjdFg==
X-Received: by 2002:a19:5e11:: with SMTP id s17mr23486926lfb.404.1632734230305;
        Mon, 27 Sep 2021 02:17:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o1sm1684460lfc.110.2021.09.27.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:17:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 29B5F10306C; Mon, 27 Sep 2021 12:17:09 +0300 (+03)
Date:   Mon, 27 Sep 2021 12:17:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 3/8] mm/madvise: remove unnecessary checks on
 madvise_free_single_vma()
Message-ID: <20210927091709.ksv2fjudjpqhnu3n@box.shutemov.name>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926161259.238054-4-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 09:12:54AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> madvise_free_single_vma() currently rechecks that the range fits within
> the VMA, adapts it accordingly, and returns -EINVAL if the range is
> entirely outside of the VMA.
> 
> The error-code of -EINVAL is incorrect according to the man pages (as it
> should have been -ENOMEM), but anyhow the range that is provided to
> madvise_free_single_vma() should always be valid. It is set correctly in
> do_madvise() and then rechecked in madvise_dontneed_free() is the
> mmap-lock is dropped.
> 
> Remove this check.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Colin Cross <ccross@google.com>
> Cc: Suren Baghdasarya <surenb@google.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  mm/madvise.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index fe843513a4e8..17e39c70704b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -716,14 +716,8 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
>  	if (!vma_is_anonymous(vma))
>  		return -EINVAL;
>  
> -	range.start = max(vma->vm_start, start_addr);
> -	if (range.start >= vma->vm_end)
> -		return -EINVAL;
> -	range.end = min(vma->vm_end, end_addr);
> -	if (range.end <= vma->vm_start)
> -		return -EINVAL;

How did you test this change?

As far as I can see, you leave 'range' uninitialized, but used for
walk_page_range() and mmu_notifiers.

NAK.

>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
> -				range.start, range.end);
> +				start_addr, end_addr);
>  
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm);
> -- 
> 2.25.1
> 
> 

-- 
 Kirill A. Shutemov
