Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5841DA62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348276AbhI3NAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:00:05 -0400
Received: from mail.fris.de ([116.203.77.234]:49876 "EHLO mail.fris.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351198AbhI3NAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:00:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 580CBBFC98;
        Thu, 30 Sep 2021 14:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1633006698; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=RoYg2mtwmpS6pGDAzqDwcgJ0Y2vM5ESAXZX7mWKK/XA=;
        b=II5Uy9tIOdHFss5EorJQ1vI7cysDIzXbQRUb/5NlIWiLWeCuhO0oh7YOGtDeivd57B+2R+
        1MYAkfzGxiy6+rUrJGRqEPU/IlavjL7rNtI2qrJYQwEkXRpDu1YoScmXgHE/WIiVA25XYo
        Yqnmx5hObXBLRYyVDI1v32Z6HnN5uykjqvV8+DVK+/hmeuSeFnvQg0ZyC2aRd2QJuZz3hy
        ilYhxjg3oXCOo8wzCOKrW5fLPVM4Qzxb+VWtwO4D9Sv2hAFdQqK0bBFZJh0fpycjTQhKHv
        lZBZ06f7V2wgXvBvydxiqWrvh+1De7Sp7UCJOgrIPHFHSFsfNVsyHeo3kTZIQQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 3/3] arm64: dts: imx8mm-kontron: Add ethernet PHY LED modes
Date:   Thu, 30 Sep 2021 14:57:45 +0200
Message-Id: <20210930125747.2511954-3-frieder@fris.de>
In-Reply-To: <20210930125747.2511954-1-frieder@fris.de>
References: <20210930125747.2511954-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This sets the LED modes for the gigabit ethernet PHY to match the ones
of the 100M USB ethernet.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index d17abb515835..9650bc378ba9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "imx8mm-kontron-n801x-som.dtsi"
+#include <dt-bindings/net/mscc-phy-vsc8531.h>
 
 / {
 	model = "Kontron i.MX8MM N801X S";
@@ -120,10 +121,14 @@ mdio {
 		#size-cells = <0>;
 
 		ethphy: ethernet-phy@0 {
+			compatible = "ethernet-phy-id0007.0570";
 			reg = <0>;
 			reset-assert-us = <100>;
 			reset-deassert-us = <100>;
 			reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
+			vsc8531,led-0-mode = <VSC8531_LINK_100_1000_ACTIVITY>;
+			vsc8531,led-1-mode = <VSC8531_LINK_ACTIVITY>;
+			vsc8531,led-0-combine-disable;
 		};
 	};
 };
-- 
2.33.0

