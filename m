Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D983FB7A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhH3OPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbhH3OPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:15:17 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D463C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:14:24 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 7923F5FF41;
        Mon, 30 Aug 2021 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1630332861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HqkVrWRC7EKt3KrlDJ9BJiUPJ234vCZbFseBVJRV4fM=;
        b=fdxDAbJhGI9SoJ1fk0YpSQfdxuCBKGd4SAmo+gTHWxuI/TAgHXQbrBdeKvo/kQ7Yg1zw2R
        9wPCg+6DlLNLrlV0lzy0zG5XIAWqftV41+5pmQX/bnCuoxgomtQYO8dx2DEO3KN0q88WWI
        Hlg0lgyCkWwbyNdb17zRdLK2x4efIzY=
Received: from localhost.localdomain (fttx-pool-157.180.227.230.bambit.de [157.180.227.230])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 9EB44100822;
        Mon, 30 Aug 2021 14:14:20 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: mt7623: add otg nodes for bpi-r2
Date:   Mon, 30 Aug 2021 16:14:15 +0200
Message-Id: <20210830141415.106136-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: db1bf837-c379-4f08-aad1-a948eac37616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add OTG-Nodes for BananaPi-R2

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
patch is based on

"arm: dts: mt7623: add musb device nodes"

https://patchwork.kernel.org/project/linux-mediatek/patch/20210822041333.5264-2-mans0n@gorani.run/
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 8d22aeec91e1..729bc055ffcd 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -374,7 +374,14 @@ adie {
 				bias-disable;
 		};
 	};
+
+	musb_pins: musb {
+		pins-musb {
+			pinmux = <MT7623_PIN_237_EXT_SDIO2_FUNC_DRV_VBUS>;
+		};
+	};
 };
+
 &consys {
 	mediatek,pwrap-regmap = <&pwrap>;
 	pinctrl-names = "default";
@@ -462,3 +469,21 @@ &u3phy1 {
 &u3phy2 {
 	status = "okay";
 };
+
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&musb_pins>;
+	status = "okay";
+	usb-role-switch;
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		type = "micro";
+		id-gpios = <&pio 44 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
-- 
2.25.1

