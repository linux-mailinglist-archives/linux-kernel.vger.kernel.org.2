Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9103031DD09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhBQQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhBQQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11AC061786;
        Wed, 17 Feb 2021 08:10:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n10so4132630wmq.0;
        Wed, 17 Feb 2021 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DV3AlkgC41dafeMetvZk/eqS2EZdfBLjPVvBILGSmE=;
        b=P4xMWGCE9xnm/vQ0wZuudet2pBa5/S8/nUaqLCprE7AKgglt8fWNcz+6WErMIcD+Dn
         rkn/ot2SxWMzxLdliLrc0xp8Y2cT0LWRMC6sMCNrChcOqa2O4PQW1dntxfA5aX2s90e7
         edHl+1M1vLBnP2Jgj0SK/29sZYwxe5DXU7eLXqmqGJfpxViTP3CMSZOnhpVYQhpADLLO
         yc4kor2JoXxXlderLP9u+HTg5dlyat7iZdsOMFDTFHZxThFhpUIGSJHb1/HeFIH+TBo6
         7kb4gLDlmvwvRUX+Wwc6kTw07XGg/Fo4+AqrrtNOaxBy7w97fvSpcgOmh6FalJREvRhW
         hoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DV3AlkgC41dafeMetvZk/eqS2EZdfBLjPVvBILGSmE=;
        b=DVrKmbe2PGEvqHChL1UJ67UtM/Eq6TapEcelkd81fgCY0HUZDygbNEhFI4GtlfzBTb
         DtvPl/3El3Kg3yifNmRNWPt8Ps2IiNWYwJXdzWlMe1BiwyNYilrOkAK6wg3kxy+7RHN+
         J5wAxVNlBn4eXo8ME9n7usSDqU/kKQ8OvhXEV/lOTnvANtHv4qQ6mxE02koikWRfNEvY
         Z6L0B4V/IWg9gFoqUhkPaHBhVFuvjVf7Fds1fYo+XgT9sU3/yBQrn8f2QLtN81MWpfzr
         9xv1gOAVHHmT+krF9Ek3amShspu+OQXfnY4Bg/3UM1glw203RcRNMQeOXnnm0qRi+wqh
         avsw==
X-Gm-Message-State: AOAM5319bVUyGb+tDZemJ9r93RzB7HKo8OLvHOAAH+7FY94fOrMaCXEg
        5PREsmn3oXoxcydnFxvaWRM=
X-Google-Smtp-Source: ABdhPJyvJC8BAjySpf4+iBz2649j7YZOCXm9mHg86vHU/azax6Aq6zALLhzhEVL1EhHhQP20rLN/DQ==
X-Received: by 2002:a05:600c:2248:: with SMTP id a8mr5007587wmm.167.1613578257577;
        Wed, 17 Feb 2021 08:10:57 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:10:57 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 2/8] arm64: dts: imx8mm-nitrogen-r2: add USB support
Date:   Wed, 17 Feb 2021 17:10:46 +0100
Message-Id: <20210217161052.877877-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217161052.877877-1-adrien.grassein@gmail.com>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of USB.
usbotg2 seems to not working on all boards (including ones
from variscite).

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 212dc9e5e85d..f62a25efc69e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -231,6 +231,34 @@ &usdhc3 {
 	status = "okay";
 };
 
+/* USB OTG port */
+&usbotg1 {
+	dr_mode = "otg";
+	over-current-active-low;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	power-active-high;
+	status = "okay";
+};
+
+/* USB Host port */
+&usbotg2 {
+	dr_mode = "host";
+	over-current-active-low;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg2>;
+	power-active-high;
+	/*
+	 * FIXME: having USB2 enabled hangs the boot just after:
+	 *[    1.655941] ci_hdrc ci_hdrc.1: EHCI Host Controller
+	 *[    1.660880] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 2
+	 *[    1.681505] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
+	 *[    1.687730] hub 2-0:1.0: USB hub found
+	 *[    1.691528] hub 2-0:1.0: 1 port detected
+	 */
+	status = "disabled";
+};
+
 &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog>;
@@ -302,6 +330,20 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
 		>;
 	};
 
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_USB1_OTG_PWR	0x16
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x156
+		>;
+	};
+
+	pinctrl_usbotg2: usbotg2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO14_USB2_OTG_PWR	0x16
+			MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC	0x15
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-- 
2.25.1

