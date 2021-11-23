Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF0745A06A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhKWKmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235669AbhKWKm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:42:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8482C61053;
        Tue, 23 Nov 2021 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637663958;
        bh=fY89zJ/guTGALBmndzOZlRqfJJPer5NjthbMCjk09Bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XV74LlS8qWopqrA4Q2nECenASuVVdcFaC5PYKIOgGpZNLOovEOK0Yl6+IB2O+jcqw
         QCr0tdAyps29anK37MiiQgf+nJ20lRKzSFXOjtwv4RABP4AB+ceXzdVzSwCOo7EGQn
         /A6qjxHj2RVykANHysYc5r9w9Po0V8mc8CfjwYxDvbhw8Joa02yCJ48M1EVNSqi0D6
         3gIn1cKvPI2SpHqc4ZfCbL/H3/17uoyR3TCRx+7JK4WrquezmdYTDoFZb8p3tX3Rib
         be5UtgHoXVHPMm8Avjpy38htgOzdFLuRAHlpQYgmH6Rq9GUkN4J5MwVVjUpyObTwSU
         P+XFyTLusVJzQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
Date:   Tue, 23 Nov 2021 12:39:08 +0200
Message-Id: <20211123103908.14220-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123103908.14220-1-rogerq@kernel.org>
References: <20211123103908.14220-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELM module is used for GPMC NAND accesses for detecting
and correcting errors during reads due to NAND bitflips errors.

4-, 8-, and 16-bit error-correction levels are supported using
the BCH (Bose-ChaudhurI-Hocquenghem) algorithm.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 7fdd1789568a..340e6b2274c3 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1272,4 +1272,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	elm0: ecc@25010000 {
+		compatible = "ti,am3352-elm";
+		reg = <0x00 0x25010000 0x00 0x2000>;
+		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 54 0>;
+		clock-names = "fck";
+	};
 };
-- 
2.17.1

