Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E960A36DF13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243681AbhD1Sm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbhD1SmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:42:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B05C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:41:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id md17so5870850pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tergllBpkqhZfPmFOTzr6qseTCwQjcNYwRpQDtmWEqo=;
        b=YGMEWFrqJZEbxGyUSDZk+OtuxIdzROuXND3g3zyqrhuuJerRoAwY9HsyzKICcB+TCA
         A+MJTHz7oucXXD++aAz5YB8Ib1NI729xqlWKsujtCgKA1xOEAo4GK3+rcbwrJoy4CURr
         wAeQazKbbiVdtnfc7RycuC2z5LnuI6VmYy5oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tergllBpkqhZfPmFOTzr6qseTCwQjcNYwRpQDtmWEqo=;
        b=NezyqftqhLkSLVFi3QMsQSaDBWKr6sr1vvDy0cHe1M76bIFEzKLiGwIfmB1tCYmhPW
         qG/T/ZGslF6NOa6p4NXvhN8iESmzRtDZgRaivNNq3rZqk15KrgC4RRXxuAGZRO3GOUV7
         pY/BSUGAUD2I1RA52LRX7aHFvuMYvo6CEtU9KqHsSIuC0QAADSgylThrRn+vQy9fBb9f
         6OyXOucpU5wh6DPWt6h2T7RA1PyGmUDGLdzI/kE6ssb1Hh+NsUOeCSSjWVVQrehb32YG
         SXEw8SWtojfoq4skiA1mpYGnzDphQSEhvJbN+kp0m+1ULRPAxqiHvdPtf9rW01e0DU7u
         bjgw==
X-Gm-Message-State: AOAM533qUKLpONP2J44IQCr+L2MNIHwuTAkk8pgW9xcJF1JNlHZmBxI4
        o/1UsY34IG8aI1ZC+KaIn3aG0g==
X-Google-Smtp-Source: ABdhPJzx1MsTS6W620JKrozI3DWA4jyZquNbYMexmJjdhivFMLI3RWM/FEVpoZmns7l0hSna+dNXvg==
X-Received: by 2002:a17:90a:6583:: with SMTP id k3mr35435254pjj.227.1619635299691;
        Wed, 28 Apr 2021 11:41:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4c1a:a0a7:2b43:81b0])
        by smtp.gmail.com with UTF8SMTPSA id n203sm391079pfd.31.2021.04.28.11.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 11:41:39 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Peter Chen <peter.chen@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v8 1/5] dt-bindings: usb: Add binding for Realtek RTS5411 hub controller
Date:   Wed, 28 Apr 2021 11:41:28 -0700
Message-Id: <20210428114109.v8.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210428184132.2184997-1-mka@chromium.org>
References: <20210428184132.2184997-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RTS5411 is a USB 3.0 hub controller with 4 ports.

This initial version of the binding only describes USB related
aspects of the RTS5411, it does not cover the option of
connecting the controller as an i2c slave.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v8:
- added entry for 'reg'
- marked 'companion-hub' as required
- changed node name of USB controller to 'usb'

Changes in v7:
- added type ref for 'companion-hub' property

Changes in v6:
- Realtek binding instead of generic onboard_usb_hub
- added 'companion-hub' property
- added reference to 'usb-device.yaml'
- 'fixed' indentation of compatible entries to keep yamllint happy
- added 'additionalProperties' entry
- updated commit message

Changes in v5:
- updated 'title'
- only use standard USB compatible strings
- deleted 'usb_hub' node
- renamed 'usb_controller' node to 'usb-controller'
- removed labels from USB nodes
- added 'vdd-supply' to USB nodes

Changes in v4:
- none

Changes in v3:
- updated commit message
- removed recursive reference to $self
- adjusted 'compatible' definition to support multiple entries
- changed USB controller phandle to be a node

Changes in v2:
- removed 'wakeup-source' and 'power-off-in-suspend' properties
- consistently use spaces for indentation in example

 .../bindings/usb/realtek,rts5411.yaml         | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml

diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
new file mode 100644
index 000000000000..04ee255eb4f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/realtek,rts5411.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for the Realtek RTS5411 USB 3.0 hub controller
+
+maintainers:
+  - Matthias Kaehlcke <mka@chromium.org>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - usbbda,5411
+          - usbbda,411
+
+  reg: true
+
+  vdd-supply:
+    description:
+      phandle to the regulator that provides power to the hub.
+
+  companion-hub:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      phandle to the companion hub on the controller.
+
+required:
+  - companion-hub
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usbbda,5411";
+            reg = <1>;
+            vdd-supply = <&pp3300_hub>;
+            companion-hub = <&hub_3_0>;
+        };
+
+        /* 3.0 hub on port 2 */
+        hub_3_0: hub@2 {
+            compatible = "usbbda,411";
+            reg = <2>;
+            vdd-supply = <&pp3300_hub>;
+            companion-hub = <&hub_2_0>;
+        };
+    };
-- 
2.31.1.498.g6c1eba8ee3d-goog

