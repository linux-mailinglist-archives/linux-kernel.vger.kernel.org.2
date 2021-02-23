Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA4323142
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhBWTST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhBWTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:17:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEDBC06178A;
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id w7so1097079wmb.5;
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EUGCovOf15Zt5QhKWqGjB7rrftXXLh9k1xJFsm/+SE=;
        b=GAVsCbXSQswJ51bqM93ZpDu1GclkP4C+amhcIoWpKYHiYBCACF7CjFGrD7Kl9PBsVl
         gi4gXrRS/svv3cB3aEYBvqetedJfJu4R9NlWQgKksnOjOcQaALKIvGAmuhUZZdxHbiuM
         XnBlduRn98t3lfUZvokpP0/ABdG9AHiW4akeGAqpQqPeT2dVFFbOK8IMaa+wjyFwIjUA
         hdRojDtT/z6jMBVLG/5djFHb/zn52oKfrfvbjCd1y16lGAM8vouPcYDR2t7x/Cd4RXx9
         2eZrtJcwrjMrl5XLE3nNdC41Lwe3LMHenxTKJex+mFn8d2oDrHZbTIG2cuKG/7ePKXFD
         01eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EUGCovOf15Zt5QhKWqGjB7rrftXXLh9k1xJFsm/+SE=;
        b=DL30nz/80LoCfB/6e6xbBj0mg0BY5PCWSoDr/hxjuemgBPSgAp9QV2UAlHJB2GkWY5
         5BGIx1RK0kP62JLofeZITpHiOjhZY/MIqSywiFMAW4MZ+truuK0k+uF4v2K6vx2Es03B
         8PHAwVDcvNgp8mh2gpiGpe0WIiASe5X0s1+VOA7C7aDZmXlLS6klyfaWCESrdj9n4zIC
         4ZZNh/rcRm1DulTqW8KQjc1b6+37JzvXL2NzpB5i90qnpC/cWNnDJBBCx32hy6ANt/9O
         ijOXwuFOgDDepcC2s97XxAgifj7NntJUaYC0EEvYqsqCADkjAGKnyfo9GXHCFYb0/nrV
         oEmg==
X-Gm-Message-State: AOAM533v5sYISfKXkKpD169/p8Hu7yK/1bbOB74ykCRnkBcQJx3DSjLr
        4TGWCLZMqJ5NpIUptkZP8Xc=
X-Google-Smtp-Source: ABdhPJyCgrxUNVVHP+7PXvjpb2RmtIV92Ovn9oUyjG18IxJMOQFJb8030QxFKPoiv5HbonkEjwHzlg==
X-Received: by 2002:a05:600c:410d:: with SMTP id j13mr229398wmi.55.1614107818710;
        Tue, 23 Feb 2021 11:16:58 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:16:58 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 03/10] arm64: dts: imx8mm-nitrogen-r2: add USB support
Date:   Tue, 23 Feb 2021 20:16:46 +0100
Message-Id: <20210223191652.436397-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
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
index 217ac8c53702..4f4cf7df5a5a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -247,6 +247,34 @@ &usdhc3 {
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
@@ -318,6 +346,20 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
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

