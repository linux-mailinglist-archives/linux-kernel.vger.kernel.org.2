Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1223C146E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhGHNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:41:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:2879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231817AbhGHNlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:41:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="209467995"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="209467995"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 06:38:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="487606704"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.103]) ([10.254.214.103])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 06:38:36 -0700
Cc:     baolu.lu@linux.intel.com,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org,
        David Stevens <stevensd@google.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
To:     David Stevens <stevensd@chromium.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20210707075505.2896824-1-stevensd@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/4] Add dynamic iommu backed bounce buffers
Message-ID: <f6541f4e-648e-d9a0-eda7-b2a117978ebb@linux.intel.com>
Date:   Thu, 8 Jul 2021 21:38:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707075505.2896824-1-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I like this idea. Thanks for proposing this.

On 2021/7/7 15:55, David Stevens wrote:
> Add support for per-domain dynamic pools of iommu bounce buffers to the
> dma-iommu API. This allows iommu mappings to be reused while still
> maintaining strict iommu protection. Allocating buffers dynamically
> instead of using swiotlb carveouts makes per-domain pools more amenable
> on systems with large numbers of devices or where devices are unknown.

Have you ever considered leveraging the per-device swiotlb memory pool
added by below series?

https://lore.kernel.org/linux-iommu/20210625123004.GA3170@willie-the-truck/

> 
> When enabled, all non-direct streaming mappings below a configurable
> size will go through bounce buffers. Note that this means drivers which
> don't properly use the DMA API (e.g. i915) cannot use an iommu when this
> feature is enabled. However, all drivers which work with swiotlb=force
> should work.

If so, why not making it more scalable by adding a callback into vendor
iommu drivers? The vendor iommu drivers have enough information to tell
whether the bounce buffer is feasible for a specific domain.

> 
> Bounce buffers serve as an optimization in situations where interactions
> with the iommu are very costly. For example, virtio-iommu operations in

The simulated IOMMU does the same thing.

It's also an optimization for bare metal in cases where the strict mode
of cache invalidation is used. CPU moving data is faster than IOMMU
cache invalidation if the buffer is small.

Best regards,
baolu
