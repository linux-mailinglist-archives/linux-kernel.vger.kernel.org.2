Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF534026E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCRJtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:49:04 -0400
Received: from 8bytes.org ([81.169.241.247]:59582 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhCRJsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:48:31 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 01ED22D8; Thu, 18 Mar 2021 10:48:29 +0100 (CET)
Date:   Thu, 18 Mar 2021 10:48:28 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, jean-philippe@linaro.org, will@kernel.org,
        prime.zeng@hisilicon.com, linuxarm@openeuler.org
Subject: Re: [PATCH v3] iommu: Check dev->iommu in iommu_dev_xxx functions
Message-ID: <YFMh7E5OiMVkJCU9@8bytes.org>
References: <20210303173611.520-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303173611.520-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:36:11PM +0000, Shameer Kolothum wrote:
> The device iommu probe/attach might have failed leaving dev->iommu
> to NULL and device drivers may still invoke these functions resulting
> in a crash in iommu vendor driver code.
> 
> Hence make sure we check that.
> 
> Fixes: a3a195929d40 ("iommu: Add APIs for multiple domains per device")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v2 --> v3
>  -Removed iommu_ops from struct dev_iommu.
> v1 --> v2:
>  -Added iommu_ops to struct dev_iommu based on the discussion with Robin.
>  -Rebased against iommu-tree core branch.
> ---
>  drivers/iommu/iommu.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Applied, thanks.
