Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6414E31555F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhBIRqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhBIRlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:41:05 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A15C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:40:25 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id l27so18741676qki.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJ1H3KkVJ1QsrWVrAqvw/WZDfdncCuLa8Ig/hildsUY=;
        b=WqO4eKL8/iRHzq2aaqjn55/EXC7y9UobGgQV8WGt8RhG/Jv++aUylXy2MQE6fRRvRt
         lZdnbY2pW1atiRjmLxUcFG7y2w/5wF1wmFHLlqIw3xXwD0YV47Zx+m/eqwuZT4eYLLHr
         jqV+lg43fM761qIWRil6I4wVeC9kwyz51DiCNqyQSxQmNoRWXmO6MR+shLBIIvhM9b+x
         fmh0cnQAvefP8yruP77NwJeZEAeKdW4crhrHJ0GyXXeoTs8BRCf/LXIP+MhdyAHirEYR
         kW8WJKjdu2z7gVxvFTnw+LM6eo6OoicTFPTJmhQeP/9acct9wqpIHR/3MUb1CAVuvl2S
         e/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJ1H3KkVJ1QsrWVrAqvw/WZDfdncCuLa8Ig/hildsUY=;
        b=Gn5Ipw+v9wLf0r+qkRr+ipU9YAFmgnpOTW2CT3Ap1khw0vMt2NkxCAd1xlRqr5vJ5A
         dIxyP8luVKVdLagE8sZStItHNq96ZodDPlklHgyMDcbaCR3SzzOh3g4tPKQ6ztwnUtjZ
         +SyMEU1Sm+/vJxORcU35pWi/wnzL+Vsxi44jfdbcEx5Eh8Cu86iI9/KTMJOn0hY8EjlC
         tj0+D7XKSVgLrXRgyK8B5TZnOl9opZsozGse3eKi8ERJdKJubmV4vM2jYHaOSbWJOrkv
         4cPrZnBbOpvFGXZAQpZ5Bxy1g7TGPXG9vkxcZFfOXH8RG3Fhx7GL4NZtskGT6USvxYKI
         K0gw==
X-Gm-Message-State: AOAM533gVrGkKI0n4D/QO+R7BdjgTLZavcJwhCNurZpTRmQnGHG7hwzw
        0U7BqoTz5jmGZTDwq5PrqN60mQ==
X-Google-Smtp-Source: ABdhPJxY8T2nkv01k4Wlrc+xxnILsbVBA/fP6+5/5kg4k0jDQORFznk7eDtahqaLHK1G01s6HBZAlQ==
X-Received: by 2002:a37:a346:: with SMTP id m67mr4862589qke.301.1612892424872;
        Tue, 09 Feb 2021 09:40:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id v145sm20045172qka.27.2021.02.09.09.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:40:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9Wzv-005XFi-SW; Tue, 09 Feb 2021 13:40:23 -0400
Date:   Tue, 9 Feb 2021 13:40:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Shutemov <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 3/5] mm: Introduce page_needs_cow_for_dma() for
 deciding whether cow
Message-ID: <20210209174023.GI4718@ziepe.ca>
References: <20210209030229.84991-1-peterx@redhat.com>
 <20210209030229.84991-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209030229.84991-4-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 10:02:27PM -0500, Peter Xu wrote:
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
> ---
>  include/linux/mm.h | 21 +++++++++++++++++++++
>  mm/huge_memory.c   |  8 ++------
>  mm/internal.h      |  5 -----
>  mm/memory.c        |  8 +-------
>  4 files changed, 24 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
