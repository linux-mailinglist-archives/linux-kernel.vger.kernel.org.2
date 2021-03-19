Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27A7341B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCSLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCSLPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:15:11 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E30C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:15:11 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 576282DA; Fri, 19 Mar 2021 12:15:07 +0100 (CET)
Date:   Fri, 19 Mar 2021 12:15:05 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.12-rc3
Message-ID: <YFSHuWNVKFOTHJWt@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc3

for you to fetch changes up to 8dfd0fa6ecdc5e2099a57d485b7ce237abc6c7a0:

  iommu/tegra-smmu: Make tegra_smmu_probe_device() to handle all IOMMU phandles (2021-03-18 11:31:12 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.12-rc3

Including:

	- Three AMD IOMMU patches to fix a boot crash on AMD Stoney
	  systems and every other AMD IOMMU system booted with
	  'amd_iommu=off'. This is a v5.11 regression.

	- A Fix for the Tegra IOMMU driver to make sure it detects all
	  IOMMUs

----------------------------------------------------------------
Dmitry Osipenko (1):
      iommu/tegra-smmu: Make tegra_smmu_probe_device() to handle all IOMMU phandles

Joerg Roedel (3):
      iommu/amd: Move Stoney Ridge check to detect_ivrs()
      iommu/amd: Don't call early_amd_iommu_init() when AMD IOMMU is disabled
      iommu/amd: Keep track of amd_iommu_irq_remap state

 drivers/iommu/amd/init.c   | 36 ++++++++++++++++++++----------------
 drivers/iommu/tegra-smmu.c |  7 +++----
 2 files changed, 23 insertions(+), 20 deletions(-)

Please pull.

Thanks,

	Joerg
