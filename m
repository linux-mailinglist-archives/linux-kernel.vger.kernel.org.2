Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A323121F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 07:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBGGPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 01:15:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51217 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229445AbhBGGPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 01:15:06 -0500
X-UUID: b9305d28ced74d0b846275b81c748acd-20210207
X-UUID: b9305d28ced74d0b846275b81c748acd-20210207
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 55937113; Sun, 07 Feb 2021 14:14:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 7 Feb 2021 14:14:18 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 14:14:19 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 0/3] Add support for MT6315 regulator
Date:   Sun, 7 Feb 2021 14:14:14 +0800
Message-ID: <1612678457-11548-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for MediaTek PMIC MT6315 regulator driver,
which adds MT6315 related buck voltage data to the driver.
This series is based on below patch[1].

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=429385

changes since v3:
- fix the error of binding document.
- refine the mt6315 regulator for better code quality.
- update mt6315 regulator node in the mt8192-evb.dts.

Hsin-Hsiung Wang (3):
  dt-bindings: regulator: document binding for MT6315 regulator
  regulator: mt6315: Add support for MT6315 regulator
  arm64: dts: mt8192: add mt6315 regulator nodes

 .../bindings/regulator/mt6315-regulator.yaml  |  69 ++++
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts   |  46 +++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6315-regulator.c          | 299 ++++++++++++++++++
 include/linux/regulator/mt6315-regulator.h    |  44 +++
 6 files changed, 469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
 create mode 100644 drivers/regulator/mt6315-regulator.c
 create mode 100644 include/linux/regulator/mt6315-regulator.h

-- 
2.18.0

