Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011B645711D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhKSOvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:51:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60012 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235165AbhKSOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:50:56 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJBafiq002441;
        Fri, 19 Nov 2021 15:47:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=hLHZnwsl1Kk6CKGDdj+TXkmQP/GwGEAgmTzVuewj/h8=;
 b=EQ3tBWmKjZmM50V2vJd/N2Y78/CJqZsRdzPNLM4OFAsn5kKpIEjBNhXr7KXB8pqLYyJl
 j/12wIa3duRMF713rmXMPCKvhTOuA+9U3O1sijqS6/x7a999K6SI4wH8VJPye0pgz9JG
 EuBd3fjVZF0gTX8/fcjb3guESlcADJE/GBMjSNBCDwYcH2jKh2qik5lsTKmd8J3TMjRR
 GUGX+6Hp8VyXNRRfXWCz1b8S5KYos6V/aLIai6oRIVDjGtWVAllS2OD7exMVkNJBmDQi
 ao6ZoDdwiZIUVITzGwyhmgaEG4JQ6gOeJaOXtpMN0Nq14zt91xmMxYUDmdH91IDxD65/ sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ceb6sh0cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:47:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 15BBE10002A;
        Fri, 19 Nov 2021 15:47:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EEAA231DF2;
        Fri, 19 Nov 2021 15:47:47 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 15:47:46
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
Subject: [PATCH 7/9] ARM: dts: stm32: rename spi node on stm32mp15xx-dhcom-drc02 boards
Date:   Fri, 19 Nov 2021 15:45:49 +0100
Message-ID: <20211119144551.7577-8-olivier.moysan@foss.st.com>
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

Rename spi1 node on STMP32MP15xx-dhcom-drc02 boards, to match new
labels of SPI/I2S nodes in the SoC device tree.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi
index 4b10b013ffd5..29f18382d962 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi
@@ -114,7 +114,7 @@
 	disable-wp;
 };
 
-&spi1 {
+&spi2s1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins_a>;
 	cs-gpios = <&gpioz 3 0>;
-- 
2.17.1

