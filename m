Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBED3B2CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhFXKt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:49:58 -0400
Received: from foss.arm.com ([217.140.110.172]:53598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhFXKt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:49:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A05231B;
        Thu, 24 Jun 2021 03:47:38 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5F73F718;
        Thu, 24 Jun 2021 03:47:36 -0700 (PDT)
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
To:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, m.szyprowski@samsung.com
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org> <20210624092930.GA802261@MiWiFi-R3L-srv>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
Date:   Thu, 24 Jun 2021 11:47:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210624092930.GA802261@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-24 10:29, Baoquan He wrote:
> On 06/24/21 at 08:40am, Christoph Hellwig wrote:
>> So reduce the amount allocated.  But the pool is needed for proper
>> operation on systems with memory encryption.  And please add the right
>> maintainer or at least mailing list for the code you're touching next
>> time.
> 
> Oh, I thoutht it's memory issue only, should have run
> ./scripts/get_maintainer.pl. sorry.
> 
> About reducing the amount allocated, it may not help. Because on x86_64,
> kdump kernel doesn't put any page of memory into buddy allocator of DMA
> zone. Means it will defenitely OOM for atomic_pool_dma initialization.
> 
> Wondering in which case or on which device the atomic pool is needed on
> AMD system with mem encrytion enabled. As we can see, the OOM will
> happen too in kdump kernel on Intel system, even though it's not
> necessary.

Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle 
here. For DMA_DIRECT_REMAP=y we can assume an atomic pool is always 
needed, since that was the original behaviour anyway. However the 
implications of AMD_MEM_ENCRYPT=y are different - even if support is 
enabled, it still should only be relevant if mem_encrypt_active(), so it 
probably does make sense to have an additional runtime gate on that.

 From a quick scan, use of dma_alloc_from_pool() already depends on 
force_dma_unencrypted() so that's probably fine already, but I think 
we'd need a bit of extra protection around dma_free_from_pool() to 
prevent gen_pool_has_addr() dereferencing NULL if the pools are 
uninitialised, even with your proposed patch as it is. Presumably 
nothing actually called dma_direct_free() when you tested this?

Robin.
