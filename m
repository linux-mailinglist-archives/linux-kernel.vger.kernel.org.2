Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF333F449
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhCQPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232475AbhCQPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615995904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WweFpqYPPp1PxeahFEtVPdauE7cc3RkHtQdhRhNh4Lw=;
        b=ADn2TgStGQt9gnJRFpdp1sle5zFAIMreNyjO281avcy79QCK/iUO34D92doI5Bl0MYFhvt
        0JeGAvxye6z+ramwISSv7dX0ZDyqiAEdYbQGoxYPvQIwPeAG4IP6yLqvfZeGAw7gUsAwiT
        V8n0rQvYEwgmntkLxgL9wm3YM9ZwJKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Ay-bCL7yMjeinaiYmuah3w-1; Wed, 17 Mar 2021 11:18:23 -0400
X-MC-Unique: Ay-bCL7yMjeinaiYmuah3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0AC1CC624;
        Wed, 17 Mar 2021 15:18:21 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FC7E6E419;
        Wed, 17 Mar 2021 15:18:21 +0000 (UTC)
Date:   Wed, 17 Mar 2021 09:18:20 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, chenjiashang@huawei.com
Subject: Re: A problem of Intel IOMMU hardware =?UTF-8?B?77yf?=
Message-ID: <20210317091820.5f4ab69e@omen.home.shazbot.org>
In-Reply-To: <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
        <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 13:16:58 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Longpeng,
> 
> On 3/17/21 11:16 AM, Longpeng (Mike, Cloud Infrastructure Service 
> Product Dept.) wrote:
> > Hi guys,
> > 
> > We find the Intel iommu cache (i.e. iotlb) maybe works wrong in a special
> > situation, it would cause DMA fails or get wrong data.
> > 
> > The reproducer (based on Alex's vfio testsuite[1]) is in attachment, it can
> > reproduce the problem with high probability (~50%).
> > 
> > The machine we used is:
> > processor	: 47
> > vendor_id	: GenuineIntel
> > cpu family	: 6
> > model		: 85
> > model name	: Intel(R) Xeon(R) Gold 6146 CPU @ 3.20GHz
> > stepping	: 4
> > microcode	: 0x2000069
> > 
> > And the iommu capability reported is:
> > ver 1:0 cap 8d2078c106f0466 ecap f020df
> > (caching mode = 0 , page-selective invalidation = 1)
> > 
> > (The problem is also on 'Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz' and
> > 'Intel(R) Xeon(R) Platinum 8378A CPU @ 3.00GHz')
> > 
> > We run the reproducer on Linux 4.18 and it works as follow:
> > 
> > Step 1. alloc 4G *2M-hugetlb* memory (N.B. no problem with 4K-page mapping)  
> 
> I don't understand 2M-hugetlb here means exactly. The IOMMU hardware
> supports both 2M and 1G super page. The mapping physical memory is 4G.
> Why couldn't it use 1G super page?
> 
> > Step 2. DMA Map 4G memory
> > Step 3.
> >      while (1) {
> >          {UNMAP, 0x0, 0xa0000}, ------------------------------------ (a)
> >          {UNMAP, 0xc0000, 0xbff40000},  
> 
> Have these two ranges been mapped before? Does the IOMMU driver
> complains when you trying to unmap a range which has never been
> mapped? The IOMMU driver implicitly assumes that mapping and
> unmapping are paired.
>
> >          {MAP,   0x0, 0xc0000000}, --------------------------------- (b)
> >                  use GDB to pause at here, and then DMA read IOVA=0,  
> 
> IOVA 0 seems to be a special one. Have you verified with other addresses
> than IOVA 0?

It is???  That would be a problem.

> >                  sometimes DMA success (as expected),
> >                  but sometimes DMA error (report not-present).
> >          {UNMAP, 0x0, 0xc0000000}, --------------------------------- (c)
> >          {MAP,   0x0, 0xa0000},
> >          {MAP,   0xc0000, 0xbff40000},
> >      }

The interesting thing about this test sequence seems to be how it will
implicitly switch between super pages and regular pages.  Also note
that the test is using the original vfio type1 API rather than the v2
API that's more commonly used today.  This older API allows unmaps to
split mappings, but we don't really know how much the IOMMU is
unmapping without reading the unmap.size field returned by the ioctl.
What I expect to happen is that the IOMMU will make use of superpages
when mapping the full range.  When we unmap {0-bffff}, that's likely
going to be covered by a 2M (or more) superpage, therefore the unmap
will actually unmap {0-1fffff}.  The subsequent unmap starting at
0xc0000 might already have {a0000-1fffff} unmapped.  However, when we
then map {0 - bffff} the IOMMU will (should) switch back to 4K pages.
The mapping at 0xc0000 should use 4K pages up through 0x1fffff, then
might switch to 2M or 1G pages depending on physical memory layout.  So
the {0-2MB} IOVA range could be switching back and forth between a
superpage mapping and 4K mapping, and I can certainly imagine that
could lead to page table, if not cache management bugs.  Thanks,

Alex


> > 
> > The DMA read operations sholud success between (b) and (c), it should NOT report
> > not-present at least!
> > 
> > After analysis the problem, we think maybe it's caused by the Intel iommu iotlb.
> > It seems the DMA Remapping hardware still uses the IOTLB or other caches of (a).
> > 
> > When do DMA unmap at (a), the iotlb will be flush:
> >      intel_iommu_unmap
> >          domain_unmap
> >              iommu_flush_iotlb_psi
> > 
> > When do DMA map at (b), no need to flush the iotlb according to the capability
> > of this iommu:
> >      intel_iommu_map
> >          domain_pfn_mapping
> >              domain_mapping
> >                  __mapping_notify_one
> >                      if (cap_caching_mode(iommu->cap)) // FALSE
> >                          iommu_flush_iotlb_psi  
> 
> That's true. The iotlb flushing is not needed in case of PTE been
> changed from non-present to present unless caching mode.
> 
> > But the problem will disappear if we FORCE flush here. So we suspect the iommu
> > hardware.
> > 
> > Do you have any suggestion ?  
> 
> Best regards,
> baolu
> 

