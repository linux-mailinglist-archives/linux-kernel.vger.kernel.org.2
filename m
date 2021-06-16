Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8713AA6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbhFPWvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:51:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51548 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233244AbhFPWvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:51:14 -0400
X-UUID: b5adb05f4a064ee69a8685b2349c4cc8-20210617
X-UUID: b5adb05f4a064ee69a8685b2349c4cc8-20210617
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 285041086; Thu, 17 Jun 2021 06:49:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 06:49:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 06:49:02 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 00/22] Mediatek MT8195 clock support
Date:   Thu, 17 Jun 2021 06:47:21 +0800
Message-ID: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch series is based on 5.13-rc3 and depends on [1]
- for makefile dependence (patches 7 ~ 19 in [1])
- for common driver dependence (patches 3 ~ 6 in [1])

[1] https://patchwork.kernel.org/project/linux-mediatek/cover/20210616003643.28648-1-chun-jie.chen@mediatek.com/

Chun-Jie Chen (22):
  dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock
  clk: mediatek: Add dt-bindings of MT8195 clocks
  clk: mediatek: Fix corner case of tuner_en_reg
  clk: mediatek: Add MT8195 basic clocks support
  clk: mediatek: Add MT8195 audio clock support
  clk: mediatek: Add MT8195 audio src clock support
  clk: mediatek: Add MT8195 camsys clock support
  clk: mediatek: Add MT8195 ccusys clock support
  clk: mediatek: Add MT8195 imgsys clock support
  clk: mediatek: Add MT8195 ipesys clock support
  clk: mediatek: Add MT8195 mfgcfg clock support
  clk: mediatek: Add MT8195 scp adsp clock support
  clk: mediatek: Add MT8195 nnasys clock support
  clk: mediatek: Add MT8195 vdecsys clock support
  clk: mediatek: Add MT8195 vdosys0 clock support
  clk: mediatek: Add MT8195 vdosys1 clock support
  clk: mediatek: Add MT8195 vencsys clock support
  clk: mediatek: Add MT8195 vppsys0 clock support
  clk: mediatek: Add MT8195 vppsys1 clock support
  clk: mediatek: Add MT8195 wpesys clock support
  clk: mediatek: Add MT8195 imp i2c wrapper clock support
  clk: mediatek: Add MT8195 apusys clock support

 .../arm/mediatek/mediatek,mt8195-clock.yaml   |  287 +++
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |   66 +
 drivers/clk/mediatek/Kconfig                  |  116 +
 drivers/clk/mediatek/Makefile                 |   19 +
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c  |   84 +
 drivers/clk/mediatek/clk-mt8195-aud.c         |  198 ++
 drivers/clk/mediatek/clk-mt8195-aud_src.c     |   60 +
 drivers/clk/mediatek/clk-mt8195-cam.c         |  144 ++
 drivers/clk/mediatek/clk-mt8195-ccu.c         |   52 +
 drivers/clk/mediatek/clk-mt8195-img.c         |   98 +
 .../clk/mediatek/clk-mt8195-imp_iic_wrap.c    |   68 +
 drivers/clk/mediatek/clk-mt8195-ipe.c         |   53 +
 drivers/clk/mediatek/clk-mt8195-mfg.c         |   49 +
 drivers/clk/mediatek/clk-mt8195-nna.c         |  128 ++
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c    |   49 +
 drivers/clk/mediatek/clk-mt8195-vdec.c        |  106 +
 drivers/clk/mediatek/clk-mt8195-vdo0.c        |  114 +
 drivers/clk/mediatek/clk-mt8195-vdo1.c        |  131 ++
 drivers/clk/mediatek/clk-mt8195-venc.c        |   71 +
 drivers/clk/mediatek/clk-mt8195-vpp0.c        |  112 +
 drivers/clk/mediatek/clk-mt8195-vpp1.c        |  110 +
 drivers/clk/mediatek/clk-mt8195-wpe.c         |  145 ++
 drivers/clk/mediatek/clk-mt8195.c             | 1958 +++++++++++++++++
 drivers/clk/mediatek/clk-pll.c                |    2 +-
 include/dt-bindings/clock/mt8195-clk.h        |  989 +++++++++
 25 files changed, 5208 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8195-apusys_pll.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-aud_src.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ccu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-nna.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-scp_adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-wpe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195.c
 create mode 100644 include/dt-bindings/clock/mt8195-clk.h

-- 
2.18.0

