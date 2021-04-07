Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97FA3561DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbhDGD23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:28:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60598 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229736AbhDGD21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:28:27 -0400
X-UUID: 8f237fc3a8ff491eb4a8b716d8886274-20210407
X-UUID: 8f237fc3a8ff491eb4a8b716d8886274-20210407
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 120020346; Wed, 07 Apr 2021 11:28:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 11:28:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 11:28:14 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 0/8] Add Support for MediaTek MT8192 APU Power
Date:   Wed, 7 Apr 2021 11:27:58 +0800
Message-ID: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
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

This series is based on MT8192 clock[1] and PMIC[2] patches.
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=454523
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=458733

Flora Fu (8):
  dt-bindings: clock: Add MT8192 APU clock bindings
  clk: mediatek: mt8192: Add APU clocks support
  dt-bindings: apu: Add MT8192 APU power domain
  dt-bindings: arm: mediatek: Add new document bindings for APU
  dt-bindings: soc: mediatek: apusys: Add new document for APU power
    domain
  soc: mediatek: apu: Add apusys and add apu power domain driver
  arm64: dts: mt8192: Add APU node
  arm64: dts: mt8192: Add APU power domain node

 .../arm/mediatek/mediatek,apusys.yaml         |  56 ++
 .../soc/mediatek/mediatek,apu-pm.yaml         | 146 +++++
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts   |   7 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  46 ++
 drivers/clk/mediatek/clk-mt8192.c             |  91 +++
 drivers/soc/mediatek/Kconfig                  |  10 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/apusys/Makefile          |   2 +
 drivers/soc/mediatek/apusys/mtk-apu-pm.c      | 613 ++++++++++++++++++
 include/dt-bindings/clock/mt8192-clk.h        |  14 +-
 include/dt-bindings/power/mt8192-apu-power.h  |  11 +
 11 files changed, 995 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
 create mode 100644 drivers/soc/mediatek/apusys/Makefile
 create mode 100644 drivers/soc/mediatek/apusys/mtk-apu-pm.c
 create mode 100644 include/dt-bindings/power/mt8192-apu-power.h

-- 
2.18.0

