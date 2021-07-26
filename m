Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C713D5879
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhGZKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhGZKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:47:39 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC2C061757;
        Mon, 26 Jul 2021 04:28:08 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BBC0A2B0; Mon, 26 Jul 2021 13:28:05 +0200 (CEST)
Date:   Mon, 26 Jul 2021 13:28:00 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        robin.murphy@arm.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH v15 0/6] iommu: Enhance IOMMU default DMA mode build
 options
Message-ID: <YP6cQDSuH7toUouj@8bytes.org>
References: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 07:12:14PM +0800, John Garry wrote:
> John Garry (3):
>   iommu: Deprecate Intel and AMD cmdline methods to enable strict mode
>   iommu: Print strict or lazy mode at init time
>   iommu: Remove mode argument from iommu_set_dma_strict()
> 
> Zhen Lei (3):
>   iommu: Enhance IOMMU default DMA mode build options
>   iommu/vt-d: Add support for IOMMU default DMA mode build options
>   iommu/amd: Add support for IOMMU default DMA mode build options

Applied to iommu/core, thanks.
