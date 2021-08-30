Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB173FB8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhH3PBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbhH3PBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:01:02 -0400
X-Greylist: delayed 2744 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Aug 2021 08:00:08 PDT
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DBC0613D9;
        Mon, 30 Aug 2021 08:00:08 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout3.routing.net (Postfix) with ESMTP id 5AFF5604DD;
        Mon, 30 Aug 2021 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1630335606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FB34z+C8sGX7ZZ7kAsjc/5fqFHG4raJPZ6x3LyD7ocE=;
        b=hBakEaTBn9R0yk9TKrAV8B3L1JVUjd5HdThgCAOP1u7JJ2FoUwWJnR5ACemZrltDFDT4K1
        WejpT517SruouMylAXEgg+91cgFnN2aI/sA/wKxMkLQ7D+ol6cvfkg3in5L/VA3YZJomJr
        fpmNV55jQISDc0xI1ZHgsQWsh8X9Ew8=
Received: from localhost.localdomain (fttx-pool-157.180.227.230.bambit.de [157.180.227.230])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id ADCE28008C;
        Mon, 30 Aug 2021 15:00:05 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm: dts: mt7623: add otg nodes for bpi-r2
Date:   Mon, 30 Aug 2021 16:59:58 +0200
Message-Id: <20210830145958.108605-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a7d5b3dd-a653-44e9-8e1d-254951e06a6d
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
v2:
	rebase on plain 5.14, v1 was based on some not upstreamed work
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index e96aa0ed1ebd..027c1b0c6a98 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -366,6 +366,14 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pio {
+	musb_pins: musb {
+		pins-musb {
+			pinmux = <MT7623_PIN_237_EXT_SDIO2_FUNC_DRV_VBUS>;
+		};
+	};
+};
+
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm_pins_a>;
@@ -396,6 +404,19 @@ &uart2 {
 	status = "okay";
 };
 
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
 &usb1 {
 	vusb33-supply = <&reg_3p3v>;
 	vbus-supply = <&reg_5v>;
@@ -408,6 +429,10 @@ &usb2 {
 	status = "okay";
 };
 
+&u2phy1 {
+	status = "okay";
+};
+
 &u3phy1 {
 	status = "okay";
 };
-- 
2.25.1

