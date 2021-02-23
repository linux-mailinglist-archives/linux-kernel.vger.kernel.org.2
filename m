Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D824323155
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhBWTVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhBWTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:18:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270FC061797;
        Tue, 23 Feb 2021 11:17:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so23702436wry.2;
        Tue, 23 Feb 2021 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PuDUmTSeFtli9x3Lq/pM36m1IGKEf7TDFXGkh1P6zYM=;
        b=adUSs1RYIqo9SWAentSeagtmClwIROj8XKyE0APIsYSiXpeui6SpAuwp2n7dQL5QJx
         q98EnrJx2tiJiENpHaQtuRXh51GW2ikdMlgasMpeWLSza4mPInlufJKuJAnX+NXkxNb8
         sLP5bYAdfM6b8uuHmTx9vw3RrpsJj5CIDjtT9AZG10qBgr6Dq7cViGgwXm4TTtoogbNA
         l/QaRg4/jak1pF75eMtaTRBBC5J0Mkh5703biRtKicSVH7GS1d4bN8VqtQSSzjYxBmM2
         un5g0DW7K1uCLNbf2k+TzA8m1s1A8atpKHKECzWunJd9czoZHsxfiJ/YUOwJvmQH7vzB
         1Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PuDUmTSeFtli9x3Lq/pM36m1IGKEf7TDFXGkh1P6zYM=;
        b=kbooXXxHDYslHBf/bOLZbp8lB/gTfEONKjotWZ4qaQPuvtKYc6jK5pVsabk0idvbmD
         LGHqQYbCfC7N1TKZ7/dS5oH7TroYKNYAgFAdOncsph2Dg45ciQrQtuM6XJwUMarcjXDe
         loMXE648IwAWWq1gNvycsgXsj8YtstobngVE+fPfSkzp3Nzl5PMdsToReyPf1Cg5ikAF
         5tpBccmU4Pm73PoTFDVjjPJbAPLOOCCngbzuY6Nj9IPBqaXVSlmxPjcMpxGpwXxY/NcY
         yJ/GwBmaoiPc/TIr1pgW2I10QIolxxq/+/EVaVqE+2yeQ4xgYO0dHUen0pnD8S9mB5En
         LkDQ==
X-Gm-Message-State: AOAM531ho3DEQYJ9tje7VMdqQspyj9NOdmtusu6k1fQhq+8M44JZw2at
        uanm3niEsnYRkUTtHvjcQuw=
X-Google-Smtp-Source: ABdhPJzktYfFrChzsUmkIbmfngMEp1vnVNrSO9+W4XNSQvQIePbeiBsU5TM7HDu76fZHZr7d8lzy0Q==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr3876858wrp.89.1614107821137;
        Tue, 23 Feb 2021 11:17:01 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:17:00 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 08/10] arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
Date:   Tue, 23 Feb 2021 20:16:50 +0100
Message-Id: <20210223191652.436397-8-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FlexSPI description an pin muxing.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index cabcd6f19d56..c13788e6c0d9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -85,6 +85,12 @@ ethphy0: ethernet-phy@4 {
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
@@ -376,6 +382,17 @@ MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x159
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

