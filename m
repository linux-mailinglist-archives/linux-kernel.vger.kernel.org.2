Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7A331954
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhCHVXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:23:45 -0500
Received: from aposti.net ([89.234.176.197]:42958 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231300AbhCHVXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:23:15 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] dt-bindings/timer: ingenic: Add compatible strings for JZ4760(B)
Date:   Mon,  8 Mar 2021 21:23:00 +0000
Message-Id: <20210308212302.10288-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings to support the system timer, clocksource, OST,
watchdog and PWM blocks of the JZ4760 and JZ4760B SoCs.

Newer SoCs which behave like the JZ4760 or JZ4760B now see their
compatible string require a fallback compatible string that corresponds
to one of these two SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: - Fix indentation
        - Fix example not using correct compatible strings

 .../bindings/timer/ingenic,tcu.yaml           | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index 024bcad75101..8165df4599cf 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -20,6 +20,8 @@ select:
         enum:
           - ingenic,jz4740-tcu
           - ingenic,jz4725b-tcu
+          - ingenic,jz4760-tcu
+          - ingenic,jz4760b-tcu
           - ingenic,jz4770-tcu
           - ingenic,jz4780-tcu
           - ingenic,x1000-tcu
@@ -52,12 +54,15 @@ properties:
           - enum:
               - ingenic,jz4740-tcu
               - ingenic,jz4725b-tcu
-              - ingenic,jz4770-tcu
+              - ingenic,jz4760-tcu
               - ingenic,x1000-tcu
           - const: simple-mfd
       - items:
-          - const: ingenic,jz4780-tcu
-          - const: ingenic,jz4770-tcu
+          - enum:
+              - ingenic,jz4780-tcu
+              - ingenic,jz4770-tcu
+              - ingenic,jz4760b-tcu
+          - const: ingenic,jz4760-tcu
           - const: simple-mfd
 
   reg:
@@ -118,6 +123,8 @@ patternProperties:
           - items:
               - enum:
                   - ingenic,jz4770-watchdog
+                  - ingenic,jz4760b-watchdog
+                  - ingenic,jz4760-watchdog
                   - ingenic,jz4725b-watchdog
               - const: ingenic,jz4740-watchdog
 
@@ -147,6 +154,8 @@ patternProperties:
               - ingenic,jz4725b-pwm
           - items:
               - enum:
+                  - ingenic,jz4760-pwm
+                  - ingenic,jz4760b-pwm
                   - ingenic,jz4770-pwm
                   - ingenic,jz4780-pwm
               - const: ingenic,jz4740-pwm
@@ -183,10 +192,15 @@ patternProperties:
         oneOf:
           - enum:
               - ingenic,jz4725b-ost
-              - ingenic,jz4770-ost
+              - ingenic,jz4760b-ost
           - items:
-              - const: ingenic,jz4780-ost
-              - const: ingenic,jz4770-ost
+              - const: ingenic,jz4760-ost
+              - const: ingenic,jz4725b-ost
+          - items:
+              - enum:
+                  - ingenic,jz4780-ost
+                  - ingenic,jz4770-ost
+              - const: ingenic,jz4760b-ost
 
       reg:
         maxItems: 1
@@ -226,7 +240,7 @@ examples:
     #include <dt-bindings/clock/jz4770-cgu.h>
     #include <dt-bindings/clock/ingenic,tcu.h>
     tcu: timer@10002000 {
-      compatible = "ingenic,jz4770-tcu", "simple-mfd";
+      compatible = "ingenic,jz4770-tcu", "ingenic,jz4760-tcu", "simple-mfd";
       reg = <0x10002000 0x1000>;
       #address-cells = <1>;
       #size-cells = <1>;
@@ -272,7 +286,7 @@ examples:
       };
 
       ost: timer@e0 {
-        compatible = "ingenic,jz4770-ost";
+        compatible = "ingenic,jz4770-ost", "ingenic,jz4760b-ost";
         reg = <0xe0 0x20>;
 
         clocks = <&tcu TCU_CLK_OST>;
-- 
2.30.1

