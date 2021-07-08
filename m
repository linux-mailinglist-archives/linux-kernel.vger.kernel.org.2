Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF333BF790
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGHJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhGHJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:30:50 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE971C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 02:28:08 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 91EC8312; Thu,  8 Jul 2021 11:28:06 +0200 (CEST)
Date:   Thu, 8 Jul 2021 11:28:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     will@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu
 v2 and uses identity mapping
Message-ID: <YObFJREB9/JlcNZP@8bytes.org>
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708074232.924844-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
> @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
>  
>  		iommu = amd_iommu_rlookup_table[dev_data->devid];
>  		dev_data->iommu_v2 = iommu->is_iommu_v2;
> +
> +		if (dev_data->iommu_v2)
> +			swiotlb = 1;

This looks like the big hammer, as it will affect all other systems
where the AMD GPUs are in their own group.

What is needed here is an explicit check whether a non-iommu-v2 device
is direct-mapped because it shares a group with the GPU, and only enable
swiotlb in this case.

Thanks,

	Joerg
