Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C83897FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhESUhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhESUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:37:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:35:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p7so11623190wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHNW49TmyZaaRrFWUNtWXt+ZlgbUc2SAp8tKEH8gOoY=;
        b=o3bt4GjXWraSnEy+C9ViC9P14StdEqRMztBo8yt4KXqmgIKa2B6FGstQuPjVjMMwMC
         ThLdrtuT6oddEi3gI/axnzz1d4S3kdhZUOYnTHI1feyuxLVsVdX3b/Ti8ZFg5x9nXnRI
         Mm098zmlkuvhFQBxFQZAoj/JDGDVQpLaz0NRg6qt0Hf2O+32LYqLrKvW9B4gwOeum6Br
         H/5TsIGVkpRlCXsjcjAU5/+BN+C9hHc+SkEMhkX7cFPp3iVX9cT0GKv6yknOKNQKTZ7x
         cKWY1POEUVL/Ux4cNd6q3BrXRDF2R1D0Ahm/dKlucEECJN2XxwFGprlp3w+ezADMMeiq
         hwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHNW49TmyZaaRrFWUNtWXt+ZlgbUc2SAp8tKEH8gOoY=;
        b=YiXo0izaYdjCFVfha4CTU0i8j1FsDB/TYmcgM4iIISc2yEaTb4fXkm6bzkcwJFcw92
         slxyDurXEHteDi6NqYTmV1K+faICCuAyrBIKPbg8dZE3R1K/2Fc8f0RaSSqF9xhbnFA/
         NFWl1rmY/m/n5GTN4rZfimyUhl0k5YjNjqNjTkwkJf+4xchc9Bw0vqlUr9jADIXBUek4
         AVaIGrmvwnvkE/SG+vGOkXksgqTGsT0/8wKLW3+o+MEfpIs5ylMjgkryXTgJdqdFoBNH
         NiGp5SMdU/zTkNkC3VOuk1QdHIoOpqAsvv2D68w1qvtNFi1JgnhGnYzgqXsYS0uHOuxY
         lT3A==
X-Gm-Message-State: AOAM532E63vEyWpiFuiB11SNoDValKnLtJjJ+1jCQaID/U+UkMlSwWFr
        +5Z71Sv0JkULXvsfsdsxYR7R8Q==
X-Google-Smtp-Source: ABdhPJzAHcq/7ZxKFF4pjEJZP86gjjMy+kdD+NQ/hRlf+/06xeRDG7FxZP7QHAYkDFynteVfB8HWjA==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr801711wrv.164.1621456553771;
        Wed, 19 May 2021 13:35:53 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y20sm7531918wmi.0.2021.05.19.13.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:35:53 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@linux.ie, daniel@ffwll.ch, linus.walleij@linaro.org,
        robh+dt@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 1/3] dt-bindings: display: convert faraday,tve200
Date:   Wed, 19 May 2021 20:35:45 +0000
Message-Id: <20210519203547.837237-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts display/faraday,tve200.txt to yaml.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- added two subsequent patchs fixing issue found when converting
- fixed all issues reported by Rob Herring
 .../bindings/display/faraday,tve200.txt       | 54 ---------------
 .../bindings/display/faraday,tve200.yaml      | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.txt
 create mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.yaml

diff --git a/Documentation/devicetree/bindings/display/faraday,tve200.txt b/Documentation/devicetree/bindings/display/faraday,tve200.txt
deleted file mode 100644
index 82e3bc0b7485..000000000000
--- a/Documentation/devicetree/bindings/display/faraday,tve200.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-* Faraday TV Encoder TVE200
-
-Required properties:
-
-- compatible: must be one of:
-	"faraday,tve200"
-	"cortina,gemini-tvc", "faraday,tve200"
-
-- reg: base address and size of the control registers block
-
-- interrupts: contains an interrupt specifier for the interrupt
-	line from the TVE200
-
-- clock-names: should contain "PCLK" for the clock line clocking the
-	silicon and "TVE" for the 27MHz clock to the video driver
-
-- clocks: contains phandle and clock specifier pairs for the entries
-	in the clock-names property. See
-	Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Optional properties:
-
-- resets: contains the reset line phandle for the block
-
-Required sub-nodes:
-
-- port: describes LCD panel signals, following the common binding
-	for video transmitter interfaces; see
-	Documentation/devicetree/bindings/media/video-interfaces.txt
-	This port should have the properties:
-	reg = <0>;
-	It should have one endpoint connected to a remote endpoint where
-	the display is connected.
-
-Example:
-
-display-controller@6a000000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "faraday,tve200";
-	reg = <0x6a000000 0x1000>;
-	interrupts = <13 IRQ_TYPE_EDGE_RISING>;
-	resets = <&syscon GEMINI_RESET_TVC>;
-	clocks = <&syscon GEMINI_CLK_GATE_TVC>,
-		 <&syscon GEMINI_CLK_TVC>;
-	clock-names = "PCLK", "TVE";
-
-	port@0 {
-		reg = <0>;
-		display_out: endpoint {
-			remote-endpoint = <&panel_in>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/faraday,tve200.yaml b/Documentation/devicetree/bindings/display/faraday,tve200.yaml
new file mode 100644
index 000000000000..e2ee77767321
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/faraday,tve200.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/faraday,tve200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday TV Encoder TVE200
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,tve200
+      - items:
+          - const: cortina,gemini-tvc
+          - const: faraday,tve200
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: PCLK
+      - const: TVE
+
+  clocks:
+    minItems: 2
+
+  resets:
+    minItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/reset/cortina,gemini-reset.h>
+    display-controller@6a000000 {
+      compatible = "faraday,tve200";
+      reg = <0x6a000000 0x1000>;
+      interrupts = <13 IRQ_TYPE_EDGE_RISING>;
+      resets = <&syscon GEMINI_RESET_TVC>;
+      clocks = <&syscon GEMINI_CLK_GATE_TVC>,
+               <&syscon GEMINI_CLK_TVC>;
+      clock-names = "PCLK", "TVE";
+
+      port {
+        display_out: endpoint {
+          remote-endpoint = <&panel_in>;
+        };
+      };
+    };
-- 
2.26.3

