Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46E1307688
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhA1Mzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:55:38 -0500
Received: from 8bytes.org ([81.169.241.247]:53376 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhA1MzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:55:13 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3841D59C; Thu, 28 Jan 2021 13:54:31 +0100 (CET)
Date:   Thu, 28 Jan 2021 13:54:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jean-philippe@linaro.org, will@kernel.org,
        prime.zeng@hisilicon.com, linuxarm@openeuler.org
Subject: Re: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Message-ID: <20210128125429.GO32671@8bytes.org>
References: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:06:29PM +0000, Shameer Kolothum wrote:
> The device iommu probe/attach might have failed leaving dev->iommu
> to NULL and device drivers may still invoke these functions resulting
> a crash in iommu vendor driver code. Hence make sure we check that.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ffeebda8d6de..cb68153c5cc0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2867,7 +2867,7 @@ bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)

This function has been removed from the iommu-tree. Can you please
rebase this patch against the latest 'core' branch when I pushed it
later this week (maybe even later today)?
A Fixes tag would be nice too.

Regards,

	Joerg
