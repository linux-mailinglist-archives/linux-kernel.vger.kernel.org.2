Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0881737007B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhD3Saj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhD3Sai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:30:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F01C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:29:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so2207907wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q48xkUDL5m0902EezKV/zpsj/dv/vtHcGNdT7vBOQFE=;
        b=eqXDxMpbRa9jxeP0xddMNS/VK8JhDK1dDygXovckB/aNwJHyMlZZ02qEl2n+hmR34a
         dVC0bJL1Y88pO2Y6ztJdct1gVYbQMOvr737SYFvHvAP21HnK2GmbDMY/ENHn9xqyRqtD
         2c/04x0Fimpr0MnQgWwdDbthYxUJhNwqFGdc5MWNyFu1JHkDuJveWa/Ym6x5TBPLqMnR
         ipxbkHmldGzDmcPlV9ENRsII59r5RLj9/FAbk8cIGB1FDq5nJm+x9wTEeT92WeJli5hL
         F58PUrNLEn7ZFC0HBri4xhR6xQDyFys/woJYehoB0VN/mO/iPML/+BrZunq5ugWw6Xjr
         j/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q48xkUDL5m0902EezKV/zpsj/dv/vtHcGNdT7vBOQFE=;
        b=GQuSyVQUdpEWHfOChNMhoJi8QV0hWBncq4Ea+EZxHvRKa8vbQgHbSG1aQEX6pw7NS6
         xjrBXwvENnBjnbBwzJv7xCDZTlXetliYXNvlbM/iGSZUboTx6X96nKqBwgYTE9HndVa9
         CjSYbfG5ldwnmzcVc1SpdnB2q9ya175xchimaTHrSf+/3l1PzDsOuYH1u+l9hdY3Ghy1
         98OEJtV8rakWB59C1vqhqNjwVlpCbIz/C88UMSHOjlaRbYFPZXPsHzEmrC/sea2f/cFv
         VQEpAUXCftkwdsZKk3Kq9VPb1NVww+M+06vBuISihqu0uFW5jeYd061037SKTzf1WTlK
         NmDg==
X-Gm-Message-State: AOAM532ccPHCx3NSxt7M/2XIg7Fj9j1gSBaTZ7/f3ob/VskBb6SFw3s3
        M7a06Dy2vG5KYLCdEnLDsP30SQ==
X-Google-Smtp-Source: ABdhPJzMFnNGAoNGZMtImg3i628rWxsx0wXh6Crp1xU/mWChiYzXhXro1NPHLaUNpQKhB9itUvxxlA==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr3857911wmi.77.1619807388561;
        Fri, 30 Apr 2021 11:29:48 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z7sm3059783wrl.11.2021.04.30.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 11:29:47 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3] dt-bindings: net: Convert mdio-gpio to yaml
Date:   Fri, 30 Apr 2021 18:29:41 +0000
Message-Id: <20210430182941.915101-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts net/mdio-gpio.txt to yaml

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- fixes yamllint warning about indent
- added maxItems 3

Changes since v2:
- fixed example (gpios need 2 entries)

 .../devicetree/bindings/net/mdio-gpio.txt     | 27 ---------
 .../devicetree/bindings/net/mdio-gpio.yaml    | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/mdio-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-gpio.yaml

diff --git a/Documentation/devicetree/bindings/net/mdio-gpio.txt b/Documentation/devicetree/bindings/net/mdio-gpio.txt
deleted file mode 100644
index 4d91a36c5cf5..000000000000
--- a/Documentation/devicetree/bindings/net/mdio-gpio.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-MDIO on GPIOs
-
-Currently defined compatibles:
-- virtual,gpio-mdio
-- microchip,mdio-smi0
-
-MDC and MDIO lines connected to GPIO controllers are listed in the
-gpios property as described in section VIII.1 in the following order:
-
-MDC, MDIO.
-
-Note: Each gpio-mdio bus should have an alias correctly numbered in "aliases"
-node.
-
-Example:
-
-aliases {
-	mdio-gpio0 = &mdio0;
-};
-
-mdio0: mdio {
-	compatible = "virtual,mdio-gpio";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	gpios = <&qe_pio_a 11
-		 &qe_pio_c 6>;
-};
diff --git a/Documentation/devicetree/bindings/net/mdio-gpio.yaml b/Documentation/devicetree/bindings/net/mdio-gpio.yaml
new file mode 100644
index 000000000000..183cf248d597
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mdio-gpio.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/mdio-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MDIO on GPIOs
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Florian Fainelli <f.fainelli@gmail.com>
+  - Heiner Kallweit <hkallweit1@gmail.com>
+
+allOf:
+  - $ref: "mdio.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - virtual,mdio-gpio
+      - microchip,mdio-smi0
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  gpios:
+    minItems: 2
+    maxItems: 3
+    description: |
+      MDC and MDIO lines connected to GPIO controllers are listed in
+      the gpios property as described in section VIII.1 in the
+      following order: MDC, MDIO.
+
+#Note: Each gpio-mdio bus should have an alias correctly numbered in "aliases"
+#node.
+unevaluatedProperties: false
+
+examples:
+  - |
+    aliases {
+        mdio-gpio0 = &mdio0;
+    };
+
+    mdio0: mdio {
+      compatible = "virtual,mdio-gpio";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      gpios = <&qe_pio_a 11>,
+              <&qe_pio_c 6>;
+      ethphy0: ethernet-phy@0 {
+        reg = <0>;
+      };
+    };
+...
-- 
2.26.3

