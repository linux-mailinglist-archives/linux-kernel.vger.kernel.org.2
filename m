Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7447335EF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348327AbhDNI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:29:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238768AbhDNI25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:28:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618388914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=77PvjZ043bsPpk7w1CZMRpSRItMCMDE42Gsr4nMRZ10=;
        b=OIfRDOnWexsq0i9cJ27GBfwAJRtJM3CVyiFWjghiXXOjWMVtpqabpZp9AfZOFNXEWqYkt2
        r0suOuQjj739ngmFG3qrLvq/GrHoA6l+Ot9PeIRnIhz4ZMG389ew9/gV8Wpi/Nn1q8TwSz
        LF2xqEkkzzrhKtpfzzkHkAw/tvo5Lwk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48574ACC4;
        Wed, 14 Apr 2021 08:28:34 +0000 (UTC)
Date:   Wed, 14 Apr 2021 10:28:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <YHansW/OnNT6/i9d@dhcp22.suse.cz>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de>
 <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
 <YHaF5efHcJJ71UP9@dhcp22.suse.cz>
 <20210414074132.GB20401@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414074132.GB20401@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-04-21 09:41:32, Oscar Salvador wrote:
> On Wed, Apr 14, 2021 at 08:04:21AM +0200, Michal Hocko wrote:
> > On Tue 13-04-21 14:19:03, Mike Kravetz wrote:
> > > On 4/13/21 6:23 AM, Michal Hocko wrote:
> > > The only place where page->private may not be initialized is when we do
> > > allocations at boot time from memblock.  In this case, we will add the
> > > pages to the free list via put_page/free_huge_page so the appropriate
> > > flags will be cleared before anyone notices.
> > 
> > Pages allocated by the bootmem should be pre initialized from the boot,
> > no?
> 
> I guess Mike means:
> 
> hugetlb_hstate_alloc_pages
>  alloc_bootmem_huge_page
>   __alloc_bootmem_huge_page
>    memblock_alloc_try_nid_raw
> 
> and AFAICS, memblock_alloc_try_nid_raw() does not zero the memory.

You are right it doesn't do it there. But all struct pages, even those
that are allocated by the bootmem allocator should initialize its struct
pages. They would be poisoned otherwise, right? I would have to look at
the exact code path but IIRC this should be around the time bootmem
allocator state transitions to the page allocator.
-- 
Michal Hocko
SUSE Labs
