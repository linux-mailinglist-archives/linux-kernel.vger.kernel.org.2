Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1B84234C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbhJFAHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbhJFAHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:07:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5CC06174E;
        Tue,  5 Oct 2021 17:05:21 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i13so1094263ilm.4;
        Tue, 05 Oct 2021 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAkXeFy8iFivf1XRGNuvjO555eIFq0kOCrxJ9EswG8c=;
        b=AKlby4eJObsm2EFkImU5h9zjJFSYFMCkcaoUKlw35sVrYfmMg+JS6Zfikcod3OLMw0
         KhP8e0z5xrgwwKH0CGmdPTrsonhjIZt7FGiQwAJuwrTa4hH/A5lI7c5y/bi2Pmh3NbPM
         kMNQYrMH4Ab3DBpQL7Vf5D6a9x5wsDFRuXnvKFKfOdkjy8vRUwedIPJNGWyfr3ruOhB8
         6inu1TIul6mq+2fTgNPHnQNwIB+zJYHSt6kkLeDdIlM+Y67eXs3tz2Z30g4XnFP3EoA6
         r9QY6qLewcO6gpnh9gKSC6CXQwu7TacZ+2FqMjnUxMMhlFwcZ4wwZL7nNmtBSXmhxP/L
         Os7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAkXeFy8iFivf1XRGNuvjO555eIFq0kOCrxJ9EswG8c=;
        b=jRKifQX6+rf15tW26+xna9S4nP/yQf3fRA1hr5RYYvA7JQ++TyeHOPCEm1qVRNuvh0
         48K3XNz0+d8mvrHL/3etEpnFYZKPz/SWnDtglKZ0O7EUfmGxYR3nbwWYPtH5oF0SmXJV
         LOrjsNheD4aBlatmZ+7F4tfJ4e1QlyqLsdZq6DbmL7t1X+8V+24kNKbYgRAZv11Sr9/z
         a4fRoRzn9geEEg5LXcrx0u7HfyCU8pvCzqpusb8bLKLbRg0s9mFVcFxopJjQm6/xspId
         Igdzgqs0iq1zvQ04IR+AbPtcIC+O2GvJGMjjMS9cwB+USg+fZNs21XBdY+eA+WmTuhpm
         sOxA==
X-Gm-Message-State: AOAM53363shAo/baDC7fhOmPxEKdCtHx2KpgxwXFm4M0GLY692kHEl9b
        StbGL4e1ME82mwVAbkx3264=
X-Google-Smtp-Source: ABdhPJzbNvp4A+gMfoIm3tiVfdlUgTlItIRd+YmuMZAqa76iVVoflkkR0zDjDxuED61VLZoNDEz1Ag==
X-Received: by 2002:a05:6e02:1d18:: with SMTP id i24mr5294632ila.182.1633478721321;
        Tue, 05 Oct 2021 17:05:21 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:94fc:9a4b:2e18:e915])
        by smtp.gmail.com with ESMTPSA id y2sm11338646ioj.12.2021.10.05.17.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:05:20 -0700 (PDT)
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
Subject: [PATCH 2/7] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
Date:   Tue,  5 Oct 2021 19:04:59 -0500
Message-Id: <20211006000505.627334-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006000505.627334-1-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT binding for the i.MX8MN DISP blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
new file mode 100644
index 000000000000..92d30aff446e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx8mm-disp-blk-ctrl.yaml#
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
+    #include <dt-bindings/clock/imx8mn-clock.h>
+    #include <dt-bindings/power/imx8mn-power.h>
+
+    disp_blk_ctl: blk_ctrl@32e28000 {
+      compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
+      reg = <0x32e28000 0x100>;
+      power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
+		       <&pgc_dispmix>, <&pgc_mipi>,
+			<&pgc_mipi>;
+      power-domain-names = "bus", "isi", "lcdif", "mipi-dsi",
+			    "mipi-csi";
+      clocks = <&clk IMX8MN_CLK_DISP_AXI>,
+	       <&clk IMX8MN_CLK_DISP_APB>,
+	       <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+	       <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+	       <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+	       <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+	       <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
+	       <&clk IMX8MN_CLK_DSI_CORE>,
+	       <&clk IMX8MN_CLK_DSI_PHY_REF>,
+	       <&clk IMX8MN_CLK_CSI1_PHY_REF>,
+	       <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
+       clock-names = "disp_axi", "disp_apb", "disp_axi_root", "disp_apb_root",
+                     "lcdif-axi", "lcdif-apb", "lcdif-pix", "dsi-pclk",
+                     "dsi-ref", "csi-aclk", "csi-pclk";
+       #power-domain-cells = <1>;
+    };
-- 
2.25.1

