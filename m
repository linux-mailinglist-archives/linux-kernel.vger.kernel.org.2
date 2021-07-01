Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1023B8FE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhGAJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhGAJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:43:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A7FC061756;
        Thu,  1 Jul 2021 02:40:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A60281F43DE2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Bilal Wasim <Bilal.Wasim@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 3/3] arm64: dts: mediatek: mt8173: Add domain supply for mfg_async
Date:   Thu,  1 Jul 2021 11:40:24 +0200
Message-Id: <20210701114012.RESEND.3.I9e27871bb700c807a564957302b292e9935dae0b@changeid>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701094024.1273759-1-enric.balletbo@collabora.com>
References: <20210701094024.1273759-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bilal Wasim <Bilal.Wasim@imgtec.com>

da9211 regulator needs to be enabled before enabling the mfg_async power
domain. Otherwise the subdomain is not enabled and causes failure in
imgtec gpu driver boot.

Add the "domain-supply" property to the "mfg_async" node in DT.

Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi     | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 21452c51a20a..a8efff2071bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -157,6 +157,10 @@ hdmi_connector_in: endpoint {
 	};
 };
 
+&mfg_async {
+	domain-supply = <&da9211_vgpu_reg>;
+};
+
 &cec {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index f6a1738dfbaa..4fa1e93302c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -62,6 +62,10 @@ usb_p0_vbus: regulator@1 {
 	};
 };
 
+&mfg_async {
+	domain-supply = <&da9211_vgpu_reg>;
+};
+
 &cec {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 003a5653c505..dbda5d656b29 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -504,7 +504,7 @@ power-domain@MT8173_POWER_DOMAIN_USB {
 					reg = <MT8173_POWER_DOMAIN_USB>;
 					#power-domain-cells = <0>;
 				};
-				power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
+				mfg_async: power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
 					reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
 					clocks = <&clk26m>;
 					clock-names = "mfg";
-- 
2.30.2

