Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79EF3AB70F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhFQPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232804AbhFQPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623942646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=60V2U3Y8XQYar/tao4RcgAgdvbeJ83af09NY8ZeK7JI=;
        b=Hm94NhyURXEUvhTpREk7bMYDtDoygzpiOd/wHits6h2xdHurs4EHHwiu9goDVdpYrFNmrm
        egeJ1S1t9AEG38ReQL9ODCbWwmgELcnBhzXUVJa5MP6hGQl8O/MyZjhT9GPUroFsfDQfty
        v5hHz3pgr1i1W2OlYDLTYl27J+A8wyk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-A2sC_o2hPM-AMB_S7Yk-7w-1; Thu, 17 Jun 2021 11:10:45 -0400
X-MC-Unique: A2sC_o2hPM-AMB_S7Yk-7w-1
Received: by mail-qv1-f72.google.com with SMTP id br4-20020ad446a40000b029021addf7b587so2468983qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60V2U3Y8XQYar/tao4RcgAgdvbeJ83af09NY8ZeK7JI=;
        b=hGMDtvs3U6WMq9y76kI7pftY2bWKWutNf8D8khRdzRHuRJdT0RpATcAS/Jyw+LERtb
         JcCWQfCjPobO3f/H5PRRsxMlKhMw0p5hB5rJSuYIUiG7Zb+E5JOaEw8W0r5mtkgIVFm/
         9HayF3ehNfCjRd9XTPHyn/sHIFogs9A+ZWElxUHTe79uHIsHUr5gmWvHTjDU91NnAMxj
         dsauhb3OZw2vUB0SaopZmREK7P84e/g86jCDq+Qj2OY/A+v36VGKpAShHfBb76k62y29
         JB8HZIEaA+DlVORljElH+ZJ9EyiW3/XK/awXHvNkrR/6UWSzh/WzsLiSgq7E+uSHQUd7
         LYzA==
X-Gm-Message-State: AOAM531lNF1lLALpg1utlyM/sN7ClJkFcmM5XWoPctjD6jM8xwY6PH8y
        1LleyoDDYfb4qp5t+YlObhixQHEyXwHYyEfWUNzNPsGPQ12LmD8/74f6SgsMhShIUq3iObybAfy
        c6q5jkAgWJd4XT6OsTXRxOiv7
X-Received: by 2002:ac8:5f0d:: with SMTP id x13mr5690589qta.69.1623942644891;
        Thu, 17 Jun 2021 08:10:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPeCcPHmIoclQ5CoZp42sKvMmfN4bqlPekaRMFGmhUVHBfdgF/PKrLkJJ85SfMn6DWbu99yg==
X-Received: by 2002:ac8:5f0d:: with SMTP id x13mr5690559qta.69.1623942644656;
        Thu, 17 Jun 2021 08:10:44 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id d85sm1955010qkg.84.2021.06.17.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:10:44 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:10:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 06/27] shmem/userfaultfd: Handle uffd-wp special pte
 in page fault handler
Message-ID: <YMtl8pqUL/zLOZiy@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <20210527202122.30739-1-peterx@redhat.com>
 <5906045.o7RC9TDvkT@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5906045.o7RC9TDvkT@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:59:09PM +1000, Alistair Popple wrote:
> > +static vm_fault_t do_swap_pte(struct vm_fault *vmf)
> > +{
> > +	/*
> > +	 * We need to handle special swap ptes before handling ptes that
> > +	 * contain swap entries, always.
> > +	 */
> > +	if (unlikely(pte_swp_uffd_wp_special(vmf->orig_pte)))
> > +		return uffd_wp_handle_special(vmf);
> > +
> > +	return do_swap_page(vmf);
> 
> Probably pretty minor in the scheme of things but why not add this special
> case directly to do_swap_page()? Your earlier "shmem/userfaultfd: Handle
> uffd-wp special pte in page fault handler" adds this to do_swap_page()
> anyway:
> 
> 	/*
> 	 * We should never call do_swap_page upon a swap special pte; just be
> 	 * safe to bail out if it happens.
> 	 */
> 	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
> 		goto out;
> 
> So this patch could instead replace the warning with the call to
> uffd_wp_handle_special(), which also means you can remove the extra
> pte_unmap_same(vmf) check in uffd_wp_handle_special().
> 
> I suppose you might have to worry about other callers of do_swap_page(),
> but the only other one I could see was __collapse_huge_page_swapin().
> Initially I thought that might be able to trigger the warning here but I
> see it checks pte_has_swap_entry() first which should skip it if it finds
> the special pte.

Yes I wanted to keep the existing caller untouched, and I wanted to keep its
semantics too to not bother with the new idea (it turns out do_swap_page should
have a history long enough to be beyond when git is introduced to Linux).

The other reason is that this series is the first one to introduce the new swap
pte which actually does not have a page on the back, so I figured maybe it's
good to call the new handler do_swap_pte() (as swap pte can either contain swap
entry or not), then we keep do_swap_page() if it's an old typed swap pte (which
contains the swap entry).

Thanks,

-- 
Peter Xu

