Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3836F07E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 21:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhD2TZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhD2TYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:24:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFEC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:23:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k14so18109185wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZR6yJJg0IBSnPE9su+AvonxGsm8ZfFFCm7ShdjTwvQ=;
        b=ssmtpDvjIDmJyk5nxi7ilK1rS/PfcgPrdlPqB0yDXDfix4oLBHhspiB1cA0BxZFHL0
         fzl19sp6iG2WIJfo8AcYmKD7PD9H/xhA9jFXuIW5GC9Nb64iN4pSa/+omhb1qzEL+JDn
         e9BGy30ocZBmOQ95/onlHVbXHHgr9BQ6B3Efah0h2d18SWOUxZ5i5lBIpvtn2uhkU3Sj
         YJSDBSqP+Hh6NS8/xCYDWXtVPlRXdKkxpfPkYxs6TKCt+fS9G724Z99u3LwGxIY51Xt0
         YfqGe3RKRw+J45fwUwdg8qQzy/4K28eD2P785rjIwWXGSzT7LSMuzTWWbww/tdwXRTGG
         g0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZR6yJJg0IBSnPE9su+AvonxGsm8ZfFFCm7ShdjTwvQ=;
        b=AlxKKQqT/aFny/9p984z+PuvDBNNaYggD2oeDRhuXhlHDRQzpdoWDKFI+zzbSxqERj
         65WS5s095u36xtw28lcoKMCKaGwH0IxAbSl60jc2VzUJkeY4IG7ZpTpmy6gb5HYSEoF3
         DILSdhNsD3slliIGenhrbWc+y+IzX5iz9RkBEJmGui6E9qQmAP2gIq3em7qqoODfhEFj
         Mjui9dzWsYqbT7+UAP9OO9uWOGuyJ4rxSK1lSO12+kkuIXJoueeQbUACzuo8NKtZ2hFQ
         a1GyaYjBbKg3YgcoaYpl1LlHQiYPWO+VxbCCaxBDJEoZkrBNXWTEYXgTR82o136bXaio
         3/Zg==
X-Gm-Message-State: AOAM530xyAOQ1jzmuJuDFz4Y355oZMGW7Y8cexDa+VkFcBn/Sq8F79lU
        0iSqDhia/ZElLBqsBlzulDdfQw==
X-Google-Smtp-Source: ABdhPJza9qioQpEDGVoOtJ96QdX0eM9IWtCXsQyzsWrrlvDYObClYYuO0Plmm5pjMypo0szdZ9lSNA==
X-Received: by 2002:adf:a316:: with SMTP id c22mr1513474wrb.202.1619724212082;
        Thu, 29 Apr 2021 12:23:32 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 61sm6708000wrm.52.2021.04.29.12.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 12:23:31 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] dt-bindings: net: Convert mdio-gpio to yaml
Date:   Thu, 29 Apr 2021 19:23:26 +0000
Message-Id: <20210429192326.1148440-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts net/mdio-gpio.txt to yaml

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- fixes yamllint warning about indent
- added maxItems 3

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
index 000000000000..70103ef17f53
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
+      gpios = <&qe_pio_a 11
+               &qe_pio_c 6>;
+      ethphy0: ethernet-phy@0 {
+        reg = <0>;
+      };
+    };
+...
-- 
2.26.3

