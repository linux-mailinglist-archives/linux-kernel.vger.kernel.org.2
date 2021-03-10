Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA763335EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhCJGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:37:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33515 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232203AbhCJGhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:37:06 -0500
X-UUID: b473a9ab44014da2be911e72d17a1802-20210310
X-UUID: b473a9ab44014da2be911e72d17a1802-20210310
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1396320664; Wed, 10 Mar 2021 14:37:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Mar 2021 14:37:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Mar 2021 14:37:00 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wendell Lin <Wendell.Lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin <Macpaul.Lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Evan Green <evgreen@chromium.org>, <Yong.Wu@mediatek.com>,
        Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH v10 0/4] Add basic SoC support for mt6765
Date:   Wed, 10 Mar 2021 14:36:54 +0800
Message-ID: <1615358218-6540-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1615291538-9799-1-git-send-email-macpaul.lin@mediatek.com>
References: <1615291538-9799-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 434342E2F5CF57348F9BEE9B788608533B4CB2C5C4A939C944A86D8F12F56F4D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic SoC support for Mediatek's new 8-core SoC,
MT6765, which is mainly for smartphone application.

Changes in V10:
   [v10,1/4] dt-bindings: mediatek: Add smi dts binding for Mediatek
            MT6765 SoC
     - No Change.
   [v10,2/4] soc: mediatek: add MT6765 scpsys and subdomain support
     - No Change.
   [v10,3/4] arm64: dts: mediatek: add mt6765 support
     - Remove interrupt in mmsys node.
     - Replace smi_common@14002000 to smi@14002000
   [v10,4/4] arm64: defconfig: add CONFIG_COMMON_CLK_MT6765_XXX clocks
     - No Change.

Changes in V9:
1. Origin V8 patchset:
   https://patchwork.kernel.org/cover/11396015/
   [v9,1/4] dt-bindings: mediatek: Add smi dts binding for Mediatek
            MT6765 SoC
     - No Change.
   [v9,2/4] soc: mediatek: add MT6765 scpsys and subdomain support
     - Fix build error based on 5.11-rc1 because
       - bp_table has been deprecated.
       - basic_clk_id has been renamed to clk_id.
       - correct the number order in marco GENMASK().
   Note: mediatek is working on porting mt6765's scpsys to driver
         "mtk-pm-domains", however we think supporting for "mtk-scpsys" is
         required before new glue is available.
   [v9,3/4] arm64: dts: mediatek: add mt6765 support
     - No Change.
   [v9,4/4] arm64: defconfig: add CONFIG_COMMON_CLK_MT6765_XXX clocks
     - No Change.

Changes in V8:
1. Origin V7 patchset:
   https://patchwork.kernel.org/cover/11370105/
   Split origin V7 patchset into 2 patchset,
   keep remain patches #2, #5, #6, and #7 in the same order as this
   V8 patchset.
   [v7,2/7] dt-bindings: mediatek: Add smi dts binding for Mediatek
            MT6765 SoC
   [v7,5/7] soc: mediatek: add MT6765 scpsys and subdomain support
   [v7,6/7] arm64: dts: mediatek: add mt6765 support
   [v7,7/7] arm64: defconfig: add CONFIG_COMMON_CLK_MT6765_XXX clocks

Changes in V7:
1. Adapt V6's patchset to latest kernel tree 5.5-rc1.
   Origin V6 patchset:
   https://patchwork.kernel.org/cover/11041963/
2. Correct 2 clock-controller type in documentation:
   mipi0 and venc_gcon.
   [v7 1/7] dt-bindings: clock: mediatek: document clk bindings
3. Remove V6's patch 03 because it has been taken into 5.5-next-soc
   [v6, 03/08] dt-bindings: mediatek: add MT6765 power dt-bindings
3. Update Reviewed-by: Rob Herring <robh@kernel.org> for
   [v6, 04/08] clk: mediatek: add mt6765 clock IDs
   --> [v7, 03/07] clk: mediatek: add mt6765 clock IDs
4. Update SPDX tag for
   [v6, 05/08] clk: mediatek: Add MT6765 clock support
   --> [v7, 04/07] clk: mediatek: Add MT6765 clock support

Changes in V6:
1. Adapt V5's patchset to latest kernel tree.
   Origin V5 patchset.
   https://lore.kernel.org/patchwork/cover/963612/
2. Due to clk's common code has been submit by other platform,
   this patch set will have dependencies with the following patchsets
   as the following orders.
   2.a. [v8,00/21] MT8183 IOMMU SUPPORT
        https://patchwork.kernel.org/cover/11023585/
   2.b. [v11,0/6] Add basic node support for Mediatek MT8183 SoC
        https://patchwork.kernel.org/cover/10962385/
   2.c. [v6,00/14] Mediatek MT8183 scpsys support
        https://patchwork.kernel.org/cover/11005751/
3. Correct power related patches into dt-binding patches.
4. Re-order V5's 4/11, 6/11, and 7/11 due clk common code change
   and make dependencies in order.
5. Update some commit message in clk related patches.

Changes in V5:
1. add clk support

Changes in V4:
1. add gic's settings in reg properties
2. remove some patches about dt-bindings since GKH already took them

Changes in V3:
1. split dt-binding document patchs
2. fix mt6765.dtsi warnings with W=12
3. remove uncessary PPI affinity for timer
4. add gicc base for gic dt node

Changes in V2:
1. fix clk properties in uart dts node
2. fix typo in submit title
3. add simple-bus in mt6765.dtsi
4. use correct SPDX license format

Mars Cheng (3):
  dt-bindings: mediatek: Add smi dts binding for Mediatek MT6765 SoC
  soc: mediatek: add MT6765 scpsys and subdomain support
  arm64: dts: mediatek: add mt6765 support

Owen Chen (1):
  arm64: defconfig: add CONFIG_COMMON_CLK_MT6765_XXX clocks

 .../mediatek,smi-common.yaml                  |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt6765-evb.dts   |  33 +++
 arch/arm64/boot/dts/mediatek/mt6765.dtsi      | 252 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   6 +
 drivers/soc/mediatek/mtk-scpsys.c             |  91 +++++++
 6 files changed, 384 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi

-- 
2.18.0

