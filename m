Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED21D39F8D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhFHOUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhFHOUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:20:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE79A6135A;
        Tue,  8 Jun 2021 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623161908;
        bh=Q6x8I0zp47PbSqGK06LBfPKboxhDlMOF9EKsflzM3z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HG9P0de34pb9jF7an+voga1Dbd4cWjUjiFSl1XICorhOHOIyJ/qcfxmdLN5MZQ9zD
         P/xqUtE2yYpRoMaZ9YZ39rRGfmIERiQVJOewrlOiQSQ1yNlOyOl4r8z/RqyrsjOlKI
         2XOZqigf7dl1H3Ajx4rQIFaTg9Ecj6l5eTZt4YFHLKyeVJpzyQkhvg2HaM7pAB/5RM
         tQ8T8QqNNTPfHTisi8Ad8SEIKHlS8T5rAJpTyLHsiuWKt7Mx9Uh0+02y+EVWCnrOzZ
         MhcCB74YNqadL9wnBl8M4brr/ji00twvVC9AsZnYYDW9tZl0e/sT8NzGzffApyuAB4
         mzbyDThXvVs/A==
Date:   Tue, 8 Jun 2021 17:18:19 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] memory-hotplug.rst: complete admin-guide overhaul
Message-ID: <YL98K4QcKPIp4gkM@kernel.org>
References: <20210525102604.8770-1-david@redhat.com>
 <YL4Ek6AqMUyiDrxY@kernel.org>
 <5e01bd6f-4073-1ebb-489d-2e5c529909a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e01bd6f-4073-1ebb-489d-2e5c529909a2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:04:19PM +0200, David Hildenbrand wrote:

...

> > > +--------------
> > > -You can offline a memory block by using the same sysfs interface that was used
> > > -in memory onlining::
> > > +We usually expect that a large portion of available system RAM will actually
> > > +be consumed by user space, either directly or indirectly via the page cache. In
> > > +the normal case, ZONE_MOVABLE can be used when allocating such pages just fine.
> > > -	% echo offline > /sys/devices/system/memory/memoryXXX/state
> > > +With that in mind, it makes sense that we can have a big portion of system RAM
> > > +managed by ZONE_MOVABLE. However, there are some things to consider when
> > > +using ZONE_MOVABLE, especially when fine-tuning zone ratios:
> > > -If offline succeeds, the state of the memory block is changed to be "offline".
> > > -If it fails, some error core (like -EBUSY) will be returned by the kernel.
> > > -Even if a memory block does not belong to ZONE_MOVABLE, you can try to offline
> > > -it.  If it doesn't contain 'unmovable' memory, you'll get success.
> > > +- Having a lot of offline memory blocks. Even offline memory blocks consume
> > > +  memory for metadata and page tables in the direct map; having a lot of
> > > +  offline memory blocks is not a typical case, though.
> > > +
> > > +- Memory ballooning. Some memory ballooning implementations, such as
> > > +  the Hyper-V balloon, the XEN balloon, the vbox balloon and the VMWare
> > 
> > So, everyone except virtio-mem? ;-)
> 
> Well, virtio-mem does not classify as memory balloon in that sense, as it
> only operates on own device memory ;)
> 
> virtio-balloon and pseries CMM support balloon compaction.
> 
> > I'd drop the names because if some of those will implement balloon
> > compaction they surely will forget to update the docs.
 
> I can do the opposite and mention the ones that already do. Some most
> probably will never support it.
> 
> "Memory ballooning without balloon compaction is incompatible with
> ZONE_MOVABLE. Only some implementations, such as virtio-balloon and pseries
> CMM, fully support balloon compaction."
 
Sounds good.
 
-- 
Sincerely yours,
Mike.
