Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218484570FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhKSOt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:49:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34544 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235933AbhKSOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:49:55 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJ9bMKW002060;
        Fri, 19 Nov 2021 15:46:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=LoJHXrGNP2sFq5xXmuOvWWyeGNiwsEBFx2HaAyznWfU=;
 b=gzXEp9cjfawC4rT4lJCg0zLa1mOgPonlxOsEVJ3A5yrh4mCkRPgvxrliAKQdyZhdvneu
 jM/7giEbRM95ZhyAnOR1VrqQXLa+cTDLgzqp6M2EOVn7R5R2Ne1/PcIOpmorYt6Tmzxu
 +JXppBAEOm1qHWr9RXShTK+pjfT/3ZGF0JBPp8BLB7/c6ncDp/BqESk77LlFeCMJfMyy
 2hyqXBEZJCylFNZqXSk/2LtoyiAINNkY44T6OGjCfjOE0zvE4QOP235zSBgp9SkK0g99
 HHJfPI4yZkWuULZptQ7Tj+TGfrbRKXXKd6E1WCPxSIBBYdiun7kpsljP49s8r5D23yN7 Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ce1knc8jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:46:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A60E910002A;
        Fri, 19 Nov 2021 15:46:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9E9F3231DF1;
        Fri, 19 Nov 2021 15:46:44 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 15:46:43
 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <arnaud.pouliquen@foss.st.com>, <fabrice.gasnier@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH 4/9] ARM: dts: stm32: merge spi and i2s nodes
Date:   Fri, 19 Nov 2021 15:45:46 +0100
Message-ID: <20211119144551.7577-5-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119144551.7577-1-olivier.moysan@foss.st.com>
References: <20211119144551.7577-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a SPI instance offers I2S feature, two nodes are defined
in SoC device tree to support both SPI and I2S.
Merge SPI node and I2S nodes into a single node, to avoid
hardware description duplication and compilation warnings.
spi2sx label is used to identify the SPI instances which
are supporting I2S feature.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 39 +++----------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index bd289bf5d269..3649a4eb425f 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -386,7 +386,7 @@
 			};
 		};
 
-		spi2: spi@4000b000 {
+		spi2s2: spi@4000b000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32h7-spi";
@@ -400,18 +400,7 @@
 			status = "disabled";
 		};
 
-		i2s2: audio-controller@4000b000 {
-			compatible = "st,stm32h7-i2s";
-			#sound-dai-cells = <0>;
-			reg = <0x4000b000 0x400>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmamux1 39 0x400 0x01>,
-			       <&dmamux1 40 0x400 0x01>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		spi3: spi@4000c000 {
+		spi2s3: spi@4000c000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32h7-spi";
@@ -425,17 +414,6 @@
 			status = "disabled";
 		};
 
-		i2s3: audio-controller@4000c000 {
-			compatible = "st,stm32h7-i2s";
-			#sound-dai-cells = <0>;
-			reg = <0x4000c000 0x400>;
-			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmamux1 61 0x400 0x01>,
-			       <&dmamux1 62 0x400 0x01>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
 		spdifrx: audio-controller@4000d000 {
 			compatible = "st,stm32h7-spdifrx";
 			#sound-dai-cells = <0>;
@@ -681,7 +659,7 @@
 			status = "disabled";
 		};
 
-		spi1: spi@44004000 {
+		spi2s1: spi@44004000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "st,stm32h7-spi";
@@ -695,17 +673,6 @@
 			status = "disabled";
 		};
 
-		i2s1: audio-controller@44004000 {
-			compatible = "st,stm32h7-i2s";
-			#sound-dai-cells = <0>;
-			reg = <0x44004000 0x400>;
-			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmamux1 37 0x400 0x01>,
-			       <&dmamux1 38 0x400 0x01>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
 		spi4: spi@44005000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.17.1

