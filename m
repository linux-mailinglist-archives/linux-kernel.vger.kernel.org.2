Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268BB3D598B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhGZLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:50:47 -0400
Received: from 8bytes.org ([81.169.241.247]:47170 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233742AbhGZLup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:50:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 66EEB2B0; Mon, 26 Jul 2021 14:31:13 +0200 (CEST)
Date:   Mon, 26 Jul 2021 14:31:12 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] iommu/amd: Enable page-selective flushes
Message-ID: <YP6rEOy5ti0SHuns@8bytes.org>
References: <20210723093209.714328-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding Suravee, reviewer for AMD IOMMU ]

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

Thanks for your work on this, Nadav. If there are no further objections
I am going to apply the patches later this week.

Regards,

	Joerg
