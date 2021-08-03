Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A633DE733
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhHCHaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhHCHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:30:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F2C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 00:30:05 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mAosC-00051A-OX; Tue, 03 Aug 2021 09:30:00 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mAosB-0001GX-OK; Tue, 03 Aug 2021 09:29:59 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v1] dt-bindings: timer: fsl,imxgpt: add optional osc_per clock
Date:   Tue,  3 Aug 2021 09:29:58 +0200
Message-Id: <20210803072958.4815-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional osc_per and fix dts validation warnings on imx6 SoCs.

Fixes: df8cad689eae ("dt-bindings: timer: Convert i.MX GPT to json-schema")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/timer/fsl,imxgpt.yaml   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index a4f51f46b7a1..e496dd9f4988 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -43,11 +43,15 @@ properties:
     items:
       - description: SoC GPT ipg clock
       - description: SoC GPT per clock
+      - description: optional SoC GPT oscillator
+    minItems: 2
 
   clock-names:
     items:
       - const: ipg
       - const: per
+      - const: osc_per
+    minItems: 2
 
 required:
   - compatible
@@ -70,3 +74,16 @@ examples:
                  <&clks IMX27_CLK_PER1_GATE>;
         clock-names = "ipg", "per";
     };
+
+  - |
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+
+    timer@2098000 {
+        compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
+        reg = <0x02098000 0x4000>;
+        interrupts = <26>;
+        clocks = <&clks IMX6QDL_CLK_GPT_IPG>,
+                 <&clks IMX6QDL_CLK_GPT_IPG_PER>,
+                 <&clks IMX6QDL_CLK_GPT_3M>;
+        clock-names = "ipg", "per", "osc_per";
+    };
-- 
2.30.2

