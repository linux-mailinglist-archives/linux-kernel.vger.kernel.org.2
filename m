Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500943E45EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhHIMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhHIMt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:49:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B53160FE3;
        Mon,  9 Aug 2021 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628513377;
        bh=DuWuffUzHWTlh5RyIppkfZJMBWUzwes3xWNKxmTLe/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jk+7pKgZ+88oYQV9NkXW4+7DYuSYjjTwrgQJpOrttxXIl5tKNVCJEgrkyQdFPhMBz
         f+hMsHunXnbXXesw+l55zR366ZFmUEFCU46XuqwsX9p51Orqm4/orNB9V6uk/Qf427
         M8lkagHV1KbxaWYI5iHUprg2PxaP5mEWPsbx4edZ51DKNkwnlvb24ksb39kRyXaIUh
         R4mSwsA0e80ppbX3SHwNrX0m85MhDas0fjY1UT3lTv39wJhvOa8g5cqTbMM2vtoEbn
         CNkDkUHMlk+b6ei3yicYLMvxr7anZ9IQoNRNMXm/AvyXMBtyTtb5tMvU3WkqdmVQv3
         Yh+XgBvSP2Q1A==
Date:   Mon, 9 Aug 2021 13:49:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH v3 25/25] iommu: Allow enabling non-strict mode
 dynamically
Message-ID: <20210809124931.GA1097@willie-the-truck>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <22b044263f69e2bfe404c4379a435005ea58b3e2.1628094601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b044263f69e2bfe404c4379a435005ea58b3e2.1628094601.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 06:15:53PM +0100, Robin Murphy wrote:
> Allocating and enabling a flush queue is in fact something we can
> reasonably do while a DMA domain is active, without having to rebuild it
> from scratch. Thus we can allow a strict -> non-strict transition from
> sysfs without requiring to unbind the device's driver, which is of
> particular interest to users who want to make selective relaxations to
> critical devices like the one serving their root filesystem.
> 
> Disabling and draining a queue also seems technically possible to
> achieve without rebuilding the whole domain, but would certainly be more
> involved. Furthermore there's not such a clear use-case for tightening
> up security *after* the device may already have done whatever it is that
> you don't trust it not to do, so we only consider the relaxation case.
> 
> CC: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Actually think about concurrency, rework most of the fq data
>     accesses to be (hopefully) safe and comment it all
> ---
>  drivers/iommu/dma-iommu.c | 25 ++++++++++++++++++-------
>  drivers/iommu/iommu.c     | 16 ++++++++++++----
>  drivers/iommu/iova.c      |  9 ++++++---
>  3 files changed, 36 insertions(+), 14 deletions(-)

I failed to break this, so hopefully you've caught everything now.

Only thing I wasn't sure of is why we still need the smp_wmb() in
init_iova_flush_queue(). Can we remove it now that we have one before
assigning into the cookie?

Will
