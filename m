Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F014745711F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhKSOvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:51:13 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54720 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236033AbhKSOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:50:58 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJBfcYK028223;
        Fri, 19 Nov 2021 15:47:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=HQiQh8c5C3HZmbe0r9dHM4pAO2C0djI19XsXNNKnkn0=;
 b=FXj6Hib4yx9dxIpzNP1A89Ab8NjstqcjA0aYZD0gcEK4GfBAJU53D6Cflpy74MJt55F2
 HqxDW8GvYc3lGkpPeg+bjcdvar5xZvupeTypj6unZPGlgKzQEcj+165uBR3R0GjDjNJy
 U3XM49XXBvwLcnsKA5onUnr+7MJ+FyMo5OdQxtbe/cEJd6hpGiBNsy9CHGvShQlF4dZ7
 o3Hvbdng0So69ZT+QJGAK1lDCQ9lQRghPC+ZrdczED/PoOYy7RW09M6HGDLxFNaKLn5F
 6il1HzpKMBpOXDwrVZ86/TlOaiR63auzuDecsKY0pGxgp0Jzj7tckfSyHsdV4LGXHUwh +Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ce6b1k0nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:47:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B64B410002A;
        Fri, 19 Nov 2021 15:47:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AEE74231DF2;
        Fri, 19 Nov 2021 15:47:48 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 15:47:48
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
Subject: [PATCH 9/9] ARM: dts: stm32: adapt i2s node to spi binding on stm32mp15xx-dk
Date:   Fri, 19 Nov 2021 15:45:51 +0100
Message-ID: <20211119144551.7577-10-olivier.moysan@foss.st.com>
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

In DT check utility, the spi2s2 node is identified as an spi node.
The check_spi_bus_reg() function issues a warning "missing or empty
reg property" if reg property is not defined in child nodes.
Add reg property to STM32 I2S port node on STM32MP15XX-DK board
to match this requirement and add related unit-address in node name.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index ff7dabfeb322..36187089c073 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -437,7 +437,8 @@
 	pinctrl-1 = <&i2s2_sleep_pins_a>;
 	status = "okay";
 
-	i2s2_port: port {
+	i2s2_port: port@0 {
+		reg = <0>;
 		i2s2_endpoint: endpoint {
 			remote-endpoint = <&sii9022_tx_endpoint>;
 			format = "i2s";
-- 
2.17.1

