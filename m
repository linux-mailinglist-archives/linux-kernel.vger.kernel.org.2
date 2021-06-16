Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3640B3A9852
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhFPLAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhFPLAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:00:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42D661042;
        Wed, 16 Jun 2021 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623841098;
        bh=ZmODpF83uSvqjPBI5p8Cu8qZyLNvoTchOyLLBiGoWk0=;
        h=Date:From:To:Cc:Subject:From;
        b=nXoYddWxQ9Qw9vxeaHPG9Oppn9Ltc3/MiGcKG0AhbE7uGQsDxtWogIpxpTPbiFfrL
         bnK7IR7Fvdr45fMha6oVVn//JwCB6+Kc+Y7I6aGWvWYksYcIGiyzAWyIbLiRkMnY60
         wzCvIbPMlr1wthDXp6+9lKeZKScJKFfaLPv50RCTAdFNkR8xLB/ynM0vXvRDBpNWZ/
         H09xe4kcxyrbZBrQrvuVXTpysIpimjggbhNEvtuVoXITqq+yenBBOrhY+1RAlI3QFC
         9fFGe+vrRmayr+a7jz0+IwYvXCKV+jqVe39k1eiCyMLL+8bbz9VAunitPnWe87nNL6
         9d7UHjUuMkl3Q==
Date:   Wed, 16 Jun 2021 11:58:13 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com, treding@nvidia.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.14
Message-ID: <20210616105813.GA22735@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.14.

Of particular note is the support for stalling faults with platform devices
using SMMUv3 -- this concludes the bulk of the SVA work from Jean-Philippe.

Other than that, one thing to note is that the patch from Thierry adding
the '->prove_finalize' implementation hook is also shared with the
memory-controller tree, since they build on top of it to get the SMMU
working with an nvidia SOC. Unfortunately, that patch also caused a NULL
dereference on other parts, so there's a subsequent patch on top here
addressing that.

Due to the above, the sooner this lands in -next, the better.

Cheers,

Will

--->8

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to ddd25670d39b2181c7bec33301f2d24cdcf25dde:

  Merge branch 'for-thierry/arm-smmu' into for-joerg/arm-smmu/updates (2021-06-16 11:30:55 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.14

- SMMUv3:

  * Support stalling faults for platform devices

  * Decrease defaults sizes for the event and PRI queues

- SMMUv2:

  * Support for a new '->probe_finalize' hook, needed by Nvidia

  * Even more Qualcomm compatible strings

  * Avoid Adreno TTBR1 quirk for DB820C platform

- Misc:

  * Trivial cleanups/refactoring

----------------------------------------------------------------
Amey Narkhede (1):
      iommu/arm: Cleanup resources in case of probe error path

Bixuan Cui (1):
      iommu/arm-smmu-v3: Change *array into *const array

Eric Anholt (2):
      iommu/arm-smmu-qcom: Skip the TTBR1 quirk for db820c.
      arm64: dts: msm8996: Mark the GPU's SMMU as an adreno one.

Jean-Philippe Brucker (4):
      dt-bindings: Document stall property for IOMMU masters
      ACPI/IORT: Enable stall support for platform devices
      iommu/arm-smmu-v3: Add stall support for platform devices
      iommu/arm-smmu-v3: Ratelimit event dump

Martin Botka (1):
      iommu/arm-smmu-qcom: Add sm6125 compatible

Sai Prakash Ranjan (2):
      iommu/arm-smmu-qcom: Add SC7280 SMMU compatible
      iommu/arm-smmu-qcom: Move the adreno smmu specific impl

Shawn Guo (2):
      iommu/arm-smmu-qcom: hook up qcom_smmu_impl for ACPI boot
      iommu/arm-smmu-qcom: Protect acpi_match_platform_list() call with CONFIG_ACPI

Thierry Reding (1):
      iommu/arm-smmu: Implement ->probe_finalize()

Will Deacon (2):
      iommu/arm-smmu: Check smmu->impl pointer before dereferencing
      Merge branch 'for-thierry/arm-smmu' into for-joerg/arm-smmu/updates

Xiyu Yang (2):
      iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
      iommu/arm-smmu: Fix arm_smmu_device refcount leak in address translation

Zhen Lei (2):
      iommu/arm-smmu-v3: Decrease the queue size of evtq and priq
      iommu/arm-smmu-v3: Remove unnecessary oom message

 Documentation/devicetree/bindings/iommu/iommu.txt |  18 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi             |   2 +-
 drivers/acpi/arm64/iort.c                         |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c       | 222 ++++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h       |  48 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c        |  43 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c             |  38 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h             |   1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c           |  13 +-
 10 files changed, 409 insertions(+), 39 deletions(-)
