Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED536F1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhD2VRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbhD2VRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:17:34 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397F6C061344;
        Thu, 29 Apr 2021 14:16:47 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c3so4789598ils.5;
        Thu, 29 Apr 2021 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPgVXT1uW8e6Y9HHaJbfKFsDy0UCQUs1OiFXNXzhl7c=;
        b=RF2rOfLyhULT8rqUxBzQzMpM9sxh5+Fy+/qnjRZXYt8ZkJ7YZ/nGUs5f6XaSfJAgVX
         SlMhQ6GKS/NueJyWyQUe10tBr33lTybSeG+iWFEydZ5a6Qx2IYKQpVa0mA//XCRMcvsk
         bIYrAgsL//74qpOtC2jfp6OXH8DtMDsh38tJqfpH/8LF7Wboihn/1K3Z8lTGVtosOkDi
         HuGF3biuvBc3n8OLiUKpDgK0ea9u9gv3wCywyu95tgvbCxiFHf7LCHkpb79s0+Hhp0GB
         OnQd7eFKTuE++zsWuCfrxX92eWR86Jh9mJ6swQlO3S0Tn7GJ1PD+XI+DGUXPcNafbSyC
         ofoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPgVXT1uW8e6Y9HHaJbfKFsDy0UCQUs1OiFXNXzhl7c=;
        b=DSxRCd32eEcyIh4M2fd5EP38F/fbTABL7lFDunv8uieZ/451xOh19HS3HVCk3Dc5kb
         VWR/bx8T+CTyGoW+MQMC/dwGEbIzjBvFbdfNHoE3cWo2vhQvWjpchWJWyM+nNCD/nsF7
         nxD98YnzxExNuSyAuwlii++faQaq41gj1K9nz4USMZdqzUDH3AVTIMU5F2tvJT6LRJLW
         97ECC7BDcYUKjKPnE1CtR8dJWqspHE3CDcQE9CqLKRlivaS4RcDgjWikTpBcjePruVly
         bYcAk0YDDzS5MOn2n6nKEzhGUPt5+K3lu1YBejvpIT+Ya0Z8SKlzXDh4T8ZD64OVQLY1
         xxkg==
X-Gm-Message-State: AOAM530IovfhI7amFdfRTHCsydrQpDDeEAIWwuv+p4lBp64mG07Tr067
        hrrzTfUtPGMpgfuBCGFzG3U=
X-Google-Smtp-Source: ABdhPJwDAoJ2qwUpVQvRt4s556II7kUnsvePTDZqEk4pZ8vOdYZhgQh6/YN0K/i1Xx4Uw/h0e59MYw==
X-Received: by 2002:a92:ca0a:: with SMTP id j10mr1470621ils.73.1619731006477;
        Thu, 29 Apr 2021 14:16:46 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8a74:d2ad:27b:e619])
        by smtp.gmail.com with ESMTPSA id q11sm1808076ile.56.2021.04.29.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:16:46 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@oss.nxp.com, marex@denx.de, frieder.schrempf@kontron.de,
        tharvey@gateworks.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/5] arm64: dts: imx8mn: add GPC node and power domains
Date:   Thu, 29 Apr 2021 16:16:22 -0500
Message-Id: <20210429211625.1835702-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429211625.1835702-1-aford173@gmail.com>
References: <20210429211625.1835702-1-aford173@gmail.com>
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
---
V3:  Rebase on series starting https://lkml.org/lkml/2021/4/29/72
V2:  Fix missing includes
     Remove interrupt controller flag
     Remove domains which interact with blk-ctl

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 16ea50089567..609294329c7b 100644
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
@@ -612,6 +614,40 @@ src: reset-controller@30390000 {
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

