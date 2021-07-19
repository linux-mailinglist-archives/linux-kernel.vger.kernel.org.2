Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923A3CE941
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357680AbhGSQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 12:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347866AbhGSPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626710602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwlSLaETgArexDqT/XyinpkjkehxQ6aINHSxgRaGFVQ=;
        b=PopawxKvGTE20tec83ttZM4Vq5oMbRDvJ3POKTE7iQWTxhmzvWdM13usvXW/HgLzJyx15u
        Vl+AW/TW2L8hSazS0yzSfYaHx81vbp50m2ML9ohCb9qRJn7R9A26JejRDr3/dWDChf/8x1
        DFBLA8YlkP9VWbqtAvG/h/i/HLhsC+k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-e0GPNygePXWh9-Rnf3XCbQ-1; Mon, 19 Jul 2021 12:03:21 -0400
X-MC-Unique: e0GPNygePXWh9-Rnf3XCbQ-1
Received: by mail-qt1-f199.google.com with SMTP id j11-20020ac8664b0000b029026549e62339so2093569qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 09:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cwlSLaETgArexDqT/XyinpkjkehxQ6aINHSxgRaGFVQ=;
        b=RGALxT0YAGQdOzDTb349KmtUFcqkv/JFLA7kBSdiuQHXwGLDJRj7aoSZ5hctB02l9K
         rRv4xxFU6PCF4MIr6RyRvEGs0DUKKL6o+xLl/nWCTIM8ER9PhLil/W5KPyRbWeIR3ESK
         bSffMKwJtrHAVm3RzWvIGq881WX++VcWrGdmqYUmsao/rknda3/0G6kL7ZYoB57WUaFd
         hJgVKv2B3ORnaMOU/0xDhISvXIAxRjGRDZ18pHfFyXOA3YMA5hAkFCnaeANlXL0jlMEp
         9ANOrcWJbTkFWZqgZK0W8BGrW3gnXBGE95Mrf9ot1YrKU8zvzeqnCYA3xBAOefu12U4W
         pehQ==
X-Gm-Message-State: AOAM533AE/NHhJkQJy8ReTM3rb52Xj/27alFfus4KWuPqTtKtrtKUjk8
        SEW0vGgL1LTaKVd3w5z7D0qjB+1JjCbN6BTe2Upr6S4nh/o9PQmpIK+QCLwLFZRU9GdE03bqePB
        Wr8uVTlPnn+YC0XlXRCcRy74S
X-Received: by 2002:ad4:584c:: with SMTP id de12mr25823736qvb.1.1626710600594;
        Mon, 19 Jul 2021 09:03:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhyqRTa1ANQ4QN7GPrnUIoWzUY/QKPJBqstzJ8ix9jTJpIHgf5d1gQCAfJ6GeAcj+iL7IPuw==
X-Received: by 2002:ad4:584c:: with SMTP id de12mr25823708qvb.1.1626710600400;
        Mon, 19 Jul 2021 09:03:20 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p197sm8475383qka.81.2021.07.19.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 09:03:19 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:03:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Message-ID: <YPWiRsNaearMNB2g@t490s>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 09:53:36AM +0000, Tiberiu Georgescu wrote:
> 
> Hello Peter,

Hi, Tiberiu,

> 
> > On 15 Jul 2021, at 21:16, Peter Xu <peterx@redhat.com> wrote:
> > 
> > This requires the pagemap code to be able to recognize the newly introduced
> > swap special pte for uffd-wp, meanwhile the general case for hugetlb that we
> > recently start to support.  It should make pagemap uffd-wp support complete.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > fs/proc/task_mmu.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> > 
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 9c5af77b5290..988e29fa1f00 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1389,6 +1389,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
> > 		flags |= PM_SWAP;
> > 		if (is_pfn_swap_entry(entry))
> > 			page = pfn_swap_entry_to_page(entry);
> > +	} else if (pte_swp_uffd_wp_special(pte)) {
> > +		flags |= PM_UFFD_WP;
> > 	}
> 
> ^ Would it not be important to also add PM_SWAP to flags?

Hmm, I'm not sure; it's the same as a none pte in this case, so imho we still
can't tell if it's swapped out or simply the pte got zapped but page cache will
still hit (even if being swapped out may be the most possible case).

What we're clear is we know it's uffd wr-protected, so maybe setting PM_UFFD_WP
is still the simplest?

Thanks,

-- 
Peter Xu

