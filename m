Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175BE356606
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhDGIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhDGIFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:05:01 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42AC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:04:52 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 54B682A6; Wed,  7 Apr 2021 10:04:50 +0200 (CEST)
Date:   Wed, 7 Apr 2021 10:04:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, will@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, robin.murphy@arm.com
Subject: Re: [PATCH 0/3] iommu/iova: Add CPU hotplug handler to flush rcaches
 to core code
Message-ID: <YG1noCU6pFQRC+yF@8bytes.org>
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:12:18PM +0800, John Garry wrote:
> The Intel IOMMU driver supports flushing the per-CPU rcaches when a CPU is
> offlined.
> 
> Let's move it to core code, so everyone can take advantage.
> 
> Also correct a code comment.
> 
> Based on v5.12-rc1. Tested on arm64 only.
> 
> John Garry (3):
>   iova: Add CPU hotplug handler to flush rcaches
>   iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>   iova: Correct comment for free_cpu_cached_iovas()
> 
>  drivers/iommu/intel/iommu.c | 31 -------------------------------
>  drivers/iommu/iova.c        | 32 ++++++++++++++++++++++++++++++--
>  include/linux/cpuhotplug.h  |  2 +-
>  include/linux/iova.h        |  1 +
>  4 files changed, 32 insertions(+), 34 deletions(-)

Applied, thanks.

