Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17F83E3E28
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 05:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhHIDJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 23:09:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44912 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232804AbhHIDJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:09:05 -0400
X-UUID: 48606c964f6e4a71ae7f57959fe9ea73-20210809
X-UUID: 48606c964f6e4a71ae7f57959fe9ea73-20210809
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1915852948; Mon, 09 Aug 2021 11:08:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Aug 2021 11:08:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Aug 2021 11:08:39 +0800
From:   Nina Wu <nina-cm.wu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nina Wu <Nina-CM.Wu@mediatek.com>,
        Neal Liu <neal.liu@mediatek.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [v4 7/7] arm64: dts: mt8192: Add devapc node
Date:   Mon, 9 Aug 2021 11:08:19 +0800
Message-ID: <1628478499-29460-7-git-send-email-nina-cm.wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1628478499-29460-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1628478499-29460-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nina Wu <Nina-CM.Wu@mediatek.com>

Add devapc nodes to mt8192.

Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
---
This patch depends on "Add dt-bindings of MT8192 clocks" [1]
and "Add mt8192 clock controllers" [2]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/dt-bindings/clock/mt8192-clk.h?h=next-20210806&id=f35f1a23e0e12e3173e9e9dedbc150d139027189
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/20210727023205.20319-2-chun-jie.chen@mediatek.com/
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 6b22441..accbd07 100644
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
 		scp_adsp: clock-controller@10720000 {
 			compatible = "mediatek,mt8192-scp_adsp";
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

