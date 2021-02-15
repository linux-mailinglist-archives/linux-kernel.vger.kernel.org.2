Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3048D31C447
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBOXUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBOXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:20:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A0C0613D6;
        Mon, 15 Feb 2021 15:19:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t15so10951014wrx.13;
        Mon, 15 Feb 2021 15:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5r0Mrwm7Ego69AW7YbQ5ctnsMQAyz04RZBJYwegDOk=;
        b=cwK5h5FFT57d217JlokrCBRpvipiPbXtB5pY3GXYEO0TpslVDPApkCfWkGp0Cl/jrd
         c3N1xse1Q1GPYuNC5O8Ot3Vb68cG3cYi7enIIDkerUbnyGisNG81lYIzixeh/oER+xw5
         yUwhBWvf3WfIc0cgTfgFj80UTSvtxWyH21EC3PUi8I8MS/zk/w6J0k0YSBnf6OltT9HL
         tjf2+HSGQDNlwxOT6U/JvcthjqYgqWz2vGsMYn5keSiQBphHTrT03Wul3V1H/wqlvfkL
         oWWV+o1NOcU0oC9mvsUXlYAJEiWvy+bHeQntI8ZHbhaIOmJSTOvOFgi3bWd+M1yZFwYG
         bA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F5r0Mrwm7Ego69AW7YbQ5ctnsMQAyz04RZBJYwegDOk=;
        b=Lx3BX7u4TVlCKI09lNnjMhuSp2AGGNZiboZNy8DW3/NHOn177wI2aH3C7/9J6j8/2n
         gklX8Uem9gQ4BfXw0FzpOHAC42kwgfJnzQtQ88Ovs4LtozyzmfyJBzJIRADcqnHja3oH
         NycXsrOqZgDpc4HFxeHIzFX7Sz4UzgJ8iBFLm1ZutuZ22Rl7tQJ9B/CPz6AoxB4DZdle
         8Pw+RKMEX/Zbom66TJlS9IVxx/TxBPXM48xStpbJ9qoojHxLGwpF8h8O6TNZL8oJarQH
         0XGEZvKj4rusBpLx/+Gsy8JnmkRXJM1orzWd4Tg13rKeZPtdGyRZ27O6+uXKWTYctJjM
         14Zw==
X-Gm-Message-State: AOAM5306t/1XVMmC2ZQHFziZPimB8lhafkjjHMClSXM8zj9rZ+5x4s4Q
        +2AcDtxqHIV7kCEOaVr2ops=
X-Google-Smtp-Source: ABdhPJx00cstIUhmTYiOLsSa7mQgV5LrcivPBLAxhW6CoXsaEGqzCo/NqiPzzoAN6edzj/MQIhoC4A==
X-Received: by 2002:adf:f648:: with SMTP id x8mr20271282wrp.34.1613431193038;
        Mon, 15 Feb 2021 15:19:53 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:52 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 2/8] arm64: dts: imx8mm-nitrogen-r2: add USB support
Date:   Tue, 16 Feb 2021 00:19:37 +0100
Message-Id: <20210215231943.36910-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215231943.36910-1-adrien.grassein@gmail.com>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add description of USB.
usbotg2 seems to not working on all boards (including ones
from variscite).

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index bf20a40bcda0..1b29d8a12d04 100644
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
+			MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC	0x156
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-- 
2.25.1

