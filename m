Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF53D59BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhGZMGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:06:13 -0400
Received: from 8bytes.org ([81.169.241.247]:47200 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234136AbhGZMFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:05:42 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8BF072B0; Mon, 26 Jul 2021 14:46:10 +0200 (CEST)
Date:   Mon, 26 Jul 2021 14:46:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: Re: [PATCH 16/23] iommu/arm-smmu: Prepare for multiple DMA domain
 types
Message-ID: <YP6ukfewNVjgS/bt@8bytes.org>
References: <cover.1626888444.git.robin.murphy@arm.com>
 <04220b3420c2c513490450f37de109182364f235.1626888445.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04220b3420c2c513490450f37de109182364f235.1626888445.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 07:20:27PM +0100, Robin Murphy wrote:
> -	if (type == IOMMU_DOMAIN_DMA && using_legacy_binding)
> +	if ((type & __IOMMU_DOMAIN_DMA_API) && using_legacy_binding)

Hmm, I wonder whether it is time to introduce helpers for these checks?

Something like iommu_domain_is_dma() is more readable.

