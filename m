Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC43031DD14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhBQQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbhBQQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F78C06178C;
        Wed, 17 Feb 2021 08:11:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a132so2571312wmc.0;
        Wed, 17 Feb 2021 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iYhVyoNMgVid7FO9qCczwvtqlms943EuAfBpGsUI3E=;
        b=mcHFiXx+1B6C+7zsKwgBwqdRi0Eq+u/m0N4URmfQ9o1S72nEfU/YAi91h4XQfMwonx
         SO1cWRAIXtqz9jybK3TuvsmbrCpEh+OrgNnW7ObPJKqKsXexGbXWqf6m7HGv1s/LDRGb
         w1AlR7bwGzrooIpLSrN1dFjNzXvdVoSVS+FwT7PJpgYoq/e6nvcE4I065b2IndvP6mBW
         mX70McXQlLcQ0r5j2Cl+1xy1dcqgQrUGiVWwkVQVzdk+YUq7w1QFBj55Q6HQ05mOchki
         SETzvVelcD0AHIvwX/2QqaJENmZdWypYfsKAsytd326KLcFhZ8fY5a2MlXmxYnhgWAYK
         ZUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iYhVyoNMgVid7FO9qCczwvtqlms943EuAfBpGsUI3E=;
        b=g5Jw8HAVs22v/CdrvtLjWEElf3fVlXcZMGZe18+NGuv+jGDOODbm5/QM8Uti2wGRGf
         wwo3BptzU5UiWe9N++Wema8uz9+zuxyuieFvVibPU9dEKnspwG0cbuDp9XEyIPGkmPtk
         pogFSZd5/d7fySEJQG5kO28EaiL3jEpPQE24uP5J4M29vWwCIsNo5t99lhTS4Zs92usJ
         sN2dvIdYDS8x3Hn6BTJ4BYg+lozp2xMYkYgg7Y1ThnIIYvi2PuvHSVdqOfbgliESDKvs
         YdGP6syEbpXSn15cMN/oyqGFg2PtRS1IyDD1HYECI9JSDO09cNGlhFee1rC8odaBbc5C
         NuIw==
X-Gm-Message-State: AOAM5301ZR9dZpbWNiMecqNnZ8izr2WaqvettCw0ijflIkSprMvAknVR
        tROElQSrjoeXtpJqKq0VDYs=
X-Google-Smtp-Source: ABdhPJzcgRKIfI+Cd59cYs92OS1JdOy2QTtWLQ4zMpeNJcyG9a/nq8zwsyGUnMGOsnlALHIguirItA==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr2317931wmz.84.1613578260190;
        Wed, 17 Feb 2021 08:11:00 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:10:59 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 6/8] arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
Date:   Wed, 17 Feb 2021 17:10:50 +0100
Message-Id: <20210217161052.877877-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217161052.877877-1-adrien.grassein@gmail.com>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
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
index 35213f3abecc..bdadc70acac6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -79,6 +79,12 @@ ethphy0: ethernet-phy@4 {
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
@@ -368,6 +374,17 @@ MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x159
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

