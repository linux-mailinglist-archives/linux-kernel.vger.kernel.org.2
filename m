Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF95234E33D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhC3Ifw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC3IfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:35:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB5C061762;
        Tue, 30 Mar 2021 01:35:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p19so7910144wmq.1;
        Tue, 30 Mar 2021 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AMb4e41DBOkeNkfR4I2f1MNHmpsgRGmBA6yo/jwP5KE=;
        b=HuyRrsejc/8hf9B7Nl5tUCSP+Kmwkw/ufQAgRM++HtNKdGOsD8WdNJIfdnxnujxhHJ
         zbMAc5A9ZUZ+2OHm4I/y95O7O5VYKbK4zPS/qbLZY3yyM1SkgYzUU724O8cCBQ6cQGfo
         WLXGiVB9PFVJjvwWSJOCYsJddCAh5Hye7Xp3zjeK9qwPjdCkWGQ//D5plWCfmwK9fxzC
         LB2CRNqriSE9XHFtPZXYqRTI47zguJh2uOG3y8y5y4RyZsALjIcq5FJIYtl42iMOQRQ8
         4gx/UQlBBRDaaaK4FaZIILBWSUBNRDasn1tRMkKQkUI3oLvd1NGkmB5Ao1RHdejSLcgZ
         KyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMb4e41DBOkeNkfR4I2f1MNHmpsgRGmBA6yo/jwP5KE=;
        b=PSn3UROpRwBVM9M55bCsB46I0zwB+OgMMQ3cqu1/KoTOQQX37GTi12cCMCUaoA9Btk
         ANN7zzEkbwlsXRafBv4xlfzYTzxjKCbFqkhylzgapH6VB/xPRvbiHOWGF0cQRz6GXMfP
         k3dPIxK5qMe/v5MGDX+HuIqNoiWdG0qH8NDDyCtD2FgebeseTicWq1qMnmlA+PUtjJPr
         X4CJI46c6mO2Nqx+s5NMfGKMJsE4qBoxoGkEYiWiCC5yHnUIDfRsZuLEro7e0T+WzdRp
         6kPzaz7JixyfPH7EmTxl2l96G30C5GSF3BvKZzZIAwfxPxsd9a4UdF9ikQGLKIQOeMt6
         ujCQ==
X-Gm-Message-State: AOAM530erHyxrYdWWVm+3oQwfgAilQ6tpjf0HooeylQwjVvYnTZimNAN
        KnDJsSWrp7gbyr5WhyS09Nw=
X-Google-Smtp-Source: ABdhPJx0ETGOd9OMdcgfLbcFElnhRTFe/g8q+CBE41LK+c2K0M5kzDPOzspDvCZM8Ra4MMclEgX7eQ==
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr2786637wmk.102.1617093321547;
        Tue, 30 Mar 2021 01:35:21 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id g9sm32830263wrp.14.2021.03.30.01.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:35:21 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 2/4] arm64: dts: imx8mq-nitrogen: add USB HOST support
Date:   Tue, 30 Mar 2021 10:35:12 +0200
Message-Id: <20210330083514.5874-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330083514.5874-1-adrien.grassein@gmail.com>
References: <20210330083514.5874-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for the USB host port.
At this time, the port will not work directly from the
kernel because it's connected through a resettable hub
that is not handle in the kernel. It should be controlled
in the bootloader or in the userspace.

In the case of the Boundary's u-boot, this is done on the
boot script:
"
starting USB...
Bus usb@38100000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
Bus usb@38200000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
scanning bus usb@38100000 for devices... 1 USB Device(s) found
scanning bus usb@38200000 for devices... 3 USB Device(s) found
"

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index b46f45a82be1..7a52e247c527 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -213,6 +213,22 @@ &usb3_phy0 {
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
@@ -388,6 +404,12 @@ MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x16
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

