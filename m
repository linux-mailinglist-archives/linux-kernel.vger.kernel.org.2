Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A053C4281BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhJJOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 10:25:27 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45290
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232901AbhJJOZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 10:25:25 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 73F4640015
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633875806;
        bh=GFOKzNYALQa+608FIQZ/in0rfsEAI0+jCScuqGun71I=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=RKHCHLE4VlJGcf4P3HX9IK1O4Dy62hZqsal5DFYo3/OxKAgwHl6gRF3vWTDUMwClM
         ZwYhyJTUWtJpDKgtVMNOSmh28qgwqqoWAe0IbYZo4mrlU/ckhVewDqZ5ii0sPr41dc
         QMLoMnyDGHcn8Xns3I7CDWGTu/+wcAnNWmQTADhOadWW7/wcxpr83rctXRJlm9kIcU
         fKStQLVt8YCbv+Sx2fQgbSX4f+rrauMXQ4Fy73o/3+EQeDk1l4M9FIc7AQmpRwyYXr
         6UwFMwaasc/e840vqZg0u28ekDfRtHV2fsO23XZ1CNAHx7Ikz1TCmLkUPhuKT36xbN
         2uydcxSgIPF5w==
Received: by mail-ed1-f70.google.com with SMTP id x5-20020a50f185000000b003db0f796903so13442380edl.18
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 07:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFOKzNYALQa+608FIQZ/in0rfsEAI0+jCScuqGun71I=;
        b=zaIyLvsgLCIT8mAMoXg4X8vKhAvlWBsImHKNb94fIb8iMOJyDSEz2dKJJrU8jyu1dv
         +vuXL0lOad3j7rEWFcSPzpOaXeygs6kHdvSMahe7vlEd9cZzPD0FbRs98HeksqRvMfDd
         rAg922qQ7MRHrjqF26rloYJInO6k2wAdQ1cLPgPEM9gISHMYkPNhMdR2d8uypMrHE4HW
         VQScBR/B4T6gWAsco14prqvN0b/qPIovoZkYKHmGVMBWvkvKPjhSnHTaV6G8+jNUTLX9
         g1gYWjKrzTqxnKpEE1NLYmZXkkLLhUQN+jq+wapEcjfJ9cC6MgjU5K01WU9S0MLrfqSB
         ukhA==
X-Gm-Message-State: AOAM532tIOhfDoEpx3FkgT7kAcyCWiXm62XerfWz3pDAUNoJn7tLuibQ
        JOoM0xMBcyvXayzo6pbaLXKVviiei+pnNdEDUi814nK4d0Gdv4BShspddWPFRhFmLI1pPd4g9kP
        Bs4jFtS4e6012J1MIQFD7AISuHqZfwZvNm0GTTryBow==
X-Received: by 2002:a17:906:4452:: with SMTP id i18mr18335291ejp.374.1633875805953;
        Sun, 10 Oct 2021 07:23:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx94bZ2ipwW70tBjgvzGZ79+303zLFR8lQVDmyzo0Dkcvx/qGXoXfyUNj77BL8MoxAU7lKhuQ==
X-Received: by 2002:a17:906:4452:: with SMTP id i18mr18335272ejp.374.1633875805770;
        Sun, 10 Oct 2021 07:23:25 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 6sm2129017ejx.82.2021.10.10.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 07:23:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Mark Greer <mgreer@animalcreek.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: nfc: nxp,nci: convert to dtschema
Date:   Sun, 10 Oct 2021 16:23:11 +0200
Message-Id: <20211010142317.168259-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NXP NCI NFC controller to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/net/nfc/nxp,nci.yaml  | 61 +++++++++++++++++++
 .../devicetree/bindings/net/nfc/nxp-nci.txt   | 33 ----------
 MAINTAINERS                                   |  1 +
 3 files changed, 62 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/nxp-nci.txt

diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
new file mode 100644
index 000000000000..f84e69775eb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nfc/nxp,nci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Semiconductors NCI NFC controller
+
+maintainers:
+  - Charles Gorand <charles.gorand@effinnov.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    const: nxp,nxp-nci-i2c
+
+  clock-frequency: true
+
+  enable-gpios:
+    description: Output GPIO pin used for enabling/disabling the controller
+
+  firmware-gpios:
+    description: Output GPIO pin used to enter firmware download mode
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clock-frequency
+  - enable-gpios
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nfc@29 {
+            compatible = "nxp,nxp-nci-i2c";
+
+            reg = <0x29>;
+            clock-frequency = <100000>;
+
+            interrupt-parent = <&gpio1>;
+            interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
+
+            enable-gpios = <&gpio0 30 GPIO_ACTIVE_HIGH>;
+            firmware-gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/nfc/nxp-nci.txt b/Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
deleted file mode 100644
index 285a37c2f189..000000000000
--- a/Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-* NXP Semiconductors NXP NCI NFC Controllers
-
-Required properties:
-- compatible: Should be "nxp,nxp-nci-i2c".
-- clock-frequency: I²C work frequency.
-- reg: address on the bus
-- interrupts: GPIO interrupt to which the chip is connected
-- enable-gpios: Output GPIO pin used for enabling/disabling the chip
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-- firmware-gpios: Output GPIO pin used to enter firmware download mode
-
-Example (for ARM-based BeagleBone with NPC100 NFC controller on I2C2):
-
-&i2c2 {
-
-
-	npc100: npc100@29 {
-
-		compatible = "nxp,nxp-nci-i2c";
-
-		reg = <0x29>;
-		clock-frequency = <100000>;
-
-		interrupt-parent = <&gpio1>;
-		interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
-
-		enable-gpios = <&gpio0 30 GPIO_ACTIVE_HIGH>;
-		firmware-gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 7cfd63ce7122..3294aaf5e56c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13632,6 +13632,7 @@ NXP-NCI NFC DRIVER
 R:	Charles Gorand <charles.gorand@effinnov.com>
 L:	linux-nfc@lists.01.org (subscribers-only)
 S:	Supported
+F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 F:	drivers/nfc/nxp-nci
 
 NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
-- 
2.30.2

