Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA79C3606B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhDOKL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:11:26 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38191 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231482AbhDOKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:11:24 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FA2VTC022588;
        Thu, 15 Apr 2021 12:10:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=tMci87o0mc1P4cAu+P9t+g6uU//QM8ZKV7YevOpKLXA=;
 b=G7JPO4os7VlTzeqAi1Y8rlIjtLUTvg5MCuDLO71xBie8HCmiz3DuF+CG3J7UAbppcVo7
 OO5RvEhpQTMG29/gY+/UjtgjparlHk5bPBp4XZ3DbkbmGtfd8SvEaHv3hQ2FT5Qs91Mx
 AKeMWSTldtqlbgEDFIy7dp4bTEJXKPT5NiShCrftxdtrhOD0GGgtLaOL4lkpBs/poSLQ
 xofOxkediSIGxPF2Dlo6KzlrmBKeL+4ps42v0M6Y7S/gc5nyAsmLQYTRz2YcyDWiDlfX
 zpF3cM8Kd4X7eqowewsXSBkzlom5qSjUVQDhweqEaxHMf1UvWfVaZc7crJtGV9raXIki MA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xg6w1qa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:10:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 77BAE100038;
        Thu, 15 Apr 2021 12:10:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 69F39226377;
        Thu, 15 Apr 2021 12:10:41 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 12:10:41
 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <kuba@kernel.org>
Subject: [PATCH 02/13] ARM: dts: stm32: fix RCC node name on stm32f429 MCU
Date:   Thu, 15 Apr 2021 12:10:26 +0200
Message-ID: <20210415101037.1465-3-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prevent warning observed with "make dtbs_check W=1"

Warning (simple_bus_reg): /soc/rcc@40023810: simple-bus unit address format
error, expected "40023800"

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index f6530d724d00..41e0087bdbf9 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -709,7 +709,7 @@
 			status = "disabled";
 		};
 
-		rcc: rcc@40023810 {
+		rcc: rcc@40023800 {
 			#reset-cells = <1>;
 			#clock-cells = <2>;
 			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
-- 
2.17.1

