Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4373DD2ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhHBJ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:27:01 -0400
Received: from 8bytes.org ([81.169.241.247]:52248 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232711AbhHBJ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:26:59 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C0B98806; Mon,  2 Aug 2021 11:26:49 +0200 (CEST)
Date:   Mon, 2 Aug 2021 11:26:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] iommu/amd: Enable page-selective flushes
Message-ID: <YQe6WPWRl9M4Jot0@8bytes.org>
References: <20210723093209.714328-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 02:32:02AM -0700, Nadav Amit wrote:
> Nadav Amit (6):
>   iommu/amd: Selective flush on unmap
>   iommu/amd: Do not use flush-queue when NpCache is on
>   iommu: Factor iommu_iotlb_gather_is_disjoint() out
>   iommu/amd: Tailored gather logic for AMD
>   iommu/amd: Sync once for scatter-gather operations
>   iommu/amd: Use only natural aligned flushes in a VM
> 
> Robin Murphy (1):
>   iommu: Improve iommu_iotlb_gather helpers

Applied, thanks Nadav.
