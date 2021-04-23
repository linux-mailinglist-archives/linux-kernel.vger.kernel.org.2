Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B556D368FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbhDWJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:52:35 -0400
Received: from foss.arm.com ([217.140.110.172]:60682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhDWJwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:52:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F65C11D4;
        Fri, 23 Apr 2021 02:51:58 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E1DD3F774;
        Fri, 23 Apr 2021 02:51:54 -0700 (PDT)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
Subject: [PATCH RFC v1 00/11] iommu/virtio: vSVA support with Arm
Date:   Fri, 23 Apr 2021 15:21:36 +0530
Message-Id: <20210423095147.27922-1-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims at enabling vSVA (Shared virtual addressing)
support in virtio-iommu driver for devices assigned to the guest
kernel using pci-passthrough technique (also called as Device
assignment). The changes are proposed to make virtio-iommu driver
become intelligent to support Shared virtual addressing.

The virtio-iommu device serves as the para-virtualized iommu for
IO devices running in the guest. This work is done for PCI devices
that are able to generate Address Translation Service (ATS) and
Page Request Interface (PRI) requests.

With vSVA support now devices running in guest can start using process
address space (Guest virtual address, GVA) for DMA. The below diagram
shows a simple system layout using iommus in guest and host.

                 ------------------
		 |  virtio-iommu  |
		 |    driver      |
		 |  (front-end)   |
		 |________________|
                                               Guest kernel
          --------------------------------------------------

                 ------------------
		 |  virtio-iommu  |
		 |    driver      |
		 |  (back-end)    |
		 |________________|
                                                    kvmtool
          --------------------------------------------------

                  -----------------
		 |  arm-smmu-v3   |
		 |    driver      |
		 |________________|
                                                Host kernel
          --------------------------------------------------

                  -----------------
		 |  arm-smmu-v3   |
		 |    hardware    |
		 |________________|
                                                   Hardware
          --------------------------------------------------

The flow of various messages/requests looks like below:
a) The stage-1 page tables are prepared by virtio-iommu driver using
   CPU page table info. This page table data then flow from guest kernel
   to host kernel using VFIO uapi changes [1]. The stage-1 page tables
   are then programmed into the hardware by the arm-smmu-v3 driver.
b) The device can then start initiating DMA transactions using ATS
   request.
c) When using GVA, SMMU encounters a translation fault and responds
   to the device with ATS success - translation failure.
d) The device can then send a PRI request that eventually populates
   the PRIQ of arm-smmu-v3.
e) The page fault info is captured from PRIQ, and sent to the guest
   kernel using VFIO dma fault region as added in [1].
f) The page fault is received on the virt-queue by virtio-iommu driver
   and is then passed to io-page-fault handler. The io page fault
   handler talks to mm fault handling engine in guest kernel and gets
   the CPU page tables updated.
g) Virtio-iommu driver then sends page_response backend virtio-iommu
   in vmm. From there this page_response info is passed to host kernel.
h) The arm-smmu-v3 driver running in the host will then use this page
   repsonse info and send a response to the requesting device.

The series use nested page table support [2] as the base to build vSVA
solution.

The changes are inspired from the SVA support in arm-smmu-v3 and are
making use of io-page-fault changes added by Jean Philippe [3].

The changes include:
- The mmu notifier structure, and allocation and freeing up of shared
  context descriptors are moved to arm-smmu-v3-cd-lib library driver,
  and changes have been made to arm-smmu-v3-sva driver to use these
  shared cd alloc/free helpers.
- In virtio-iommu driver:
  - changes have been added to add various iommu_ops to enable/disable
    feature, and to perform sva_bind/unbind. 
  - A iopf queue has been added that accepts incoming page faults, and
    work with mm fault handler to get the page resident.
  - Incoming page fault information from vmm is parsed using a work-queue
    and passed to the iopf fault handler.
  - A new virt-queue request has been added to send page response back
    to the vmm back-end driver. The page response is populated from the
    mm fault handler response, and includes information on Page Request
    pasid, group-id, and response code, etc.

[1] https://lore.kernel.org/linux-iommu/20210411114659.15051-1-eric.auger@redhat.com/
    https://lore.kernel.org/linux-iommu/20210411111228.14386-1-eric.auger@redhat.com/
[2] https://lore.kernel.org/linux-iommu/20210115121342.15093-1-vivek.gautam@arm.com/
[3] https://www.spinics.net/lists/arm-kernel/msg886518.html

Vivek Gautam (11):
  uapi/virtio-iommu: Add page request grp-id and flags information
  iommu/virtio: Maintain a list of endpoints served by viommu_dev
  iommu/virtio: Handle incoming page faults
  iommu/virtio: Add a io page fault queue
  iommu/virtio: Add SVA feature and related enable/disable callbacks
  iommu/pasid-table: Add pasid table ops for shared context management
  iommu/arm-smmu-v3: Move shared context descriptor code to cd-lib
  iommu/arm-smmu-v3: Implement shared context alloc and free ops
  iommu/virtio: Implement sva bind/unbind calls
  uapi/virtio-iommu: Add a new request type to send page response
  iommu/virtio: Add support to send page response

 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 165 ++++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 230 +------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 -
 drivers/iommu/iommu-pasid-table.h             |  43 ++
 drivers/iommu/virtio-iommu.c                  | 634 +++++++++++++++++-
 include/uapi/linux/virtio_iommu.h             |  35 +
 7 files changed, 904 insertions(+), 206 deletions(-)

-- 
2.17.1

