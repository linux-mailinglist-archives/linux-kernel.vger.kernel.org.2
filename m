Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988704287F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhJKHm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:42:26 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57612
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234701AbhJKHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:41:57 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 846063FFFE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633937997;
        bh=sEh5KUYuxEm3bzH5hsUc+ps6L/VdQWx+zLSKJvPfz9w=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=aXk3vr02i9kK+jRKHuRBMyfsIsxmaYpVM4pkOH0gomK6ikRt7RdetGfkIesL3HySH
         gwpRoN1ApFSG3y+AhnUMP7S7mtfVDQ8JubJpQ9U7GTz5RtMEVkjwMaXDvZgBHX4H/o
         D+hnVn4eK/doE3PeVYcqHuYZoZNn3hZePF1/x2KpTSUgFsnAIRVnbYwYsy2PV3Y8sj
         VmYsu7aJCudEduglpVO17OF5JvsGwBcrnvRryU8RoujR4GpTwCJTcgSYKzuwuR4nLb
         /hO87EWehLGeuG1Bqm0myuWDoASx0F7RpLcw8uilUcuaFL6pyuf8Wth2owJMCvwhy9
         ig8ZiCjBAmcOw==
Received: by mail-ed1-f71.google.com with SMTP id cy14-20020a0564021c8e00b003db8c9a6e30so2673729edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEh5KUYuxEm3bzH5hsUc+ps6L/VdQWx+zLSKJvPfz9w=;
        b=NoRAGBmjdnSIjojC3K0YJjL4uP6fRYSXdXeUdfQaN0yYSVmDRfNbQpa0nYIr8d4lNI
         uqjW1bDFomOrbKwgTGgAevJnphBnbfVzYZ+SKSdEYgn+eTY4CtDVy03rUXzmV2Ol5/P+
         GPs6o0jVX8iQ1ZcD9ahjIX+VWu3k1LRHfQaX88/1/SzQo2MksicLw/Jve8w0OG3Qzyrc
         JEUODH7NWSRPWhSDjlJTQdjuPIFBn95P5p9BOlBEmPYXudV+Oz2a8YA5QaHmB0+bzZKR
         FfGlQyLBBOdwKxluSxOBvrq9WaFBUr4lFvQoV/4Q7Wa0AAbKlBeyDMDoWtyrsbb4ha//
         kShQ==
X-Gm-Message-State: AOAM532yhHJy3XOJ6EpHcamdpMVy0bjvTLj0Y1IBDx6QPlGkFL9uhQBh
        VX7Gl+eOL1bNtQZiveUgl5IicpWSe2LMlBd/jaKPuoeugxd0XbK0hCHhTT5FUj30Ij0b4C3Ki5J
        458gfWGgZs0ayPXo8vNcLprR+SaYpMLHlP7cLB8vZ2A==
X-Received: by 2002:a17:906:7805:: with SMTP id u5mr23831457ejm.26.1633937996674;
        Mon, 11 Oct 2021 00:39:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAEg2SKbUYUgI5xLf79tbap6qzVlxVcbZCZgmYQ4c9v9F4kzNOwk0ZNgfo1iwPZTfpks2bOg==
X-Received: by 2002:a17:906:7805:: with SMTP id u5mr23831438ejm.26.1633937996497;
        Mon, 11 Oct 2021 00:39:56 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y8sm3023965ejm.104.2021.10.11.00.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:39:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Mark Greer <mgreer@animalcreek.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2 8/8] dt-bindings: nfc: marvell,nci: convert to dtschema
Date:   Mon, 11 Oct 2021 09:39:34 +0200
Message-Id: <20211011073934.34340-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
References: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Marvell NCI NFC controller to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/net/nfc/marvell,nci.yaml         | 170 ++++++++++++++++++
 .../devicetree/bindings/net/nfc/nfcmrvl.txt   |  84 ---------
 2 files changed, 170 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/nfcmrvl.txt

