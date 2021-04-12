Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038C135CA55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243071AbhDLPrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243030AbhDLPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:47:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C38C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:46:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so9001374wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=409QTL0hdWWRMQj+5oULQZC2JwXWrdGHiQRBuE3m5qs=;
        b=nAc7PNeKZKqHAXmi3LGWyOFnnNBrBYXpokEAYTbOnLAdVfcV1kwh6MyRhBsqfibSL6
         LfrmqDpGBiNzqnNHeTKn6Ivil6WHKCALe6CR4t3Yqa4f/TahR6oSt4Ur9Utgnvlnoi93
         R3WN2Ojp2XmtR8YZea/nJ/BfpcOakszj9iBC+5LNJzPHo/WakSDw+teVeyLs0huwEdQW
         Ffm0IuFnQBmMbEkMPsQ8H4kvpY5sRnrEWV578Haz8bfCxbRbdPAsWuv/6fTLSArOfZbF
         Yy3kTyplYAf3gU9baaz0Okm2bjOLz8kQFfi0tJcohJXprMUfUTDcIAog/5I9mReOfZE6
         nqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=409QTL0hdWWRMQj+5oULQZC2JwXWrdGHiQRBuE3m5qs=;
        b=rLvmnbgR2WxR2bt/ghjEFxHAE2IyxwdM3WAnlv1DEjxRCD80im3Xj/cUQeXIr3xkky
         X0/aYhNDUojA0ZgHEthOf0a1KylKQc05rXgMwE4khMubvgLk/fl5QneVcGMys+0fYU1w
         COMSZxMV15Z0WYkKQPMGFRbjnC0SjkZnyg4z+m+vnpSQnkIaKYxwpsweVlH9uiUEkbGL
         Ws7TfB74da7w4zEgOw/1Umy591MX5wB6HfTPEkcWMIvgm3u5TRL6goj1LvOVCVmz0H6/
         QkM/EIH2mSqK5IeLMAHuOmJtBavgIIFpNotWUZxL3ISeWeCgfU4Wvds8CW60DAsR0JUW
         AurA==
X-Gm-Message-State: AOAM533s2cKtlDhabZ25f9MYnVb7ObJXIcLzxngOCfgTpcP2F1UuCPLE
        BNgLn/c+fqmcm13hgXfny7yUTg==
X-Google-Smtp-Source: ABdhPJyEI0xHO5CJxCBwlBCwlz9e2995zsMDWinK81u+lnXoNI6gulBFX/BaPKvpFJ2+9fLRYdJgWQ==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr27294205wmc.3.1618242414584;
        Mon, 12 Apr 2021 08:46:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id u3sm12647332wmg.48.2021.04.12.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:46:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        paul@crapouillou.net, robert.foss@linaro.org,
        devicetree@vger.kernel.org
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 1/3] dt-bindings: display: bridge: add it66121 bindings
Date:   Mon, 12 Apr 2021 17:46:46 +0200
Message-Id: <20210412154648.3719153-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412154648.3719153-1-narmstrong@baylibre.com>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=A37XVUhvAjeOHadMAQvzsTXvq4/Mx+3fpb+QMgZO0wk=; m=4pbLDTHmUx/bdOuUE4bnndkED+bQKYHuWP7IpaPzTyo=; p=NMnvxRQNO0UfPjnn5oPHclBIYEUF7AEtJYQxnlns38g=; g=7885d5dafd4182d3fd1e195e1b4fc94b84582e40
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmB0a0kACgkQd9zb2sjISdFhZQ//WjD XF7VLF9hVcJzoOou9W5jDshNKpCH3+bOWnAe9BwzNjMAmUzV1ryLlgg/TlNWoxV0usgM65SF1BPEf MTWDid2YBLW4sheOhQhGD/EyFf0mtikyYjpHf2SbidFERb6qC3c6OjFsyGOflfbN+gjHn+u9PjYGE 7meaSxx/ftgijcGDJyI2BuCJkrRNPfnPk2DQBTYoBZF5rud3S1jGmS1N7GYEBwwVzCZqH0fMTR8H+ EhbuLIhMVI5xiZPu4sUM+swcrAJPrPB1oljkPpbQd2EK7cQh2m+DQhg/RdwkCKXrmEOOV6z65WEc5 7+1MlYujrMdAsc1gAieFZ+7RMTR1pD7z1z27AlqTVVTV3wd+7a36rjgqT18iDiCRt7R1cPKCbkAXD x29Kxkkvf1t/FF9QEhTzXbgxOY5RDIH9H1awza2Yg8HqpKbUDLj4hioSn/V7804ognNFIImOoUU0a zVFNGNuT3h47VSrKLOJUBGRV3qKxnP7UHlcPJYsehwtWD75xunr6JLM34QZ98NFb7DGys4XM35aCI 1jnr+ZFKajIuUYCqtRvZhPkhAh7Y9hjpZynj/MIX6DxRfgt3NY4EiUENSTLCKtEnglrtuDO0a0vGx mnEwF0IKUYiqrS1DcQD2hKl7C1jUJBIk150g9dTGHDa7z+wrpQcl257uYjrJCxUs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong LE <ple@baylibre.com>

Add the ITE bridge HDMI it66121 bindings.

Signed-off-by: Phong LE <ple@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/display/bridge/ite,it66121.yaml  | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
new file mode 100644
index 000000000000..61ed6dc7740b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
@@ -0,0 +1,123 @@
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
+    description: base I2C address of the device
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      it66121hdmitx: it66121hdmitx@4c {
+        compatible = "ite,it66121";
+        pinctrl-names = "default";
+        pinctrl-0 = <&ite_pins_default>;
+        vcn33-supply = <&mt6358_vcn33_wifi_reg>;
+        vcn18-supply = <&mt6358_vcn18_reg>;
+        vrf12-supply = <&mt6358_vrf12_reg>;
+        reset-gpios = <&pio 160 1 /* GPIO_ACTIVE_LOW */>;
+        interrupt-parent = <&pio>;
+        interrupts = <4 8 /* IRQ_TYPE_LEVEL_LOW */>;
+        reg = <0x4c>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+            it66121_in: endpoint {
+              bus-width = <12>;
+              remote-endpoint = <&display_out>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+            hdmi_conn_out: endpoint {
+              remote-endpoint = <&hdmi_conn_in>;
+            };
+          };
+        };
+      };
+    };
-- 
2.25.1

