Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8031FAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhBSOe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhBSObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:31:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE883C061788;
        Fri, 19 Feb 2021 06:30:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m1so7840856wml.2;
        Fri, 19 Feb 2021 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ilc0HnbkaLFZ7yQdM40kwNPB2AaZIcYdDKJZnjEdJ4c=;
        b=WusAanOLuxh824astYFXlE7xKrwzBbUR4UqkAT3YCWo3k59GFo6gzfl8PWcat5ZJA6
         82oDpvjtGY81eI0zIjin93mANIJHbV7MS+Z0eOgf8kLliv5zYWUyzb1Erq7r8MGkUnKM
         7/Kl8o/nJ48m4rhaPC79d7mlrYP2lAWUHp1LWeRUvr97cJl2EYQNq3IxXo3lhKWwe9ok
         js5XGANhyeTE3gVY5ZJie1nViCmfyA3L1ZRt867z2Ryeq6idBEaIkfLqyEvXpOXqTulY
         pujo+z/WS8S+hIA0T/hz7c+rbYuMLcqP42IGxdm2wm2ZezbwdgSHYSr4uUaU4otCly2k
         mYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ilc0HnbkaLFZ7yQdM40kwNPB2AaZIcYdDKJZnjEdJ4c=;
        b=Di99GEDyq0bUGSYwOuaLrf9cRLnQ3jvy6kNxS4yr8cP1QDPReyLc305kqpr6c2gT6o
         z20ozIgfmqGrZh73EhRwHEOYmyK6yXpfL6l0u4A6Ft+qYo6iiQq6Tx8Sx31q1BxQx5uv
         +OVKgnXUKUzxw5jW1MjnUJSL7wmWexKcbIT8jvwrEJWUFgqg7tI+65l/anYPRi9ssJv/
         pd+l5r1GzcnALvtkBEJK9YQlaXVJ4VrH2hcYZZiH5cZKDlD18S1TEOlwi70aq9EwDw/k
         ifrLiiidJK7ePEq7d9ZOA8lUND5CiNrS9WkVk/yNqoY5hwDq/5K7VTD6IcK1e73hnJ9I
         M5bw==
X-Gm-Message-State: AOAM532urFPMF4rtYOkF2+Ipxh8RVjp1zkIqYBcJmbrADGnWjO0SlYsq
        HtbnqZ9PYH/A8oK2exA5/v4=
X-Google-Smtp-Source: ABdhPJy8fbKjY0nGMwJd3s8bW00w6g1j2dovBlCAqQ11bWcNPiFPLTATyKzLW8oInU+TrR4HmV2QbA==
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr8584800wmd.105.1613745037542;
        Fri, 19 Feb 2021 06:30:37 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:37 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 2/9] arm64: dts: imx8mm-nitrogen-r2: add USB support
Date:   Fri, 19 Feb 2021 15:30:21 +0100
Message-Id: <20210219143028.207975-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
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
index 4a3dabeb8c85..48b3bf4316b8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -238,6 +238,34 @@ &usdhc3 {
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
@@ -309,6 +337,20 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
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

