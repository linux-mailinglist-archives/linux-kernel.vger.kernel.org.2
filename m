Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3131C457
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBOXWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBOXVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:21:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E62C06178B;
        Mon, 15 Feb 2021 15:19:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so11013605wrx.4;
        Mon, 15 Feb 2021 15:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZXL+p9hniJu6mnDjhlcdxQ44L9TZGtYsYl5ypZ+4RY=;
        b=h8kTYSyU/CTBsobQ/ON3lHQCFEmImYPfQCVUYUBAHQMGPhDmNR+947CyA5OlOgXiC0
         8qsOFG/zDHvJrh11PnY+1ZyvFDBop/5NwBlI/9jWbBDWhUAuzUeMF3c9bAZJoEfB70JX
         uMgejDRyC55bm4+f4WmKNTp9rf643WdUeDQ2xWziskyuRBBBJ3pbrs/GrGnJ9kD80I2U
         2DAHOdkJuyjxpgsGy9AJgCx16RFgLbxakEoVYcOBieTVYbl8hgdPbM4qW/C87FLFyaEm
         rqL8RlbxKrSdpBwAKfC09TVwkVkKclr9166sa/uOWGBAyVM57GjV7mkIhrGTBKdEIlp1
         7U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZXL+p9hniJu6mnDjhlcdxQ44L9TZGtYsYl5ypZ+4RY=;
        b=pn7fRb0OlaI473LVb1ElyNnJ5dXqDcZGo1rxchdi/GoDL45CCfnmenLLfyBkIM6o+t
         RDIwYKrOjd22588ONkpjr3myLLEpa6qznirlUL1GZ8D6VjRlG4h9ldN8dezp2CtCVyj7
         j9AXTxkAI/QPLay4doVu0UyjPYAMXeUMhU/on3Iai5BrCXIt9qfxzXPv7fGLcZrRiwld
         qlma9VwObyUjnZCdkKBemTyFF7Ta0Dx4ES1Mfj26zEuZe0w2Q1fgn2AJbYoKlL5ddIoh
         Nwr9xy9BUWDbJ5fawsWb9mN91dyaczy5jr4ZOwln2P9zcqPd/EBt7HhdCx4Vb5HI6jGp
         gqvA==
X-Gm-Message-State: AOAM532YujISuVOy4OeCyers+uter3vQxE7JCXnK0MWd74K4XvxL3Y1G
        G4Fpc01Nkhzr3ES+22b4LxQ=
X-Google-Smtp-Source: ABdhPJzlPPMozugXHrZWuWxEtnramAmW4vWPaPMZKGMnDBuGHmyYnjKgcAgjHWaymZWziOksUUGRqA==
X-Received: by 2002:a5d:54c6:: with SMTP id x6mr14602333wrv.216.1613431195797;
        Mon, 15 Feb 2021 15:19:55 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:55 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 6/8] arm64: dts: imx8mm-nitrogen-r2: add flexspi
Date:   Tue, 16 Feb 2021 00:19:41 +0100
Message-Id: <20210215231943.36910-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215231943.36910-1-adrien.grassein@gmail.com>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flexspi description an pinmuxing.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index eafdf39e1f39..5ba3c8ef7706 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -80,6 +80,12 @@ ethphy0: ethernet-phy@4 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -373,6 +379,17 @@ MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x159
 		>;
 	};
 
+	pinctrl_flexspi: flexspigrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK	0x1c2
+			MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B	0x82
+			MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0	0x82
+			MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x82
+			MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x82
+			MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x82
+		>;
+	};
+
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3 0x09
-- 
2.25.1

