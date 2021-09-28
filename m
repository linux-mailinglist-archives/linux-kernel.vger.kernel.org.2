Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B0E41ABEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbhI1Jcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:43 -0400
Received: from 8bytes.org ([81.169.241.247]:39764 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239958AbhI1JcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1841B2FF; Tue, 28 Sep 2021 11:30:45 +0200 (CEST)
Date:   Tue, 28 Sep 2021 11:30:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Tidy up Kconfig selects
Message-ID: <YVLgw1nfEf7U13Mh@8bytes.org>
References: <9ba6f2e8568a3ff6a94fade66668d99705433c44.1631536879.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba6f2e8568a3ff6a94fade66668d99705433c44.1631536879.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:41:19PM +0100, Robin Murphy wrote:
> Now that the dust has settled on converting all the x86 drivers to
> iommu-dma, we can punt the Kconfig selection to arch code where it
> was always intended to be.

Can we select IOMMU_DMA under IOMMU_SUPPORT instead? The only drivers
not using IOMMU_DMA are the arm32 ones, afaics.

If we could get rid of the arm32 exception, the IOMMU_DMA symbol could
also go away entirely and we handle it under IOMMU_SUPPORT instead. But
that is something for the future :)

Regards,

	Joerg

