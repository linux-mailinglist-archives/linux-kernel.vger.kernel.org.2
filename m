Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA832BBDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358748AbhCCNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:02:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62731 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842876AbhCCIOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614759269; x=1646295269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3l9hEFDNzDkUJtdNsrVkuF+4J4G7EYWCBVDB3gq68X4=;
  b=yuZUoef4qpTQOSIY+gKoqba5VgMTQYmAaT2LDqkSYF2xngM891jkul6Z
   ZzTBsLTNIQc5qsjxHSbY9m8tt8KcOtM+OSw9a0ypJqM/Rp1Cw3GQ7MJEO
   7zTysVn+yU7/is0cKD0cGlMaESgNrgCfnhEsyFdDg6w+JFewh4nxT/GZS
   S+tOsXBB8WKBv96tGhfAwG+8PBlYcpMxzfgqizs9pE2+rcwgRplNtoy92
   kDaD1Ko9LkB9E3N+Yq2IUkqcWap9O0GfwBezXJbOEpq9BUMJCA+kGsSuO
   es1fc637iq6IP+nmeJWYBQjdTvBAv7AZgJbxFQd5Lsqxr+ZAa8biUOmzC
   Q==;
IronPort-SDR: iQYPVk9xanB4c2FbaocUi4c0evwkRflxIIbwFUGG3x8vCutk3HBetl/04nyQsAq1nECXADDnMJ
 P1AZc3bpYrD3duRhqIQ4E/MXFfL9Fnfaan4y1ApLRHk2jFNK6JF5Rfqgs/q3NBsBpQ/NAo52Bl
 fudmfx00yMLctWBqylaBeMHV/UfxqCeS2LJmmQSUMo8auf2hrpwXTmDTCFn1bcfdTZ4cSekYHs
 Oru8RtxWgLB9GDohnzmcrVYANBGomEEDgiZUOFdLcoChJV8xy2xbEjlEXuUVdlhfkHfdK9ew6N
 k2E=
X-IronPort-AV: E=Sophos;i="5.81,219,1610434800"; 
   d="scan'208";a="105779114"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2021 01:12:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 3 Mar 2021 01:12:11 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 3 Mar 2021 01:12:09 -0700
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
Subject: [PATCH v7 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Wed, 3 Mar 2021 09:11:58 +0100
Message-ID: <20210303081158.684532-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303081158.684532-1-steen.hegelund@microchip.com>
References: <20210303081158.684532-1-steen.hegelund@microchip.com>
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
2.30.1

