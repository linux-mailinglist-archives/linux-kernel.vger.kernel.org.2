Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07F3E34E1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhHGKkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36531 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231990AbhHGKkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D66245C00C2;
        Sat,  7 Aug 2021 06:39:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 07 Aug 2021 06:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=VEDE2BLIpf0ev
        X9WccmkC2h6O8pdz1/Qld9JBV1z04s=; b=nNP49X2VXp33QydZPgeUp57KbxgmK
        PY7YhsgbwLLP8LIjB434b9gxJQ7gWL0lIO6m16DjvbYLw7+HSrFVVAAmDjFl+kqg
        +Jd95NBlbzT1A3oIFhivvMKl7T0FUzcBZsGin/J6YjEH0pTXVwp6T3/v/OMJiSFo
        ms0e2cRejoz4m2fjyHzlBOINGGqENasMSiQKCXjBQYErgwcj0f/MNT9ORLBsijdL
        wpqncdXlvj0r07royBb7r7tydQijVNynq5ab6s13H/yFznGCNrBifOjvCIB55wMf
        sW5FA7NRy7CeMMrgg67jwb5l8xD1Q521cPtWcFnAJ+Jan6qJN3bC8Bzaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VEDE2BLIpf0evX9WccmkC2h6O8pdz1/Qld9JBV1z04s=; b=c1+8fXdA
        ENgt8CN6n2wun7BNpjM7EgkH4I60XEkJRe1P9wF6qZrnGmMkIJIWiPT7NTcMfH9A
        MCbXo89Kmr9y2mu1cjtyra8hmDsvSlE+EpFxhHnL6Q25GoC34oKY8pvkviaAtPA8
        s9sakCBxOT3RhZEdECA8FGs+ip7A0BFDbGVX8hPO/6SOPN2vCZ7Xw0gxZjNFeIRt
        uaIYaPWIiz6JVNQSJ2JSUyyE1Qamhh485uF64cTvyS9K+F1fvJNLBi8Dri/vBI8d
        viYkn7QGF8a9KUwoDC6Bh3V5ylG4JEamPywLNpacWrW+n5Riaz+57vcBn82BMSeD
        zbPBQPu8p3LMKg==
X-ME-Sender: <xms:_WIOYW1qZaxlJJSh42AcK8sizS80pOYRL2vj5_M0Atwb0spQOpXmFg>
    <xme:_WIOYZFaPm8tjRBVlcQo4UArnPfw5vSTFWuc4cltOv7K-9MSeLiAmGztLQtzPr4LM
    IkEN1uoOAV7tXZL1bM>
X-ME-Received: <xmr:_WIOYe4t95U7HrUtjppyp-pxb51DLY-GfgqcLV0vCEvbu9RHCU8lG5wWdfR6r_RgzznLCvgJEmoX2iyaz36f7XzLSqlXDpWWfdpdZmOwcJnPdMFwYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffdthffggefgle
    fgkeejhfekiefgleelfefhtefhheefteelgeeggefgfeffvddtnecuffhomhgrihhnpegu
    vghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:_WIOYX3Oze3XE3a_CiRrLewPFwLonEAJVcxGHgVSMKLvbRpSU7VgHw>
    <xmx:_WIOYZH9pCX-pZLyNq1CHih9e5ZM37a4U4ss9XSjjB_W9Zr8LdWhNA>
    <xmx:_WIOYQ_ZokM1Tt0EEUNKDXubpMe7ilk4bYESBctGQZfZKNN8h9EJMg>
    <xmx:_WIOYQ2rpxfjbROkBmuBumLEWXKY5kaPvJYnuVUf9yk8MNN9PEJfVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:39:53 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 01/11] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Sat,  7 Aug 2021 20:39:30 +1000
Message-Id: <20210807103940.152-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip
and regulator.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
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

