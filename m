Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1249431813
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhJRLwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:52:33 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:59619 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhJRLwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:52:32 -0400
X-UUID: 9f4eb64a42bb4c44a1f635ed1cef80e4-20211018
X-UUID: 9f4eb64a42bb4c44a1f635ed1cef80e4-20211018
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1829911727; Mon, 18 Oct 2021 04:50:20 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 04:40:18 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Oct 2021 19:40:17 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v7 0/3] Add basic SoC support for mediatek mt7986
Date:   Mon, 18 Oct 2021 19:40:06 +0800
Message-ID: <20211018114009.13350-1-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic SoC support for Mediatek's new 4-core SoC,
MT7986, which is mainly for wifi-router application.

---
v7: added memory node back to dts
v6: separate basic part into a single patch series

According to the maintainer’s suggestion, this patch splits the previous
thread into independent patch series.
This patch include basic device support.

Original thread:
https://lore.kernel.org/all/20210914085137.31761-1-sam.shih@mediatek.com/
---

Sam Shih (3):
  dt-bindings: arm64: dts: mediatek: Add mt7986 series
  arm64: dts: mediatek: add basic mt7986a support
  arm64: dts: mediatek: add basic mt7986b support

 .../devicetree/bindings/arm/mediatek.yaml     |   8 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  |  38 +++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 149 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts  |  30 ++++
 arch/arm64/boot/dts/mediatek/mt7986b.dtsi     | 149 ++++++++++++++++++
 6 files changed, 376 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986b.dtsi

--
2.29.2

