Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BB415D44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhIWMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:00:27 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47518 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240710AbhIWMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:00:24 -0400
X-UUID: ac0a49c064464231a573907a1adefbbf-20210923
X-UUID: ac0a49c064464231a573907a1adefbbf-20210923
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1934805908; Thu, 23 Sep 2021 19:58:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Sep 2021 19:58:49 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Sep 2021 19:58:48 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <yen-chang.chen@mediatek.com>
Subject: [PATCH v3 00/33] MT8195 IOMMU SUPPORT
Date:   Thu, 23 Sep 2021 19:58:07 +0800
Message-ID: <20210923115840.17813-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds MT8195 iommu support.

MT8195 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW is
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
directly. It use a independent pgtable.

Also, mt8195 IOMMU bank supports. Normally the IOMMU register size only
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
special bank registers, like pgtable base register, tlb operation registers,
the fault status registers.
 
In mt8195, we enable this bank feature for infra iommu, We put PCIe in bank0
and USB in bank4. they have independent pgtable.

patch[1..23]:  support mt8195 iommu. 
patch[24..33]: support bank feature.

TODO: there is another APU_IOMMU in mt8195, this should depend on APU patches.
thus, we need add that feature after that.

Change note:
v3: 1) base on v5.15-rc1
    2) Adjust devlink with smi-common, not use the property(sub-sommon).
    3) Adjust tlb_flush_all flow,
       a) Fix tlb_flush_all only is supported in bank0.
       b) add tlb-flush-all in the resume callback.
       c) remove the pm status checking in tlb-flush-all.
       The reason are showed in the commit message.
    4) Allow IOMMU_DOMAIN_UNMANAGED since PCIe VFIO use that.
    5) Fix a clk warning and a null abort when unbind the iommu driver.

v2: https://lore.kernel.org/linux-mediatek/20210813065324.29220-1-yong.wu@mediatek.com/
    1) Base on v5.14-rc1.
    2) Fix build fail for arm32.
    3) Fix dt-binding issue from Rob.
    4) Fix the bank issue when tlb flush. v1 always use bank->base.
    5) adjust devlink with smi-common since the node may be smi-sub-common.
    6) other changes: like reword some commit message(removing many
       "This patch..."); seperate serveral patches.

v1: https://lore.kernel.org/linux-mediatek/20210630023504.18177-1-yong.wu@mediatek.com/
    Base on v5.13-rc1

Yong Wu (33):
  dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
  dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
  iommu/mediatek: Fix 2 HW sharing pgtable issue
  iommu/mediatek: Remove clk_disable in mtk_iommu_remove
  iommu/mediatek: Adapt sharing and non-sharing pgtable case
  iommu/mediatek: Add 12G~16G support for multi domains
  iommu/mediatek: Add a flag DCM_DISABLE
  iommu/mediatek: Add a flag NON_STD_AXI
  iommu/mediatek: Remove for_each_m4u in tlb_sync_all
  iommu/mediatek: Add tlb_lock in tlb_flush_all
  iommu/mediatek: Remove the granule in the tlb flush
  iommu/mediatek: Always tlb_flush_all when each PM resume
  iommu/mediatek: Remove the power status checking in tlb flush all
  iommu/mediatek: Always enable output PA over 32bits in isr
  iommu/mediatek: Add SUB_COMMON_3BITS flag
  iommu/mediatek: Add IOMMU_TYPE flag
  iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
  iommu/mediatek: Adjust device link when it is sub-common
  iommu/mediatek: Add list_del in mtk_iommu_remove
  iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
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
  iommu/mediatek: Initialise/Remove for multi bank dev
  iommu/mediatek: Backup/restore regsiters for multi banks
  iommu/mediatek: mt8195: Enable multi banks for infra iommu

 .../bindings/iommu/mediatek,iommu.yaml        |  20 +-
 drivers/iommu/mtk_iommu.c                     | 799 ++++++++++++------
 drivers/iommu/mtk_iommu.h                     |  56 +-
 .../dt-bindings/memory/mt8195-memory-port.h   | 408 +++++++++
 include/dt-bindings/memory/mtk-memory-port.h  |   2 +
 5 files changed, 1014 insertions(+), 271 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h

-- 
2.18.0


