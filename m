Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32C388325
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbhERXa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:30:28 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39757 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbhERXaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:30:22 -0400
Received: by mail-ot1-f45.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so10172597otc.6;
        Tue, 18 May 2021 16:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONKu0r6UrA/+nSoLHHrR2PJ8kD1WQsRPTA58wxevovQ=;
        b=iHMzB4eK5ZPJkBtedJyflkAwnbesNGEQ2xMV1v3wbz2sGM4zG46aa4tNfdSYFRnmrs
         9bpQqjoRCkk6uq1pK2+QqsIubaSTrMVRkJkot0akaANNennaGXyL22odxaJnjywCFgg4
         s/MK9eFjuCI5R/7EgH9OZUufwiluCgMwFo1PAXd/oCgpnBcCN+9U6UkfCsGrn1t0FmZ3
         3jvYD93alVzo4f2XN+AfdnN+H7HwyKrVw4h+xidvKA6b17/nFEYhXIyHfa5Q5b6NfbFv
         SvNgUoOseb237owTiw7tXfEoD6x7wclwfbQSi67baiwImjuYIyK7KECZ4yG/THk/DnEc
         a5WQ==
X-Gm-Message-State: AOAM5302Mz8yMBTarJYXdOQy/Fol16FkZfh7ddSMwqH3B4yom2lwdf3T
        XcMngpc/3LUXx+g3pd/lddVG8NRjLg==
X-Google-Smtp-Source: ABdhPJxamqG1aRGLZkPr2eUpSbvaYNTJWfe2v3Yrad36qHLVlE2WgKAG7M6a53Z2DIbHdeOjhUqicg==
X-Received: by 2002:a05:6830:1512:: with SMTP id k18mr6076380otp.357.1621380542650;
        Tue, 18 May 2021 16:29:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id d19sm3985608oop.26.2021.05.18.16.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:29:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/6] dt-bindings: rtc: nxp,pcf8563: Convert to DT schema
Date:   Tue, 18 May 2021 18:28:54 -0500
Message-Id: <20210518232858.1535403-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518232858.1535403-1-robh@kernel.org>
References: <20210518232858.1535403-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Philips PCF8563/Epson RTC8564 binding to DT schema format.

Add 'interrupts' as this device has an interrupt which was not
documented, but in use.

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml  | 50 +++++++++++++++++++
 .../devicetree/bindings/rtc/pcf8563.txt       | 29 -----------
 2 files changed, 50 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/pcf8563.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
new file mode 100644
index 000000000000..15e67be0ef95
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf8563.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Philips PCF8563/Epson RTC8564 Real Time Clock
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - epson,rtc8564
+      - microcrystal,rv8564
+      - nxp,pcf8563
+      - nxp,pca8565
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@51 {
+            compatible = "nxp,pcf8563";
+            reg = <0x51>;
+            #clock-cells = <0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentation/devicetree/bindings/rtc/pcf8563.txt
deleted file mode 100644
index 0a900f7c8977..000000000000
--- a/Documentation/devicetree/bindings/rtc/pcf8563.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Philips PCF8563/Epson RTC8564 Real Time Clock
-
-Philips PCF8563/Epson RTC8564 Real Time Clock
-
-Required properties:
-- compatible: Should contain "nxp,pcf8563",
-	"epson,rtc8564" or
-	"microcrystal,rv8564" or
-	"nxp,pca8565"
-- reg: I2C address for chip.
-
-Optional property:
-- #clock-cells: Should be 0.
-- clock-output-names:
-  overwrite the default clock name "pcf8563-clkout"
-
-Example:
-
-pcf8563: pcf8563@51 {
-	compatible = "nxp,pcf8563";
-	reg = <0x51>;
-	#clock-cells = <0>;
-};
-
-device {
-...
-	clocks = <&pcf8563>;
-...
-};
-- 
2.27.0

