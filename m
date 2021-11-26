Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6511F45ECC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348475AbhKZLkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:40:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55228 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241570AbhKZLiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:38:05 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AQAIQGG005791;
        Fri, 26 Nov 2021 12:34:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=t9BKOAnNH3/ir6fGgTKt/gxb6w6S9NYgh/v5dE749Lk=;
 b=Y91G++Exgef0SjdUHnFKX2ctR+4/xDbf1vo4KZBAx418t76tFKrNPXMai/eDpGGcCnWR
 BsKsVu2P7EPX++ogveSDG8UrGgk8Zkd7TAS9aqXZUfGsht1MUMXLsxwpem19R1EX246a
 +q+6lyQ0LhyZZ3XtfQqkVR2f8fx0FJ5lxyBMj3uunMaAJRjDEOW9w1BM+lhSJ3JIvqz+
 t/nfM2A06iHfzT4h09ghGZz03lQ9Dh01PlQbVobWdafRHdK/3M2KMC+HVni5oKxMUaDG
 IhOGHM006w577nMCcym9hO8oih0b3mYyB7wVd1gR9STX387t+jXDm1xIINBQlmvLfGLp Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cjptfarr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 12:34:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE88910002A;
        Fri, 26 Nov 2021 12:34:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C2BFB2261F2;
        Fri, 26 Nov 2021 12:34:38 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 26 Nov 2021 12:34:38
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <amelie.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>, <fabien.dessenne@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: fix stusb1600 pinctrl used on stm32mp157c-dk
Date:   Fri, 26 Nov 2021 12:33:40 +0100
Message-ID: <1637926420-5116-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_03,2021-11-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pinctrl handle is used to setup a pull-up on the stusb1600 IRQ pin (that
is open drain).
When in ANALOG state, no pull-up can be applied in the GPIO HW controller,
still the setting is done into the register. The pull-up is effective
currently, only when the GPIO IRQ is requested. The correct setting is to
use directly the GPIO, instead of ANALOG state.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 5f060fe..3b65130 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1718,7 +1718,7 @@
 
 	stusb1600_pins_a: stusb1600-0 {
 		pins {
-			pinmux = <STM32_PINMUX('I', 11, ANALOG)>;
+			pinmux = <STM32_PINMUX('I', 11, GPIO)>;
 			bias-pull-up;
 		};
 	};
-- 
2.7.4

