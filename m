Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C079A3566D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbhDGIbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhDGIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:31:33 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C93C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:31:24 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 34F6F2A6; Wed,  7 Apr 2021 10:31:23 +0200 (CEST)
Date:   Wed, 7 Apr 2021 10:31:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 0/4] iommu/iova: Add CPU hotplug handler to flush
 rcaches to core code
Message-ID: <YG1t2W3Inf+55KER@8bytes.org>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:29:57PM +0800, John Garry wrote:
> John Garry (4):
>   iova: Add CPU hotplug handler to flush rcaches
>   iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>   iommu: Delete iommu_dma_free_cpu_cached_iovas()
>   iommu: Stop exporting free_iova_fast()
> 
>  drivers/iommu/dma-iommu.c   |  9 ---------
>  drivers/iommu/intel/iommu.c | 31 -------------------------------
>  drivers/iommu/iova.c        | 34 +++++++++++++++++++++++++++++++---
>  include/linux/cpuhotplug.h  |  2 +-
>  include/linux/dma-iommu.h   |  8 --------
>  include/linux/iova.h        |  6 +-----
>  6 files changed, 33 insertions(+), 57 deletions(-)

Okay, newer version. Applied this one instead, thanks.
