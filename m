Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA69C3A0E9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhFIIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbhFIIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:17:46 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE23C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 01:15:51 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 58D2C36A; Wed,  9 Jun 2021 10:15:49 +0200 (CEST)
Date:   Wed, 9 Jun 2021 10:15:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        rdunlap@infradead.org
Subject: Re: [PATCH v11 0/3] Enhance IOMMU default DMA mode build options
Message-ID: <YMB4tCrkZv1b44qM@8bytes.org>
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Tue, Jun 08, 2021 at 09:18:25PM +0800, John Garry wrote:
> Zhen Lei (3):
>   iommu: Enhance IOMMU default DMA mode build options
>   iommu/vt-d: Add support for IOMMU default DMA mode build options
>   iommu/amd: Add support for IOMMU default DMA mode build options

So I like the idea, but can we go a step further and get (mostly) rid of
the driver-specific setup code for lazy/non-lazy mode? This can happen
in the dma-iommu code and the drivers only need to keep the support for
their legacy command line options.

Regards,

	Joerg
