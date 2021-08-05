Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290073E0E95
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhHEGyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235050AbhHEGyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628146458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j85DEN/GjXBt17nWPtFfA65KJvlMB121aW2wNcv0HLM=;
        b=bmvu6KQ2W+jWG7BMsCJtCFfmDVJ+A2XIWnL9H9Tn5lzS5mn842S6Iufn1g0hkHbQYsEjW2
        U5/L+1bxdYTOsx88pvBj4cJUP3sLBzv1e4R3uEi6737K58JKUaa2RkzzuJ95wy/u3fnb/X
        nrlaN83VZ4If9dM/c+KZVDmy83fiVP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-agHRmAA1PeKyjzdK13dT9A-1; Thu, 05 Aug 2021 02:54:16 -0400
X-MC-Unique: agHRmAA1PeKyjzdK13dT9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3FB8100CF79;
        Thu,  5 Aug 2021 06:54:14 +0000 (UTC)
Received: from localhost (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D23A751C63;
        Thu,  5 Aug 2021 06:54:13 +0000 (UTC)
Date:   Thu, 5 Aug 2021 14:54:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, m.szyprowski@samsung.com
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <20210805065410.GA2051@MiWiFi-R3L-srv>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
 <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/21 at 11:47am, Robin Murphy wrote:
> On 2021-06-24 10:29, Baoquan He wrote:
> > On 06/24/21 at 08:40am, Christoph Hellwig wrote:
> > > So reduce the amount allocated.  But the pool is needed for proper
> > > operation on systems with memory encryption.  And please add the right
> > > maintainer or at least mailing list for the code you're touching next
> > > time.
> > 
> > Oh, I thoutht it's memory issue only, should have run
> > ./scripts/get_maintainer.pl. sorry.
> > 
> > About reducing the amount allocated, it may not help. Because on x86_64,
> > kdump kernel doesn't put any page of memory into buddy allocator of DMA
> > zone. Means it will defenitely OOM for atomic_pool_dma initialization.
> > 
> > Wondering in which case or on which device the atomic pool is needed on
> > AMD system with mem encrytion enabled. As we can see, the OOM will
> > happen too in kdump kernel on Intel system, even though it's not
> > necessary.

Sorry for very late response, and thank both for your comments.

> 
> Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle here.
> For DMA_DIRECT_REMAP=y we can assume an atomic pool is always needed, since
> that was the original behaviour anyway. However the implications of
> AMD_MEM_ENCRYPT=y are different - even if support is enabled, it still
> should only be relevant if mem_encrypt_active(), so it probably does make
> sense to have an additional runtime gate on that.

> 
> From a quick scan, use of dma_alloc_from_pool() already depends on
> force_dma_unencrypted() so that's probably fine already, but I think we'd
> need a bit of extra protection around dma_free_from_pool() to prevent
> gen_pool_has_addr() dereferencing NULL if the pools are uninitialised, even
> with your proposed patch as it is. Presumably nothing actually called
> dma_direct_free() when you tested this?

Yes, enforcing the conditional check of force_dma_unencrypted() around
dma_free_from_pool sounds reasonable, just as we have done in
dma_alloc_from_pool().

I have tested this patchset on normal x86_64 systems and one amd system
with SME support, disabling atomic pool can fix the issue that there's no
managed pages in dma zone then requesting page from dma zone will cause
allocation failure. And even disabling atomic pool in 1st kernel didn't
cause any problem on one AMD EPYC system which supports SME. I am not
expert of DMA area, wondering how atomic pool is supposed to do in
SME/SEV system. 

Besides, even though atomic pool is disabled, slub page for allocation
of dma-kmalloc also triggers page allocation failure. So I change to
take another way to fix them, please check v2 post. The atomic pool
disabling an be a good to have change.

Thanks
Baoquan

