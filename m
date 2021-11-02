Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693074430AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKBOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:45:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33466 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKBOpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:45:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 733121F44C5E
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8173-elm: Add backlight enable pin config
Date:   Tue,  2 Nov 2021 15:42:24 +0100
Message-Id: <20211102144224.457446-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211102144224.457446-1-angelogioacchino.delregno@collabora.com>
References: <20211102144224.457446-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the proper pinctrl for GPIO95 backlight enable pin and assign it
to the pwm-backlight node.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index f292ca459a9a..9c75fbb31f98 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -27,6 +27,8 @@ backlight: backlight {
 		power-supply = <&bl_fixed_reg>;
 		enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_backlight_en_pins>;
 		status = "okay";
 	};
 
@@ -825,6 +827,12 @@ pins_clk {
 		};
 	};
 
+	panel_backlight_en_pins: panel_backlight_en_pins {
+		pins1 {
+			pinmux = <MT8173_PIN_95_PCM_TX__FUNC_GPIO95>;
+		};
+	};
+
 	panel_fixed_pins: panel_fixed_pins {
 		pins1 {
 			pinmux = <MT8173_PIN_41_CMMCLK__FUNC_GPIO41>;
-- 
2.33.1

