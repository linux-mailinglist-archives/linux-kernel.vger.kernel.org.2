Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF7E31DB43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhBQOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:16:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:35852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhBQOPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:15:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613571292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrNRTe46UspWVm0C7Y/cZDBRLIXFQ95FjJ33Q06xdsM=;
        b=cP25jOTUqYSksYP99Y7VQjj7v3RIfnEFoTafYYEOPpkn44j7UdssGRezRJ7XzYV+AnF+g2
        Xc9XiYZLERkaPJdt7/GjnyXSy/jgtj5RiPMmYFhyP3/g2nKPcdpONUgZfXPD4h6Rg5G4pt
        c2d7iqBB79F288MM8QymPXmxFtfb/l8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C751EB8FA;
        Wed, 17 Feb 2021 14:14:52 +0000 (UTC)
Date:   Wed, 17 Feb 2021 15:14:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC0k1u3QtyU00kxC@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
 <182f6a4a-6f95-9911-7730-8718ab72ece2@redhat.com>
 <YC0fIhEHRDOVzK8U@dhcp22.suse.cz>
 <5f50c810-3f49-a162-6d1d-cf621c515f45@redhat.com>
 <YC0gzBX8ubV6x5NK@dhcp22.suse.cz>
 <5d70b340-2db0-ef1f-1564-e5d39354c11c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d70b340-2db0-ef1f-1564-e5d39354c11c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 15:08:04, David Hildenbrand wrote:
> On 17.02.21 14:59, Michal Hocko wrote:
> > On Wed 17-02-21 14:53:37, David Hildenbrand wrote:
> > > On 17.02.21 14:50, Michal Hocko wrote:
> > [...]
> > > > Do we have any real life examples? Or does this fall more into, let's
> > > > optimize an existing implementation category.
> > > > 
> > > 
> > > It's a big TODO item I have on my list and I am happy that Oscar is looking
> > > into it. So yes, I noticed it while working on virtio-mem. It's real.
> > 
> > Do not take me wrong, I am not opposing to the functionality. I am
> > asking for the specific usecase.
> 
> Makes sense, and a proper motivation should be included in the patches/cover
> letter. So here comes a quick-n-dirty example:
> 
> 
> Start a VM with 4G. Hotplug 1G via virtio-mem and online it to ZONE_MOVABLE.
> Allocate 512 huge pages.
> 
> [root@localhost ~]# cat /proc/meminfo
> MemTotal:        5061512 kB
> MemFree:         3319396 kB
> MemAvailable:    3457144 kB
> ...
> HugePages_Total:     512
> HugePages_Free:      512
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> 
> 
> The huge pages get partially allocate from ZONE_MOVABLE. Try unplugging 1G
> via virtio-mem (remember, all ZONE_MOVABLE). Inside the guest:
> 
> [  180.058992] alloc_contig_range: [1b8000, 1c0000) PFNs busy
> [  180.060531] alloc_contig_range: [1b8000, 1c0000) PFNs busy
> [  180.061972] alloc_contig_range: [1b8000, 1c0000) PFNs busy
> [  180.063413] alloc_contig_range: [1b8000, 1c0000) PFNs busy
> [  180.064838] alloc_contig_range: [1b8000, 1c0000) PFNs busy
> [  180.065848] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
> [  180.066794] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
> [  180.067738] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
> [  180.068669] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
> [  180.069598] alloc_contig_range: [1bfc00, 1c0000) PFNs busy
> 
> 
> I succeed in unplugging 540MB - 484 MB remain blocked by huge pages ("which
> did not end up there by pure luck"). These pages are movable (and even
> free!) and can easily be reallocated.

OK, this sounds reasonable.
-- 
Michal Hocko
SUSE Labs
