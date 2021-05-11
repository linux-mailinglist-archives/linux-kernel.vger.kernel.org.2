Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA237AF65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhEKThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhEKThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:37:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B141C061574;
        Tue, 11 May 2021 12:36:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so21251232wrw.8;
        Tue, 11 May 2021 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8J0rxRLOBDTAVJ8RrisbFd6rAqKqG+nZqciagcgf+Wg=;
        b=C1HR7lnk8whbXFecMZYyFc1UuJUaEvTBER66a8bgRFL1o4R71IiHcT5ovHRNkl2NB8
         LcInWL6mZjRDNuXTYhTQPHDZmYafDQ3Zm3JGmZmec2YRzhfWYA0+29pGDMWwdD7ppSri
         6bCnnNozz02Ey1Xp1blwnMIuId6Y0jTblNDd5qCCviEB4ckPGuH/WprS0tOKgGEhj+eA
         nq6OAI6/oOkDVyG+b/SP9yfiMZLOwqjEGvxIBDh2SM8eRP2sPfx3jn933AFBY2ImLB67
         TEOZAGAd7O1I4RmSpMqQbwklwPKd1PJpLOYxjpuFpGzIXAr1tAvsCiLIWwQszN8zH/kb
         /L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8J0rxRLOBDTAVJ8RrisbFd6rAqKqG+nZqciagcgf+Wg=;
        b=W07KVo3t8rFarphn4hBUazRdAiBAXiaHyK4QuN9LjwZPtnQfQErr9B/ppLIzFTIWqj
         JdhqGR2yXhUCXAEu9DlMe82h12ruxTAZh0v0O07uoBcsIEOLaLZGoeaM+/DvyG42NuWD
         Cgg7HhuMAtYz2r5lk9jJ4fj2k8Ex+wLC2Pyk0TEYjJv3iASXUyaMonuK7bdA9YKYQmn1
         u3KUExFh8/LrrMxB4HES1QGFq5dIr6bubp6Ncc1tjeBwQIpz+R7C9wp4bqAtuqA/urDp
         Ge9uFh0zGH2i32GyIpEYCcY+w/7+wZI50NBsMwxcVoEAZZVv2gXkA2uetUn7RToMKu/G
         /z1w==
X-Gm-Message-State: AOAM532FO72g4ihi2xRyRhCbjZukauT5M/EggZ+ukYt094jQXnoBxcHS
        l1X7UbF72/dXzo9WWQTTnZ4=
X-Google-Smtp-Source: ABdhPJzlEc7QN8dO4sTycX6SPOk32/7gZgArEDWWXxnccaAh5DXIak6/jEABr2Te4d31792ng4d6xg==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr39512912wrn.303.1620761767831;
        Tue, 11 May 2021 12:36:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:3e6:d280:2c6d:4527:c2ea:bb9a])
        by smtp.gmail.com with ESMTPSA id a76sm2604562wmd.16.2021.05.11.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:36:07 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 2/4] arm64: dts: imx8mq-nitrogen: add USB HOST support
Date:   Tue, 11 May 2021 21:35:59 +0200
Message-Id: <20210511193601.2584324-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511193601.2584324-1-adrien.grassein@gmail.com>
References: <20210511193601.2584324-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for the USB host port.
This port is linked to a resettable USB HUB so handle
this reset signal with a GPIO hog.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index b46f45a82be1..5553f3c84dbc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -102,6 +102,15 @@ ethphy0: ethernet-phy@4 {
 	};
 };
 
+/* Release reset of the USB Host HUB */
+&gpio1 {
+	usb-host-reset-hog {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -213,6 +222,17 @@ &usb3_phy0 {
 	status = "okay";
 };
 
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb3_phy1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb3_1>;
+	status = "okay";
+};
+
 &usdhc1 {
 	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
 	assigned-clock-rates = <400000000>;
@@ -388,6 +408,12 @@ MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x16
 		>;
 	};
 
+	pinctrl_usb3_1: usb3-1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x16
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
-- 
2.25.1

