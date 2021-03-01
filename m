Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4F328076
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhCAOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236222AbhCAON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614607917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdU4+sq7g37Wxke/MuWqo/r1ostOr9DvvYrfRTQF7O4=;
        b=NZto309b20xyjEskP1YYHl4wkg0dp04ERYE0XD+8RssYG031tOf9fk6giI/6yRkRsihQwo
        hLbAqsQiQhfeNx+O81ZYYsP1+54s4z+yS4TA9WAJMVGnkbBuJOyHaxxD5k91vCCJjDG66o
        ptH8Vf0VTLWLR+jpXNafGM4EJ3fB9es=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-ntmtLVoyNbyJT_PihPBR1A-1; Mon, 01 Mar 2021 09:11:55 -0500
X-MC-Unique: ntmtLVoyNbyJT_PihPBR1A-1
Received: by mail-qk1-f198.google.com with SMTP id j6so7286131qkd.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdU4+sq7g37Wxke/MuWqo/r1ostOr9DvvYrfRTQF7O4=;
        b=SjtPQ8awptlbyUC22bA4obZPWIIoZsC2TD/GbZmrK/WDE9nLLwm1X0QS7Gpi79Cnzg
         zEBLi+0r0ACc8WI8fDNzTIlD+fsWYfly1sbKgomYV1eivhl5wO1znW6nfrno3DNjs/dJ
         cg3WSixOJP2JuAp2AwcSp0K2YlMfEYDvrUK27N8UAIIAypmoc0IQqspplcJycyiAn5tE
         Z2zvuBrCi80icpTpvWkdyEL29F21UVm2qTDpQEsJQCWHk/Ck+NmRSTJSs49g38Uf3Bdd
         rUFVpwAuAiC/ySMvbks9SZFKSdA4ZKpgT5khdZeXggfugvxvtGns5o5cDulLbvFGUYSL
         8FsQ==
X-Gm-Message-State: AOAM5335MvOPcIJ98YasGecLNlzjvEhyrWjk7nIKGeBjHN1f9HhMzGAw
        92QyBWaEjtbiyQ9VUzmsevxegVAL0OCjirRaGwUStmrmk5DAY13GAoqEjM3ea4YYwVd7dpyTwxr
        NgI2kjD6JVCcYWClDV6QtgifP
X-Received: by 2002:a0c:9bae:: with SMTP id o46mr14835275qve.56.1614607915157;
        Mon, 01 Mar 2021 06:11:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzixSXgSz+uvk1ApNgGWMbsIEOfeLFpMdwWzbfc2Q3jEsziL3baHkg9YDMzinZsPBrIKwpPzw==
X-Received: by 2002:a0c:9bae:: with SMTP id o46mr14835251qve.56.1614607914975;
        Mon, 01 Mar 2021 06:11:54 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id j2sm12355288qkk.96.2021.03.01.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:11:53 -0800 (PST)
Date:   Mon, 1 Mar 2021 09:11:51 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Message-ID: <20210301141151.GA397383@xz-x1>
References: <20210217233547.93892-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217233547.93892-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 06:35:42PM -0500, Peter Xu wrote:
> v5:
> - patch 4: change "int cow" into "bool cow"
> - collect r-bs for Jason

Andrew,

I just noticed 5.12-rc1 has released; is this series still possible to make it
for 5.12, or needs to wait for 5.13?

Thanks,

-- 
Peter Xu

