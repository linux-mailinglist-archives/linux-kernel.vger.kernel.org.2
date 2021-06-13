Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C473A5763
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhFMJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 05:50:44 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:44615 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFMJun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 05:50:43 -0400
Received: by mail-wm1-f49.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so7921699wms.3;
        Sun, 13 Jun 2021 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k8Tcr/7hh6x1TjU9mgPl8U2ujjvIEU7EhIT4MxZ7SOk=;
        b=KeA0K7SElPIS7sEnawxhgq1tX01lPeaGPuoWXaUhK/80J3R+clXgxYf0k8i3U+ToVq
         MIioP/6SpgwuH952kXtXj1zM8YXm7yLoaLUgfa/ZPI7Xtn5bMtbs0zxtQ86pWl+i12ec
         s8d7+b64GyedYJHw+dYyThPZ2Pc/TrJJ9ZxycOi0WGr9QfJYbNV2GnYIMxgULGuKIHPF
         caPFgmILv79rWr0pgfWmyDuNNBVLPSfhdS18WDlhAPxfYBXk7udk+xvTgg/1ieURiblH
         e5eNt4BV668NZO7pBBZtnWD2I08zY0R4GcsFJb80O4W+ZYba5HD+1a5ad97XCf1CrZ0g
         v2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k8Tcr/7hh6x1TjU9mgPl8U2ujjvIEU7EhIT4MxZ7SOk=;
        b=A2dEtA/WxQ6fJ+XDaFbx+DjWjlb6OsdPCJ3PGY03lljyc2POD84GZxfCKZP3gtkhxR
         vtWIaPaMCJS/eyOA61Umi9roof9gDWcZBhURdf5dlsc5h6b2ROS307h5EYbZP7Yobtzp
         tuYZx0S0YKJi1ASRC1vJOa0/jpJ1g9H8VPzb7CteaSUPu4U+aMYgKnnCg/4pTFthYKHF
         rJIwyhiVZXQQNUw4vNHQJblGIlCa3lQH0MNrMw9u5ky3jwOV9wqdgG+uPFcpZA/ZcnIM
         VB2NtjXcDBfdzEJbwN88ne6cFYUJVem1yTq02KNkQOxcI060Iy7zxQfmcF52ou9AOTf6
         rM7g==
X-Gm-Message-State: AOAM531xXHz/pgas95W2lTEEWKphsBAj5xQnmlWP3wZCzomUKYY0BVE+
        eIlc9Lasi2ku6dm1f81xAUqJEfiotY0=
X-Google-Smtp-Source: ABdhPJy/XuQCc5BH8sN6gBgGQS78fLek7ilWWUE+4UJ0gifajvZw76otnVo+Y4jKdnURGQtS6AdZoA==
X-Received: by 2002:a1c:453:: with SMTP id 80mr11077477wme.171.1623577661587;
        Sun, 13 Jun 2021 02:47:41 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id y189sm10953178wmy.25.2021.06.13.02.47.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 13 Jun 2021 02:47:41 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: NSP: disable qspi node by default
Date:   Sun, 13 Jun 2021 10:46:34 +0100
Message-Id: <20210613094639.3242151-1-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QSPI bus is enabled by default, however this may not used on all
devices. This patch disables by default, requiring it to be explicitly
enabled where required.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 1 +
 arch/arm/boot/dts/bcm958522er.dts  | 1 +
 arch/arm/boot/dts/bcm958525er.dts  | 1 +
 arch/arm/boot/dts/bcm958525xmc.dts | 1 +
 arch/arm/boot/dts/bcm958622hr.dts  | 1 +
 arch/arm/boot/dts/bcm958623hr.dts  | 1 +
 arch/arm/boot/dts/bcm958625hr.dts  | 1 +
 arch/arm/boot/dts/bcm958625k.dts   | 1 +
 arch/arm/boot/dts/bcm988312hr.dts  | 1 +
 9 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index b4d2cc70afb1..c0427d985438 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -310,6 +310,7 @@ qspi: spi@27200 {
 			num-cs = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		xhci: usb@29000 {
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index b6f4d931123c..e5ed67b3c35f 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -134,6 +134,7 @@ nand_sel: nand_sel {
 };
 
 &qspi {
+	status = "okay";
 	bspi-sel = <0>;
 	flash: m25p80@0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index af66caa87bfc..017fc46cdf0b 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -134,6 +134,7 @@ nand_sel: nand_sel {
 };
 
 &qspi {
+	status = "okay";
 	bspi-sel = <0>;
 	flash: m25p80@0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 3d6859e4fd5e..5364f98ae1b8 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -150,6 +150,7 @@ nand_sel: nand_sel {
 };
 
 &qspi {
+	status = "okay";
 	bspi-sel = <0>;
 	flash: m25p80@0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index dca2c9c60857..4763eb5d68a6 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -138,6 +138,7 @@ nand_sel: nand_sel {
 };
 
 &qspi {
+	status = "okay";
 	bspi-sel = <0>;
 	flash: m25p80@0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index 4e106ce1384a..f2468bed2808 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -142,6 +142,7 @@ &sata_phy0 {
 };
 
 &qspi {
+	status = "okay";
 	bspi-sel = <0>;
 	flash: m25p80@0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 3a62d2d90a18..c26849304bc7 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -149,6 +149,7 @@ nand_sel: nand_sel {
 };
 
 &qspi {
+	status = "okay";
 	bspi-sel = <0>;
 	flash: m25p80@0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index d331c0a4e6b6..b7b136c862a8 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -153,6 +153,7 @@ &pwm {
 };
 
 &qspi {
+	status = "okay";
 	bspi-sel = <0>;
 	flash: m25p80@0 {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index 7cfb48fb48ba..6b57530a3964 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -138,6 +138,7 @@ nand_sel: nand_sel {
 };
 
 &qspi {
+	status = "okay";
 	bspi-sel = <0>;
 	flash: m25p80@0 {
 		#address-cells = <1>;
-- 
2.26.3

