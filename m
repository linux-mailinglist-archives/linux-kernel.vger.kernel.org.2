Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32553AB6DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhFQPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhFQPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:06:13 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BDFC061760
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:04:04 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4414F60E; Thu, 17 Jun 2021 17:04:02 +0200 (CEST)
Date:   Thu, 17 Jun 2021 17:04:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, john.garry@huawei.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu: Update "iommu.strict" documentation
Message-ID: <YMtkYeoaiFIxeyoY@8bytes.org>
References: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8c06e1b449d6b060c5bf9ad3b403cd142f405d.1623682646.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 03:57:26PM +0100, Robin Murphy wrote:
> Consolidating the flush queue logic also meant that the "iommu.strict"
> option started taking effect on x86 as well. Make sure we document that.
> 
> Fixes: a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.
