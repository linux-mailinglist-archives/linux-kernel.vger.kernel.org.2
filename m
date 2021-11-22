Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8502D458E69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbhKVMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:35:48 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:50076 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233849AbhKVMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:35:47 -0500
X-UUID: 0fa1b28206714aa6b9c010add04b6047-20211122
X-UUID: 0fa1b28206714aa6b9c010add04b6047-20211122
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 469721819; Mon, 22 Nov 2021 20:32:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Nov 2021 20:32:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Nov 2021 20:32:36 +0800
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
Subject: [PATCH v8 0/2] Add basic SoC support for mediatek mt7986
Date:   Mon, 22 Nov 2021 20:32:20 +0800
Message-ID: <20211122123222.8016-1-sam.shih@mediatek.com>
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

The MT7986 series includes mt7986a and mt7986b,
The difference is that some pins do not exist on mt7986b
(two pinctrls compatible string are required),

But the basic part of the device tree should be the same,
So we only add mt7986a in this basic part patch series.
We will separate mt7986a and mt7986b in the pinctrl patch series

---
v8: updated dts
v7: added memory node back to dts
v6: separate basic part into a single patch series

According to the maintainer’s suggestion, this patch splits the previous
thread into independent patch series.
This patch include basic device support.

Original thread:
https://lore.kernel.org/all/20210914085137.31761-1-sam.shih@mediatek.com/


Sam Shih (2):
  dt-bindings: arm64: dts: mediatek: Add mt7986 series
  arm64: dts: mediatek: add basic mt7986 support

 .../devicetree/bindings/arm/mediatek.yaml     |   8 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  |  37 +++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 148 ++++++++++++++++++
 4 files changed, 194 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a.dtsi

-- 
2.29.2

