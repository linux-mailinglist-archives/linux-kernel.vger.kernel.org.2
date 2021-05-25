Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A638FA66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhEYFzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:55:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56037 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231313AbhEYFzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:55:33 -0400
X-UUID: dad6ddd890bf453f9aca5c7a0bd46524-20210525
X-UUID: dad6ddd890bf453f9aca5c7a0bd46524-20210525
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 101585140; Tue, 25 May 2021 13:54:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 13:53:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 13:53:59 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Nina Wu <Nina-CM.Wu@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 7/7] arm64: dts: mt8192: Add devapc node
Date:   Tue, 25 May 2021 13:53:06 +0800
Message-ID: <1621921986-20578-7-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1621921986-20578-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1621921986-20578-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

Add devapc nodes to mt8192.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
This patch depends on "Add dt-bindings of MT8192 clocks" [1]
and "Add mt8192 clock controllers" [2]

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210524122053.17155-7-chun-jie.chen@mediatek.com/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20210331083854.7650-2-chun-jie.chen@mediatek.com/
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index b0923de..6f5c8c5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -517,6 +517,33 @@
 			clock-names = "clk13m";
 		};
 
+		devapc_infra: devapc@10207000 {
+			compatible = "mediatek,mt8192-devapc";
+			reg = <0 0x10207000 0 0x1000>;
+			vio-idx-num = <367>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_DEVICE_APC>;
+			clock-names = "devapc-infra-clock";
+		};
+
+		devapc_peri: devapc@10274000 {
+			compatible = "mediatek,mt8192-devapc";
+			reg = <0 0x10274000 0 0x1000>;
+			vio-idx-num = <292>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_DEVICE_APC>;
+			clock-names = "devapc-infra-clock";
+		};
+
+		devapc_peri2: devapc@10275000 {
+			compatible = "mediatek,mt8192-devapc";
+			reg = <0 0x10275000 0 0x1000>;
+			vio-idx-num = <242>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_DEVICE_APC>;
+			clock-names = "devapc-infra-clock";
+		};
+
 		scp_adsp: syscon@10720000 {
 			compatible = "mediatek,mt8192-scp_adsp", "syscon";
 			reg = <0 0x10720000 0 0x1000>;
@@ -661,6 +688,15 @@
 			status = "disabled";
 		};
 
+		devapc_peri_par: devapc@11020000 {
+			compatible = "mediatek,mt8192-devapc";
+			reg = <0 0x11020000 0 0x1000>;
+			vio-idx-num = <58>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_DEVICE_APC>;
+			clock-names = "devapc-infra-clock";
+		};
+
 		nor_flash: spi@11234000 {
 			compatible = "mediatek,mt8192-nor";
 			reg = <0 0x11234000 0 0xe0>;
-- 
2.6.4

