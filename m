Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF68314D94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhBIKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhBIKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:48:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC7C061794
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:48:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y18so22797187edw.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0/ds6TqyQAWLEqEisftvaogVWIhX2wWYb95Z1KhnN4=;
        b=bcMsBCW+9HiNELwvyzTbp9GO8Pm+mluEh0lDlaxb9Vd+6ItEuK1Lzko6p10rtbypY6
         Yg4AJvhODI49GathqCahEaiXaSo4iGy1XQmzQfe2AXZ8sjkSOiYhNoNhytd8wvMnrYW6
         E6zQTgAVTckX3Cly7GrmjhFdL96mXLsENwy4ujqVuvTq21YLmSMz3SVYL6InGoTJjpjq
         nQUGIKTjV9Ejx/Q4NOOyRn7EVIAsJJ6P/FfHERAw7Uisp5gMuAbU3sNdV6kVmW56LJg3
         6KoYH7I/7dA6LQ6uLVPw8TpYurvfbXHzmk334lZgPGV8Z57QvpMddv2rewnAQsqujkna
         iviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=P0/ds6TqyQAWLEqEisftvaogVWIhX2wWYb95Z1KhnN4=;
        b=pSbYpWyhqCafaJW17FadOVnsOidO4X/pxgxBJI4Su0E4MIZlr36c02AXkvhf1kAgl+
         8smMI39JAD2AS/TWlZVFzvcMOL1LDeK9t86z8gdnQVJU+6vct+vAnmFJbmTi/GzvmmjN
         U98/PVlVu9cVTqK4cagPM5j/xrJcOq/cbgDNhfK4RKD6VFmPW6o0zFKgt92QtiBv1OyE
         GlHDf6yFVULMEpTWZUBM2lCOtMxtV1iLK7Zaflfs3ElutGC5nURFN/gXWwE/uVPU9c/Q
         9kHQI/26i4ZbzNhYxtpDAbFOW/j7kwWcdtcc2tTzmX/tPnCQUEodLcCrKQtBQ26K3WSf
         YAQA==
X-Gm-Message-State: AOAM531hHnEA7k2qPMOHHeqkSMyqd8dR/GEpu85eSjIJocjODSDTZCF9
        Uo0K+6A2eO5EHQHGZPMIR+NLPqn76wF2gA==
X-Google-Smtp-Source: ABdhPJzBcV5KCgtMy0P0CJf8soqGHUHtOEc4yMLz7EY8MjXZpHHuBmZSDzu+X3wGL9lrdIY/IgIgEg==
X-Received: by 2002:a05:6402:3553:: with SMTP id f19mr22313795edd.271.1612867692886;
        Tue, 09 Feb 2021 02:48:12 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id p25sm11025831eds.55.2021.02.09.02.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 02:48:12 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Piyush Mehta <piyush.mehta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: usb: misc: Add binding for Microchip usb5744 hub
Date:   Tue,  9 Feb 2021 11:48:09 +0100
Message-Id: <076994fc051e9230a3fef9e3eb5ec932104ef16a.1612867682.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1612867682.git.michal.simek@xilinx.com>
References: <cover.1612867682.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

Added dt binding for usb5744 driver.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 .../bindings/usb/microchip,usb5744.yaml       | 56 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
new file mode 100644
index 000000000000..fe222f6db81d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/microchip,usb5744.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Bindings for the Microchip USB5744 4-port Hub Controller
+
+description:
+  Microchip’s USB5744 SmartHub™ IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
+  low power, low pin count configurable and fully compliant with the USB 3.1
+  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
+  (LS) USB signaling, offering complete coverage of all defined USB operating
+  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
+  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
+  USB 2.0 traffic.
+
+maintainers:
+  - Piyush Mehta <piyush.mehta@xilinx.com>
+  - Michal Simek <michal.simek@xilinx.com>
+
+properties:
+  compatible:
+    const: microchip,usb5744
+
+  reg:
+    maxItems: 1
+    description: |
+      Specifies the i2c slave address, it is required and should be 0x2d
+      if I2C is used.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      The phandle and specifier for the GPIO that controls the RESET line of
+      USB hub.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        usb5744@2d {
+            compatible = "microchip,usb5744";
+            reg = <0x2d>;
+            reset-gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 41e8d3d7faec..7439471b5d37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2697,6 +2697,7 @@ W:	http://wiki.xilinx.com
 T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+F:	Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
 F:	arch/arm/mach-zynq/
 F:	drivers/block/xsysace.c
 F:	drivers/clocksource/timer-cadence-ttc.c
-- 
2.30.0

