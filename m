Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E959B316C33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhBJRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhBJRMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:12:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99580C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:10:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x9so1560194plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ru6h1j/YIj3xrtPVTo1pv1Pz995jHBhEUi/qYOZbRz8=;
        b=Ff+N/H43BG+I/T4N2pdZRNi7nfRY3HNUUgxDLHi0WCBgmYyTPevEO80FjZACgUen76
         QtgY0n9Wngtuj9hgJyj2VRPGwMq9e+dl7XA5WgQgq2jnf6bSXpLAElrg/9s/YaqMQbLb
         N9GVibzSyhsAczUaidKOXXFNsh+s8Q/rIBazI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ru6h1j/YIj3xrtPVTo1pv1Pz995jHBhEUi/qYOZbRz8=;
        b=KTMgi3V9g8IYToEZWIiy7aw3DAhV3Wf4F3bAMk76p6yHQMXohsLNVQZ4HyHrxZkvdI
         0xWgGiyO8qdWcH32TZTHC7TPQxGm61egOHweeRRsXCQ6UAKJO0iOFPfzGMvtE1dOppja
         tTRCQZ6/PWc8assFh4rATkGbhDrJfGBGjaYFi/HBVRqMIr8iYw4VMLTjf6dqbt2R5vhw
         jaT7zNQDaBYY2xtjYhew8e/Mmf5qaRuGz07kShBLT2MWAPKV6pI7kKcecioC4jRIQ9VN
         hjwcc29xWlGKRTi+4VWsOh4mTvohbX35NLIFl2PGan4jjoq2+e3o8eeuY48Rvyk2LgZc
         TmLA==
X-Gm-Message-State: AOAM533podrTgiiLYeelb9tgxnMafVt/7DfAfM8JeSX0ekfVVNUvzgfr
        V0pNmZyOCZ/TWfY5FmFboU49/g==
X-Google-Smtp-Source: ABdhPJwJE8+kZQK9NPhmP8pTGBRiXX6lDO1NUXzvaYRJ/+GOql3oRTgZ0ueQPWa5utTYrgbWQ43V5A==
X-Received: by 2002:a17:90a:8c87:: with SMTP id b7mr4114508pjo.158.1612977050513;
        Wed, 10 Feb 2021 09:10:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:d8e6:826a:fc50:2158])
        by smtp.gmail.com with UTF8SMTPSA id y24sm2898957pfr.152.2021.02.10.09.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 09:10:49 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 1/4] dt-bindings: usb: Add binding for discrete onboard USB hubs
Date:   Wed, 10 Feb 2021 09:10:36 -0800
Message-Id: <20210210091015.v5.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210171040.684659-1-mka@chromium.org>
References: <20210210171040.684659-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discrete onboard USB hubs (an example for such a hub is the Realtek
RTS5411) need to be powered and may require initialization of other
resources (like GPIOs or clocks) to work properly. This adds a device
tree binding for these hubs.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

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

 .../bindings/usb/onboard_usb_hub.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml

diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
new file mode 100644
index 000000000000..bf4ec52e6c7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for discrete onboard USB hubs
+
+maintainers:
+  - Matthias Kaehlcke <mka@chromium.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - usbbda,5411
+        - usbbda,411
+
+  vdd-supply:
+    description:
+      phandle to the regulator that provides power to the hub.
+
+required:
+  - compatible
+  - vdd-supply
+
+examples:
+  - |
+    usb-controller {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usbbda,5411";
+            reg = <1>;
+            vdd-supply = <&pp3300_hub>;
+        };
+
+        /* 3.0 hub on port 2 */
+        hub_3_0: hub@2 {
+            compatible = "usbbda,411";
+            reg = <2>;
+            vdd-supply = <&pp3300_hub>;
+        };
+    };
+
+...
-- 
2.30.0.478.g8a0d178c01-goog

