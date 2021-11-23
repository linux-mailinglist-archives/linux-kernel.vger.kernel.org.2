Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD64F45A068
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhKWKm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235534AbhKWKmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:42:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DCD660F26;
        Tue, 23 Nov 2021 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637663956;
        bh=KaeAcTq7ryoOJczj2oukkolt/mq/dGtSGMOihhOSsgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Umg1Em8Wfwc9efuAbLpMoG2beO8b33pHWMmIKC1hYM0ej/vTnxwQZUMllzFAypXWe
         VV6UndPamtDgfjtqFCGVlP0brN9sBn6N390KQi76YFJbzS2UHIDlwbZBnIIxKD7V9C
         FxdpeKuONESMpkKYq2Okbn8vnsnx0s09pqHuOaPwNCwgTaJFhX8SltIL9TzzLJcpDe
         MK9NIR/QtjxwP4h02nwLp4Tz0GWdCZwkbTdTBHiRmCIFMBUAv2I9lpkAiU0K8fJ8HP
         NjuPXw2HEfW1AHXlnfMK5m5JZdotIWV+3jCybGc3wfm23/OtfZXGF4q7giMKqSYhJw
         P9kru6xYrCzJw==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
Date:   Tue, 23 Nov 2021 12:39:07 +0200
Message-Id: <20211123103908.14220-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123103908.14220-1-rogerq@kernel.org>
References: <20211123103908.14220-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPMC is a unified memory controller dedicated for interfacing
with external memory devices like
  - Asynchronous SRAM-like memories and ASICs
  - Asynchronous, synchronous, and page mode burst NOR flash
  - NAND flash
  - Pseudo-SRAM devices

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5ad638b95ffc..7fdd1789568a 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1253,4 +1253,23 @@
 			bus_freq = <1000000>;
 		};
 	};
+
+	gpmc0: memory-controller@3b000000 {
+		compatible = "ti,am64-gpmc";
+		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 80 0>;
+		clock-names = "fck";
+		reg = <0x00 0x03b000000 0x00 0x2000>,
+		      <0x00 0x050000000 0x00 0x7FFFFFF>;
+		reg-names = "cfg", "data";
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		gpmc,num-cs = <3>;
+		gpmc,num-waitpins = <2>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
2.17.1

