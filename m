Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC974458E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhKVMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:39:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55056 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234308AbhKVMjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:39:09 -0500
X-UUID: 8095f3456ce44959a0c2651a7ac9ba19-20211122
X-UUID: 8095f3456ce44959a0c2651a7ac9ba19-20211122
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1399505868; Mon, 22 Nov 2021 20:35:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 22 Nov 2021 20:35:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Nov 2021 20:35:57 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "Sam Shih" <sam.shih@mediatek.com>
Subject: [PATCH v10 0/2] Mediatek MT7986 pinctrl support
Date:   Mon, 22 Nov 2021 20:35:50 +0800
Message-ID: <20211122123552.8218-1-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add pinctrl support for mediatek mt7986 SoC series.
It is based on patch series "Add basic SoC support for mediatek mt7986"
https://lore.kernel.org/all/20211122123222.8016-1-sam.shih@mediatek.com/

This patch series base on the following patches
https://lore.kernel.org/all/20211022124036.5291-2-sam.shih@mediatek.com/
https://lore.kernel.org/all/20211022124036.5291-3-sam.shih@mediatek.com/
that have been applied to the pin control tree

---
v10: used mt7986b.dtsi to include mt7986a.dtsi to reduce duplicate dts nodes
v9: added Acked-by and Reviewed-by tag
v8: fixed uart node in yaml dts example
v7: separate pinctrl part into a single patch series

According to the maintainer’s suggestion, this patch splits the previous
thread into independent patch series.
This patch include clock driver and device tree update

Original thread:
https://lore.kernel.org/all/20210914085137.31761-1-sam.shih@mediatek.com/
---

Sam Shih (2):
  arm64: dts: mediatek: add pinctrl support for mt7986a
  arm64: dts: mediatek: add pinctrl support for mt7986b

 arch/arm64/boot/dts/mediatek/Makefile        |  1 +
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 20 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 21 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 29 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b.dtsi    | 12 ++++++++
 5 files changed, 83 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986b.dtsi

-- 
2.29.2

