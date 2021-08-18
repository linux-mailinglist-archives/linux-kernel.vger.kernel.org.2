Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E03F17CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhHSLQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:16:31 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:54653 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238480AbhHSLQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:29 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0D182580AF6;
        Thu, 19 Aug 2021 07:15:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 19 Aug 2021 07:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=DiwHj+vaHXUQK
        XyQ9BUo+GIG90hR4W/o3+wsmuFsT8o=; b=dUwUjS98N7+fRQC2sMrgXvPNsVPgX
        mZJnfsfxR4ZtNStMi0sBqoS7TjZL6l3ul0kevxXsWHvfiQeaQkwsgNFZzeM9rKP2
        Y10MiNsrVWSTbubGbtpP5v+b+NjV7RBkenvV8Qpq11/vN5NM1OHpaqWKXDz2zoJT
        kHbnjgzdwZI4zyHrFd+f4m6Ykf90CW+cezA8r4bLepqtiMLydSsRyCeIHHiXH5/N
        6tw6wZxb/MuoovaIha667scvkUnE0GQjU24+ZOlBrU/yzu4nEYfZcF+UmgkZKRvb
        pN7JQ21qKOC3lRPkF9AuNomUYn9AcYP1xz5mJtMoqeAwT4Xv7ZQ+iR0PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=DiwHj+vaHXUQKXyQ9BUo+GIG90hR4W/o3+wsmuFsT8o=; b=ODNO3YSQ
        iDG+MWDheEwwWIGOBTUG/iLgrxe8jJrWy5zyBpDAUD0rSLIks4bVUJRXkhbBUfXB
        uo/B/PpScGMDHqev2YleYvpLauoPHzFsxwpVImWO9ajRYL8c9t4S9UsxeCUY6hYb
        qgtf9F/L+fvbWAorDef8ytKb30LI8B2ahjxX3TcEr1sLC6ZgSzMf55nl4RaLibk6
        +Xl9OSX5GQvnFkRgkaxlxX2388LlpJr5RcX6wrHxVA9PfWNtE/3g0PGlhXxQTAYE
        A2Xg3M8pP+zXR65bNZDIBYKWi/FIUXs6hINzuhiLqSOXzEC9FaDOF7/M6EvFrwMj
        wzLDL1cXPyZvCw==
X-ME-Sender: <xms:aD0eYRcMHobmF583C9mNvtaD7n6rRrKExKEPbrCx9wOV-l6e0Xbw_w>
    <xme:aD0eYfPr0Xg1Iy6r90yKw8XqqhpFgpKIFf6wQ-DAk4E-ASj5OpOS1nRbKnVgRDrxN
    cprTIj6MCwPsz6-X3A>
X-ME-Received: <xmr:aD0eYaggwkAYmlxYn7940vjUzk3o7xSAvKluUyO7PpQEYOVMR5Xfj3zQDAVKe3KCZDa17nfi0UG6gimi_B8ThAd2E0UwicmyZ8qqpsX1w6FZpkk99Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpefftdfhgfeggfelgfekjefhkeeigfelleefhfethfehfeet
    leeggeeggfefffdvtdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:aD0eYa9DwgtQ9fPBdPBQqcbHeLvgs4WyqEiibxllv5srE3cpSpaQeQ>
    <xmx:aD0eYdvPHe6LjE40Ujob8t2scQNoTelMmk38nvDBJxUSEMSu0JC8WA>
    <xmx:aD0eYZHeOjS-ukj28VCyAkwRbXbO9v5VfognfIjAmxzWjwkUzYJgfA>
    <xmx:aT0eYTCDWvlG_A6OZNLjK1uc9zk9YHQlvZ5vW6POM9z2sFF3DV5B5Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:15:48 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v11 01/10] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Thu, 19 Aug 2021 01:44:40 +1000
Message-Id: <20210818154449.1037-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip
and regulator.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/silergy,sy7636a.yaml         | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..0566f9498e2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -0,0 +1,79 @@
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

