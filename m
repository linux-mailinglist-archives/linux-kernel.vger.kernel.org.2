Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7F36B1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhDZKqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:46:47 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:52756 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhDZKqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:46:45 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QAgMBq030924;
        Mon, 26 Apr 2021 12:45:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=hcCxZtYxYxv8vj0tBPhmpxbvzi6xB/6A326+3anLC9U=;
 b=V9oGwPWe5yDcuCLDqRQQkAZOHnrKMoPcCX7Er+FGmB/izQST2yjk7IHn/O6UmXCqIZQj
 1QufD9tmkCbxswZuWeb3aL/CzitjVbnIfNB5B++BZv+XJUR8HgqQJLYdZzGWVhRn4/Q3
 jfQqL66Rd2rd81NjOcsEc6w22+gESjJhfLIWdPV7Gmxcx6h7SAceUF3OQJe/aU/mEvlt
 Y7iUvQu01NUA5+pYLSGTv7cbFRxQLruyw8AfNcpsKzWhKWLMIAHkT6i8JO2QpPL2hsiH
 SwxSEAWOVXJkS6YtOIt56MxQ/DCyn68HGYg/kewro3LoE3SxtbHT14CjG+VkQzH3z8Zy 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 385gb2b81h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 12:45:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BB49100034;
        Mon, 26 Apr 2021 12:45:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2A1C9243D3A;
        Mon, 26 Apr 2021 12:45:52 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 12:45:51
 +0200
From:   <patrice.chotard@foss.st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 1/1] ARM: dts: stm32: Configure qspi's mdma transfer to block for stm32mp151
Date:   Mon, 26 Apr 2021 12:45:36 +0200
Message-ID: <20210426104536.29576-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_03:2021-04-26,2021-04-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Configure qspi's mdma from buffer transfer (max 128 bytes) to
block transfer (max 64K bytes).

mtd_speedtest shows that write throughtput increases :
  - from 734 to 782 KiB/s (~6.5%) with s25fl512s SPI-NOR.
  - from 4848 to 5319 KiB/s (~9.72%) with Micron SPI-NAND.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 4b8031782555..cb326c1e12bc 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1358,8 +1358,8 @@
 			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
 			reg-names = "qspi", "qspi_mm";
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&mdma1 22 0x2 0x100002 0x0 0x0>,
-			       <&mdma1 22 0x2 0x100008 0x0 0x0>;
+			dmas = <&mdma1 22 0x2 0x10100002 0x0 0x0>,
+			       <&mdma1 22 0x2 0x10100008 0x0 0x0>;
 			dma-names = "tx", "rx";
 			clocks = <&rcc QSPI_K>;
 			resets = <&rcc QSPI_R>;
-- 
2.17.1

