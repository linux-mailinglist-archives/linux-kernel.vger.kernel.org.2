Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109273FD30E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbhIAFk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:40:56 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43051 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242046AbhIAFkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:40:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1A5585804EC;
        Wed,  1 Sep 2021 01:39:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Sep 2021 01:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=xNxl1EEs8ZC8t
        hhUYggA/mA77asD+KQkI79V0Cgwm9k=; b=rb6ZY5b0GyM3AmHeW555IzXGQeEyJ
        tRwWIupsqdj/FJgzo9vawl1Wr0IepLnC4bjsCjPQE39TA9uwHWBvDvQHHyINpNF/
        jrEGH5/OS3zQFPNOFA+UB1AaNgqrGltfdS1zQmOXQ3fDk34BXJdM5Ea8JEY0aSo7
        YmsK5wTYwbeARfCyzqaAFi+VpILz3hI6k/SSW2eQeJlOva2fOrGCxeza+qj7VKQ5
        Ol2s0fDH0n4urAcBp1Gk38wup+E2lkHibuZQMbBGpQW4RXiMQt+8Z+IRS3PHHROQ
        RnRAQrhUyC/YSpWRk92rer2xEegST8gJar9zsuNAIHHS4MXwbh8gKsbGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xNxl1EEs8ZC8thhUYggA/mA77asD+KQkI79V0Cgwm9k=; b=RI1dDRfS
        jDayyk9cWjw/fbRuwpz7Ux4OPsClzrV8SZXOeVoxBOr7ar0RrcaLyya86NMThEVx
        L1V7LVmlog9t8uKvGFa4wPuksx109mDdFiiAu/Yc/zaRA5CmVRrsYtU9JEwOBwov
        zXMOxpzgxmFE8aoZlIZwkDQoVG+Vss/slVyRe+0RNm1fi83jIBYb17aFTsxsb7tE
        BPH9Bqm18bFk/a7ORV0UF4I5wD6G/jD3omQWRfEIyID8cmY7mszfAjoGFv4lVxQ2
        mY7Q+3toYCDBvV5FeypJQ+4l0cicsT1YPxZ1nXGBw3IXXLijILsvECU5N+hrd+fB
        SqSHMIVyES8M4A==
X-ME-Sender: <xms:KxIvYQ-k6F3nabT6RSkHmLMaXyS1Y2FQvKhmxbzqPPSqjJw79e-cRg>
    <xme:KxIvYYtwPYcNGHyjSOS-aP3axo1dxjX37upuz9vyYR7ib_VaAWKCJkmhWAC99wz88
    W11kwzRbGJv4WR_-w>
X-ME-Received: <xmr:KxIvYWAlygl1mrfZsTA8V5dDg9IlwBHyy1lP8lnjq08sEj0Zr5hKz9nJwEjtrbOlrCg6-cCM-73gP-wslxq_nOb0uLo7de3jYog1xUO2fx8Oyr5IAN_BtYCK9Qis_r3--Bf8FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:KxIvYQeWCcJtMt8AJsmoEHUnRqx5YHfq747MR5qHqePMH7RKGLKktA>
    <xmx:KxIvYVPvltfTQO9LJWRckM3JP_q-UESighBfUKCEh5g3HPIdUMdYdQ>
    <xmx:KxIvYakUs4EWKZG5wt4i9SxY51fKZwhQ8YsqbQlja-XH0mUu_UETTQ>
    <xmx:LBIvYWH8Mw04PUv8RGRc6r88UXofQ7YFS2ZaqeKl_sywjc3vDcwivw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:39:55 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 1/7] dt-bindings: rtc: sun6i: Add H616 and R329 compatibles
Date:   Wed,  1 Sep 2021 00:39:45 -0500
Message-Id: <20210901053951.60952-2-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901053951.60952-1-samuel@sholland.org>
References: <20210901053951.60952-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For these new SoCs, start requiring a complete list of input clocks.

For H616, this means bus, hosc, and pll-32k. For R329, this means ahb,
bus, and hosc; and optionally ext-osc32k.

I'm not sure how to best represent this in the binding...

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 55 +++++++++++++++++--
 include/dt-bindings/clock/sun50i-rtc.h        | 12 ++++
 2 files changed, 61 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/clock/sun50i-rtc.h

diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
index beeb90e55727..3e085db1294f 100644
--- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
@@ -26,6 +26,8 @@ properties:
           - const: allwinner,sun50i-a64-rtc
           - const: allwinner,sun8i-h3-rtc
       - const: allwinner,sun50i-h6-rtc
+      - const: allwinner,sun50i-h616-rtc
+      - const: allwinner,sun50i-r329-rtc
 
   reg:
     maxItems: 1
@@ -37,7 +39,24 @@ properties:
       - description: RTC Alarm 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      - anyOf:
+          - const: ahb
+            description: AHB parent for SPI bus clock
+          - const: bus
+            description: AHB/APB bus clock for register access
+          - const: ext-osc32k
+            description: External 32768 Hz oscillator input
+          - const: hosc
+            description: 24 MHz oscillator input
+          - const: pll-32k
+            description: 32 kHz clock divided from a PLL
 
   clock-output-names:
     minItems: 1
@@ -85,6 +104,9 @@ allOf:
             enum:
               - allwinner,sun8i-h3-rtc
               - allwinner,sun50i-h5-rtc
+              - allwinner,sun50i-h6-rtc
+              - allwinner,sun50i-h616-rtc
+              - allwinner,sun50i-r329-rtc
 
     then:
       properties:
@@ -96,13 +118,35 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun50i-h6-rtc
+            enum:
+              - allwinner,sun50i-h616-rtc
+              - allwinner,sun50i-r329-rtc
 
     then:
+      clocks:
+        minItems: 3 # bus, hosc, and (pll-32k [H616] or ahb [R329])
+
+      clock-names:
+        minItems: 3
+
+      required:
+        - clock-names
+
+    else:
+      required:
+        - clock-output-names
+
+  - if:
+      properties: clock-names
+
+    then:
+      required:
+        - clocks # hosc is required
+
+    else:
       properties:
-        clock-output-names:
-          minItems: 3
-          maxItems: 3
+        clocks:
+          maxItems: 1 # only ext-osc32k is allowed
 
   - if:
       properties:
@@ -127,7 +171,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - clock-output-names
 
 additionalProperties: false
 
diff --git a/include/dt-bindings/clock/sun50i-rtc.h b/include/dt-bindings/clock/sun50i-rtc.h
new file mode 100644
index 000000000000..d45e3ff4e105
--- /dev/null
+++ b/include/dt-bindings/clock/sun50i-rtc.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_CLK_SUN50I_RTC_CCU_H_
+#define _DT_BINDINGS_CLK_SUN50I_RTC_CCU_H_
+
+#define CLK_OSC32K		0
+#define CLK_OSC32K_FANOUT	1
+#define CLK_IOSC		2
+
+#define CLK_RTC_SPI		8
+
+#endif /* _DT_BINDINGS_CLK_SUN50I_RTC_CCU_H_ */
-- 
2.31.1

