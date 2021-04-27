Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080D936CB54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhD0SzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236394AbhD0SzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619549655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6scYoYaJnZw9w+YTIXgfa8KVKfLRpUAPMKwzhV1kGVU=;
        b=DxaACZs5Bh6FUByw8Y5vEMFZsNkeXkaCHCd6nD3RJ7x5SUtyHmoqWb5SOCUkTcxiB8tEdE
        ysyiFr85MVz7IYYUNec39DKs9KViE3KgvBWOJQcvPGJ69mwstLtHi/Et9LNv7CfHDHgN0X
        5X5xSyJLHEPi/a3pzbNfi50JCLIUtt0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-oR-OvzQTNG6JMr1URyvEdQ-1; Tue, 27 Apr 2021 14:54:14 -0400
X-MC-Unique: oR-OvzQTNG6JMr1URyvEdQ-1
Received: by mail-qv1-f69.google.com with SMTP id s13-20020a0cdc0d0000b02901bbc03198caso4097266qvk.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6scYoYaJnZw9w+YTIXgfa8KVKfLRpUAPMKwzhV1kGVU=;
        b=U66DnLYuHDTxFPOMFeMIcl0QI4pvkN06M6a2zipz4obEc5pCLJ6l/djyBzRjnmq2tL
         ntWFpFM0YoSZtPbUKw/DHNNvDKfmtMxeqmD6znsOxChBkjjPmTRbuegYBpXRl5l9YDMI
         0qUC3P+zT58VJ3qr6CUxAVBZu/CikIU8BMVnKdHGn/9X0sP1v8dS+LtFVJo+szy9iIJH
         pqsVd8awTjZk31R8BeUFYNej6BOE7E9gtShTUWyfRyaS2VGWGFcrVLQBDUQIyJNWuV9X
         HFksz64ERNnBJRCiUMNjSqGhoboAGA8Pe+rkCrkKNxzZgvCHbMDXfAO7r2hAKV7Onlx6
         Qoqg==
X-Gm-Message-State: AOAM5322Nh7et6HJKaCEEO7Tbpc7FaMP/a3+igbi1+Rm1Y9K+tgrdrsS
        sOBvIJAzfdSgmjJBQZ8kjcW0oZsGmlgwROeu17dCnt/dcWRFg75SLtOdubjhT4qpVSQYDMGi/M3
        ENJ7M+sSqgDLuJYsLpef6FEXR
X-Received: by 2002:ac8:60d7:: with SMTP id i23mr22310844qtm.184.1619549653522;
        Tue, 27 Apr 2021 11:54:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVTUNFNAnZMgU4XsiHk6z89v+ygkwXtAm8ItrZOw7RjZxhaD33Lrgq3XyNL8VJHDGUhULb/w==
X-Received: by 2002:ac8:60d7:: with SMTP id i23mr22310810qtm.184.1619549653168;
        Tue, 27 Apr 2021 11:54:13 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id c192sm3449561qke.25.2021.04.27.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 11:54:12 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:54:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 05/24] shmem/userfaultfd: Handle uffd-wp special pte
 in page fault handler
Message-ID: <20210427185410.GE6820@xz-x1>
References: <20210427161317.50682-1-peterx@redhat.com>
 <20210427161317.50682-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427161317.50682-6-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:12:58PM -0400, Peter Xu wrote:
> File-backed memories are prone to unmap/swap so the ptes are always unstable.
> This could lead to userfaultfd-wp information got lost when unmapped or swapped
> out on such types of memory, for example, shmem.  To keep such an information
> persistent, we will start to use the newly introduced swap-like special ptes to
> replace a null pte when those ptes were removed.
> 
> Prepare this by handling such a special pte first before it is applied.  Here
> a new fault flag FAULT_FLAG_UFFD_WP is introduced.  When this flag is set, it

FAULT_FLAG_UFFD_WP does not exist any more.  Obviously I should have touched up
the commit message when touching up the code...

> means the current fault is to resolve a page access (either read or write) to
> the uffd-wp special pte.
> 
> The handling of this special pte page fault is similar to missing fault, but it
> should happen after the pte missing logic since the special pte is designed to
> be a swap-like pte.  Meanwhile it should be handled before do_swap_page() so
> that the swap core logic won't be confused to see such an illegal swap pte.
> 
> This is a slow path of uffd-wp handling, because unmap of wr-protected shmem
> ptes should be rare.  So far it should only trigger in two conditions:
> 
>   (1) When trying to punch holes in shmem_fallocate(), there will be a
>       pre-unmap optimization before evicting the page.  That will create
>       unmapped shmem ptes with wr-protected pages covered.
> 
>   (2) Swapping out of shmem pages
> 
> Because of this, the page fault handling is simplifed too by not sending the
> wr-protect message in the 1st page fault, instead the page will be installed
> read-only, so the message will be generated until the next do_wp_page() call.
> 
> Disable fault-around for such a special page fault, because the introduced new
> flag (FAULT_FLAG_UFFD_WP) only applies to current pte rather than all the pages

Same here.

> around it.  Doing fault-around with the new flag could confuse all the rest of
> pages when installing ptes from page cache when there's a cache hit.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/userfaultfd_k.h | 11 +++++
>  mm/memory.c                   | 80 ++++++++++++++++++++++++++++++++---
>  2 files changed, 86 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index bc733512c6905..fefebe6e96560 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -89,6 +89,17 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
>  	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
>  }
>  
> +/*
> + * Don't do fault around for FAULT_FLAG_UFFD_WP because it means we want to

Same here...

> + * recover a previously wr-protected pte.  This flag is a per-pte information,
> + * so it could confuse all the pages around the current page when faulted in.
> + * Similar reason for MINOR mode faults.
> + */
> +static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
> +}

-- 
Peter Xu

