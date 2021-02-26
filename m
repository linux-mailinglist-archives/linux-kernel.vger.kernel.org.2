Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1D32621B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBZLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZLqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:46:50 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE56C061574;
        Fri, 26 Feb 2021 03:46:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d3so13360924lfg.10;
        Fri, 26 Feb 2021 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJzFAcZoyFgWGexvAUtbeRDKN1VQtp+a3ZPt/hRSa30=;
        b=J5Qru1t+nED43amQyWlLpye37AYa7xHzaqS/ZflyVx0c3z14Z59rja+ZR/CjrgmxrN
         XdW2TVGaLHgLs+4JjCDZKxtn/de6QiwTZBxarkSc3PbKlnExuxX30yUb4gCynHWCSEvW
         KIwxqCLrAa4JoHsJuoCMP1h6eySW6aHYo94wm/ZfxOf05LPQG/dh06FUwrxkGbRH/oMl
         51g1T1rDi0rax0Qn2KYV8fmbzV818SkzV/KBx03Yc4ToLybDnwjRTTKntDMj8TWwqBih
         CnXZCJ6VIDLTa/wMixNiz/NwZ+2JORdtNgktFNYAo32nLWOUhyNYEwUjb5sJQuspSnYj
         6s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJzFAcZoyFgWGexvAUtbeRDKN1VQtp+a3ZPt/hRSa30=;
        b=qGYIQlCPb2O7J+uS3ulsRCDhOFtz05ZhFFiFzKtukNT1JVxBsS8k23w41IEFS47wZG
         DXnMcYjcimZyHpKCFdalpAx0wr7DxymGaWPp73I7Io2dmY7LhXQhkodL7B6Y2UKe4Xt+
         WAduZEyIoC1r+vI878OFYNU94nLPcS+ZiuQNblMXtPY79p5cyIAAGj4xk5hK7c8fZgID
         t7oq5YXm+C1DMeNgFwugzL5dei/+htq5N0/iFn+z1oY2sdsYs7TODMOVh1jdcMXkcHYK
         RbUhCJ4BTGyGPqa/qViwj2pEyS0XSHzkrs6iquQej7IDpBZWcbEu+FUNCLHc5QR2KpUg
         +JVA==
X-Gm-Message-State: AOAM530S9vK57zD4XegFUmE5HrUfLB/b6gYx1nDocfGAKJELx7wVTIWN
        TrCb9N8Nppnc5BN3riF9kMHp1Cl4aYQ=
X-Google-Smtp-Source: ABdhPJyeH+1Qd6GJA0xhpdRd9vZc0K58Jr7ZZCQdqzueYDVVw2326pzilWupr7YW0QSWLx0NO90NNA==
X-Received: by 2002:ac2:520b:: with SMTP id a11mr1570009lfl.483.1614339968892;
        Fri, 26 Feb 2021 03:46:08 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id f16sm1380475lfk.217.2021.02.26.03.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:46:08 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] dt-bindings: phy: convert Broadcom NS USB 2.0 to the json-schema
Date:   Fri, 26 Feb 2021 12:44:59 +0100
Message-Id: <20210226114501.31086-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Minor example fixes:
1. Include bcm-nsp.h
2. Add address to the node name

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This has been verified using dt_binding_check
---
 .../bindings/phy/bcm-ns-usb2-phy.txt          | 21 -------
 .../bindings/phy/brcm,ns-usb2-phy.yaml        | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
deleted file mode 100644
index a7aee9ea8926..000000000000
--- a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Driver for Broadcom Northstar USB 2.0 PHY
-
-Required properties:
-- compatible: brcm,ns-usb2-phy
-- reg: iomem address range of DMU (Device Management Unit)
-- reg-names: "dmu", the only needed & supported reg right now
-- clocks: USB PHY reference clock
-- clock-names: "phy-ref-clk", the only needed & supported clock right now
-
-To initialize USB 2.0 PHY driver needs to setup PLL correctly. To do this it
-requires passing phandle to the USB PHY reference clock.
-
-Example:
-	usb2-phy {
-		compatible = "brcm,ns-usb2-phy";
-		reg = <0x1800c000 0x1000>;
-		reg-names = "dmu";
-		#phy-cells = <0>;
-		clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
-		clock-names = "phy-ref-clk";
-	};
diff --git a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
new file mode 100644
index 000000000000..b8b683ce8fa9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/brcm,ns-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Northstar USB 2.0 PHY
+
+description: Broadcom's USB 2.0 PHY integrated into Northstar family SoCs
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    const: brcm,ns-usb2-phy
+
+  reg:
+    maxItems: 1
+    description: DMU (Device Management Unit) address range
+
+  reg-names:
+    const: dmu
+
+  clocks:
+    maxItems: 1
+    description: USB PHY reference clock
+
+  clock-names:
+    const: phy-ref-clk
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm-nsp.h>
+
+    usb2-phy@1800c000 {
+        compatible = "brcm,ns-usb2-phy";
+        reg = <0x1800c000 0x1000>;
+        reg-names = "dmu";
+        clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
+        clock-names = "phy-ref-clk";
+        #phy-cells = <0>;
+    };
-- 
2.26.2

