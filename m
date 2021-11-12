Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068744E155
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 06:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhKLFLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 00:11:14 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56360 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229910AbhKLFLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 00:11:10 -0500
X-UUID: 749835dfaf814856a678bda5592acc0a-20211112
X-UUID: 749835dfaf814856a678bda5592acc0a-20211112
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 933969298; Fri, 12 Nov 2021 13:08:14 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 12 Nov 2021 13:08:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Nov
 2021 13:08:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 13:08:12 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <bgolaszewski@baylibre.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v5 0/2] Add basic SoC support for mediatek mt8195
Date:   Fri, 12 Nov 2021 13:08:09 +0800
Message-ID: <20211112050811.21202-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic SoC support for Mediatek's SoC MT8195.

clock nodes depends on [1][2].
phy nodes are reviewed at v2 thread.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01404648df2055ba79f85858528b723d678bd2a8
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34d3ed3b9a0022409cf07c810e68b1ab625ab6fd

---
Changes in v5:
  - enable basic nodes in mt8195-evb.dts
  - remove dedicated clock nodes
  - add mmc2 node
  - fix interrupt number of pinctrl node
  - update clock nodes to apply internal fixes
  - add dt-bindings for perficfg node

v4 thread:
https://lore.kernel.org/all/20210922093303.23720-2-seiya.wang@mediatek.com/
v3 thread:
https://lore.kernel.org/all/20210601075350.31515-2-seiya.wang@mediatek.com/
v2 thread:
https://lore.kernel.org/all/20210319023427.16711-10-seiya.wang@mediatek.com/
v1 thread:
https://lore.kernel.org/all/20210316111443.3332-11-seiya.wang@mediatek.com/
---

Tinghan Shen (2):
  dt-bindings: arm: mediatek: add mt8195 pericfg compatible
  arm64: dts: Add mediatek SoC mt8195 and evaluation board

 .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  210 ++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1044 +++++++++++++++++
 4 files changed, 1256 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi

-- 
2.18.0

