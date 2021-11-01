Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE03A4412E7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 06:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKAFR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 01:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhKAFRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 01:17:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A24C061714;
        Sun, 31 Oct 2021 22:15:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q187so16249563pgq.2;
        Sun, 31 Oct 2021 22:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8x40FioA4dTSlRCNyqADsN3XNXWhRws9g0HfGYeRmdE=;
        b=TkkMAMsG7VfjU7SylLSUN9lXv3s09huF4IgWTVRnYhls+6pyl31eAQTY8Gxo695Yu+
         PFRHZ/LeB8NRH19U2avN3GsNdpNAzWkwsP5a/XzfSopfAMg7iIC91LyyY+tlr6Z7ymVz
         fy3Jr5w/DCz5x+9CDIvr9HUDHddILiCJjfEPriHUd04RJpjYLYfZrAKqq5oGQw80/UWv
         LNPkBn/ukcuCzGQpuuXUIWsEdzIbrkmsnNe+Wphk65ev5QUgOHtYl0u3k3tE0TLYqSts
         /Utd3WZ6bvKN54dgab2vCTi9CG4Y7DucGOL91s57tUM8pJByeSmR8XyQJDQwqmY9PAxp
         MC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8x40FioA4dTSlRCNyqADsN3XNXWhRws9g0HfGYeRmdE=;
        b=Bo7QdaCuEjHakX0IhmUU3P/Viq8y9YFL144R9jWwjCUZ52DwpdWL9pb3E/4r7QEC+B
         rGGBFeTegUcHBaV8zlApQP7+ZHz27v3J8lbTVZgnvxPZEE8FQTQ2SULhkExmdkwVKqUN
         GCVwwiUxmBe82lsXsJBdn4kU0unes2z4aZzdkurVhL2GRl5ipTxWS9nfKt5XvnyoIeBA
         hlixgf0GON+F3kdHmQONMp7KO/4gWErRXoXQyQ/7STN8HIwzIuIvT9+ag+kIo07vgekt
         wtVrTicdueArhbtT0qZ78PrCzSkxsFIS4zOC5rLaIpJZ+e6H6SwQRz3H3kFGp0JOv97A
         GtKg==
X-Gm-Message-State: AOAM531DRkSXod4HjmEO7ISIE4V4uRXNfV+arFpB7gbVA6jWNriXpcY2
        FymHN5+L+3YEDHfWoEEbvj8uBKRy0OabWg==
X-Google-Smtp-Source: ABdhPJz+uFsUoT3M/pf7vsLTXtrBFI/CvnCzCGIXK4pYenK7KZ5ugWZeqT0BcNDztttWp82EZDJO+Q==
X-Received: by 2002:a63:d644:: with SMTP id d4mr9077977pgj.360.1635743721815;
        Sun, 31 Oct 2021 22:15:21 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k7sm3182090pgn.47.2021.10.31.22.15.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 22:15:21 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
X-Google-Original-From: Vincent Shih <vincent.shih@sunplus.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Vincent Shih <vincent.shih@sunplus.com>
Subject: [PATCH 2/2] dt-bindings: nvmem: Convert Sunplus OCOTP to json-schema
Date:   Mon,  1 Nov 2021 13:15:12 +0800
Message-Id: <1635743712-25358-3-git-send-email-vincent.shih@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635743712-25358-1-git-send-email-vincent.shih@sunplus.com>
References: <1635743712-25358-1-git-send-email-vincent.shih@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Sunplus OCOTP to json-schema

Signed-off-by: Vincent Shih <vincent.shih@sunplus.com>
---
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       | 116 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
new file mode 100644
index 0000000..2d18f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sunplus,sp7021-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: On-Chip OTP Memory for Sunplus sp7021
+
+maintainers:
+  - Vincent Shih <vincent.shih@sunplus.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    const: sunplus,sp7021-ocotp
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: hb_gpio
+      - const: otprx
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  therm_calib:
+    type: object
+    description: thermal calibration values
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+  mac_addr0:
+    type: object
+    description: MAC address of ethernet port 0
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+  mac_addr1:
+    type: object
+    description: MAC address of ethernet port 1
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+  disc_vol:
+    type: object
+    description: disconnect voltages of usb2 port 0 and port 1
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+
+    otp: otp@9C00AF00 {
+        compatible = "sunplus,sp7021-ocotp";
+        reg = <0x9C00AF00 0x34>, <0x9C00AF80 0x58>;
+        reg-names = "hb_gpio", "otprx";
+        clocks = <&clks OTPRX>;
+        resets = <&rstc RST_OTPRX>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        therm_calib: therm_calib@14 {
+          reg = <0x14 0x3>;
+        };
+        mac_addr0: mac_addr0@34 {
+          reg = <0x34 0x6>;
+        };
+        mac_addr1: mac_addr1@3A {
+          reg = <0x3A 0x6>;
+        };
+        disc_vol: disc_vol@18 {
+          reg = <0x18 0x2>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index b7df2f1..c0ccc95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17950,6 +17950,7 @@ F:	drivers/net/ethernet/dlink/sundance.c
 SUNPLUS OCOTP DRIVER
 M:	Vincent Shih <vincent.shih@sunplus.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 F:	drivers/nvmem/sunplus-ocotp.c
 F:	drivers/nvmem/sunplus-ocotp.h
 F:	drivers/nvmem/sunplus-ocotp0.c
-- 
2.7.4

