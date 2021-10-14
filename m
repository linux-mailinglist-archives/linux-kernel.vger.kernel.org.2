Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4107842D0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhJNCyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNCyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:54:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734CC061570;
        Wed, 13 Oct 2021 19:52:42 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s3so1969550ild.0;
        Wed, 13 Oct 2021 19:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmAdnBpF9m+zRKAxIasG4Lm9idjhAcnVvHr8JQ4A/rI=;
        b=W9RifGoh604jNgThU8UuYdhIXvWcXdSX7bdFStEu6ZUjY6mM2DosiwPs/hPCY+lWHl
         9IYHxOdfnWT7MxiP1qFRHiI0V1OMEiMQlnewB79LS6HYlfuOEmiDKbdjRXy+sDfL0E2w
         bDlrF7hv11Pk4pzEMmQjOB81HZhYT5mkuBHnhsubgtUUZCcsD8c7zDuISc/Epz7VSXzh
         6/2Ik7xfX7/BQrC0wZPYLkSqOG7vhPKZ8/oy14XpXZm15L3riRUS2X4jlKcBj2Cuk2i/
         ywKPJ0wz3TrvZrNOc10+bAfcVeyLHKUqTjJeHJK4NpAmcIYEQFVRGSUoJjh9Srg76Cj6
         Fdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmAdnBpF9m+zRKAxIasG4Lm9idjhAcnVvHr8JQ4A/rI=;
        b=Y3AIxiQSEENcQypXTabZXTO3n946DZafi3rVMWdiDEXWrDlcofvxEQ/09nnzD6w6hx
         dbkBmbDWRqcNw/F1UCxWYA1Prbe6WGfWO4Up8H5UCWQZr+ExUHqGm3H47zieYVkhkqIz
         ej7vywQxlYrf/gnbeHR62QQJcSp3KWiciWubEliBI0uB50dcVFFA8OtweNe7iJPATa77
         cR/xDlXqII84MUTbQ4gfCswxr+W46rFygbbhbfcAmpDf0gc70g8M0713JpIdMHEXhStF
         tRsghr8TMI4F7FU6pmoHujxtvqZvSwWLrnvAX80fK4+oQvzsGe9xjFHNI5RbQ4CTipB2
         MHhQ==
X-Gm-Message-State: AOAM531n+HwCMUeCzXfC6XSyX21SS77LhMjy3kEAaAOCVXMBjZMWmIs8
        467vSS6PAZCM6ohjFQX7GEw=
X-Google-Smtp-Source: ABdhPJzgfgcqBZfCrzhW/IwuzvVuyv88OevKEFNCNKbDJDN8QKgOPUlbZB7dBy9JnBOEUS8e/+Cntw==
X-Received: by 2002:a05:6e02:1a43:: with SMTP id u3mr466283ilv.35.1634179962261;
        Wed, 13 Oct 2021 19:52:42 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:904d:9f1b:d148:a9a2])
        by smtp.gmail.com with ESMTPSA id b7sm572093ilq.65.2021.10.13.19.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 19:52:41 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm: Add CSI nodes
Date:   Wed, 13 Oct 2021 21:52:34 -0500
Message-Id: <20211014025234.145147-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a csi bridge and csis interface that tie together
to allow csi2 capture.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..8a8a5d0a4a1e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1068,6 +1068,22 @@ aips4: bus@32c00000 {
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			csi: csi@32e20000 {
+				compatible = "fsl,imx7-csi";
+				reg = <0x32e20000 0x1000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_CSI1_ROOT>;
+				clock-names = "mclk";
+				power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;
+				status = "disabled";
+
+				port {
+					csi_in: endpoint {
+						remote-endpoint = <&imx8mm_mipi_csi_out>;
+					};
+				};
+			};
+
 			disp_blk_ctrl: blk-ctrl@32e28000 {
 				compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
 				reg = <0x32e28000 0x100>;
@@ -1095,6 +1111,41 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 				#power-domain-cells = <1>;
 			};
 
+			mipi_csi2: mipi-csi@32e30000 {
+				compatible = "fsl,imx8mm-mipi-csi2";
+				reg = <0x32e30000 0x1000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <333000000>;
+				clocks = <&clk IMX8MM_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MM_CLK_CSI1_ROOT>,
+					 <&clk IMX8MM_CLK_CSI1_PHY_REF>,
+					 <&clk IMX8MM_CLK_DISP_AXI_ROOT>;
+				clock-names = "pclk", "wrap", "phy", "axi";
+				power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						imx8mm_mipi_csi_in: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						imx8mm_mipi_csi_out: endpoint {
+							remote-endpoint = <&csi_in>;
+						};
+					};
+				};
+			};
+
+
 			usbotg1: usb@32e40000 {
 				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
 				reg = <0x32e40000 0x200>;
-- 
2.25.1

