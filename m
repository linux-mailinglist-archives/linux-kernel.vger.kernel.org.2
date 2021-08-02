Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF2B3DDB6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhHBOqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234623AbhHBOqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:46:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5893460F5A;
        Mon,  2 Aug 2021 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627915588;
        bh=PCyu/Y0oyAjSVhXusuoKFGjC/gazcGTZ7a+kCE6+TgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvCVQELnU1ndwO//2Z0IEuRfGtQDeGfy5jOET9KRUmeZtILAwFChOT5WU62TStRhp
         VFr5cMybOmmsXE9vNkxj5p5vmaZvlPcetHGFB6Jn6nyHakFE0+4qy0uNtABHlGR7gj
         0IUgCqefhhus8DtsNOFZOUZZOdhUV4OSXHOfp6tdMe7OmH3P9KgbktnbObZ8uEC6o3
         uB43y2UnFBcD9ymFukR0sZn55vZr8MSUcJs5HlFBbQ83688xCIlnUz/EHlGxeQxfTD
         CZL2cehfqa9yMljCDHRhnvEPxoOViomRyb+0xt1WJI62FZPQZeDFbueqpIHt6EwODD
         3rcl7gJE9Xbfg==
Date:   Mon, 2 Aug 2021 15:46:22 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, digetx@gmail.com, mst@redhat.com,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v4 1/6] iommu: Refactor iommu_group_store_type()
Message-ID: <20210802144621.GB28735@willie-the-truck>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626259003-201303-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 06:36:38PM +0800, John Garry wrote:
> Function iommu_group_store_type() supports changing the default domain
> of an IOMMU group.
> 
> Many conditions need to be satisfied and steps taken for this action to be
> successful.
> 
> Satisfying these conditions and steps will be required for setting other
> IOMMU group attributes, so factor into a common part and a part specific
> to update the IOMMU group attribute.
> 
> No functional change intended.
> 
> Some code comments are tidied up also.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iommu.c | 73 +++++++++++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 27 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Although likely to conflict with Robin's monster series.

Will
