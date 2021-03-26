Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29148349F35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCZBzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:55:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51761 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230324AbhCZBz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:55:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D48F85C0101;
        Thu, 25 Mar 2021 21:55:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Mar 2021 21:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=tSssrKGE1xrYAd12+7AP9DGEGy
        sEBms2IXWgsJtNFns=; b=PJQ/8oyrA8DwbXJTDcCzps2077AAFyv7TnpT0b3GYg
        ZiTujGuMu4WvOPcU/OwuR3fXWlu017CCOhq0XI2Hj2vW1d2MK6SBKocxYiHTBzRQ
        HmONguOc77HEpYh8hZIASj9j+QDXwwqT3DBlfzCiqWuWh1is5SQu1gAV/vN+y6ah
        tEJS2LWr9UvPhZfnF1DGTNapW9k8Rfl36nZV1VBobCjmyTjKA2nuLKxE0exPCs8X
        J9+SlrMROOs05FKflUrmCJO4z/bYcu8Bg0e+8JPmjic5jLiAaSh+OjEouecC98tn
        pEqj8cPG3xE2X4QM0aKu3kgS2lT9QJyGG96XRik8V84w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tSssrKGE1xrYAd12+
        7AP9DGEGysEBms2IXWgsJtNFns=; b=n8OG2jAUwFYn+wkDkTiM9VDjGJnNRItQk
        LjLAoFwhuB/NyabIk3QbejvsOfDVGDD8KPuygcHLq44kmIzBb0q6eWmjtonwRouJ
        idBV+EGGyQzFQN8Esbtd4BrVqo4Rm23JF9TJwvNJJDD6LikXYmDQSMLlxWVPkbI5
        Ug1Z69GSals3uHjBT4qaLLXcevTjsa0G83L1ErC7RZ/qBdtvcHZIx38n5EBuEs8Y
        aasmvC935KygR6NwVHa9iAdfSGv9eMdEiy5gmLLC+IjVyHyHQux9bqFbAJ+fkVmM
        I5ttAqV8KAf4fCYoKyUkH8AfxxGgZPr915FEzTzLFV/AS31TE9k/A==
X-ME-Sender: <xms:DT9dYO8MtG-SirlDgws7GPE9gNxqgnHaKu5vQmC-qiQRNw1PzH909Q>
    <xme:DT9dYOtXkskg4bkQ8R2l0HW3BQsPaWNf65SQ4bQBFkcrfToWs7se0eNfRbaAdaPJM
    PBbAOZIFNTv1r3MSzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeevieeuudfhveehte
    elvdfguefhjefgffeijeehtddtffduhfehgeejfeejffelheenucffohhmrghinhepuggv
    vhhitggvthhrvggvrdhorhhgnecukfhppeduleefrddvjedrudefrddvfeehnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:DT9dYEDpUBxOGrwTY0eNObVC3qc0wO1f751Pjz8pJEPAqftgcg1paw>
    <xmx:DT9dYGc85ov5yhCaDHBszWb9_AochNVpxHYm8V9NybwquABsGYAj7w>
    <xmx:DT9dYDMGhKheb_AkzPTZrs2jSIbiWfxswcGUvlsWL3Yb1KaPV1xyXw>
    <xmx:DT9dYPCLiuy9onn91p6rzPgJOP1et4IEMHu738ETTQTb-0JSnHeRNQ>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF5801080054;
        Thu, 25 Mar 2021 21:55:23 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 1/5] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Thu, 25 Mar 2021 21:55:07 -0400
Message-Id: <20210326015511.218-1-alistair@alistair23.me>
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
v3:
 - No change
v2:
 - N/A

 .../bindings/mfd/silergy,sy7636a.yaml         | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..f260a8eae226
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -0,0 +1,63 @@
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
+  regulators:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+
+    properties:
+      compatible:
+        const: silergy,sy7636a-regulator
+
+      regulator-name:
+        pattern: "vcom"
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
+      sy7636a@62 {
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
2.31.0

