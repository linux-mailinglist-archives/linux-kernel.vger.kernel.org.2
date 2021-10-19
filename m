Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCBF433667
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhJSM4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235743AbhJSM4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:56:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F03F261360;
        Tue, 19 Oct 2021 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634648079;
        bh=XolEmSFJHODP9aZmMvAA9I4STQCYJzJC8vm4MrX87+A=;
        h=Date:From:To:Cc:Subject:From;
        b=JTlB2vgYj9uw9wf9tW1PRncSDV+KgTyAY3pqEqAbqoKFnZ8ZByto/QSzeQOn6Ta6K
         VKvWraVrGCwJsvslP7sZ2vkWzKg76vnnqVoO9BOvv9GUDv2sS3MOoFKHWczrEKvsNm
         +0UsPbZjQhFflXVEezwadYPjAv3BPjZK+D7WQuswWNaz1f+fN0FG2JJcW3iFotSv4w
         z9GksigTUWunwJvGGZUqEnc8W+NIQQIBfvVaCsboXrqSmFshjHy3gO9UVyCA400FW6
         kmop9K/bEgwI61TQoiX2kMvgUUf/B6cyKFvhyiN749xG+HyT8wf3N+aMSJF8vlaEVq
         wvuA4ykRzYCOg==
Date:   Tue, 19 Oct 2021 13:54:34 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.16
Message-ID: <20211019125434.GA14085@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull this tiny batch of Arm SMMU updates for 5.16. It's dominated
by compatible string additions for Qualcomm SMMUv2 implementations, but
there's a bit of cleanup on the SMMUv3 command-submission side as well.

Cheers,

Will

--->8

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to e37f1fe4332491bf2f7b7849d5c3adba0d2a77b3:

  iommu/arm-smmu-qcom: Request direct mapping for modem device (2021-10-08 09:07:44 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.16

- Minor optimisations to SMMUv3 command creation and submission

- Numerous new compatible string for Qualcomm SMMUv2 implementations

----------------------------------------------------------------
Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add compatible for SM6350 SoC
      iommu/arm-smmu-qcom: Add SM6350 SMMU compatible

Loic Poulain (2):
      dt-bindings: arm-smmu: Add compatible for QCM2290 SoC
      iommu: arm-smmu-qcom: Add compatible for QCM2290

Sibi Sankar (1):
      iommu/arm-smmu-qcom: Request direct mapping for modem device

Zhen Lei (2):
      iommu/arm-smmu-v3: Stop pre-zeroing batch commands in arm_smmu_atc_inv_master()
      iommu/arm-smmu-v3: Properly handle the return value of arm_smmu_cmdq_build_cmd()

 .../devicetree/bindings/iommu/arm,smmu.yaml         |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 21 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c          |  3 +++
 3 files changed, 19 insertions(+), 7 deletions(-)
