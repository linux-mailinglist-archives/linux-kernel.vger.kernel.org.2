Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D950438316
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhJWKQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 06:16:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48890 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230126AbhJWKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 06:16:03 -0400
X-UUID: 36a512ea59e84be394440c4a73b7eb8d-20211023
X-UUID: 36a512ea59e84be394440c4a73b7eb8d-20211023
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2012393897; Sat, 23 Oct 2021 18:13:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Oct 2021 18:13:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Oct 2021 18:13:38 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 0/7] Add Support for MediaTek MT8192 APU Power
Date:   Sat, 23 Oct 2021 18:13:27 +0800
Message-ID: <20211023101334.27686-1-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek AI Processing Unit (APU) is a proprietary hardware
in the SoC to support AI operations.
The series is to create apusys in the SoC folder for developing
the related drivers. Add the apu clocks, basic apu nodes and the
power domain to provide the power controller of APU subsystem.

This series is based on MT8192 clock[1] and MT8193/PMIC[3][4] patches.
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=521655
[2] https://patchwork.kernel.org/patch/12134935
[3] https://patchwork.kernel.org/patch/12140237

Change notes:
v2->v3:
  1) Rebase to 5.15-rc1
  2) remove the apu-mbox registers from syscon.
  3) update mtk-apu-pm to fix clock flow and move power status bit into
     platform data to support different hardware settings.

v1->v2:
  1) update expression "s/_/-/" in dt-bindings documents.
  2) drop apu power domain header file for mt8192.

v1: https://patchwork.kernel.org/project/linux-mediatek/list/?series=461999

Flora Fu (7):
  dt-bindings: clock: Add MT8192 APU clock bindings
  clk: mediatek: mt8192: Add APU clocks support
  dt-bindings: arm: mediatek: Add new document bindings for APU
  dt-bindings: soc: mediatek: apusys: Add new document for APU power
    domain
  soc: mediatek: apu: Add apusys and add apu power domain driver
  arm64: dts: mt8192: Add APU node
  arm64: dts: mt8192: Add APU power domain node

 .../arm/mediatek/mediatek,apusys.yaml         |  49 ++
 .../soc/mediatek/mediatek,apu-pm.yaml         | 144 ++++
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts   |   7 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  39 ++
 drivers/clk/mediatek/clk-mt8192.c             |  91 +++
 drivers/soc/mediatek/Kconfig                  |  19 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/apusys/Makefile          |   2 +
 drivers/soc/mediatek/apusys/mtk-apu-pm.c      | 633 ++++++++++++++++++
 include/dt-bindings/clock/mt8192-clk.h        |  14 +-
 10 files changed, 997 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
 create mode 100644 drivers/soc/mediatek/apusys/Makefile
 create mode 100644 drivers/soc/mediatek/apusys/mtk-apu-pm.c

-- 
2.18.0

