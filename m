Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDEC42D43F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhJNH6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:58:34 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47296 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229970AbhJNH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:58:32 -0400
X-UUID: 234527f3442f41388b16ffde21a6067b-20211014
X-UUID: 234527f3442f41388b16ffde21a6067b-20211014
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 583870662; Thu, 14 Oct 2021 15:56:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 Oct 2021 15:56:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Oct 2021 15:56:24 +0800
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
Subject: [PATCH v4 0/5] Mediatek MT7986 basic clock support
Date:   Thu, 14 Oct 2021 15:56:15 +0800
Message-ID: <20211014075620.17563-1-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add basic clock support for mediatek mt7986 SoC.
It is based on patch series "Add basic SoC support for mediatek mt7986":
https://lore.kernel.org/all/20211014074403.17346-1-sam.shih@mediatek.com/

---
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
 drivers/clk/mediatek/clk-mt7986-apmixed.c     |  78 +++++
 drivers/clk/mediatek/clk-mt7986-eth.c         | 132 ++++++++
 drivers/clk/mediatek/clk-mt7986-infracfg.c    | 198 +++++++++++
 drivers/clk/mediatek/clk-mt7986-topckgen.c    | 319 ++++++++++++++++++
 include/dt-bindings/clock/mt7986-clk.h        | 169 ++++++++++
 14 files changed, 1049 insertions(+), 10 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt7986-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-topckgen.c
 create mode 100644 include/dt-bindings/clock/mt7986-clk.h

--
2.29.2

