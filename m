Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1640A32F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhINCSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:18:06 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33164 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229754AbhINCSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:18:05 -0400
X-UUID: 1f51c357e7d84e9597453061b0f0bcca-20210914
X-UUID: 1f51c357e7d84e9597453061b0f0bcca-20210914
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1673174197; Tue, 14 Sep 2021 10:16:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 10:16:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 10:16:43 +0800
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
Subject: [v3 00/24] Mediatek MT8195 clock support
Date:   Tue, 14 Sep 2021 10:16:09 +0800
Message-ID: <20210914021633.26377-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch series is based on 5.15-rc1.

changes since v2:
- fix line wrap in Makefile
- update commit message in vdosys clock provider
- refine description of special clock
- refine kconfig
- merge CLK_OF_DECLARE_DRIVER to builtin_platform_driver (topck)

changes since v1:
- fix resource leak if error condition happens
- refine clock name to match datasheet
- remove redundant data in mux parent source
- seperate clock driver based on IP architecture
- change to dual licence
- refine dt-binding file
- remove audio clock driver (handled in [4])
- integrate vdosys0 and vdosys1 clock registration with mmsys in [2] and [3]

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=521127
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=531695
[3] https://patchwork.kernel.org/project/linux-mediatek/list/?series=519617
[4] https://patchwork.kernel.org/project/linux-mediatek/list/?series=528369

Chun-Jie Chen (24):
  dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock
  clk: mediatek: Add dt-bindings of MT8195 clocks
  clk: mediatek: Fix corner case of tuner_en_reg
  clk: mediatek: Add API for clock resource recycle
  clk: mediatek: Fix resource leak in mtk_clk_simple_probe
  clk: mediatek: Add MT8195 apmixedsys clock support
  clk: mediatek: Add MT8195 topckgen clock support
  clk: mediatek: Add MT8195 peripheral clock support
  clk: mediatek: Add MT8195 infrastructure clock support
  clk: mediatek: Add MT8195 camsys clock support
  clk: mediatek: Add MT8195 ccusys clock support
  clk: mediatek: Add MT8195 imgsys clock support
  clk: mediatek: Add MT8195 ipesys clock support
  clk: mediatek: Add MT8195 mfgcfg clock support
  clk: mediatek: Add MT8195 scp adsp clock support
  clk: mediatek: Add MT8195 vdecsys clock support
  clk: mediatek: Add MT8195 vdosys0 clock support
  clk: mediatek: Add MT8195 vdosys1 clock support
  clk: mediatek: Add MT8195 vencsys clock support
  clk: mediatek: Add MT8195 vppsys0 clock support
  clk: mediatek: Add MT8195 vppsys1 clock support
  clk: mediatek: Add MT8195 wpesys clock support
  clk: mediatek: Add MT8195 imp i2c wrapper clock support
  clk: mediatek: Add MT8195 apusys clock support

 .../arm/mediatek/mediatek,mt8195-clock.yaml   |  254 ++++
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |   73 +
 drivers/clk/mediatek/Kconfig                  |    8 +
 drivers/clk/mediatek/Makefile                 |    8 +
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c  |  145 ++
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c  |   92 ++
 drivers/clk/mediatek/clk-mt8195-cam.c         |  142 ++
 drivers/clk/mediatek/clk-mt8195-ccu.c         |   50 +
 drivers/clk/mediatek/clk-mt8195-img.c         |   96 ++
 .../clk/mediatek/clk-mt8195-imp_iic_wrap.c    |   68 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  206 +++
 drivers/clk/mediatek/clk-mt8195-ipe.c         |   51 +
 drivers/clk/mediatek/clk-mt8195-mfg.c         |   47 +
 drivers/clk/mediatek/clk-mt8195-peri_ao.c     |   62 +
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c    |   47 +
 drivers/clk/mediatek/clk-mt8195-topckgen.c    | 1273 +++++++++++++++++
 drivers/clk/mediatek/clk-mt8195-vdec.c        |  104 ++
 drivers/clk/mediatek/clk-mt8195-vdo0.c        |  123 ++
 drivers/clk/mediatek/clk-mt8195-vdo1.c        |  140 ++
 drivers/clk/mediatek/clk-mt8195-venc.c        |   69 +
 drivers/clk/mediatek/clk-mt8195-vpp0.c        |  110 ++
 drivers/clk/mediatek/clk-mt8195-vpp1.c        |  108 ++
 drivers/clk/mediatek/clk-mt8195-wpe.c         |  143 ++
 drivers/clk/mediatek/clk-mtk.c                |   21 +-
 drivers/clk/mediatek/clk-mtk.h                |    1 +
 drivers/clk/mediatek/clk-pll.c                |    2 +-
 include/dt-bindings/clock/mt8195-clk.h        |  864 +++++++++++
 27 files changed, 4304 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8195-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-apusys_pll.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ccu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-infra_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-peri_ao.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-scp_adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vdo1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-vpp1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8195-wpe.c
 create mode 100644 include/dt-bindings/clock/mt8195-clk.h

-- 
2.18.0

