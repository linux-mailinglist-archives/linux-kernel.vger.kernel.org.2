Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0933A4359
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhFKNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231393AbhFKNwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D7DE61357;
        Fri, 11 Jun 2021 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623419444;
        bh=4g9zOBMtlLANWjsSzpBI0yPUcR1JafM3BAkdl/2DRjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huqExwz9svuE+0K5X/MWkdW0X79ZbDiGNmay76Y88bNqFOJguDAdSitTn8KyMPZ19
         nlXc4WBp/GZH2SK4kyEAaxdin+T4nTefqJ7xDJP5iY9rbf394O+nUKDadCOiiShU82
         TbjmsPvLQDQkPB6WlPWc56XRcY135G1u8iMMTqFffViBMEjeSe8ii4SNM0vT4jXDGe
         g2c6jvOsx30Tc0dqOELYK2FIafC09RqSF6h1wRJSLWnSbsFSJvBVhPFjrzeXj2d/7q
         x10ouJtJsxfA7dAc9eL+AEpG2bbp5CfmATTbIXjvXvEnbxlpCTNcACLqn9aoB3xuZ+
         JqS11eowipklQ==
Date:   Fri, 11 Jun 2021 14:50:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
Message-ID: <20210611135039.GB15776@willie-the-truck>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607182541.119756-4-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:25:38AM -0700, Nadav Amit wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> The Mediatek driver is not the only one which might want a basic
> address-based gathering behaviour, so although it's arguably simple
> enough to open-code, let's factor it out for the sake of cleanliness.
> Let's also take this opportunity to document the intent of these
> helpers for clarity.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> Changes from Robin's version:
> * Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
> * Use iommu_iotlb_gather_add_range() in iommu_iotlb_gather_add_page()
> ---
>  drivers/iommu/mtk_iommu.c |  5 +----
>  include/linux/iommu.h     | 43 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 39 insertions(+), 9 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
