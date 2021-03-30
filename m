Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC88234E421
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhC3JOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhC3JOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:14:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19376C061765;
        Tue, 30 Mar 2021 02:14:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so15518454wrd.1;
        Tue, 30 Mar 2021 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkyoH8DdUwp+B1Rx/yzwIrC4PSW0Djv+hDyEsHmurrg=;
        b=NZnza3aX7Tefw8Gl8bfiYgYmz78PvwxJQ0BWJo8rkjmwBR6o3MgY26Y/7Mn1x7H/hL
         y3PrDT8XTz5YMgGR0zinbOXWnMjSBt6ekKZSUdfEgZfQxASGjKUnpR/KRsyVYiRF6EpC
         VvYDo1bzJIB6lmKNNfLCqFEJmppQigElx5mBnUI9Vru3Z6qmMqU2eBGMEFo7lwXy1g8E
         RPfekQR/ffr4wKEG0fXdWR8mK48OsIa8Go03su3DDag9ZUlqYWDvHg2Jh5kksc56+mz1
         Js4ujwRv5VXpAMzYvtpO4GYQtn/towcPPv1S4+jF8J9A/zr2EMde1v4qfOg51TgALf1j
         KsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkyoH8DdUwp+B1Rx/yzwIrC4PSW0Djv+hDyEsHmurrg=;
        b=DAz/zmnMZkd+gxi9odTh2RRqfkQvsr8sPy0tQyaTLWPCeZpzeCevX8wZRTRLjrGtIj
         JKJsEOyI8IPnzG8NZpozWLKbZW0x+B1tUHjZ0Wi4QKYEHcrw6PE8uAuKlNacC6ljLXkP
         rtSwjLn8nznCXc1yerk3vq1A1Oi/CXEUFXubE7GtygDMtoUHFW5lBfrg1+fNHsDYxnI6
         /2Ol3oYftoTTEIAlQeOuNYfBrSsk/2HML2z47g+zlTPt0r5VquAXHqEpzeOst/TuPZe+
         bwfCwJCEjGovIY63mtnTDRWRrzYVAEnqU4+Ng4Y7IXMJ9PjMrgJDVt0oWvVh4z7RPx9Y
         aLLg==
X-Gm-Message-State: AOAM533ovncdCci6pTi6iyVP8au24tdrYUvS4ntgUO2dDU5ewrx/PLJ9
        yRuWv0b15Qiyavt/c7Af8aU=
X-Google-Smtp-Source: ABdhPJw9JTw6NPREHSWHmCS8g4Ns+KRfThPCVxesGwjYL9mc5CtaPr2l0kVDPyZID9KTvyo+Y7/wrw==
X-Received: by 2002:a05:6000:18d2:: with SMTP id w18mr33039073wrq.88.1617095670838;
        Tue, 30 Mar 2021 02:14:30 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id l8sm33305840wrx.83.2021.03.30.02.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:14:30 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 2/4] arm64: dts: imx8mq-nitrogen: add USB HOST support
Date:   Tue, 30 Mar 2021 11:14:24 +0200
Message-Id: <20210330091426.95030-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330091426.95030-1-adrien.grassein@gmail.com>
References: <20210330091426.95030-1-adrien.grassein@gmail.com>
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

