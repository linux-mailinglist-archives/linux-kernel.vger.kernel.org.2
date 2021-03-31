Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A961350AB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhCaXY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhCaXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:24:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CFFC061574;
        Wed, 31 Mar 2021 16:24:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso1916428wmi.3;
        Wed, 31 Mar 2021 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkyoH8DdUwp+B1Rx/yzwIrC4PSW0Djv+hDyEsHmurrg=;
        b=UAURaNjQBcvgZbnjg1rhCYDUsoXdXHWY1CObVWGxFNAtsnwp9nq+P6cnMjR15611j4
         U5A1nsySioau9fmbBaJK6N9ea5jspmOclLQ+LNrx6epU1u8ma6wlcrg2gn1chvuTiU6K
         w5q1NtQYi+5d+DA/zrI0K5zKRWiQR2S1AdTzQON7dC6Ek31BSHh4Kd19KdTBO+XXXerh
         nd16dVTZL+ehb5NMaEkVc3Dhh4mRaHIG7LK/hA05+3kvp13tN9RAcsvYM5WCzFyA/Tv7
         FePkQaI4N4iUg6TEx/ttRp4mf5hS5Xzmhr/H/rSCjiEMbfZMQ/guGKFCywhohgA1xlvV
         luXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkyoH8DdUwp+B1Rx/yzwIrC4PSW0Djv+hDyEsHmurrg=;
        b=b6TujwsvdZrQFFu73kArmoZ1VWR6X4DpyFZx4Xk0cdBxpFfVcO6UXddjuR298RHcCO
         odcaBqsOxiATLuhu8PYTSWscQc+392pO2q3M2MkoxXhpHIlMAuf6izx3cuAaCkN8tjru
         Mo0+S3m3fvjNIQpPdH4DQ5/gBc3oCapPKZRj3jL8Fhoets8vGS0MONdvgMAaD6Cy1qL/
         nLDT7OHbw5tstojdz48yhyM7xBRjUhmDXGhQbKbExJQLWePfqccgS6CXJ2Scn1RcSK9Q
         WkOIw3UI6WEIRiyVhiaRzeMZFS+SAfZnFVYyK19VZtYjGNL05F2xa5s2MbyC1VmkI1Px
         4qOw==
X-Gm-Message-State: AOAM533tpORvx2QCQfhmsOKMWDnY6cgtb7U7G315HQFCp91xsWV0FnTC
        WjyOcIfKj/9Hthlv02IFymc=
X-Google-Smtp-Source: ABdhPJy2PCxktEow+IbqOsMb6OcW17tKG9P1EJBVHbiPqTbZfqLUAFBT+8TtrAeoTYJhBXy0899p0w==
X-Received: by 2002:a1c:10f:: with SMTP id 15mr5328847wmb.14.1617233040244;
        Wed, 31 Mar 2021 16:24:00 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27007d57ea0d08d946c1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:7d57:ea0d:8d9:46c1])
        by smtp.gmail.com with ESMTPSA id t14sm6343041wru.64.2021.03.31.16.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 16:23:59 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 2/4] arm64: dts: imx8mq-nitrogen: add USB HOST support
Date:   Thu,  1 Apr 2021 01:23:54 +0200
Message-Id: <20210331232356.2204476-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232356.2204476-1-adrien.grassein@gmail.com>
References: <20210331232356.2204476-1-adrien.grassein@gmail.com>
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
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index b46f45a82be1..04992cbba56e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -102,6 +102,14 @@ ethphy0: ethernet-phy@4 {
 	};
 };
 
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
@@ -213,6 +221,22 @@ &usb3_phy0 {
 	status = "okay";
 };
 
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/*
+ * On this board, USB host is connected to a resettable hub.
+ * The reset signal is connected to the GPIO <&gpio1 14 GPIO_ACTIVE_LOW>.
+ * You need to activate it in the bootloader or in the userspace.
+ */
+&usb3_phy1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb3_1>;
+};
+
 &usdhc1 {
 	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
 	assigned-clock-rates = <400000000>;
@@ -388,6 +412,12 @@ MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x16
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

