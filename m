Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A613C860F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhGNO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhGNO11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57CFD61154;
        Wed, 14 Jul 2021 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626272675;
        bh=uGr4g/Ee6pV+EYvldgWLzrmg2C688Tc8vlJSlq63pk8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cET9p+pZsUlfkwOTPAtB5/mDe7yDJsg4FzfZffrQRnOVuD0rYqFVb6ZeVscmNktjM
         bNA7IV3qJNt14ok7rAS5FJ3LfAXGNCKyl42bXGsyuyHfNyQIkBZURhjTYhGVDqTBSH
         TxgYKIosOSty1JV9snDp7ZdJ2NYRoq/gkKi0nMNIZMI7NA/frs3I90G5cVnZT1Cid6
         WIvbWsHG0zjCrPhEFXqGGcASjc9YI16y+p/Xh8ELeyNyhOoZo7e9/786yUHZUa6oAg
         Do/lYC41xrtfNZS757OeycCgPNWOg2pYEI3fjwaTGVfKxUaSRe6HSlXOboC0wLIOdF
         XC0EsUYXlRjdg==
Subject: Re: [PATCH v7 00/15] Optimizing iommu_[map/unmap] performance
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com
Cc:     joro@8bytes.org, isaacm@codeaurora.org, baolu.lu@linux.intel.com,
        pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <e6c8993e-353e-6a05-9b6d-9a49de471cb6@kernel.org>
Date:   Wed, 14 Jul 2021 17:24:29 +0300
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.21 16:38, Georgi Djakov wrote:
> When unmapping a buffer from an IOMMU domain, the IOMMU framework unmaps
> the buffer at a granule of the largest page size that is supported by
> the IOMMU hardware and fits within the buffer. For every block that
> is unmapped, the IOMMU framework will call into the IOMMU driver, and
> then the io-pgtable framework to walk the page tables to find the entry
> that corresponds to the IOVA, and then unmaps the entry.
> 
> This can be suboptimal in scenarios where a buffer or a piece of a
> buffer can be split into several contiguous page blocks of the same size.
> For example, consider an IOMMU that supports 4 KB page blocks, 2 MB page
> blocks, and 1 GB page blocks, and a buffer that is 4 MB in size is being
> unmapped at IOVA 0. The current call-flow will result in 4 indirect calls,
> and 2 page table walks, to unmap 2 entries that are next to each other in
> the page-tables, when both entries could have been unmapped in one shot
> by clearing both page table entries in the same call.
> 
> The same optimization is applicable to mapping buffers as well, so
> these patches implement a set of callbacks called unmap_pages and
> map_pages to the io-pgtable code and IOMMU drivers which unmaps or maps
> an IOVA range that consists of a number of pages of the same
> page size that is supported by the IOMMU hardware, and allows for
> manipulating multiple page table entries in the same set of indirect
> calls. The reason for introducing these callbacks is to give other IOMMU
> drivers/io-pgtable formats time to change to using the new callbacks, so
> that the transition to using this approach can be done piecemeal.

Hi Will,

Did you get a chance to look at this patchset? Most patches are already
acked/reviewed and all still applies clean on rc1.

Thanks,
Georgi
