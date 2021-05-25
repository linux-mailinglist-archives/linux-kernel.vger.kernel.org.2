Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF138F758
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhEYBJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhEYBJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:09:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449EC061756;
        Mon, 24 May 2021 18:07:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a8so21646340ioa.12;
        Mon, 24 May 2021 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDtRZbhOC2kiaH83Vu38CKuYDq3Ey/spCPAL1xviNrA=;
        b=qVgb7bRRRAkUJL3NdtKfEnvW7pu6k2zxZ6/jgx9QeiIAYiXWlIUdm3q++cGV4kgG/s
         ka3oNWeUX7xGccY2Qy5Axh7+9Uvj/bj2gpGMC9vuZCMRBZbmuIaluACLzIRyoklIUzH9
         KuLbDxC1ea1M3PYAWnBlBCLXa9JfG4K3ETZHldbhfJ17J3bJccqqe4fV7wABYB51QbT8
         rn6Nwb6BHHBVouzKn5a6uOG9NOInVjFAHtVDnaUqkEiEn5FbwX1lJ6SdK+YZVF74r7v+
         dl9kiNyaa8yqh8mQHyzWXRG+4J+/gMpdS6Px102o5G93Dw1itDf1Oo1RDlEqIyovMBm0
         UkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDtRZbhOC2kiaH83Vu38CKuYDq3Ey/spCPAL1xviNrA=;
        b=UASmy5uR5TYSdMl14jF6onSCdCElavFZRjMmypFC0LIAfoUEGLvPqOBYYYX9F6eKe4
         h0wJCeuXEE3b5WUVenbXhgY7ddphTMm2U8r91i4Z6VXEhZTcBoK2lE+qtkEBLxM/O9s8
         GxlIqNrIWv0+Cx1apmYe0rz8gOaIzYYsCr8cbZdR13Kxj3BiKO3etazo623tRel0FOiX
         kjsWS3er4IWFZHHhyshvg1TggNfTluEm2NdcQp+x+zAWSqe9ucUqwTCpBOrihXw8CSF5
         K+cRybDDvwNrvZ8sPyhrlwyYyCukWcuwt6Se6eb1U3kvVzb/Mb8/PrKnK7UEUX6gYN1O
         Zznw==
X-Gm-Message-State: AOAM53064WnV3rMMrY7hwsMIVDh+a3hEFNmvecpQz5On5pS4GJR3Y5qi
        psreFSNjroPS8kFFM/QKUC4=
X-Google-Smtp-Source: ABdhPJy8FuUWUXY91/rNjnq1m2tRa1xMs1sdlu3dlgxRMPset0cAB2dgqOZZapDj/GkuzECpoKCvCg==
X-Received: by 2002:a6b:f118:: with SMTP id e24mr18113453iog.125.1621904866310;
        Mon, 24 May 2021 18:07:46 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:599b:b8c7:b3a9:9f1d])
        by smtp.gmail.com with ESMTPSA id w20sm12318413ilj.16.2021.05.24.18.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:07:45 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: imx8mn: add GPC node and power domains
Date:   Mon, 24 May 2021 20:07:30 -0500
Message-Id: <20210525010732.115562-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525010732.115562-1-aford173@gmail.com>
References: <20210525010732.115562-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT nodes to describe the power domains available on the
i.MX8MN. There are more power domains, but the displaymix and mipi
power domains need a separate clock block controller which not yet
available, so this limits it to the HSIO, OTG and GPU domains.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index d4231e061403..0eb64b59c8e3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include <dt-bindings/clock/imx8mn-clock.h>
+#include <dt-bindings/power/imx8mn-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -613,6 +615,40 @@ src: reset-controller@30390000 {
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mn-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_hsiomix: power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_HSIOMIX>;
+						clocks = <&clk IMX8MN_CLK_USB_BUS>;
+					};
+
+					pgc_otg1: power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_OTG1>;
+						power-domains = <&pgc_hsiomix>;
+					};
+
+					pgc_gpumix: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_GPUMIX>;
+						clocks = <&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+							 <&clk IMX8MN_CLK_GPU_SHADER_DIV>,
+							 <&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+							 <&clk IMX8MN_CLK_GPU_AHB>;
+						resets = <&src IMX8MQ_RESET_GPU_RESET>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
-- 
2.25.1

