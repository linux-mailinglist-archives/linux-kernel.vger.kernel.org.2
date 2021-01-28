Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88F7307FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhA1Ucn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhA1Ucf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:32:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D098D6146D;
        Thu, 28 Jan 2021 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611865914;
        bh=ikddncy7CqjnKtLrYpUeMTE7X6rsHUE6n+WXCE1YkD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NE7JiXBzTuCvA2Q10N56mTYgsE2JGAo1XZjBq55zIpOGe69wexKJ0CpsuIGnRnzCu
         RTVEBT/NXKWmbkVtPmyUz7JqbLOMKJO94cn9iEM7hbHFv/AnvGGI/WWR4ecLb/LXd2
         kXmRgYJTobbDRdAybBw1clw7ORiky4RCY+RybW4FBQFRtldfnHllXuQg3oFGC+KyOI
         s1XVzSeET6vHDb3T+Yx8oz+kiW0+GbnEWZU2peBP25bN/rinjgfiXjKLDdCgpOh65k
         1rrHWUuuiISHr9dc5GXglLH0LXWkjsUJNy9/kGfstK4MYGveq1Pgh0PrfsL/cbegyb
         0XIo5233AkFHA==
Date:   Thu, 28 Jan 2021 20:31:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 0/3] perf/smmuv3: Don't reserve the PMCG register
 spaces
Message-ID: <20210128203148.GG3016@willie-the-truck>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127113258.1421-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 07:32:55PM +0800, Zhen Lei wrote:
> v2 --> v3:
> Patch 3 is updated because https://lkml.org/lkml/2021/1/22/532 has been queued in advance.
> 
> v1 --> v2:
> According to Robin Murphy's suggestion: https://lkml.org/lkml/2021/1/20/470
> Don't reserve the PMCG register spaces, and reserve the entire SMMU register space.
> 
> v1:
> Since the PMCG may implement its resigters space(4KB Page0 and 4KB Page1)
> within the SMMUv3 64KB Page0. In this case, when the SMMUv3 driver reserves the
> 64KB Page0 resource in advance, the PMCG driver try to reserve its Page0 and
> Page1 resources, a resource conflict occurs.
> 
> commit 52f3fab0067d6fa ("iommu/arm-smmu-v3: Don't reserve implementation
> defined register space") reduce the resource reservation range of the SMMUv3
> driver, it only reserves the first 0xe00 bytes in the 64KB Page0, to avoid
> the above-mentioned resource conflicts.
> 
> But the SMMUv3.3 add support for ECMDQ, its registers space is also implemented
> in the SMMUv3 64KB Page0. This means we need to build two separate mappings.
> New features may be added in the future, and more independent mappings may be
> required. The simple problem is complicated because the user expects to map the
> entire SMMUv3 64KB Page0.
> 
> Therefore, the proper solution is: If the PMCG register resources are located in
> the 64KB Page0 of the SMMU, the PMCG driver does not reserve the conflict resources
> when the SMMUv3 driver has reserved the conflict resources before. Instead, the PMCG
> driver only performs devm_ioremap() to ensure that it can work properly.
> 
> Zhen Lei (3):
>   perf/smmuv3: Don't reserve the PMCG register spaces
>   perf/smmuv3: Add a MODULE_SOFTDEP() to indicate dependency on SMMU
>   iommu/arm-smmu-v3: Reserving the entire SMMU register space

I'll need Robin's ack on these.

Will
