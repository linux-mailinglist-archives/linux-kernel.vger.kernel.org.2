Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB43D57A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhGZJ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:58:08 -0400
Received: from 8bytes.org ([81.169.241.247]:46986 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhGZJ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:57:49 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F178A2B0; Mon, 26 Jul 2021 12:38:03 +0200 (CEST)
Date:   Mon, 26 Jul 2021 12:37:56 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, isaacm@codeaurora.org,
        baolu.lu@linux.intel.com, pratikp@codeaurora.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: Re: [PATCH v7 00/15] Optimizing iommu_[map/unmap] performance
Message-ID: <YP6QhHDyCLSiqIvn@8bytes.org>
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 06:38:41AM -0700, Georgi Djakov wrote:
> Isaac J. Manjarres (12):
>   iommu/io-pgtable: Introduce unmap_pages() as a page table op
>   iommu: Add an unmap_pages() op for IOMMU drivers
>   iommu/io-pgtable: Introduce map_pages() as a page table op
>   iommu: Add a map_pages() op for IOMMU drivers
>   iommu: Add support for the map_pages() callback
>   iommu/io-pgtable-arm: Prepare PTE methods for handling multiple
>     entries
>   iommu/io-pgtable-arm: Implement arm_lpae_unmap_pages()
>   iommu/io-pgtable-arm: Implement arm_lpae_map_pages()
>   iommu/io-pgtable-arm-v7s: Implement arm_v7s_unmap_pages()
>   iommu/io-pgtable-arm-v7s: Implement arm_v7s_map_pages()
>   iommu/arm-smmu: Implement the unmap_pages() IOMMU driver callback
>   iommu/arm-smmu: Implement the map_pages() IOMMU driver callback
> 
> Will Deacon (3):
>   iommu: Use bitmap to calculate page size in iommu_pgsize()
>   iommu: Split 'addr_merge' argument to iommu_pgsize() into separate
>     parts
>   iommu: Hook up '->unmap_pages' driver callback

Applied to iommu/core branch, thanks to everyone involved!
