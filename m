Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF833217B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhCIJBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhCIJBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615280477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJrOIK90yeKd1J7ld5QNGZ0DUG9UcOp8ot5JeN+BY34=;
        b=VpFV8PszXbjttA4yBG+uJmzI9XdvuOmpwudm1P2PIiFR5eb5gKkI6Ozhyrja6i+u1GVmly
        hyhrk8lza7pqPpsJLlNv0ohg9gj5QXslzdRz5oEGVvhqSRCVda65PpyAK84BNSUqVp2tN4
        UjqfgSAw87ohwrdProNZlasmNNsJooc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-tcUkzYJVPNqQfuneIzZDmg-1; Tue, 09 Mar 2021 04:01:13 -0500
X-MC-Unique: tcUkzYJVPNqQfuneIzZDmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FCB81005D4A;
        Tue,  9 Mar 2021 09:01:12 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A90759458;
        Tue,  9 Mar 2021 09:01:10 +0000 (UTC)
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
Message-ID: <29cb78c5-4fca-0f0a-c603-0c75f9f50d05@redhat.com>
Date:   Tue, 9 Mar 2021 10:01:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309001855.142453-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.21 01:18, Mike Kravetz wrote:
> The concurrent use of multiple hugetlb page sizes on a single system
> is becoming more common.  One of the reasons is better TLB support for
> gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
> being used to back VMs in hosting environments.
> 
> When using hugetlb pages to back VMs in such environments, it is
> sometimes desirable to preallocate hugetlb pools.  This avoids the delay
> and uncertainty of allocating hugetlb pages at VM startup.  In addition,
> preallocating huge pages minimizes the issue of memory fragmentation that
> increases the longer the system is up and running.
> 
> In such environments, a combination of larger and smaller hugetlb pages
> are preallocated in anticipation of backing VMs of various sizes.  Over
> time, the preallocated pool of smaller hugetlb pages may become
> depleted while larger hugetlb pages still remain.  In such situations,
> it may be desirable to convert larger hugetlb pages to smaller hugetlb
> pages.
> 
> Converting larger to smaller hugetlb pages can be accomplished today by
> first freeing the larger page to the buddy allocator and then allocating
> the smaller pages.  However, there are two issues with this approach:
> 1) This process can take quite some time, especially if allocation of
>     the smaller pages is not immediate and requires migration/compaction.
> 2) There is no guarantee that the total size of smaller pages allocated
>     will match the size of the larger page which was freed.  This is
>     because the area freed by the larger page could quickly be
>     fragmented.
> 
> To address these issues, introduce the concept of hugetlb page demotion.
> Demotion provides a means of 'in place' splitting a hugetlb page to
> pages of a smaller size.  For example, on x86 one 1G page can be
> demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
> - demote_size	Read only target page size for demotion
> - demote	Writable number of hugetlb pages to be demoted
> 
> Only hugetlb pages which are free at the time of the request can be demoted.
> Demotion does not add to the complexity surplus pages.  Demotion also honors
> reserved huge pages.  Therefore, when a value is written to the sysfs demote
> file that value is only the maximum number of pages which will be demoted.
> It is possible fewer will actually be demoted.
> 
> If demote_size is PAGESIZE, demote will simply free pages to the buddy
> allocator.

With the vmemmap optimizations you will have to rework the vmemmap 
layout. How is that handled? Couldn't it happen that you are half-way 
through splitting a PUD into PMDs when you realize that you cannot 
allocate vmemmap pages for properly handling the remaining PMDs? What 
would happen then?

Or are you planning on making both features mutually exclusive?

Of course, one approach would be first completely restoring the vmemmap 
for the whole PUD (allocating more pages than necessary in the end) and 
then freeing individual pages again when optimizing the layout per PMD.

-- 
Thanks,

David / dhildenb

