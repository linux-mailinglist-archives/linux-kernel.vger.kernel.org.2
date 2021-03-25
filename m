Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC28A3498C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhCYRyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhCYRx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 005376192E;
        Thu, 25 Mar 2021 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616694839;
        bh=p9Fw2VLMXBm9WgC0jrRce9sCideLVwWWxngLieDXLLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggTDTbr92KwP/mo+C2q0J3WFddw0H+IKJWQBbaFFSjZ5oY8Dmu4wHRa9QVpWJLR2M
         O3/vjS5TtRUHfnaRhuhH/rNtOQTOO2a2fJIzlzll1Y5bQ5WFqn1+hqZKhytwGgCoCO
         TNj7hpKX3eWJHHdHVJDt6rUNRefcyfO8Cti2AkVjjcdUqTt1NWAtxMoBMCloPgTEpo
         vzkR5v1+RT5byZy9E8NSsabT0RHHcbeKAzNgxrRERVo7GSEt5GxYjDpuN5k6vnGkg2
         I+luU5xrMQsGQiAvflIQDX0P5uf5qLkgkPJw/RrXiCRCGzyFk9yZgbzmMXf9fEqWQf
         5SFPdUDzKptyg==
Date:   Thu, 25 Mar 2021 17:53:54 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 0/4] iommu/iova: Add CPU hotplug handler to flush
 rcaches to core code
Message-ID: <20210325175354.GE15504@willie-the-truck>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:29:57PM +0800, John Garry wrote:
> The Intel IOMMU driver supports flushing the per-CPU rcaches when a CPU is
> offlined.
> 
> Let's move it to core code, so everyone can take advantage.
> 
> Also throw in a patch to stop exporting free_iova_fast().
> 
> Differences to v1:
> - Add RB tags (thanks!)
> - Add patch to stop exporting free_iova_fast()
> - Drop patch to correct comment
> - Add patch to delete iommu_dma_free_cpu_cached_iovas() and associated
>   changes
> 
> John Garry (4):
>   iova: Add CPU hotplug handler to flush rcaches
>   iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>   iommu: Delete iommu_dma_free_cpu_cached_iovas()
>   iommu: Stop exporting free_iova_fast()

Looks like this is all set for 5.13, so hopefully Joerg can stick it in
-next for a bit more exposure.

Will
