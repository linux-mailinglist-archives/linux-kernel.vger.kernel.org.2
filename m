Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39393EBAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhHMREK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:04:10 -0400
Received: from foss.arm.com ([217.140.110.172]:55984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhHMREH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:04:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCFBFD6E;
        Fri, 13 Aug 2021 10:03:40 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33B13F70D;
        Fri, 13 Aug 2021 10:03:39 -0700 (PDT)
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.15
To:     Will Deacon <will@kernel.org>, joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20210813164735.GA8765@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <603960e8-e8cd-ed5c-32fd-93118401a221@arm.com>
Date:   Fri, 13 Aug 2021 18:03:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813164735.GA8765@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-13 17:47, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull these Arm SMMU updates for 5.15. There's not tonnes here, but
> a good mixture of optimisations and cleanups -- summary in the tag.
> 
> This applies cleanly against iommu/next, but I suspect it will conflict
> with Robin's series on the list. Please shout if you need anything from
> me to help with that (e.g. rebase, checking a merge conflict).

In fact it merges cleanly into my local branch, so I hope we should be 
good :)

Robin.

> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit ff1176468d368232b684f75e82563369208bc371:
> 
>    Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> for you to fetch changes up to fac956710ab0812f9e395e9f7a27da551412830f:
> 
>    iommu/arm-smmu-v3: Stop pre-zeroing batch commands (2021-08-13 14:26:06 +0100)
> 
> ----------------------------------------------------------------
> Arm SMMU updates for 5.15
> 
> - SMMUv3
> 
>    * Minor optimisation to avoid zeroing struct members on CMD submission
> 
>    * Increased use of batched commands to reduce submission latency
> 
>    * Refactoring in preparation for ECMDQ support
> 
> - SMMUv2
> 
>    * Fix races when probing devices with identical StreamIDs
> 
>    * Optimise walk cache flushing for Qualcomm implementations
> 
>    * Allow deep sleep states for some Qualcomm SoCs with shared clocks
> 
> ----------------------------------------------------------------
> Ashish Mhetre (1):
>        iommu: Fix race condition during default domain allocation
> 
> John Garry (2):
>        iommu/arm-smmu-v3: Remove some unneeded init in arm_smmu_cmdq_issue_cmdlist()
>        iommu/arm-smmu-v3: Stop pre-zeroing batch commands
> 
> Krishna Reddy (1):
>        iommu/arm-smmu: Fix race condition during iommu_group creation
> 
> Sai Prakash Ranjan (2):
>        iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to system pm callbacks
>        iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom implementation
> 
> Zhen Lei (4):
>        iommu/arm-smmu-v3: Use command queue batching helpers to improve performance
>        iommu/arm-smmu-v3: Add and use static helper function arm_smmu_cmdq_issue_cmd_with_sync()
>        iommu/arm-smmu-v3: Add and use static helper function arm_smmu_get_cmdq()
>        iommu/arm-smmu-v3: Extract reusable function __arm_smmu_cmdq_skip_err()
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 +++++++++++++++++------------
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  | 11 ++++
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 45 ++++++++++++---
>   drivers/iommu/arm/arm-smmu/arm-smmu.h       |  1 +
>   drivers/iommu/iommu.c                       |  2 +
>   5 files changed, 106 insertions(+), 42 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
