Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F5C45711E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhKSOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:51:07 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54710 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235158AbhKSOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:50:57 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJBhAlD028361;
        Fri, 19 Nov 2021 15:47:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=/AS+UCeSy85lgCeYmkKCKu1vC9Ig5p0E8k9UAs4vdCU=;
 b=fND2YVCAAFflYYwiWOOYkfZRgBleFtTJSrpbb4wCfLGxQHPaMRoaMz7E0tJbvzjgVj2R
 J7ZUJxPUVWwfHM8uoRDG7bqmBnQEI7mcpy8vMK7SQwL/o04L+rVEvkFio9qImRZ77RTq
 wVsLTTe4uiKvIjT++bVs95Xtc9wbzgEK8ljK1HxwK1xNBDsEnfIqSoU1wX+MAZzt54yw
 lx5O4yRxNFpoZy7OKRnxct9ZAUpPRTqgPympIl+GWl1hPFXJ99j9ZNBHnK8qHbr2EB1W
 0sp7IzzD7V2vknpcMFobv+We8SY9bC80d4IYe5St/eVhzmmEh4GvMqVvO63+19Zl3HLI iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ce6b1k0nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:47:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCB51100034;
        Fri, 19 Nov 2021 15:47:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D5202231DF2;
        Fri, 19 Nov 2021 15:47:47 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 15:47:47
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
Subject: [PATCH 8/9] ARM: dts: stm32: rename spi node on stm32mp157c-ev1 board
Date:   Fri, 19 Nov 2021 15:45:50 +0100
Message-ID: <20211119144551.7577-9-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119144551.7577-1-olivier.moysan@foss.st.com>
References: <20211119144551.7577-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename spi1 node on STMP32MP157C-EV1 boards, to match new
labels of SPI/I2S nodes in the SoC device tree.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 5c5b1ddf7bfd..c836b4a1dbe2 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -293,7 +293,7 @@
 	status = "disabled";
 };
 
-&spi1 {
+&spi2s1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins_a>;
 	status = "disabled";
-- 
2.17.1

