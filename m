Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F340B3623D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbhDPPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:23:17 -0400
Received: from 8bytes.org ([81.169.241.247]:35312 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244938AbhDPPXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:23:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6A174223; Fri, 16 Apr 2021 17:22:47 +0200 (CEST)
Date:   Fri, 16 Apr 2021 17:22:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v2 1/2] iommu: Statically set module owner
Message-ID: <YHmrxuIXH2rOozti@8bytes.org>
References: <31423b99ff609c3d4b291c701a7a7a810d9ce8dc.1617285386.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31423b99ff609c3d4b291c701a7a7a810d9ce8dc.1617285386.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:56:25PM +0100, Robin Murphy wrote:
> It happens that the 3 drivers which first supported being modular are
> also ones which play games with their pgsize_bitmap, so have non-const
> iommu_ops where dynamically setting the owner manages to work out OK.
> However, it's less than ideal to force that upon all drivers which want
> to be modular - like the new sprd-iommu driver which now has a potential
> bug in that regard - so let's just statically set the module owner and
> let ops remain const wherever possible.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 +
>  drivers/iommu/sprd-iommu.c                  | 1 +
>  drivers/iommu/virtio-iommu.c                | 1 +
>  include/linux/iommu.h                       | 9 +--------
>  5 files changed, 5 insertions(+), 8 deletions(-)

Applied these two directly on-top of my next branch. This essentially
means that all topic branches are frozen now until after the merge
window.

Regards,

	Joerg
