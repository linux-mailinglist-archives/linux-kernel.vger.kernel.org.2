Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BE5319CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBLLAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:00:03 -0500
Received: from foss.arm.com ([217.140.110.172]:35050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhBLK74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:59:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3658113E;
        Fri, 12 Feb 2021 02:59:10 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9843B3F719;
        Fri, 12 Feb 2021 02:59:06 -0800 (PST)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, Lorenzo.Pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
Subject: [PATCH 0/2] Domain nesting info for arm-smmu
Date:   Fri, 12 Feb 2021 16:28:57 +0530
Message-Id: <20210212105859.8445-1-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These couple of patches are adding nesting information for arm
and are based on the domain nesting info patches by Yi [1,2,3].

Based on the discussion in the thread [4], sending these out as
I have been using in my tree [5] for nested translation based
on virtio-iommu on Arm reference platforms.

Thanks & regards
Vivek

[1] https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu@intel.com/
[2] https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu@intel.com/
[3] https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu@intel.com/
[4] https://lore.kernel.org/kvm/306e7dd2-9eb2-0ca3-6a93-7c9aa0821ce9@arm.com/
[5] https://github.com/vivek-arm/linux/tree/5.11-rc3-nested-pgtbl-arm-smmuv3-virtio-iommu

Vivek Gautam (2):
  iommu: Report domain nesting info for arm-smmu-v3
  iommu: arm-smmu-v3: Report domain nesting info reuqired for stage1

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++--
 include/uapi/linux/iommu.h                  | 31 +++++++++++++++++----
 2 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.17.1

