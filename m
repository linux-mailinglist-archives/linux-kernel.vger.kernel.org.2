Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E03B7B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 04:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhF3CiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:38:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33782 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231938AbhF3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:38:08 -0400
X-UUID: 5911c5eb51dc4d4887087db639e97605-20210630
X-UUID: 5911c5eb51dc4d4887087db639e97605-20210630
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1746401114; Wed, 30 Jun 2021 10:35:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:35:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:35:12 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH 00/24] MT8195 IOMMU SUPPORT
Date:   Wed, 30 Jun 2021 10:34:40 +0800
Message-ID: <20210630023504.18177-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add mt8195 iommu supports.

mt8195 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW is
for infra-master, like PCIe/USB.

About the 2 MM IOMMU HW, something like this:

        IOMMU(VDO)          IOMMU(VPP)
           |                   |
      SMI_COMMON(VDO)      SMI_COMMON(VPP)
      ---------------     ----------------
      |      |   ...      |      |     ...
    larb0 larb2  ...    larb1 larb3    ...

these two MM IOMMU HW share a pgtable.

About the INFRA IOMMU, it don't have larbs, the master connects the iommu
directly. It use a dependent pgtable.

Also, mt8195 IOMMU bank supports..Normally the IOMMU register size only
is 0x1000. In this IOMMU HW, the register size is 5 * 0x1000. each 0x1000
is a bank. the banks' register look like this:
     ----------------------------------------
     |bank0  | bank1 | bank2 | bank3 | bank4|
     ----------------------------------------
     |global |
     |control|         null
     |regs   |
     -----------------------------------------
     |bank   |bank   |bank   |bank   |bank   |
     |regs   |regs   |regs   |regs   |regs   |
     |       |       |       |       |       |
     -----------------------------------------
All the banks share some global control registers, and each bank have its
special bank registers, like pgtable base registser, tlb operation registers,
the fault status registers.
 
In mt8195, we enable this bank feature for infra iommu, We put PCIe in bank0
and USB in bank4. they have independent pgtable.

patch[1..15]:  support mt8195 iommu. 
patch[16..24]: support bank feature.

base on v5.13-rc1.

todo: there is another APU_IOMMU in mt8195, this should depend on APU patches.
thus, we need add that feature after that.

---
Yong Wu (24):
  dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
  dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
  iommu/mediatek: Fix 2 HW sharing pgtable issue
  iommu/mediatek: Adapt sharing and non-sharing pgtable case
  iommu/mediatek: Add 12G~16G support for mult domain
  iommu/mediatek: Add a flag DCM_DISABLE
  iommu/mediatek: Add flag NON_STD_AXI
  iommu/mediatek: Remove for_each_m4u in tlb_sync_all
  iommu/mediatek: Always pm_runtime_get while tlb flush
  iommu/mediatek: Always enable output PA over 32bits
  iommu/mediatek: Add SUB_COMMON_3BITS flag
  iommu/mediatek: Add IOMMU_TYPE flag
  iommu/mediatek: Add infra iommu support
  iommu/mediatek: Add PCIe support
  iommu/mediatek: Add mt8195 support
  iommu/mediatek: Only adjust code about register base
  iommu/mediatek: Just move code position in hw_init
  iommu/mediatek: Add mtk_iommu_bank_data structure
  iommu/mediatek: Initialise bank HW for each a bank
  iommu/mediatek: Add bank_nr and bank_enable
  iommu/mediatek: Change the domid to iova_region_id
  iommu/mediatek: Get the proper bankid for multi banks
  iommu/mediatek: Add multi bank support
  iommu/mediatek: mt8195: Enable multi-bank for infra iommu

 .../bindings/iommu/mediatek,iommu.yaml        |  21 +-
 drivers/iommu/mtk_iommu.c                     | 760 ++++++++++++------
 drivers/iommu/mtk_iommu.h                     |  33 +-
 .../dt-bindings/memory/mt8195-memory-port.h   | 408 ++++++++++
 include/dt-bindings/memory/mtk-memory-port.h  |   2 +
 5 files changed, 961 insertions(+), 263 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h

-- 
2.18.0


