Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E85445716
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhKDQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhKDQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:13 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32454C061205;
        Thu,  4 Nov 2021 09:18:35 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i79so7220115ioa.13;
        Thu, 04 Nov 2021 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ftr4HvATWA8R2D1hs/XQ6cE+KuTY1wr4XbGAaD8YFZA=;
        b=AkIpupy0hn2htAB7o2AIrekPD2joEPWdiu89amAoS4yfLbZFOAbOuMqIjm4Lo6oY8C
         dg97kmwNKgMchd0XoRosLksEy/V9+LHvW0YLLwCtwtyHGUmytGjZKF5D0CPYZM50vlhe
         xxl94pqJZo7oznuYFa8kK8w1mk2GbtC4+IwM/0e6S03Ntx0CaDey5CFYcDEP7RqANcTP
         zacoeqHWlfQlb8mpq89ga3n3VLHy325vscwCrXvA/DIoM5IKol3SdC96G/DIC4W2YtCV
         OiG3V05ujIrI1lahRQ7wm3GTCv/JSbomvTMCjXtnGHtYVy2Ol7GrYaa7LZ4O578zkmIE
         Ca6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftr4HvATWA8R2D1hs/XQ6cE+KuTY1wr4XbGAaD8YFZA=;
        b=o29xvH/38IOai/aVmD+xH1oYPknoQ/qDucYTZ6yBQ0RA5y3GQ4O0xkNpb5Cg39NnHq
         ubL4n4Up1s6O3DyxZSStTxjaotyQ6hK/L+rT05GsdvxNNqmIci6GC7SZIIZxisHEwNQf
         VolT4joeJFca6eJoiye40MeXqLy9q7bID6FLnyTP1YkIsxigC1pnwy8KBQyXifr800Iv
         uNqtPtG/uMoiq9qhoqNSh3IhMHmv6bkWivwU7tJsBsOJaQ7czl/xLicKB4kFasmkmiEp
         cT2a+EZTfVi4t4MR9ykL0Jxie+zVD/ooKJ/Hg+2qhd8YyFPM0N0AkAcBToSU2GfhFKRA
         Vk4g==
X-Gm-Message-State: AOAM530K4X33edPvPgcxcdOsXVA1i3LiTDu/RFCVuGg91q8ecafN5E2d
        ipvjvSeTsGpxOsHniu7m4BA=
X-Google-Smtp-Source: ABdhPJwZhnwBMuUJaLYXLbet1nMh9x2zCmpzWsi3UpK0KxHASthUEsM6traSMHSoPIVWHRAWo/yU9Q==
X-Received: by 2002:a5d:964e:: with SMTP id d14mr36692270ios.45.1636042714523;
        Thu, 04 Nov 2021 09:18:34 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:33 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/9] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
Date:   Thu,  4 Nov 2021 11:17:59 -0500
Message-Id: <20211104161804.587250-5-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding for the i.MX8MN DISP blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
new file mode 100644
index 000000000000..fbeaac399c50
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
+    #include <dt-bindings/clock/imx8mn-clock.h>
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
2.32.0

