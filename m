Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A800E3BAAFE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 05:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhGDDJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 23:09:44 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39830 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229639AbhGDDJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 23:09:40 -0400
X-UUID: e7b49e11c9e34494abd7e812c63c6ad5-20210704
X-UUID: e7b49e11c9e34494abd7e812c63c6ad5-20210704
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1189049; Sun, 04 Jul 2021 11:07:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 4 Jul 2021 11:07:01 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 4 Jul 2021 11:07:01 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v9 0/5] Add SPMI support for Mediatek SoC IC
Date:   Sun, 4 Jul 2021 11:06:53 +0800
Message-ID: <1625368018-17505-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for new SoC MT6873/MT8192/MT8195 to the spmi driver.
This series is based on Chun-Jie's patches[1][2].

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=509159
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=501127

changes since v8:
- Add MT8195 spmi support.

Henry Chen (1):
  spmi: mediatek: Add support for MT8195

Hsin-Hsiung Wang (4):
  dt-bindings: spmi: modify the constraint 'maxItems' to 'minItems'
  dt-bindings: spmi: document binding for the Mediatek SPMI controller
  spmi: mediatek: Add support for MT6873/8192
  arm64: dts: mt8192: add spmi node

 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      |  76 +++
 .../devicetree/bindings/spmi/spmi.yaml        |   2 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  17 +
 drivers/spmi/Kconfig                          |  10 +
 drivers/spmi/Makefile                         |   2 +
 drivers/spmi/spmi-mtk-pmif.c                  | 555 ++++++++++++++++++
 6 files changed, 661 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
 create mode 100644 drivers/spmi/spmi-mtk-pmif.c


base-commit: 4b820e167bf6f410ace479d8df5b15a574000e75
prerequisite-patch-id: 8d0ea71c97ffaea629a73e7e7606baa0947cd4ad
prerequisite-patch-id: 15f52bb664f0f0436627d056a53afefb0b99f67a
prerequisite-patch-id: 479b44dfdc6d7b367c0d441d8635d2dc02466057
prerequisite-patch-id: 5df1858972e343d3750cdda1063655fc232eb831
prerequisite-patch-id: 7e63a29430f65c2a0d56d7353df884645d70ed8c
prerequisite-patch-id: 2a6200e8a05329d51aaa4fd63aacfbba66d16177
prerequisite-patch-id: 604d2702c4217b77de3dc305ff08f630ba38fdb4
prerequisite-patch-id: d3ece2688dbd45eee248a8c6ba3206c0c673c904
prerequisite-patch-id: 1bebe1cd9b267c974cae50c3df8c0f8f4f0b0b3d
prerequisite-patch-id: 3b34fe85667da5287bde9fd2378359be4a126266
prerequisite-patch-id: 5d3d139212ab304739b75f7638251703b95948d5
prerequisite-patch-id: 621291b21be177a63eaf6769aa6d2ee8ddb2ea2b
prerequisite-patch-id: 024f786586b409420782d24218b15f05f6476667
prerequisite-patch-id: 946aae93303bde26226289dc389c94de96a9dacd
prerequisite-patch-id: b3ddf6f2079c3c269bd24091243030a971c43cbc
prerequisite-patch-id: 5c0e0308aa8eb06ca6df6f5467bc925f2cc106ad
prerequisite-patch-id: d4e481acd8b970f08d3e4da9c8fc0ad6e1fff551
prerequisite-patch-id: 99db7309fbe1b9f73a07e25d5174db8976c77a2c
prerequisite-patch-id: cffbc99e9e60f6db43cf7879f17e05c5b041d312
prerequisite-patch-id: cd19be7b7f361644843ff8111f120e3da3330ab5
prerequisite-patch-id: 4f5900b98a0c7cbe62694f2477a6cb410187714b
-- 
2.18.0

