Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D6413452
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhIUNgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:36:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45528 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233033AbhIUNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:36:49 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L7AKhB006203;
        Tue, 21 Sep 2021 15:35:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=9+Kwlm+L8H7YKY6mvIF1mdYOkB2nTTC9Hu8EuriSzrU=;
 b=nXFMZrZzOSdm5R6DaTY7ZzSwgPRXY9EWeYurFmkxS0NtlCvAxgTFNo+je7p/46boFQLY
 2aR2dK1A2nw6CrlrGcIN7bAv4l9vuwO4FSBMBCF1YwcfQCliyOq6Ez8IniEL38fF8bVc
 7+J+cA1lCMwhp2ZSN4deoNSzKgzbynxD1HYFXwkYEsK8A96ETfSlZ81nZ/ZWeodev0oX
 g8bAFVyhAAzDWC06Rx7lCBqtInkt8EBW/eilPjkOvfsiOxrUdo47FOo7m1quuhE4xvSE
 P3ZhBl+okv+B4uUiuZJVrY83MOIgPREY938GUv8022FCzjfc8k20+pzyVj/eu0pkc71M gA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b7as51u8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 15:35:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1364100034;
        Tue, 21 Sep 2021 15:35:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A44D244899;
        Tue, 21 Sep 2021 15:35:07 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep 2021 15:35:04
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <amelie.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: fix STUSB1600 Type-C irq level on stm32mp15xx-dkx
Date:   Tue, 21 Sep 2021 15:34:49 +0200
Message-ID: <1632231289-18881-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_01,2021-09-20_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STUSB1600 IRQ (Alert pin) is active low (open drain). Interrupts may get
lost currently, so fix the IRQ type.

Fixes: 83686162c0eb ("ARM: dts: stm32: add STUSB1600 Type-C using I2C4 on stm32mp15xx-dkx")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 9a95489..878ea36 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -260,7 +260,7 @@
 	stusb1600@28 {
 		compatible = "st,stusb1600";
 		reg = <0x28>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-parent = <&gpioi>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&stusb1600_pins_a>;
-- 
2.7.4

