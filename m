Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9133FC87A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhHaNle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhHaNlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:41:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E40C061760;
        Tue, 31 Aug 2021 06:40:28 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 857282224F;
        Tue, 31 Aug 2021 15:40:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630417224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c26NehuqcimpKT1j1bnc733TXJ2Zh9Gkb+sYGg6YF5A=;
        b=GAS+LoFTKtjLYf5ax67A3QWZygN87j0CH6i5KvEEzQwjLSgF371JEyHAvzmTEEVYxFdYYT
        KM+dnLyAtVeor0EGRz2PBsVz232546ORqR+cRMC8VMc26BDqjD6dOdKVJY5hjeW7mwn3Lm
        NFcs4fJM4McPCJVYaZyiL9IFLddM6Tk=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 5/7] arm64: dts: ls1028a: disable usb controller by default
Date:   Tue, 31 Aug 2021 15:40:11 +0200
Message-Id: <20210831134013.1625527-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831134013.1625527-1-michael@walle.cc>
References: <20210831134013.1625527-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the last devices which are enabled by default are the USB
controllers. Although the pins are not multi-function pins, some boards
might not use USB at all. Apply the "disabled-by-default" style also for
the USB controllers and enable the controllers in the actual device tree
of the boards.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts         | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts         | 5 +++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi            | 2 ++
 4 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index a92ecb331cdc..2c6266991c38 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -309,3 +309,11 @@ eeprom@50 {
 &lpuart1 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index bfd14b64567e..f36f87858aef 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -335,3 +335,11 @@ &sai1 {
 &sata {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index d7b527272500..b0967b987f8a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -287,6 +287,11 @@ &sata {
 	status = "okay";
 };
 
+&usb0 {
+	status = "okay";
+};
+
 &usb1 {
 	dr_mode = "otg";
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 876dea668a90..c10c84d9495d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -585,6 +585,7 @@ usb0: usb@3100000 {
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			status = "disabled";
 		};
 
 		usb1: usb@3110000 {
@@ -595,6 +596,7 @@ usb1: usb@3110000 {
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			status = "disabled";
 		};
 
 		sata: sata@3200000 {
-- 
2.30.2

