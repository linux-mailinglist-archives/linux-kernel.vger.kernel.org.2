Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE53D4317D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhJRLtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:49:36 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50336 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231364AbhJRLtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:49:31 -0400
X-UUID: 0172d2064dc440339f9ef37e75c540be-20211018
X-UUID: 0172d2064dc440339f9ef37e75c540be-20211018
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1008275473; Mon, 18 Oct 2021 19:47:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 19:47:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Oct 2021 19:47:16 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v5 0/5] Mediatek MT7986 basic clock support
Date:   Mon, 18 Oct 2021 19:46:56 +0800
Message-ID: <20211018114701.13984-1-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add basic clock support for mediatek mt7986 SoC.
It is based on patch series "Add basic SoC support for mediatek mt7986"
https://lore.kernel.org/all/20211018114009.13350-1-sam.shih@mediatek.com/
and "clk: mediatek: Add API for clock resource recycle"
https://lore.kernel.org/linux-arm-kernel/20210914021633.26377-5-chun-jie.chen@mediatek.com/

---
v5: used builtin_platform_driver instead of CLK_OF_DECLARE
    follow recent clk-mt8195 clock patch series:
    https://lore.kernel.org/linux-arm-kernel/20210914021633.26377-1-chun-jie.chen@mediatek.com/

v4:
According to the maintainer’s suggestion, this patch splits the previous
thread into independent patch series.
This patch include clock driver and device tree update

Original thread:
https://lore.kernel.org/all/20210914085137.31761-1-sam.shih@mediatek.com/
https://lore.kernel.org/linux-arm-kernel/20210914085137.31761-2-sam.shih@mediatek.com/
---

Sam Shih (5):
  dt-bindings: clock: mediatek: document clk bindings for mediatek
    mt7986 SoC
  clk: mediatek: add mt7986 clock IDs
  clk: mediatek: add mt7986 clock support
  arm64: dts: mediatek: add clock support for mt7986a
  arm64: dts: mediatek: add clock support for mt7986b

 .../arm/mediatek/mediatek,apmixedsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt |   1 +
 .../arm/mediatek/mediatek,infracfg.txt        |   1 +
 .../arm/mediatek/mediatek,sgmiisys.txt        |   2 +
 .../arm/mediatek/mediatek,topckgen.txt        |   1 +
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  68 +++-
 arch/arm64/boot/dts/mediatek/mt7986b.dtsi     |  68 +++-
 drivers/clk/mediatek/Kconfig                  |  17 +
 drivers/clk/mediatek/Makefile                 |   4 +
 drivers/clk/mediatek/clk-mt7986-apmixed.c     | 100 +++++
 drivers/clk/mediatek/clk-mt7986-eth.c         | 132 +++++++
 drivers/clk/mediatek/clk-mt7986-infracfg.c    | 224 ++++++++++++
 drivers/clk/mediatek/clk-mt7986-topckgen.c    | 342 ++++++++++++++++++
 include/dt-bindings/clock/mt7986-clk.h        | 169 +++++++++
 14 files changed, 1120 insertions(+), 10 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt7986-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-topckgen.c
 create mode 100644 include/dt-bindings/clock/mt7986-clk.h

--
2.29.2

