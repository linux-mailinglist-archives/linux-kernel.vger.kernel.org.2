Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5C3A7C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhFOKg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:36:28 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35367 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231724AbhFOKg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:36:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 267045C0102;
        Tue, 15 Jun 2021 06:34:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 15 Jun 2021 06:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=FXWO8BWkbjSyAl5Ap6Kfru+KYv
        1KDGgUzEsYSnb0uoU=; b=llG0iHb5KKSjfUZ8CKIJXL2wzU4wTLxkYYeFvAbIJA
        GmlIgpgHxo1Y8sYbyZCjs7HuTj/EMBQYoBZgX1EDYz/A7P27oTX1HxNfwiboeHOt
        2vcq9Qo/gntaRclgYe591TxFyX9UaIVVEhLEmw3c8HSYiy79AxdX5ezsPkmbk/go
        ctu8WZe316JBjwKEEckGlL9op8QEuv/vvW0FxmhtzbQDtYedfPLxJDcGIj/YNhmJ
        01/mD/ys7Qo6oPRNxWsWFTn5leTcutGm0YaMpkrv6B0QSSOamrDELlW1cNPRU1wh
        oLA1EM8QaSK4BR6pWuElbggZb+6zHrVlRC5fKBfouIeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FXWO8BWkbjSyAl5Ap
        6Kfru+KYv1KDGgUzEsYSnb0uoU=; b=vTjaQK4/kBGKkDHGQekEwljf6+KffsC6h
        MyjIBp4K+GW2J2vyCMZMhUZwGzfnRcrXleaYXy87TEESXa7gGX5SqzdRTGzESdk5
        AlGDoDlraJauhflyt34gfAEP8WW4BhzOOKYGB5TtfRzDT2ECeONkrFTlUMtqzZ4b
        0+mXQq/1+Y3jJJsV7neBMvmZ3EPxJ9+YOhikGuXPuj6j9IzGNo3aAbvUDKE2QkkF
        ghEU2MyWbJefRYDFTkOL8lTrZ4CY9nibxzCAqgy1m6P+Qhn/KgnAEN1aBHgG40/T
        +B+Jbz8qkxXs/IqiiXgB05NPLLxah1gbSdb+yanaVWXW1QIvkl7kw==
X-ME-Sender: <xms:LILIYBEkCBj_sxJ4fLh1RJ2ERITAg1z2b4kzFAa1_3k7TMURQxfFng>
    <xme:LILIYGW9gNFQ17e2X4wwvmrJBUEfIiIRwl-gvbh6QopwA2OB3AQAwCgYFsxJ639NV
    y2oNbjWYd_-fJmVO74>
X-ME-Received: <xmr:LILIYDK6dQR2ZTrm7RYsaPHHbOOu_ZNFYbGODvuWQU2UK7Q2beNF-Z18mE7Mut3TUB8r7ynetGt977G5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvjedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeevieeuudfhveehte
    elvdfguefhjefgffeijeehtddtffduhfehgeejfeejffelheenucffohhmrghinhepuggv
    vhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:LILIYHGfZPK5NoLrr_aOthfJOG63yGsxAtki6cz9v_CJZqbiti6Qlw>
    <xmx:LILIYHUth9J6xADsX8xo2fvszC3_LtaDFcm77FHsPTVGw_Hg-xO-ww>
    <xmx:LILIYCMVKPUZjnfSLmao3b5WjnTNot0zbwPm8YtyCunnTQgSKraRVw>
    <xmx:LYLIYOFqWNdXBUlX4ielz79sIU04lPszIVVpV3t7M_3I4cqzoZ9N9Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 06:34:15 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 1/5] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Tue, 15 Jun 2021 20:33:56 +1000
Message-Id: <20210615103400.946-1-alistair@alistair23.me>
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
 .../bindings/mfd/silergy,sy7636a.yaml         | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..9e50f57d5e8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -0,0 +1,73 @@
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
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  epd-pwr-good-gpios:
+    description:
+      Specifying the power good GPIOs. As defined in bindings/gpio.txt.
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    properties:
+      compatible:
+        const: silergy,sy7636a-regulator
+
+      "vcom":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+
+      regulator-name:
+        const: "vcom"
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
+        status = "okay";
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

