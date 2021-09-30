Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF741D57E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbhI3Idz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349229AbhI3Ids (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:33:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62506C061776;
        Thu, 30 Sep 2021 01:32:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 98E811F449F5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org, eizan@chromium.org,
        kernel@collabora.com, drinkcat@chromium.org,
        jitao.shi@mediatek.com, chunkuang.hu@kernel.org,
        hsinyi@chromium.org, matthias.bgg@gmail.com,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 5/7] arm64: dts: mt8183: Add the mmsys reset bit to reset the dsi0
Date:   Thu, 30 Sep 2021 10:31:48 +0200
Message-Id: <20210930103105.v4.5.I933f1532d7a1b2910843a9644c86a7d94a4b44e1@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930083150.3317003-1-enric.balletbo@collabora.com>
References: <20210930083150.3317003-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the DSI hardware is needed to prevent different settings between
the bootloader and the kernel.

While here, also remove the undocumented and also not used
'mediatek,syscon-dsi' property.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8183.dtsi  | 3 ++-
 include/dt-bindings/reset/mt8183-resets.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9639ca17638e..9c4158a1057c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1251,6 +1251,7 @@ mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8183-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
 				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
@@ -1365,11 +1366,11 @@ dsi0: dsi@14014000 {
 			reg = <0 0x14014000 0 0x1000>;
 			interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
-			mediatek,syscon-dsi = <&mmsys 0x140>;
 			clocks = <&mmsys CLK_MM_DSI0_MM>,
 				 <&mmsys CLK_MM_DSI0_IF>,
 				 <&mipi_tx0>;
 			clock-names = "engine", "digital", "hs";
+			resets = <&mmsys MT8183_MMSYS_SW0_RST_B_DISP_DSI0>;
 			phys = <&mipi_tx0>;
 			phy-names = "dphy";
 		};
diff --git a/include/dt-bindings/reset/mt8183-resets.h b/include/dt-bindings/reset/mt8183-resets.h
index a1bbd41e0d12..48c5d2de0a38 100644
--- a/include/dt-bindings/reset/mt8183-resets.h
+++ b/include/dt-bindings/reset/mt8183-resets.h
@@ -80,6 +80,9 @@
 
 #define MT8183_INFRACFG_SW_RST_NUM				128
 
+/* MMSYS resets */
+#define MT8183_MMSYS_SW0_RST_B_DISP_DSI0			25
+
 #define MT8183_TOPRGU_MM_SW_RST					1
 #define MT8183_TOPRGU_MFG_SW_RST				2
 #define MT8183_TOPRGU_VENC_SW_RST				3
-- 
2.30.2

