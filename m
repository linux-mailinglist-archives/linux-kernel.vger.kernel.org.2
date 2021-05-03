Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF23720BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhECTpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:45:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BEC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:44:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t21so3450725plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddRS2AScHEHzlrlyRh3qV79ZQtFjv/zHQpWHpAegDbs=;
        b=bn8SuD2klGotzTJfSUaJpQvHQRJyCYM3QL0TJ4qh9qy6QftRedWkUVODgpjsLhZE5a
         QBmFFUZevKUd2iHUBLaBW9GSXcRTu6gj2rt3b6syduNqrXc4SDbiWffzywbmTR9gbO7G
         1RLV/uyWbFf1qRNW7Lg3ElBTTvz1DMV8ZBehg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddRS2AScHEHzlrlyRh3qV79ZQtFjv/zHQpWHpAegDbs=;
        b=U4xJnUaPrBtnVBIrrqyr2NfcxCbGSg1E2p5m37HVRrXkQQwLvUc9vFd/SSTWvURltV
         nkLnOE7mDzpfVtXZJBDft2rvLBT3VorfHulecP4jIvhAQkc1VNWrwAoXIb9ohhVnqNQk
         mBSRew7WrSp0cHQVd4fXQ+7byzhT70WSnuaqS2Lz9CX3TbWarlBQMoosPrDbPFv6ZtSF
         2M6QRtPikmFcZGrOAK4q/O5L7UBuhTs975RD0rEPFetjxbsfiunjKhSCsjIOBR1PAWKw
         i6oVTkKkC8fcZrCNvyCJn2+ZhOQMq3oeP9oyKrlBr0dxaKE758Wl1cjZZYD9PfV2gRJ6
         fLJg==
X-Gm-Message-State: AOAM531kCKYtquy6vNHf7KPtRpa4PVP6tQkWObyXmp3s2LMax82iMaH9
        NsTm5ri5u7LPxh5EgcCjJ81MLw==
X-Google-Smtp-Source: ABdhPJzLyH241/6ZtXe3lGzVfNoHbdGWe7OLeC5zZgTVQcK5LLcCBYuuIiBj9Xvq9rYCms+qagcyGQ==
X-Received: by 2002:a17:902:bcc7:b029:ed:6f73:ffc4 with SMTP id o7-20020a170902bcc7b02900ed6f73ffc4mr21843321pls.1.1620071085778;
        Mon, 03 May 2021 12:44:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:8584:3fd:2adf:a655])
        by smtp.gmail.com with UTF8SMTPSA id k127sm10335226pfd.63.2021.05.03.12.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 12:44:45 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 1/5] dt-bindings: usb: Add binding for Realtek RTS5411 hub controller
Date:   Mon,  3 May 2021 12:44:35 -0700
Message-Id: <20210503124408.v9.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210503194439.3289065-1-mka@chromium.org>
References: <20210503194439.3289065-1-mka@chromium.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v9:
- added Rob's 'Reviewed-by' tag

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
2.31.1.527.g47e6f16901-goog

