Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB33584B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhDHNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhDHNaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:30:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C40C56113C;
        Thu,  8 Apr 2021 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617888603;
        bh=NfLfquOCyf9Vx2nOKutNnCFVm83emxs246Y2WC5ndgY=;
        h=Date:From:To:Cc:Subject:From;
        b=hMudnabJt8rAyFOkHZeu6v5zhqbqpGRTEIsE25L+r2gOPljpxM6yCm6UKFd0rjJoZ
         BNRikw0D2pQpNDcw6dNj/tUdbAUYYGIUS5qCm5thXlJcCLvkjO4NoGiHPIex4xhSGF
         ec4GGjPGySTXjj9+ymY2jfYBwjmj+aMvqLuiHdQBNL2CBB65+loIi2/409cvhTtTdF
         TjEF3BbuI2sGeYlDYa6kMbOQeHQhokYtXgEaJ5JRUCNVwn+hzjyaPxfhifIs4wM9Mc
         SjLJk93GNabznECcVecP8xtqXmNCQn3nye3w/Ao4Xkl4eJKkUotutOOLhBi/6S3s9q
         kzTVtpbfD/Rpg==
Date:   Thu, 8 Apr 2021 14:29:59 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.13
Message-ID: <20210408132959.GB17873@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

There's hardly anything on the SMMU front for 5.13, but please pull
these regardless. Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to e0bb4b73540495111ff2723e41cf5add2f031021:

  iommu/arm-smmu-v3: Remove the unused fields for PREFETCH_CONFIG command (2021-04-07 11:30:40 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.13

- SMMUv3:

  * Drop vestigial PREFETCH_ADDR support

  * Elide TLB sync logic for empty gather

  * Fix "Service Failure Mode" handling

- SMMUv2:

  * New Qualcomm compatible string

----------------------------------------------------------------
Sai Prakash Ranjan (1):
      dt-bindings: arm-smmu: Add compatible for SC7280 SoC

Xiang Chen (1):
      iommu/arm-smmu-v3: Add a check to avoid invalid iotlb sync

Zenghui Yu (1):
      iommu/arm-smmu-v3: Remove the unused fields for PREFETCH_CONFIG command

Zhen Lei (1):
      iommu/arm-smmu-v3: add bit field SFM into GERROR_ERR_MASK

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           | 5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h           | 4 +---
 3 files changed, 5 insertions(+), 5 deletions(-)
