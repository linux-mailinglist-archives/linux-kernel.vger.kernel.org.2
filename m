Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C5F3620CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbhDPNT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243838AbhDPNTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:19:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A18C061574;
        Fri, 16 Apr 2021 06:18:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j5so25720134wrn.4;
        Fri, 16 Apr 2021 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=42+196C4PV/WgalEyYCCLfdIC87N4rvne8jso4N4z3M=;
        b=amK1DS8UnJHRBsTKWylu6z+VuhXAVU/mDKeVhFeNvZt+s4+L/GvpwAOrYjJqoqGHf/
         tj8usFiQsi/fmBRSsNK7uRTSyTOPVuocQQzuVRb7f2jeNBrNbns+fe4nMe0EmYU9t8Z9
         I8Sk7sngXBfBfBl18XI3QW7ddIqt0bdB7v+0M3mpm/87lAffzengXWpHreU82ghISPWR
         9Mbo5bweohmIEg3k4G+ezvW7Cf5UScnmGhzAjrM8vIKr8Ofv2rkNgrd/kzpu0BJO3TPp
         hTLN4GRvU27PyMoPOuINjjphvKRcS3X7DR0cHL2okLh29xxE466/SXFWHI1ZypE78VFP
         UzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=42+196C4PV/WgalEyYCCLfdIC87N4rvne8jso4N4z3M=;
        b=VxQhkMqNky4EKd7tmhazFpfLZKfPgdzVks63SIRZrbnF8VivFHfyNzHbqesNwlzrP1
         i1LWJy5OqV/wt7dh+3MT1ZhLStJoO8N0VBmmN551W73qmQubSbSE2sLGZZjOLEHvpD0f
         EsjA94fqiS4OC5tVEXD4O2Ws71wkIiELLbSpOqaNNb3XHRhAyNEX5OyOcDuT/11p+JNu
         rvSwFyb6vtCRAJB2UZpUq4kSJflGGynCHTrKXYMyrP6RA/GadaAQQMsCtUtaykf79NAO
         sRQMlr2Vn4ti1qNzOrlSUgxbCLMJPgNhJXbVFD4Eiit9HHf0SXnix5grfTP84BF3M17n
         sKGA==
X-Gm-Message-State: AOAM531vlMu0e0/AvGIgc7/j5Wyf3U6WQhMYPA2/DeZgMNiDojj3pv49
        S2RwOGcp8ES7dAAaf+UaRu3NiWKfgjw=
X-Google-Smtp-Source: ABdhPJyAIzTQNakUUG3n72laAisHxLyY0sS4rYhhGhkKbfgjpqw/aAK1CQ+ChidZiP1dKAVM7MGWCQ==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr8986466wrj.339.1618579137045;
        Fri, 16 Apr 2021 06:18:57 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id k22sm10512972wrh.5.2021.04.16.06.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 06:18:56 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:18:54 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Need help converting usb/faraday,fotg210.yaml to yaml
Message-ID: <YHmOvvyxAyOY/fRL@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am converting Documentation/devicetree/bindings/usb/faraday,fotg210.txt to yaml with the patch attached below.
But validating it give me:
Documentation/devicetree/bindings/usb/faraday,fotg210.example.dt.yaml: usb@68000000: 'syscon', 'wakeup-source' do not match any of the regexes: 'pinctrl-[0-9]+'

I dont know from where came this pinctrl regex.
I think this is perhaps due to the if not matched, but still didnt find any solution.

Thanks

--- a/Documentation/devicetree/bindings/usb/faraday,fotg210.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Faraday FOTG Host controller
-
-This OTG-capable USB host controller is found in Cortina Systems
-Gemini and other SoC products.
-
-Required properties:
-- compatible: should be one of:
-  "faraday,fotg210"
-  "cortina,gemini-usb", "faraday,fotg210"
-- reg: should contain one register range i.e. start and length
-- interrupts: description of the interrupt line
-
-Optional properties:
-- clocks: should contain the IP block clock
-- clock-names: should be "PCLK" for the IP block clock
-
-Required properties for "cortina,gemini-usb" compatible:
-- syscon: a phandle to the system controller to access PHY registers
-
-Optional properties for "cortina,gemini-usb" compatible:
-- cortina,gemini-mini-b: boolean property that indicates that a Mini-B
-  OTG connector is in use
-- wakeup-source: see power/wakeup-source.txt
-
-Example for Gemini:
-
-usb@68000000 {
-	compatible = "cortina,gemini-usb", "faraday,fotg210";
-	reg = <0x68000000 0x1000>;
-	interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&cc 12>;
-	clock-names = "PCLK";
-	syscon = <&syscon>;
-	wakeup-source;
-};
diff --git a/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml b/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
new file mode 100644
index 000000000000..b5418f29745e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/faraday,fotg210.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/faraday,fotg210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday FOTG Host controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+    This OTG-capable USB host controller is found in Cortina Systems
+    Gemini and other SoC products.
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,fotg210
+      - items:
+        - const: cortina,gemini-usb
+        - const: faraday,fotg210
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: PCLK
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: cortina,gemini-usb
+then:
+  properties:
+    syscon:
+      maxItems: 1
+      $ref: /schemas/types.yaml#/definitions/phandle
+      description: Phandle to the system controller to access PHY registers
+    cortina,gemini-mini-b:
+      type: boolean
+      description: boolean property that indicates that a Mini-B OTG connector is in use
+    wakeup-source:
+      type: boolean
+      description: see power/wakeup-source.txt
+  required:
+    - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    usb@68000000 {
+      compatible = "cortina,gemini-usb", "faraday,fotg210";
+      reg = <0x68000000 0x1000>;
+      interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cc 12>;
+      clock-names = "PCLK";
+      syscon = <&syscon>;
+      wakeup-source;
+    };
+...

