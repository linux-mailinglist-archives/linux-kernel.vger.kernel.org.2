Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5273E2861
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbhHFKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244947AbhHFKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:14:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF2C06179B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:14:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i6so12379890edu.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FraMKiuwqRJEEp0VY/xE3q2Xu80ABlyGMu9aYVFQwIo=;
        b=AO0OcPI8g1krDcZz2jpbJ+cGIaFZnhskk4x3kVoCtCF6eX4Q7fCLkt+Nph+B/98N83
         6QZwj8G2vE6QlLB5c0dg20bABuf4F1PCYP8UAwBJDEdWQ+NzbDeiK2atXCXVdnENzad4
         5gk/hlKifSSdZ245dG1zMqfwc2Pc9U9JGNqAnm+xW3eES06lXOX4q0lBTxgV47WjtbZb
         eFu2cbwrU/2DE3uMTa+yS9TICN+crMnncUBcXnBYPNlgeQGEdA3z+WercjBe+LYaiMNd
         q+BS4FhzPs8/dtJyc+pKODrxsZLgJwM0izCJyduLWeD22JDCms+FD90jd3TMsS3kd15N
         Ylvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FraMKiuwqRJEEp0VY/xE3q2Xu80ABlyGMu9aYVFQwIo=;
        b=h2DiGvtwLzfaUd8YplyS9VkIb6GWtLsR+hpYL61TLNQv/kaoJzAIGICZDrpYif562B
         90hRHTXbs/ly7DdpgPrAqlamJiwX3l2AebkIF5BD4UtIj+Qkf3zkSDeCUNRJ/fCaV07a
         OfWaBcBDIgmT4pghbxifuuCJXsaCsOsJu/QuN0IiLjrXVS+FZtX03XbVlp3k/SLPfwmr
         hCkXgFmkIwnShOe+8U8hzrA9YNweYTPc7fNGSN79Czvn+TmuCM3OanIDkvlEqFXAgFVB
         87rGyVv5SuzJWS+Zgok+gcNvKiRQvsOSpYwlnOF0ZZM6X7m0CklMRolVkHfeCgPK4uAt
         xvCg==
X-Gm-Message-State: AOAM530kHZYXCTAx51Ho0B3F6ut/NCLB+bc8AT8y9nOQitkoNVg1ulIz
        nS1xSe57QB2lbVI4Ldfd16nRR53VRKsYAaBX
X-Google-Smtp-Source: ABdhPJyqklZ8NR5PP4B4PIOZAYBYEY38HFNg+eVeye0F9Qh9scqnA4dYFf2Ct/eFuyCmIzeONs25YQ==
X-Received: by 2002:a50:ed14:: with SMTP id j20mr11719765eds.323.1628244864494;
        Fri, 06 Aug 2021 03:14:24 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id bx11sm2725816ejb.107.2021.08.06.03.14.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Aug 2021 03:14:24 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: zynqmp: Wire psgtr for zc1751-xm013
Date:   Fri,  6 Aug 2021 12:14:23 +0200
Message-Id: <8c78625f08c16385a4798e0a62d20df7491ac00e.1628244860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add psgtr description for SATA and USB.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on https://lore.kernel.org/r/cover.1628244703.git.michal.simek@xilinx.com
---
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
index 4394ec3b6a23..381cc682cef9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -11,6 +11,7 @@
 
 #include "zynqmp.dtsi"
 #include "zynqmp-clk-ccf.dtsi"
+#include <dt-bindings/phy/phy.h>
 
 / {
 	model = "ZynqMP zc1751-xm017-dc3 RevA";
@@ -37,6 +38,18 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
+
+	clock_si5338_2: clk26 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	clock_si5338_3: clk125 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
 };
 
 &fpd_dma_chan1 {
@@ -116,6 +129,13 @@ &nand0 {
 	num-cs = <2>;
 };
 
+&psgtr {
+	status = "okay";
+	/* usb3, sata */
+	clocks = <&clock_si5338_2>, <&clock_si5338_3>;
+	clock-names = "ref2", "ref3";
+};
+
 &rtc {
 	status = "okay";
 };
@@ -131,6 +151,8 @@ &sata {
 	ceva,p1-comwake-params = /bits/ 8 <0x06 0x19 0x08 0x0E>;
 	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
 	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	phy-names = "sata-phy";
+	phys = <&psgtr 2 PHY_TYPE_SATA 0 3>;
 };
 
 &sdhci1 { /* emmc with some settings */
@@ -149,6 +171,8 @@ &uart1 {
 
 &usb0 {
 	status = "okay";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 0 PHY_TYPE_USB3 0 2>;
 };
 
 &dwc3_0 {
@@ -161,6 +185,8 @@ &dwc3_0 {
 /* ULPI SMSC USB3320 */
 &usb1 {
 	status = "okay";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 3 PHY_TYPE_USB3 1 2>;
 };
 
 &dwc3_1 {
-- 
2.32.0