diff --git a/Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml b/Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
new file mode 100644
index 000000000000..15a45db3899a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nfc/marvell,nci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell International Ltd. NCI NFC controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - marvell,nfc-i2c
+      - marvell,nfc-spi
+      - marvell,nfc-uart
+
+  hci-muxed:
+    type: boolean
+    description: |
+      Specifies that the chip is muxing NCI over HCI frames
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  reset-n-io:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    maxItems: 1
+    description: |
+      Output GPIO pin used to reset the chip (active low)
+
+  i2c-int-falling:
+    type: boolean
+    description: |
+      For I2C type of connection. Specifies that the chip read event shall be
+      trigged on falling edge.
+
+  i2c-int-rising:
+    type: boolean
+    description: |
+      For I2C type of connection.  Specifies that the chip read event shall be
+      trigged on rising edge.
+
+  break-control:
+    type: boolean
+    description: |
+      For UART type of connection. Specifies that the chip needs specific break
+      management.
+
+  flow-control:
+    type: boolean
+    description: |
+      For UART type of connection. Specifies that the chip is using RTS/CTS.
+
+  spi-cpha: true
+  spi-cpol: true
+  spi-max-frequency: true
+
+required:
+  - compatible
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,nfc-i2c
+    then:
+      properties:
+        break-control: false
+        flow-control: false
+        spi-cpha: false
+        spi-cpol: false
+        spi-max-frequency: false
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,nfc-spi
+    then:
+      properties:
+        break-control: false
+        flow-control: false
+        i2c-int-falling: false
+        i2c-int-rising: false
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,nfc-uart
+    then:
+      properties:
+        i2c-int-falling: false
+        i2c-int-rising: false
+        interrupts: false
+        spi-cpha: false
+        spi-cpol: false
+        spi-max-frequency: false
+        reg: false
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
+        nfc@8 {
+            compatible = "marvell,nfc-i2c";
+            reg = <0x8>;
+
+            interrupt-parent = <&gpio3>;
+            interrupts = <21 IRQ_TYPE_EDGE_RISING>;
+
+            i2c-int-rising;
+
+            reset-n-io = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nfc@0 {
+            compatible = "marvell,nfc-spi";
+            reg = <0>;
+
+            spi-max-frequency = <3000000>;
+            spi-cpha;
+            spi-cpol;
+
+            interrupt-parent = <&gpio1>;
+            interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+
+            reset-n-io = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    uart {
+        nfc {
+            compatible = "marvell,nfc-uart";
+
+            reset-n-io = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+
+            hci-muxed;
+            flow-control;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/nfc/nfcmrvl.txt b/Documentation/devicetree/bindings/net/nfc/nfcmrvl.txt
deleted file mode 100644
index c9b35251bb20..000000000000
--- a/Documentation/devicetree/bindings/net/nfc/nfcmrvl.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-* Marvell International Ltd. NCI NFC Controller
-
-Required properties:
-- compatible: Should be:
-  - "marvell,nfc-uart" or "mrvl,nfc-uart" for UART devices
-  - "marvell,nfc-i2c" for I2C devices
-  - "marvell,nfc-spi" for SPI devices
-
-Optional SoC specific properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-- reset-n-io: Output GPIO pin used to reset the chip (active low).
-- hci-muxed: Specifies that the chip is muxing NCI over HCI frames.
-
-Optional UART-based chip specific properties:
-- flow-control: Specifies that the chip is using RTS/CTS.
-- break-control: Specifies that the chip needs specific break management.
-
-Optional I2C-based chip specific properties:
-- i2c-int-falling: Specifies that the chip read event shall be trigged on
-  		   falling edge.
-- i2c-int-rising: Specifies that the chip read event shall be trigged on
-  		  rising edge.
-
-Example (for ARM-based BeagleBoard Black with 88W8887 on UART5):
-
-&uart5 {
-
-	nfcmrvluart: nfcmrvluart@5 {
-		compatible = "marvell,nfc-uart";
-
-		reset-n-io = <&gpio3 16 0>;
-
-		hci-muxed;
-		flow-control;
-        }
-};
-
-
-Example (for ARM-based BeagleBoard Black with 88W8887 on I2C1):
-
-&i2c1 {
-	clock-frequency = <400000>;
-
-	nfcmrvli2c0: i2c@1 {
-		compatible = "marvell,nfc-i2c";
-
-		reg = <0x8>;
-
-		/* I2C INT configuration */
-		interrupt-parent = <&gpio3>;
-		interrupts = <21 0>;
-
-		/* I2C INT trigger configuration */
-		i2c-int-rising;
-
-		/* Reset IO */
-		reset-n-io = <&gpio3 19 0>;
-	};
-};
-
-
-Example (for ARM-based BeagleBoard Black on SPI0):
-
-&spi0 {
-
-	mrvlnfcspi0: spi@0 {
-		compatible = "marvell,nfc-spi";
-
-		reg = <0>;
-
-		/* SPI Bus configuration */
-		spi-max-frequency = <3000000>;
-		spi-cpha;
-		spi-cpol;
-
-		/* SPI INT configuration */
-		interrupt-parent = <&gpio1>;
-		interrupts = <17 0>;
-
-		/* Reset IO */
-       		reset-n-io = <&gpio3 19 0>;
-	};
-};
-- 
2.30.2

