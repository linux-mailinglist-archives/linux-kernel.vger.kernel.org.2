Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338A8310089
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBDXUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhBDXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:20:42 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0DCC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 15:20:02 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a19so5228695qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 15:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DJBAqOJIb2bK546eUomBLziWNsQdl9+DyYJ9LvCcAEY=;
        b=AdIuNlaAznLEic3h7nb6J5UFmUhLlTmFIx+P7W/VVAZIy6uKnlhP7k2mfFDbwo3Beo
         P3xT9UnKKOFe653iZY0vneLQtqYiAB4CoiDE8PGB9RoEiIcqgYA9Qn2FziXJRLPxM5G4
         pZzyxg+xHsnPJRieFBz/YmgbZEE8D/oKFB1Wdx3gtN2K3tXD15xfbD9qYnmC02LnM8Rc
         QYFzYI1XtQnGCCMHoYouo0f+Ee3fSPX3CFOnFU51gUBz+cfeBx3NypC0lgXLF12jBqJe
         4jXye5GtoDJHsiughq6M+xkqhyTJVygv+h50azgg43fTfOK93pvFktxCgYmT0btZe11T
         +65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJBAqOJIb2bK546eUomBLziWNsQdl9+DyYJ9LvCcAEY=;
        b=ZuwcjMuuorUTeFrmFEm/qWdSyaKed/77erLAgZ7nesEU8H9+j593rObX9Y1V/DQkMA
         BM7odOvws71rczXD1C7rEdUWWNGgiM02Ty1NStQjFW5AYEQU/67Im0OIPwrKS9mfjSU5
         b7kuXjTlTOwDSlpL/nmOmJQZyu0i/FAJ+8I7r+F6VIV/9pWyGqWJl9Z57WaawcZEqcmc
         AoNuH+SrfJXEUNDf/28cmwgTxgD3zmF0bK8TetbQgKjexITsVcCek+31OlDxw6PLxNY1
         50moQUKiiPlILow1J1dXSLCuSxvbwtbOgDCxOWUks32DODTMEd0QyMbDbI8izQ3hOZhc
         MfZA==
X-Gm-Message-State: AOAM530319JdrsWL411VGzfUA76fbQsqPEdnEcPan1iaBN3sDelBu3SN
        ZNdqtuNIxGV60Jh3Nh6BqA0Jeg==
X-Google-Smtp-Source: ABdhPJxUA57wPycobe+FwcJXrI8gdQFRBo7XQFRm85rhupmZem2foImNoDNZ2Ljq7CooHWewWdzkFg==
X-Received: by 2002:a05:620a:898:: with SMTP id b24mr1643689qka.269.1612480801680;
        Thu, 04 Feb 2021 15:20:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id z20sm6266353qki.93.2021.02.04.15.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:20:01 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l7nuq-003e2a-NM; Thu, 04 Feb 2021 19:20:00 -0400
Date:   Thu, 4 Feb 2021 19:20:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/4] mm: Introduce page_needs_cow_for_dma() for
 deciding whether cow
Message-ID: <20210204232000.GG4718@ziepe.ca>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204145033.136755-4-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:50:32AM -0500, Peter Xu wrote:
> We've got quite a few places (pte, pmd, pud) that explicitly checked against
> whether we should break the cow right now during fork().  It's easier to
> provide a helper, especially before we work the same thing on hugetlbfs.
> 
> Since we'll reference is_cow_mapping() in mm.h, move it there too.  Actually it
> suites mm.h more since internal.h is mm/ only, but mm.h is exported to the
> whole kernel.  With that we should expect another patch to use is_cow_mapping()
> whenever we can across the kernel since we do use it quite a lot but it's
> always done with raw code against VM_* flags.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
>  include/linux/mm.h | 21 +++++++++++++++++++++
>  mm/huge_memory.c   |  8 ++------
>  mm/internal.h      |  5 -----
>  mm/memory.c        |  7 +------
>  4 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecdf8a8cd6ae..6ea20721d349 100644
> +++ b/include/linux/mm.h
> @@ -1291,6 +1291,27 @@ static inline bool page_maybe_dma_pinned(struct page *page)
>  		GUP_PIN_COUNTING_BIAS;
>  }
>  
> +static inline bool is_cow_mapping(vm_flags_t flags)
> +{

It feels a bit more logical to pass in a struct vm_area_struct *' here?

Jason
