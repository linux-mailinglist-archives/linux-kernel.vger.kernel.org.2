Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE33ED3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhHPMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:07:52 -0400
Received: from verein.lst.de ([213.95.11.211]:54145 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235091AbhHPMHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:07:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E8D66736F; Mon, 16 Aug 2021 14:07:14 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:07:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] dma-iommu: fold _swiotlb helpers into callers
Message-ID: <20210816120714.GC15860@lst.de>
References: <20210816025755.2906695-1-stevensd@google.com> <20210816025755.2906695-5-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816025755.2906695-5-stevensd@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +		    (dir == DMA_TO_DEVICE ||
> +		     dir == DMA_BIDIRECTIONAL)) {

Nit: the two dire checks easily fit onto a single line and are easier to
follow that way.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
