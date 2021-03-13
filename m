Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459E8339FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 19:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhCMSBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 13:01:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48749 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234189AbhCMSBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 13:01:06 -0500
X-UUID: 203ad42489384cc2b6a98da80798dbe9-20210314
X-UUID: 203ad42489384cc2b6a98da80798dbe9-20210314
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1800377787; Sun, 14 Mar 2021 02:01:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 14 Mar 2021 02:00:59 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 14 Mar 2021 02:00:58 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v7 0/4] Add SPMI support for Mediatek MT6873/8192 SoC IC
Date:   Sun, 14 Mar 2021 02:00:49 +0800
Message-ID: <1615658453-3989-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for new SoC MT6873/8192 to the spmi driver.
This series is based on Weiyi's patches[1].

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1608642587-15634-7-git-send-email-weiyi.lu@mediatek.com/

changes since v6:
- rebase to Linux 5.12.
- refnie mtk-pmif spmi driver for batter code.

Hsin-Hsiung Wang (4):
  dt-bindings: spmi: modify the constraint 'maxItems' to 'minItems'
  dt-bindings: spmi: document binding for the Mediatek SPMI controller
  spmi: mediatek: Add support for MT6873/8192
  arm64: dts: mt8192: add spmi node

 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      |  74 +++
 .../devicetree/bindings/spmi/spmi.yaml        |   2 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  17 +
 drivers/spmi/Kconfig                          |  10 +
 drivers/spmi/Makefile                         |   2 +
 drivers/spmi/spmi-mtk-pmif.c                  | 465 ++++++++++++++++++
 6 files changed, 569 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
 create mode 100644 drivers/spmi/spmi-mtk-pmif.c

-- 
2.18.0

