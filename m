Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A30361D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbhDPJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:33:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39514 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240321AbhDPJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:32:55 -0400
X-UUID: 97df4e19f3b94247aeeeefd416012ef4-20210416
X-UUID: 97df4e19f3b94247aeeeefd416012ef4-20210416
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <pk.chi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1952144195; Fri, 16 Apr 2021 17:32:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 17:32:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 17:32:19 +0800
From:   Po-Kai Chi <pk.chi@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>
Subject: [PATCH v2] memory: mediatek: add DRAM controller driver
Date:   Fri, 16 Apr 2021 17:32:14 +0800
Message-ID: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A1A89FB72589495136EA6DE31C9FE8535C9EEF142A74311CD22CAF680AD76D292000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series introduces the MediaTek DRAM controller driver (DRAMC)
on MT6779 SoC, and enables to be built as a module by default for the
ARM64 builds.

MediaTek DRAMC driver provides cross-platform features as below:
  - API provided to other kernel modules for querying DRAM type,
    rank count, rank size, channel count and mode register settings.
  - Sysfs interface used to pass DRAM mode register settings and current
    DRAM data rate to user-space for MediaTek ecosystem.

The API user includes MediaTek External Memory Interface (EMI) and
DVFS Resource Control (DVFSRC), which will be sent to mainline later.

Changes since v1:
- add prefix to vendor properties in device tree, dt-binding and drivers
- fix dt-binding check fail

Po-Kai Chi (4):
  dt-bindings: memory: Add binding for MediaTek DRAM Controller
  memory: mediatek: add DRAM controller driver
  arm64: dts: add DRAMC node for MT6779
  arm64: defconfig: Enable MediaTek DRAMC common driver

 .../memory-controllers/mediatek,dramc.yaml    | 162 ++++
 arch/arm64/boot/dts/mediatek/mt6779-evb.dts   |   9 +
 arch/arm64/boot/dts/mediatek/mt6779.dtsi      |  18 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/memory/Kconfig                        |   1 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/mediatek/Kconfig               |   9 +
 drivers/memory/mediatek/Makefile              |   3 +
 drivers/memory/mediatek/mtk-dramc.c           | 711 ++++++++++++++++++
 include/memory/mediatek/dramc.h               |  18 +
 10 files changed, 933 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
 create mode 100644 drivers/memory/mediatek/Kconfig
 create mode 100644 drivers/memory/mediatek/Makefile
 create mode 100644 drivers/memory/mediatek/mtk-dramc.c
 create mode 100644 include/memory/mediatek/dramc.h

