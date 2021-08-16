Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4358E3ED3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhHPMFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:05:40 -0400
Received: from verein.lst.de ([213.95.11.211]:54121 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhHPMFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:05:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D0FC6736F; Mon, 16 Aug 2021 14:05:05 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:05:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] dma-iommu: fix arch_sync_dma for map
Message-ID: <20210816120504.GA15860@lst.de>
References: <20210816025755.2906695-1-stevensd@google.com> <20210816025755.2906695-3-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816025755.2906695-3-stevensd@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
