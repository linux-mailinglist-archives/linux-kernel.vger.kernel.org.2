Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC63432F1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 15:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCUOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 10:14:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59141 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhCUONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 10:13:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C85A75C0046;
        Sun, 21 Mar 2021 10:13:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 21 Mar 2021 10:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=0OwfkKfuxQ7vIwVrLbGr1Kj+Dx
        0aIM+oAp+Ug8phIv8=; b=NVLtx0pZrtEeRU0Uhm/88IAfrcQ5jZlDzS+riglmKh
        XKTDYdy/rhyeDWAinR5KHUTTH/GqGtxAFAeqEn44e9fyuY8EJ3ymRtOT1VI/16zG
        1UQAcczjmg5+E0EKRwzgQ9NUNdSQebC5AD2LqcU2G0bN06mIxoEbV8WdR75p7IbD
        hVrAhyR2MpnTZbdnr1JJ+27J96VTrY6i5t1Z9+tPdU3TWVnBdarwGal5jkT3wV6e
        6x0/UoxG5KH1H0zEYT1zfhTyIuuYN0VQiP3JI8eZAGFPeFyMXNm4Pw4vxNTi6ZKD
        z9eDgISc7EJzbcjsfZuLwGe5sEzxI+QYpkmm+g9pmWJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0OwfkKfuxQ7vIwVrL
        bGr1Kj+Dx0aIM+oAp+Ug8phIv8=; b=FjQB9MBwlGMIpdLxHV6dHoZDQVICqnGCx
        DUu1ha+05DqHF+E44u4+YBajdKwfI9igxkvxdruaTS1WPeN9vNKBJF6wUorb7cmS
        2lseaRvl51GBrGuFKNdro6ny8wo75PjoYTVyL3Ty+A45uPRpEORJQ8r17UrFwsjt
        bQ4DjkOe8x4iS5JD4wJ7l9hNihBvNyGSvNdsywGt5QBdK43TfEvZqgGkWsduM7fT
        TM2OWspdt5577PoxEp4fpY+Mf277xKPr6eUcymJJkcsIB9uuADujq8/O/KOcrp0/
        p5bHsAX08BbYLZ75wmfx5rmEGRBjkUXRL7b7ViNuYsxS8Kifqp1FA==
X-ME-Sender: <xms:jFRXYP8Ggsw6w8JvyUlSd32dYjxYnfXQ1FjH68hjEdCgHtM9QQEfjg>
    <xme:jFRXYLswsMLgTrMIWSn5UacuooQFQ3n4TzC-uYJr0TNb-96GLiqHWi5zxXRUhmNq9
    Ap_cshzr5LEfXKhS7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegvddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeevieeuudfhveehte
    elvdfguefhjefgffeijeehtddtffduhfehgeejfeejffelheenucffohhmrghinhepuggv
    vhhitggvthhrvggvrdhorhhgnecukfhppeduleefrddvjedrudefrddvfeehnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:jFRXYNAZkT6mgF_Csg-ETYaCYDmT5i8euLptOtWYRS_vyQ6iyNmQRA>
    <xmx:jFRXYLdJnHGkO91HPf9daP0f4KdWxvBzC-KqyFb1xNpqIEWJAENsig>
    <xmx:jFRXYEORvayLrOljOfqKM3yVAP-5vGKhKl_W7TSpLd5U1nIhiR60vg>
    <xmx:jFRXYAAqC2jUvv9go1thXrLkN_dvoh5iaJ2MG45N-IoF5a7rc4VflA>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA5F8240408;
        Sun, 21 Mar 2021 10:13:30 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 1/2] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Sun, 21 Mar 2021 10:13:21 -0400
Message-Id: <20210321141322.298-1-alistair@alistair23.me>
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
2.30.1

