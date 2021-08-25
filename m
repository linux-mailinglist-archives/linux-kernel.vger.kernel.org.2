Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5A3F7325
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhHYK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbhHYK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:27:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A63C0613C1;
        Wed, 25 Aug 2021 03:26:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ED0501F43714
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        eizan@chromium.org, drinkcat@chromium.org, chunkuang.hu@kernel.org,
        kernel@collabora.com, Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/7] arm64: dts: mt8173: Add the mmsys reset bit to reset the dsi0
Date:   Wed, 25 Aug 2021 12:26:29 +0200
Message-Id: <20210825122613.v3.4.I7bd7d9a8da5e2894711b700a1127e6902a2b2f1d@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825102632.601614-1-enric.balletbo@collabora.com>
References: <20210825102632.601614-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the DSI hardware is needed to prevent different settings between
the bootloader and the kernel.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8173.dtsi  | 2 ++
 include/dt-bindings/reset/mt8173-resets.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 17d70e2f5394..97ea3f9960b1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1036,6 +1036,7 @@ mmsys: syscon@14000000 {
 			assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
 			assigned-clock-rates = <400000000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
 				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
@@ -1262,6 +1263,7 @@ dsi0: dsi@1401b000 {
 				 <&mmsys CLK_MM_DSI0_DIGITAL>,
 				 <&mipi_tx0>;
 			clock-names = "engine", "digital", "hs";
+			resets = <&mmsys MT8173_MMSYS_SW0_RST_B_DISP_DSI0>;
 			phys = <&mipi_tx0>;
 			phy-names = "dphy";
 			status = "disabled";
diff --git a/include/dt-bindings/reset/mt8173-resets.h b/include/dt-bindings/reset/mt8173-resets.h
index ba8636eda5ae..6a60c7cecc4c 100644
--- a/include/dt-bindings/reset/mt8173-resets.h
+++ b/include/dt-bindings/reset/mt8173-resets.h
@@ -27,6 +27,8 @@
 #define MT8173_INFRA_GCE_FAXI_RST       40
 #define MT8173_INFRA_MMIOMMURST         47
 
+/* MMSYS resets */
+#define MT8173_MMSYS_SW0_RST_B_DISP_DSI0	25
 
 /*  PERICFG resets */
 #define MT8173_PERI_UART0_SW_RST        0
-- 
2.30.2

