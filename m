Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D636F460645
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357503AbhK1Mz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 07:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbhK1Mxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 07:53:53 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C1C061748;
        Sun, 28 Nov 2021 04:50:37 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 14so17405841ioe.2;
        Sun, 28 Nov 2021 04:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zF5AygEz5+OHo26V18w4VHwZbn9xlxivKPIQEuf7sw=;
        b=V09imOpwejqgrElEhKLOOXiP2LkPDXpGGRwmT/l05RowvJjI33Vk7y70XtamUhDmSr
         WIa8DK3MDOVS9mzqMdwJhJy6/Vxook0eGYkL5M2nDrAy0iGZALbHTvs6bnNJPSO0P6I4
         8X+I2ilf+TgPfP+1vRb1FfecDu30o1MyahNvAxmfNJ2+zVX/32pG59eu91z7qk519IqZ
         ffoauv7prbB8EdiURb3p/3s5Nt3dgO/5QEYPaxrUJZmp8hZH6qcu63C4Nvd/NdMa1IYD
         PxsQhRRo4VMvAaUz4G5Gsl3rGu+O6ewo3SFcMF/9LUpoCl/E91PAnlHQsq7E0ZEbYuAC
         1eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zF5AygEz5+OHo26V18w4VHwZbn9xlxivKPIQEuf7sw=;
        b=DwMsKkl7Iba0MmbBpJKg6JBALUb12eo0Bk64dBXu1pG54/S2jOJ57+9eJQJ21tyTqY
         jpOefI7gAKVVlLHGcuAum2VmVV4OuSqnv+rPwuvtSfLJanUxaabcKAXMQU32SRsHdBuE
         TNEECpM2rLWo/77H8s8LmFl8J8NVYh8ZQz0spxufBedIKkLAuVlidB145fdvGcMsCcBI
         har1etW+9Q3DZudPvSxxL0FIb2ugT0yY6L+k4+V/Nn0KqV+uej1DBdp0X9dpNPihkbXc
         Qgy8d1N0bV9aa248R+Aze+P5fxc3j8/LYShIyzhMM3G7oFiRuLOhc1o8eBeZX5UgBQeH
         1+NA==
X-Gm-Message-State: AOAM5309j9XA8Z+XmvwvTqtmWQp/gOUXXBCuAonT78qGijVQ0AHG79w3
        c2mq3xJvUbd2A7CVVXUa5vY=
X-Google-Smtp-Source: ABdhPJznO3n9U7FsarIUrvOXh/o0MsSeT2U2+YkVGHztqGrF1nIcMBb86YT1MKZUEzLuYVneyMOLLg==
X-Received: by 2002:a5e:9b0e:: with SMTP id j14mr52998522iok.127.1638103836700;
        Sun, 28 Nov 2021 04:50:36 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id j21sm6545240ila.6.2021.11.28.04.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 04:50:36 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, tharvey@gateworks.com,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/5] arm64: dts: imx8mm: Add CSI nodes
Date:   Sun, 28 Nov 2021 06:50:08 -0600
Message-Id: <20211128125011.12817-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128125011.12817-1-aford173@gmail.com>
References: <20211128125011.12817-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a csi bridge and csis interface that tie together
to allow csi2 capture.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  No Change
V2:  No Change

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 51 +++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 5b9c2cca9ac4..a31cf2b9769c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1096,6 +1096,22 @@ aips4: bus@32c00000 {
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			csi: csi@32e20000 {
+				compatible = "fsl,imx8mm-csi", "fsl,imx7-csi";
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
@@ -1123,6 +1139,41 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 				#power-domain-cells = <1>;
 			};
 
+			mipi_csi: mipi-csi@32e30000 {
+				compatible = "fsl,imx8mm-mipi-csi2";
+				reg = <0x32e30000 0x1000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				assigned-clocks = <&clk IMX8MM_CLK_CSI1_CORE>,
+						  <&clk IMX8MM_CLK_CSI1_PHY_REF>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
+							  <&clk IMX8MM_SYS_PLL2_1000M>;
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
 			usbotg1: usb@32e40000 {
 				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
 				reg = <0x32e40000 0x200>;
-- 
2.32.0

