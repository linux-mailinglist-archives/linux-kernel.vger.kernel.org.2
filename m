Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DBB324D38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhBYJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:52:18 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47667 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbhBYJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614246698; x=1645782698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNoFr4Rzb5ZvCVXn33z1SjDCgMcKIqCrQjEL0ZRl/rs=;
  b=c4YvS8wlrIQlEr7S4qtop3LunDrfCOX45D7m+QqaXpxiuPdIXZ5W0jWF
   G4hNi3WVGBWywj5IydD+7gTXfT/RSU0TUBIObiklpPtAOGdicjeudKPAB
   FO1GoydCtTDtcAhAuUcBp77kIG23F40MxbbcQhWehMSA3YuSWfUNGJGfe
   uMnpQflVvmMnYr6mSySoiJY9w8hv3RnsF38LYrKHOSbKjt0jC1wUZpUir
   R2K1KjyVf3tIxNe9HeGiixJzPQHyXFSEPu4n25rWUmFhvm0UItVPP1bQb
   5b/l/1skHnnd5ri/uuF+lenk9xPH02Uvf80zJ3cBtAmuZ4ZH7WCi7hwQn
   w==;
IronPort-SDR: bG86HA0kGMCUY37hKoIbbSmqddPC0E0x2JAU8t99R4NvtcmipZrWJXn8zyjEdkETHh3WwSB485
 F+yYLIi9HaXRPci4+XRdlIm3es1ytoKN762/r4QUQcT6oeeM0CTIUi6Hr6wEVh34v7lfnpPlb2
 Ft/Dc3pSLmOmQQLi2e5OTOjgZ1Kb4L+bmUJZG4t/0J/yWj7jqp/EQ/M4546dqpqgNWDp5keDBX
 pl0jWs0UAXXRxHN4BD/jTH6nDLnPzzH/+blvIf90OUJsec/A+a95clxs7rA7+rypy6GCuGJJ1T
 CKg=
X-IronPort-AV: E=Sophos;i="5.81,205,1610434800"; 
   d="scan'208";a="116583080"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2021 02:50:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 02:50:22 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 25 Feb 2021 02:50:20 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v6 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Thu, 25 Feb 2021 10:50:05 +0100
Message-ID: <20210225095005.1510846-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225095005.1510846-1-steen.hegelund@microchip.com>
References: <20210225095005.1510846-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides reset driver support for the Microchip Sparx5 PCB134 and
PCB135 reference boards.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 380281f312d8..dc3ada5cf9fc 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -132,9 +132,12 @@ mux: mux-controller {
 			};
 		};
 
-		reset@611010008 {
-			compatible = "microchip,sparx5-chip-reset";
+		reset: reset-controller@611010008 {
+			compatible = "microchip,sparx5-switch-reset";
 			reg = <0x6 0x11010008 0x4>;
+			reg-names = "gcb";
+			#reset-cells = <1>;
+			cpu-syscon = <&cpu_ctrl>;
 		};
 
 		uart0: serial@600100000 {
-- 
2.30.0

