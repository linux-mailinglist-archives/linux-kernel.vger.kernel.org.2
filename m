Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BFD363DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbhDSIlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:41:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38559 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231193AbhDSIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:41:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2067F5C00F0;
        Mon, 19 Apr 2021 04:40:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 19 Apr 2021 04:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=h2/102y7KFubPZu3F29MQRUxvR
        zSMvSp7JzzGudzr2E=; b=hMJGai/p3D34sFRREfOJez12w37GiBoAGd3XbH2fP2
        aolqtblegakuTtJ5rEaiNPtRKUpao2zfhWjeOmK4Fa6Kzg2/1olSucEC28s7x+6v
        8Nbe2yW+EKWRHRNINUVrvbD1b4/hWlN5bw0rJvTwPxFjj/jcbHkf4wr07/xs44kh
        s+o1WDVMGMwTmGWqqMx8TTFairD3mySmUqceBSCL6fWUwp8qqvw3f2+afBUV7RW+
        mO6RWXLn3X43r54zPWDDrjNC8qZLuk1qlfLzixIWZYK0e/RnoS5wf0GkihNQ9Imn
        rTNUQBBXkvvLkkujBcYfWxvGqpx9bhf5ANLGw9bDlhxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=h2/102y7KFubPZu3F
        29MQRUxvRzSMvSp7JzzGudzr2E=; b=alSWABtCe55VzD8wPyGDvsskUkLWkeHjw
        a/If3ZWTZdjdlUwfrF+HP63i2Kn8SuFvg0XIWRG3vY0J4hRqOMdTvDBXpkpK5ued
        Fo9yIGz9sw816TmwF+oA/iLt//eUX55i1zJ9PRMP7tAtHxNjLrVhqu23/oqd+ApE
        HFBDpf2d8VjAll7rMc2h0BuzxA9UysQVesFLCJG8dOiU1EwpP79XgntuBPj3rZns
        YVfBA42OuWHtdTh3t5GQ/EZPP3DuxZ1Bf5/Ne2pn8CICW5yzMfh8+Yid0jERJkdV
        HWlX+Lgux3IRZl//hT1ZzG9JHL14X8hbOFzf0hDqGCtfzutt/OYgw==
X-ME-Sender: <xms:BEJ9YLnSRAJmxbEW65Y8DCeuinMzJF6IZAmILEnwhS9hDFcEwN8Tyw>
    <xme:BEJ9YOxvoeVwGtBE28_9uE8jMtrqb-4iDIywCqJOuhhp4SUhajwgexjIhAnVkkexx
    U2WW3iC71KbAPUb680>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeevieeuudfhveehte
    elvdfguefhjefgffeijeehtddtffduhfehgeejfeejffelheenucffohhmrghinhepuggv
    vhhitggvthhrvggvrdhorhhgnecukfhppeekledrgeegrddutddruddvfeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:BEJ9YOik_0aFa8Q2Kqcr97V2qmn91K57KHnXMcUfDdEQXDGY47zPGQ>
    <xmx:BEJ9YLWTjOCxv5OxjSS_51SlHTDv784K_hQWMvfFdGDGfqEw0XKt-A>
    <xmx:BEJ9YI2Lahhc0yIxTyRsdIm9q46Rvlb2j9wiCHKvLOp-yDF5Od48jQ>
    <xmx:BUJ9YB51gPcrjGoXpKa18Ms8nxturZus2jFhsbJxPC-ZxOd3YgxQPg>
Received: from ThinkpadX1Yoga3.localdomain (unknown [89.44.10.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id 19A031080057;
        Mon, 19 Apr 2021 04:40:31 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 1/5] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Mon, 19 Apr 2021 07:02:18 +1000
Message-Id: <20210418210222.2945-1-alistair@alistair23.me>
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
v5:
 - Improve the documentation

 .../bindings/mfd/silergy,sy7636a.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..83050c36acaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -0,0 +1,70 @@
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
+      $ref: /schemas/regulator/regulator.yaml#
+
+      regulator-name:
+        const: "vcom"
+
+      additionalProperties: false
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

