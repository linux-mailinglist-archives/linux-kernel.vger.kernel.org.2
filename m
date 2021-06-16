Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43E3AA07E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhFPP6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhFPP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:57:31 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4484C061760;
        Wed, 16 Jun 2021 08:55:19 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E811F22287;
        Wed, 16 Jun 2021 17:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623858917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQoZAPUkI2dNoVO5Lz675tmVta2Sc7zwbvp/wMn9YW8=;
        b=AQye+zOTLaYxk9bEAX5GDAE0JH546N/CMReeQ0bE8G/yqC06y2qYwKNn7sVBIwIx1M0JHz
        e5nwF2PJ1mWhWyOl7NQbFNDw/BCIjPR4TZjTn/keNsxk5KbU++3Vy6sbn6B79Vqp7vzdbp
        rVl0JLq8d0IoJU62FEvtvepjXW6B65Q=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/3] ARM: dts: zynq: add NAND flash controller node
Date:   Wed, 16 Jun 2021 17:54:36 +0200
Message-Id: <20210616155437.27378-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210616155437.27378-1-michael@walle.cc>
References: <20210616155437.27378-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, a driver for the ARM Primecell PL35x static memory controller
(including NAND controller) was added in linux. Add the corresponding
device tree node.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index df9ad831cf05..47c2a4b14c06 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -252,6 +252,27 @@
 			#size-cells = <0>;
 		};
 
+		smcc: memory-controller@e000e000 {
+			compatible = "arm,pl353-smc-r2p1", "arm,primecell";
+			reg = <0xe000e000 0x0001000>;
+			status = "disabled";
+			clock-names = "memclk", "apb_pclk";
+			clocks = <&clkc 11>, <&clkc 44>;
+			ranges = <0x0 0x0 0xe1000000 0x1000000 /* Nand CS region */
+				  0x1 0x0 0xe2000000 0x2000000 /* SRAM/NOR CS0 region */
+				  0x2 0x0 0xe4000000 0x2000000>; /* SRAM/NOR CS1 region */
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+			nfc0: nand-controller@0,0 {
+				compatible = "arm,pl353-nand-r2p1";
+				reg = <0 0 0x1000000>;
+				status = "disabled";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		sdhci0: mmc@e0100000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
-- 
2.20.1

