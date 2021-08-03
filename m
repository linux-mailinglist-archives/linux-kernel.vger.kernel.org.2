Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D018A3DE8A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhHCIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:02 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36741 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234487AbhHCIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 84F865C003B;
        Tue,  3 Aug 2021 04:45:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Aug 2021 04:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=gH7P96GX4Wpance/PgEklxkMKw
        +zm8D7Df70KbmQDjg=; b=YtIre5i67hNLOsZwX69z3L7ai7FLD0OoiTWA8kERxZ
        wTfEEvwD20LOlfUYwOWtWIKlGgtHZcq2T0I7wqgNg3TFMcHbvG9FXk9Q4gecoVb1
        Yn/Kaxfd2ZaxItDOrwrXiHCHJlzp0zVqQbl9TJuDPu9amrtd8kmYKW3fiaVbpiMD
        BsWS2mUTflRCywOcT+TWZYIeno694jFPTyqj1FZbJK193sADsbj/C/miK3aETTmZ
        yanKqZWYs5Nvt/GJ+f9ARtk8oe6k8RBS5/LnHcLEQPuc6AnyacnsXWl71EeI1Fj8
        8Waqv2HkiYjKArRzDrxzLEtZC3IoJA/KjDQVJvsMYBRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gH7P96GX4Wpance/P
        gEklxkMKw+zm8D7Df70KbmQDjg=; b=X2cDr6JvKUlIZamQVWmCXIImL18y7L05m
        cizpMX0ll5XP4gQntS0Sfbkj3Hh7znoj0bM0m9q46T8SvOWM9UDaceZEKv7vo2x2
        glfqOaM9Un/Qf8q1iV/9+fOTwFHmYUBFIy+hkvprIKfMOQnYNKzN3c29tz2ljCVm
        w7c7IfvXltZixojJyMxISM9ia3rS5KNALa1QNhhdJdyC83uoBshN3HqAX/qn50XS
        EuGabpUSrBt667qxAURvefK9fa43T/C2zohlpJ0Brm2pRDWsWBXvBIuqooY/bhHX
        aIdlAVU4hZVlMpoeo/7HkCYAmnFQpwaoL+LGlTG5V1jkF/cmeP3ow==
X-ME-Sender: <xms:PQIJYQKIuaZaSMUzXwyv43GTzzHx5Pb6MyhFLRr0G611N00k7IcOTw>
    <xme:PQIJYQLR_hLDlNDsaPGZ4SEPMtTZDJ2ZhBUQKrpHMixFkQ3DTf_jnuzEiaBkdyYFd
    dIVseasQ8zvtPdQPQg>
X-ME-Received: <xmr:PQIJYQsif2fjmzJmvWseI-2oEbwkrgVBuRn3yentqQBI_5ghfnRMtuqRpSmWJp10VzjexX9F0WthR0cCCNfx2buTMHWYxIh4c9YknDHZWoijZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepveeiueduhfevheetle
    dvgfeuhfejgfffieejhedttdffudfhheegjeefjeffleehnecuffhomhgrihhnpeguvghv
    ihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:PQIJYdbMvnoOHc-DTdZPxeUmoQvpHrV_K2xewGFw-RvEbWzgdlClMQ>
    <xmx:PQIJYXY_0VQVUqzPSU0MrW9faaxjpDLkX34x3HCQstYuCusYo_t-Cw>
    <xmx:PQIJYZClynH0LtTDXzDlvLMgA4jRPmJi-fMEPIzYVh748lGWeoJ9ow>
    <xmx:PgIJYb6fpjfM9rrXRnezD_iCAL57VqftC8c3Gn4d7zAoxV8UOKTl3w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:45:46 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 01/11] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Tue,  3 Aug 2021 18:44:48 +1000
Message-Id: <20210803084456.198-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip
and regulator.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../bindings/mfd/silergy,sy7636a.yaml         | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..2726c17b7f4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/silergy,sy7636a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: silergy sy7636a PMIC
+
+maintainers:
+  - Alistair Francis <alistair@alistair23.me>
+
+properties:
+  compatible:
+    const: silergy,sy7636a
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  epd-pwr-good-gpios:
+    description:
+      Specifying the power good GPIOs.
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    properties:
+      compatible:
+        const: silergy,sy7636a-regulator
+
+      vcom:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        properties:
+          regulator-name:
+            const: vcom
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@62 {
+        compatible = "silergy,sy7636a";
+        reg = <0x62>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_epdpmic>;
+        #thermal-sensor-cells = <0>;
+
+        regulators {
+          compatible = "silergy,sy7636a-regulator";
+          reg_epdpmic: vcom {
+            regulator-name = "vcom";
+            regulator-boot-on;
+          };
+        };
+      };
+    };
+...
-- 
2.31.1

