Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9A3460670
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357711AbhK1NYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352717AbhK1NWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:22:44 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F08C061758;
        Sun, 28 Nov 2021 05:19:23 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id t8so14122345ilu.8;
        Sun, 28 Nov 2021 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJw5AcFi8obUkIcIkKbrZqnV587fXxOec3+l7+Bf4+U=;
        b=FuypyBIAu+XfStW+nb07EcPD3HInW6oF8fQyBrZEbPOjJo/F6W80A7VEwRnat/JOd7
         os8jv5pmvUp7fg1usfb9D7JVNH4Ld6pg/ZBfRJVqMG1AZ1XjOSFbgRzEnSRiqZjEG1L/
         qzVT5q9qfKoqQXNPbP0or00DuyT2PQZQ+ZcoFLD9k9PO+NklZ5TpLPTY9wXtZnQVTNP1
         M78Qdelro9p0L0jp2d0WNH423z06yPwuBqdskfO/iTigRrP3y4uL61ShPet59BGxBFio
         3/bX2jRNQYgxZcO8aQfmOEapBU/WziAPsprN4E58FSRmbMaOjfSt/8ruhyiRiudPtpx7
         n9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJw5AcFi8obUkIcIkKbrZqnV587fXxOec3+l7+Bf4+U=;
        b=ApUcVJ61C9QM4T2VeRukyWkQkqFN0ZQgy2wW1gIlZfVKYYwroaBs//N4RYHVFJB/hc
         buFHJdPrzpjcCZoGW1lLuyx3NeLKAYOP/jWl9EGjm01xKj+cqq4GcoRjBzpo87k82n04
         zSkk5FTFqMXcFI7k+L/EqMWvwHFs5kJSUccrDp51v5QagIEPiJ0feNycQ7yboTRiDcvC
         TUWnr/0W/HfdqjpVB6Y8HihyWD5LbvwOxUm83KjI74sgHd6ssWQT5H4fXc8JVTuEnsr4
         bKbMwbexZk1xjKxQHK7/ucrM3g13Sl+YiF2PS7e3Sm9nkE21aw171eWff8RZfQWwGpky
         1JBQ==
X-Gm-Message-State: AOAM5321sPflIzVitHWK6jbHXTEj3dx93xXJUlxZbu1wwkP26xpfqTs8
        qfjZwzoRZBlUxNdZQg3JPbA=
X-Google-Smtp-Source: ABdhPJxUkF4D2c6ZBki62Tc5NzFTgznK9pf+/l6IGq/ZRNOuJgNwuItCKyqKS9x+mzBnCWso82GiGQ==
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr42878117ili.14.1638105563229;
        Sun, 28 Nov 2021 05:19:23 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:22 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/9] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
Date:   Sun, 28 Nov 2021 07:18:47 -0600
Message-Id: <20211128131853.15125-5-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
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

