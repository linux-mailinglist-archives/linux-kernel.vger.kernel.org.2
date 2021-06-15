Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C943D3A87D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhFORgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:36:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34916 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231308AbhFORe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:59 -0400
X-UUID: 00ff0ee9a06641ecac3fc873d0fa480a-20210616
X-UUID: 00ff0ee9a06641ecac3fc873d0fa480a-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 985036743; Wed, 16 Jun 2021 01:32:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:44 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Subject: [PATCH 10/27] arm64: dts: mt8195: add PCIe phy device node
Date:   Wed, 16 Jun 2021 01:32:16 +0800
Message-ID: <20210615173233.26682-10-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianjun Wang <jianjun.wang@mediatek.com>

Add PCIe phy device node for mt8195 SoC.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 80a272703879..dd5644410fea 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1107,6 +1107,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0 0x11e30000 0xe00>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
 			status = "disabled";
 
 			u2port1: usb-phy@0 {
@@ -1146,6 +1147,19 @@
 			};
 		};
 
+		pciephy: phy@11e80000 {
+			compatible = "mediatek,mt8195-pcie-phy";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#phy-cells = <0>;
+			reg = <0 0x11e80000 0 0x10000>,
+			      <0 0x11e90000 0 0x10000>;
+			reg-names = "phy-sif", "phy-ckm";
+
+			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_PHY>;
+			status = "disabled";
+		};
+
 		ufsphy: phy@11fa0000 {
 			compatible = "mediatek,mt8195-ufsphy", "mediatek,mt8183-ufsphy";
 			reg = <0 0x11fa0000 0 0xc000>;
-- 
2.18.0

