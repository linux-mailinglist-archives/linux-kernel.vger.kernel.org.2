Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B23EB23E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhHMIG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:06:29 -0400
Received: from verein.lst.de ([213.95.11.211]:46783 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239642AbhHMIDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:03:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B9FE76736F; Fri, 13 Aug 2021 10:02:36 +0200 (CEST)
Date:   Fri, 13 Aug 2021 10:02:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dma-iommu: fix arch_sync_dma for map
Message-ID: <20210813080236.GB28020@lst.de>
References: <20210813073839.1562438-1-stevensd@google.com> <20210813073839.1562438-3-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813073839.1562438-3-stevensd@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a really hard time reading following the patch.
Can you split folding__iommu_dma_map_swiotlb into iommu_dma_map_page
into a second cleanup patch?
