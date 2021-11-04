Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EBE445447
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhKDNzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:55:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56572 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhKDNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:55:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D1B101F4619B
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] arm64: dts: mediatek: mt8173: Add gce-client-reg to display od/ufo
Date:   Thu,  4 Nov 2021 14:52:54 +0100
Message-Id: <20211104135254.580257-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use CMDQ commands on these two IPs, we need to declare
the appropriate mediatek,gce-client-reg for them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index dee66e5f054c..2b7d331a4588 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1212,6 +1212,7 @@ ufoe@1401a000 {
 			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_UFOE>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xa000 0x1000>;
 		};
 
 		dsi0: dsi@1401b000 {
@@ -1316,6 +1317,7 @@ od@14023000 {
 			compatible = "mediatek,mt8173-disp-od";
 			reg = <0 0x14023000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_DISP_OD>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1402XXXX 0x3000 0x1000>;
 		};
 
 		hdmi0: hdmi@14025000 {
-- 
2.33.1

