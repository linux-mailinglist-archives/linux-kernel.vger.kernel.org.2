Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0115F3CED13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382924AbhGSRnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359311AbhGSRPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626717385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBElLwqpPID1BN8TMn/1i6CmvM212NI5w9OKbU1jkvk=;
        b=dWcrfaoG9UQ2aLV+CNoMsF1yzKUmcz2HnmlyMttv1QarGlD5GU5jhqQm+6t7x0CiFqFuwg
        C28Z6NzJpy4/SQN1ovqhmZolBBIwLHxBnllL+ui42ieCeH8SYg5ps8PVvs6bFPcIZDDNt4
        IfruRE9GJgrzJNpnoH+Z52MX1H9psqM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-dnkdytnbNCiP2HFDaXuSnA-1; Mon, 19 Jul 2021 13:56:24 -0400
X-MC-Unique: dnkdytnbNCiP2HFDaXuSnA-1
Received: by mail-qk1-f198.google.com with SMTP id b127-20020a3799850000b02903b960837cbfso3230943qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 10:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBElLwqpPID1BN8TMn/1i6CmvM212NI5w9OKbU1jkvk=;
        b=axAIa27J+cywrX32p8yH4o77KfG4NtE2+oFVS2SpgNVE4WPc4JUNdPyosvF6UnXZkn
         8KW10p9BdP2mKu5FwG2efEKDnqshP8/SzY591Tq692huXbVNxeQJ8/CWs0kfzdxCXxEZ
         Qme9IzMKxyn8pZi8vdWIzXFQeD1OjqxkeH+ciN4ORJL/VXf/2SEZ7XFoBfO/tR8pRyFt
         IIU6BQKeYrkCdF1FCpH6kUXlgEMrfi5O0DGRp+Vt2i9c6FYEPoydOJUkUkFLM48LaXE3
         RLBZ8gMrrkwUQlsQZCYgsEPCrAyEwRUhqLn5R3+C0fjdE8pmBGwKUMlT3LD9xsmMhhvM
         o4jg==
X-Gm-Message-State: AOAM532qUXOdJNO8ZtKrw6co1SeO+3xgzuTK6pN+CnXZ+qBASV0vWFKw
        Cq2ug0MFW9i9J5NI478Sv2eNQsrhjoy6X1yhgYLvYn5vQ1lgOw8Ikzij+M9f9nxG0/EZH5ASGCL
        OzE58AxJfHoqehQExsYcKOLNO
X-Received: by 2002:a05:6214:5b0:: with SMTP id by16mr25324031qvb.54.1626717384025;
        Mon, 19 Jul 2021 10:56:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQqqNgBSoRaZRpSdWGiX4A4izIiy1gA3EJPG/ihB1Ef+eISSJmMPKR3BzAg9FgcvLKhLcnNg==
X-Received: by 2002:a05:6214:5b0:: with SMTP id by16mr25324012qvb.54.1626717383819;
        Mon, 19 Jul 2021 10:56:23 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id p64sm8356183qka.114.2021.07.19.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:56:22 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:56:21 -0400
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
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>
Subject: Re: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Message-ID: <YPW8xaejtl68AYCk@t490s>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com>
 <YPWiRsNaearMNB2g@t490s>
 <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 05:23:14PM +0000, Tiberiu Georgescu wrote:
> > What we're clear is we know it's uffd wr-protected, so maybe setting PM_UFFD_WP
> > is still the simplest?
> 
> That's right, but if we were to require any of the differentiations above, how
> does keeping another bit on the special pte sound to you? One to signal the location on swap or otherwise (none or zapped).

I don't know how to do it even with an extra bit in the pte.  The thing is we
need some mechanism to trigger the tweak of that bit in the pte when switching
from "present" to "swapped out", while I don't see how that could be done.

Consider when page reclaim happens, we'll unmap and zap the ptes first before
swapping the pages out, then when we do the pageout() we've already released
the rmap so no way to figure out which pte to tweak, afaiu.  It also looks
complicated just for maintaining this information.

> 
> Is there any other clearer way to do it? We wouldn't want to overload the
> special pte unnecessarily.

I feel like the solution you proposed in the other patch for soft dirty might
work.  It's just that it seems heavier, especially because we'll try to look up
the page cache for every single pte_none() (and after this patch including the
swap special pte) even if the page is never accessed.

I expect it will regress the case of a normal soft-dirty user when the memory
is sparsely used, because there'll be plenty of page cache look up operations
that are destined to be useless.

I'm also curious what would be the real use to have an accurate PM_SWAP
accounting.  To me current implementation may not provide accurate value but
should be good enough for most cases.  However not sure whether it's also true
for your use case.

Thanks,

-- 
Peter Xu

