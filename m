Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7442A363C47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhDSHNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbhDSHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:12:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E174C061760
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:12:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e7so23818822wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVHcO7akxBa72/X7FrsMB/fvKb0p1e2KUjNMQdLiNAc=;
        b=ZMzkwdXp/CzrI7tBL9v1ONStdrw1ViW4X//V00qNjTFeskT1zQy3AwkbZEHmm/PdsB
         4+55Tyu31p5Z3gFfbQV956zejngtCVRWrr4aUhSsUxAjr3EknGaeVosXEn6x1iiq6Q57
         /V6MIariYSuYikcTfBqn8v9ML+Df7SOl5oNNqWa4QkyTPJB8WG3r8Xwgz7L+nu86QDV9
         VkWSEs8ODal2PNVVvTG1YQhbw0iUOjIqobtR0Yagf4kKna98wgyU29KRKhkApGc/piZA
         BQJ4O/9wO+ulPBp2CuMU9gTeOunsNeXJQgGo/k4qd1EH00FGBdKKwphMNd1cUWMhdcek
         RIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVHcO7akxBa72/X7FrsMB/fvKb0p1e2KUjNMQdLiNAc=;
        b=uN2sfytZaf7t7DwzbEZrwvS2csHa85hUI6wQ0g5vgIcRt1PgZU5cLIwCSU3u8m/Uni
         dqYhvGyugBy0IdcR1aridH9zY1o3o3ZDdxjFoB6wJN5f2NTd3cSGT4RbTBhOsnC/0jlf
         rIWKje0aegt4A8eyYODmN92rK9/lvnyS7onA/29d9nWqtGbJg04l8gGF7WV0EX39bd+g
         R08CTpegmzMKoXepQp4LPex/cCXt2Bv7zdtw64M8PAqqbqDtHWCxaDLfRMY85JOPiDPg
         xDGJiGyXDMnrTuT7bNuaw7K3raIg7tfEeN8BD8wk462UckZjmYGQMkGZhTebF4SwN4Wv
         TLiA==
X-Gm-Message-State: AOAM5319fv/xMglqYiDSJZ838l0eAt09vnzOFVKlronhY+zqWeNyXX6x
        itHNJsHkeUJv1RvJtWh1ewy0XA==
X-Google-Smtp-Source: ABdhPJxczwmslePqXk+KftKBflLc3iAlG17HunPpf12xQ4UKo4Ipg4xfRyX1Z6kJq4DFZhMSpxzwhQ==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr12462248wro.169.1618816344715;
        Mon, 19 Apr 2021 00:12:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:2e82:31e6:67f1:4f33])
        by smtp.gmail.com with ESMTPSA id i9sm10447922wmg.2.2021.04.19.00.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:12:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        paul@crapouillou.net, robert.foss@linaro.org,
        devicetree@vger.kernel.org
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 1/3] dt-bindings: display: bridge: add it66121 bindings
Date:   Mon, 19 Apr 2021 09:12:21 +0200
Message-Id: <20210419071223.2673533-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419071223.2673533-1-narmstrong@baylibre.com>
References: <20210419071223.2673533-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=A37XVUhvAjeOHadMAQvzsTXvq4/Mx+3fpb+QMgZO0wk=; m=hE6W1GKMCnDe7Xl9Y2XkaKJE8GpE3GDH9eFQ15OmrR0=; p=eWsF/9X6dJ2dGxyfExV9lgaFxqhX7MsrvS3ZLcdKl2U=; g=b0191a1ee2971a02d75b9362a1e39795593059ab
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmB9LUEACgkQd9zb2sjISdGQ+w/+PKr bmPInssnRpLnrUXH34tL/DOBc1ijeBguSraXABsWzrn1WtmxnEN26WsStOUHD0h+s0pEEVz6UjWde zMbs1WWTa0tAPRY/pVAtMwnIvVA0jf1hvIHx+jY8A8he6oMzhhBIqEnF+13yZw9xlcJZdP0dgRw1N 4U6sJwqpxuk+vaOXrRexMshwNNBKBsX7xhj+8cIDuOGHkQr7xK84i+pfPAyGdAX+onwbhJuUEp4ct tx0oA6qIousQTQTIiV0CdJAsXHOG4tQrRBCrI8vTUfMzPQuDqNbfu6FZilPW9BySsGtXe9Jh75p+J 5dwobwC2XumiiV//ecuN4+TTHStKMHNb0WiD4/jhiGxtCVHuX4QgJ1h6wrkYf2+3Huq4uR6Fd2EHs Oc91zTlc4JQgWzNWeTUDwaIaduWdtoQ49QFH0blNMEz/5EK5tqwNYhxuqp7+uR/h3Y2BIcQWXz1Y8 i/u2O3D++aPFK7JGQdWwwHxYXwcOmTCypVdGyvDsNIlaq/FgRV+iB9TwYJxNE6kZ+dOP/KCwfTsEA V5DQYpDnggXd7ys3KMff8FXz6qG7/btmLbNK2/AARUOa6TEYxgONq0MhOhvEtsue5ExtaWLLIPLbs WRiQw4UAqMcQXm1VYYS0rFouyfLWLf2OYOg4P+wgnQPWRcgFJcE7eeRpff/tmB68=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong LE <ple@baylibre.com>

Add the ITE bridge HDMI it66121 bindings.

Signed-off-by: Phong LE <ple@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../bindings/display/bridge/ite,it66121.yaml  | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
new file mode 100644
index 000000000000..6ec1d5fbb8bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/ite,it66121.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ITE it66121 HDMI bridge Device Tree Bindings
+
+maintainers:
+  - Phong LE <ple@baylibre.com>
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  The IT66121 is a high-performance and low-power single channel HDMI
+  transmitter, fully compliant with HDMI 1.3a, HDCP 1.2 and backward compatible
+  to DVI 1.0 specifications.
+
+properties:
+  compatible:
+    const: ite,it66121
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to active low reset
+
+  vrf12-supply:
+    description: Regulator for 1.2V analog core power.
+
+  vcn33-supply:
+    description: Regulator for 3.3V digital core power.
+
+  vcn18-supply:
+    description: Regulator for 1.8V IO core power.
+
+  interrupts:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: DPI input port.
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              bus-width:
+                description:
+                  Endpoint bus width.
+                enum:
+                  - 12  # 12 data lines connected and dual-edge mode
+                  - 24  # 24 data lines connected and single-edge mode
+                default: 24
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: HDMI Connector port.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vrf12-supply
+  - vcn33-supply
+  - vcn18-supply
+  - interrupts
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        it66121hdmitx: hdmitx@4c {
+            compatible = "ite,it66121";
+            pinctrl-names = "default";
+            pinctrl-0 = <&ite_pins_default>;
+            vcn33-supply = <&mt6358_vcn33_wifi_reg>;
+            vcn18-supply = <&mt6358_vcn18_reg>;
+            vrf12-supply = <&mt6358_vrf12_reg>;
+            reset-gpios = <&pio 160 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&pio>;
+            interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+            reg = <0x4c>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    it66121_in: endpoint {
+                        bus-width = <12>;
+                        remote-endpoint = <&display_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    hdmi_conn_out: endpoint {
+                        remote-endpoint = <&hdmi_conn_in>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.25.1

