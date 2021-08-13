Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D213EBA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhHMQsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhHMQsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:48:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43ED86103A;
        Fri, 13 Aug 2021 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628873260;
        bh=TOC8YA+AWzpLpPO1FgCb/XYmAb7MvaYyPY+3sTJWw5M=;
        h=Date:From:To:Cc:Subject:From;
        b=rZ2O8SaKYpf2+wor2v6iJ5KIDtOqkAhJRKy4AQ87te8HAdTMyXVxA9UchwVrFBRQr
         9mwepfj97eWuCWcusaZ/xXr/GfgI3WYkM3KHMU8RX1tbQfEzk96LalijllOxg5Ufr1
         UjbT77f73g28dj/RAIg98dmL6wZcUk0n/iN974D5xIVAu1tRNYj73xB1+r4DZbhnhA
         K0q4RicMBiaDNYQg5XEcQLTwEzC7OZrc1bdIXkZywvNm40SXkHnGYQXUaMDs4e8mdG
         n0CQNbGg9PhhBxylzKIuJl/FQRzSb+saSAWhxWk50m263staH6QhcExH5bnDXUpkIt
         T+s5RaeBxJvXg==
Date:   Fri, 13 Aug 2021 17:47:35 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.15
Message-ID: <20210813164735.GA8765@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.15. There's not tonnes here, but
a good mixture of optimisations and cleanups -- summary in the tag.

This applies cleanly against iommu/next, but I suspect it will conflict
with Robin's series on the list. Please shout if you need anything from
me to help with that (e.g. rebase, checking a merge conflict).

Cheers,

Will

--->8

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to fac956710ab0812f9e395e9f7a27da551412830f:

  iommu/arm-smmu-v3: Stop pre-zeroing batch commands (2021-08-13 14:26:06 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.15

- SMMUv3

  * Minor optimisation to avoid zeroing struct members on CMD submission

  * Increased use of batched commands to reduce submission latency

  * Refactoring in preparation for ECMDQ support

- SMMUv2

  * Fix races when probing devices with identical StreamIDs

  * Optimise walk cache flushing for Qualcomm implementations

  * Allow deep sleep states for some Qualcomm SoCs with shared clocks

----------------------------------------------------------------
Ashish Mhetre (1):
      iommu: Fix race condition during default domain allocation

John Garry (2):
      iommu/arm-smmu-v3: Remove some unneeded init in arm_smmu_cmdq_issue_cmdlist()
      iommu/arm-smmu-v3: Stop pre-zeroing batch commands

Krishna Reddy (1):
      iommu/arm-smmu: Fix race condition during iommu_group creation

Sai Prakash Ranjan (2):
      iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to system pm callbacks
      iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom implementation

Zhen Lei (4):
      iommu/arm-smmu-v3: Use command queue batching helpers to improve performance
      iommu/arm-smmu-v3: Add and use static helper function arm_smmu_cmdq_issue_cmd_with_sync()
      iommu/arm-smmu-v3: Add and use static helper function arm_smmu_get_cmdq()
      iommu/arm-smmu-v3: Extract reusable function __arm_smmu_cmdq_skip_err()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 +++++++++++++++++------------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  | 11 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 45 ++++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |  1 +
 drivers/iommu/iommu.c                       |  2 +
 5 files changed, 106 insertions(+), 42 deletions(-)
