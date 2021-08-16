Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779013ED3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhHPMJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:09:10 -0400
Received: from verein.lst.de ([213.95.11.211]:54155 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhHPMJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:09:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 979966736F; Mon, 16 Aug 2021 14:08:36 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:08:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] dma-iommu: Check CONFIG_SWIOTLB more broadly
Message-ID: <20210816120836.GD15860@lst.de>
References: <20210816025755.2906695-1-stevensd@google.com> <20210816025755.2906695-6-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816025755.2906695-6-stevensd@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
> +	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_use_swiotlb(dev) &&
>  	    iova_offset(iovad, phys | size)) {

This can drop the explicit CONFIG_SWIOTLB check now (and make the remaining
conditional fit onto a single line).
