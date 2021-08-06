Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD83E26D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbhHFJLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:11:33 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40015 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242767AbhHFJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:11:32 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id CCEC05C0069;
        Fri,  6 Aug 2021 05:11:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 06 Aug 2021 05:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=VEDE2BLIpf0ev
        X9WccmkC2h6O8pdz1/Qld9JBV1z04s=; b=Hgi7lmrLBkpuBXRHz48+U075H9mKS
        ndy9Lb+JJ1Wmu9xbx2kKHlRPYlP5ZDAiu+NIJ8RwiDIH+0DsGJedtltvvpZnz16o
        0TihHSLbAG2aA8pPcFsB+BynqbyYzXahD1xPYPsyDnDxENLrz02HlRy9W1+J4UIJ
        wS/YzGh/IriVE19RGV1/52bQfv5fH4jr7xdh/v5MY/HTXr0qAvwdiY1Ln+YYViCS
        S/HFX3a70ubifvp5G/nz1b6H0mvtFH5mCmv3mpJDJJWvddjBV+SA6GMndH1VVz7f
        N0oADDjZOx5b0HVmX3Fa8HnFiCpnYTJcOs02JDr9BB1NdABbAes4jBFPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VEDE2BLIpf0evX9WccmkC2h6O8pdz1/Qld9JBV1z04s=; b=KVQ3fgE0
        TtCUegMQ+cU1/NcDtCQXfZxuLjNXtXSsgvBFCT+or1aAHg5HegAb0Cwngpp8PPJr
        w/o/rFYUOHai4A/9BFO+m6W5nRZTTaiys2RVj57Lvi3j1ZpHFCxQBvX9d0u8Pyho
        3+OGjvVJ7jqZ+x3/y6rcX0JaScKfImk3FLgYS+IJNelQgTbhcbPHrX4M4dAjaOt2
        we10TyipFQF3AyjW8uxD2xRxyUtxUKPkc+mM6qqCqVb7C4TON9OnFYN/Ms1gPWqj
        88u4dUeJYB1QCQ63q5u1es1nDdvnyACo8xW4/3IsdrGpmwO41nQaTvMc9hRG3q3W
        CrFjpfsnxQ1TcA==
X-ME-Sender: <xms:tPwMYZ-HrZXgx7kgptzWeCOMxkiSdIovZ7lzUTHeIdXp5NVXFxhcMg>
    <xme:tPwMYdu0RdPgFv24N0vyairnA0YDu3ZmB0lZi-kEsDb77WpokS4WEsttfJFktoxSc
    h7DcBBxbxUyptPMPe8>
X-ME-Received: <xmr:tPwMYXAbbzB0BcY6pzEICWyx6FPpFegTYzRQiz5hdbY4MD8-7xTsIslreL4kDx-sONanpxyg6j4oOog_e__3dm5bVJWH86QRZ8D0ZrJO05BHRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffdthffggefgle
    fgkeejhfekiefgleelfefhtefhheefteelgeeggefgfeffvddtnecuffhomhgrihhnpegu
    vghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:tPwMYde6GCL8xNUk1cUZo7b7p6fSQA_QBVNaQu9SzXt8R3P-a9FWkg>
    <xmx:tPwMYeN73Khzl724KTJj9RWujhpLkF2HOUZGGhtzWne5F6a_6-Clkg>
    <xmx:tPwMYflNWY16E2B04eJB_z6dqg8tA0y6rnUfrmxjqlJXumsJOtnCow>
    <xmx:tPwMYdcrwjVR5Yh4Gx-SeXu7P1xoFTUUlc5lkVOCUHRt1roLDF3Utw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:12 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 01/12] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Fri,  6 Aug 2021 19:10:47 +1000
Message-Id: <20210806091058.141-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
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

