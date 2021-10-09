Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20EC427BF4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhJIQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhJIQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:22 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B8C061570;
        Sat,  9 Oct 2021 09:27:25 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p68so14437794iof.6;
        Sat, 09 Oct 2021 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oY5+OZjNBJCaCB0Z7I0Y33zoAQCqpXgPwvgbrJrvZAw=;
        b=TXyMWVEXqafQoA7/2sVCl2maihOG0ssi+o1Y+Vx5etVO6RWFIrsLy9RGUCWQNuAcZM
         J61AvdZyN2xyoVqFLqj0f4KMfrv4HhCxNKYOyx5G1Krv/MjIScTIQck8wg+lqX1iqhcK
         huHfMvsu/UtwdGKPkskcdtI0SYD/Sw4e1OItDs2TxYfJ0xzOIxhBuyNQSj+DrVO0LAYr
         yI7JmvuI6hqo9y2w5bz5ouUlTACd+Vtv07GuJ5sIFvhHbFRMYGz/pIZReV1HgW08kc6k
         X+eEnJnsDFGux1MXj3S79egmTL4flGUY1OLpS1mlnaOwKCi+jmP2P6V3jjj9z2tm3StG
         MOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oY5+OZjNBJCaCB0Z7I0Y33zoAQCqpXgPwvgbrJrvZAw=;
        b=xiEcH6LRaSbPdHfGDRF3FTnvOf6O4Ad3U81Djpwq9N4iLRNAcvnzNllWAe4rHplatW
         P6nOELD2SW2V1qobD1H/PtLcgsxFXTKBzRVhLnT0iSXPX4sKnM7Vu0NQQQyB5Orzp1GL
         TcuL3t84WVtckTxP6KJCLj0oKmkotWDpkh8YqCIfA36y7DhSqhGHaj4avBpAGV4qzlPh
         YkijyEwXE9YURN2EgWdtXXiYOuFrHUgMg4NN+b7UFMJ9FYIMuGkGoJl8Jfb3VGWHIJ2Z
         nmimrB5+hY8yxHyqAGSguDNxTwllKc853Lf0ZxnQcAwVg7RI/avfQEOFXnMZRG57bXtw
         vvdQ==
X-Gm-Message-State: AOAM5329xzD44enx7j8WlMmzMRkGQzGIW6ec67tEZGIAD76dWKM6XkRh
        EeLFTxqfTd9hOQAzKT6K/VE=
X-Google-Smtp-Source: ABdhPJwXTHgGRCkyyUXFAutqhaEKGco21ku5vAjbioOvpY2ef4FEUdmNQ//R86lsTpzpcCjatQve7g==
X-Received: by 2002:a02:9522:: with SMTP id y31mr511875jah.112.1633796845226;
        Sat, 09 Oct 2021 09:27:25 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:24 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/9] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
Date:   Sat,  9 Oct 2021 11:26:54 -0500
Message-Id: <20211009162700.1452857-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding for the i.MX8MN DISP blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
new file mode 100644
index 000000000000..493b86658ad8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8MN DISP blk-ctrl
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+
+description:
+  The i.MX8MN DISP blk-ctrl is a top-level peripheral providing access to
+  the NoC and ensuring proper power sequencing of the display and MIPI CSI
+  peripherals located in the DISP domain of the SoC.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8mn-disp-blk-ctrl
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  power-domains:
+    minItems: 5
+    maxItems: 5
+
+  power-domain-names:
+    items:
+      - const: bus
+      - const: isi
+      - const: lcdif
+      - const: mipi-dsi
+      - const: mipi-csi
+
+  clocks:
+    minItems: 11
+    maxItems: 11
+
+  clock-names:
+    items:
+      - const: disp_axi
+      - const: disp_apb
+      - const: disp_axi_root
+      - const: disp_apb_root
+      - const: lcdif-axi
+      - const: lcdif-apb
+      - const: lcdif-pix
+      - const: dsi-pclk
+      - const: dsi-ref
+      - const: csi-aclk
+      - const: csi-pclk
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - power-domain-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    #include <dt-bindings/power/imx8mn-power.h>
+
+    disp_blk_ctl: blk_ctrl@32e28000 {
+      compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
+      reg = <0x32e28000 0x100>;
+      power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
+                      <&pgc_dispmix>, <&pgc_mipi>,
+                      <&pgc_mipi>;
+      power-domain-names = "bus", "isi", "lcdif", "mipi-dsi",
+                           "mipi-csi";
+      clocks = <&clk IMX8MN_CLK_DISP_AXI>,
+               <&clk IMX8MN_CLK_DISP_APB>,
+               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+               <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
+               <&clk IMX8MN_CLK_DSI_CORE>,
+               <&clk IMX8MN_CLK_DSI_PHY_REF>,
+               <&clk IMX8MN_CLK_CSI1_PHY_REF>,
+               <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
+       clock-names = "disp_axi", "disp_apb", "disp_axi_root", "disp_apb_root",
+                     "lcdif-axi", "lcdif-apb", "lcdif-pix", "dsi-pclk",
+                     "dsi-ref", "csi-aclk", "csi-pclk";
+       #power-domain-cells = <1>;
+    };
-- 
2.25.1

