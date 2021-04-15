Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445343606CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhDOKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:11:44 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38173 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232381AbhDOKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:11:26 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FA2WmV022690;
        Thu, 15 Apr 2021 12:10:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=iKl8ihiAwkR441LJhrdzRvXU5oYA0PmZdlNbMgXPPHc=;
 b=7Kh1GUmPhwYz3vOg7n5oHo2B/CTWYQNXCArRPUB1iOevT7yo4mepcT8fNQ3e7lOT6JEP
 DRV/A+1Js+GszEgME2k+5iQVqNQy84n0Vpk6oixPKNL09uI3C2AITXs65IDnU3hyfjGB
 Re91/f/1Lr0Yk0LM+FiSkw6hC5p+FVr+17Pv+C/L/FrlItPayzQxRlv3njNjsBTVzk0O
 M9bAM42tGm+rkpt8t7KzNJxvtBaOBhMX0bmdKEfihW2oEhbseVtLRAJ7ukbVzVxCo1Ga
 Y7C4/1m5byiK9r6vl3UDBodT6z4Xgo6/phTByB6EeRgS81ml46VY6rGAXEPAHugrBKhq MA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37xg6w1qam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:10:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9EB6510002A;
        Thu, 15 Apr 2021 12:10:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8EDA6226377;
        Thu, 15 Apr 2021 12:10:45 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Apr 2021 12:10:45
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
Subject: [PATCH 07/13] ARM: dts: stm32: move stmmac axi config in ethernet node on stm32mp15
Date:   Thu, 15 Apr 2021 12:10:31 +0200
Message-ID: <20210415101037.1465-8-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes the following warning seen running "make dtbs_check W=1"

Warning (simple_bus_reg): /soc/stmmac-axi-config: missing or empty
reg/ranges property

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index fb80d53e6be2..8aa87cb86821 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1409,12 +1409,6 @@
 			status = "disabled";
 		};
 
-		stmmac_axi_config_0: stmmac-axi-config {
-			snps,wr_osr_lmt = <0x7>;
-			snps,rd_osr_lmt = <0x7>;
-			snps,blen = <0 0 0 0 16 8 4>;
-		};
-
 		ethernet0: ethernet@5800a000 {
 			compatible = "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
 			reg = <0x5800a000 0x2000>;
@@ -1440,6 +1434,12 @@
 			snps,axi-config = <&stmmac_axi_config_0>;
 			snps,tso;
 			status = "disabled";
+
+			stmmac_axi_config_0: stmmac-axi-config {
+				snps,wr_osr_lmt = <0x7>;
+				snps,rd_osr_lmt = <0x7>;
+				snps,blen = <0 0 0 0 16 8 4>;
+			};
 		};
 
 		usbh_ohci: usb@5800c000 {
-- 
2.17.1

