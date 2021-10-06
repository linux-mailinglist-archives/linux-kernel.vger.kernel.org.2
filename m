Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F2423B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhJFJ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:56:13 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41654 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhJFJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:56:02 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1968Zurl023597;
        Wed, 6 Oct 2021 11:53:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=iBK4jt+j/TuaNdy+BtubPQOGdvAAr+skdXQvKDtN8d4=;
 b=OVS9amKfW5iF06CYWl4M0AJla3mr76y6Opsvuizx+rhWsdJe2z6hQGiH0id/Q8fTtJnG
 nB3eIF+Nsc7yAKsJxawwJpR6OfHpeeAjLO02KyoJssoNs5TTgTISi7xRN5xvgNJDD/S4
 B4rIX/vU8Qb7494IW9R9k6k+fiyn49V1lavZUR8OW4kxDv8gft6sJ5lpztnkHlhROoGw
 7tV1UyYenUyFCLuII4bEFsEMsP6IFch6X5OpyXZam9qTFdT/Fy1JgTjweunFPeWBAeOx
 utaBq4G3lTPQPZtL4njJ4VyvYGBfbDbQ/u2Fi3KQsMT4xo5fikjQZrsAqHaNqsvgKjh+ wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bh8e8ghe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 11:53:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B520100034;
        Wed,  6 Oct 2021 11:53:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6346F21BF6D;
        Wed,  6 Oct 2021 11:53:56 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 6 Oct 2021 11:53:55
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/1] ARM: dts: stm32: use usbphyc ck_usbo_48m as USBH OHCI clock on stm32mp151
Date:   Wed, 6 Oct 2021 11:53:55 +0200
Message-ID: <20211006095355.59078-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_02,2021-10-04_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Referring to the note under USBH reset and clocks chapter of RM0436,
"In order to access USBH_OHCI registers it is necessary to activate the USB
clocks by enabling the PLL controlled by USBPHYC" (ck_usbo_48m).

The point is, when USBPHYC PLL is not enabled, OHCI register access
freezes the resume from STANDBY. It is the case when dual USBH is enabled,
instead of OTG + single USBH.
When OTG is probed, as ck_usbo_48m is USBO clock parent, then USBPHYC PLL
is enabled and OHCI register access is OK.

This patch adds ck_usbo_48m (provided by USBPHYC PLL) as clock of USBH
OHCI, thus USBPHYC PLL will be enabled and OHCI register access will be OK.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index bd289bf5d269..fe194c787e6c 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1452,7 +1452,7 @@ stmmac_axi_config_0: stmmac-axi-config {
 		usbh_ohci: usb@5800c000 {
 			compatible = "generic-ohci";
 			reg = <0x5800c000 0x1000>;
-			clocks = <&rcc USBH>;
+			clocks = <&rcc USBH>, <&usbphyc>;
 			resets = <&rcc USBH_R>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
-- 
2.25.1

