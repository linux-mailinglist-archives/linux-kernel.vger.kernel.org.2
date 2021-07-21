Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396043D0E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhGULJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:09:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34392 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbhGUK4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:56:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16LBad7k058772;
        Wed, 21 Jul 2021 06:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626867399;
        bh=uePKf1OmyD6OW0Cttfy3/pVQXaBFYXSb4x30lPq/Iu4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aVa/JL+sAkp1YLYA5RNLP4P49vZXWpMi43qsqcc12rLrEXiHr3DwfxtqOxU+7YpBq
         SLYkkRh3TA7BI+IsZveH5lXsy3vTB+GrVktFZEGhKoYJIIkKTC2DJglEohHddXPUzG
         jG4ovdugTCd7wipHjR9wRm76cAkHZcBQXsbPGBjs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16LBadDS109237
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 06:36:39 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 06:36:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 06:36:39 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16LBaQBo115096;
        Wed, 21 Jul 2021 06:36:36 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-am642-evm: Add pwm nodes
Date:   Wed, 21 Jul 2021 17:06:24 +0530
Message-ID: <20210721113625.17299-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721113625.17299-1-lokeshvutla@ti.com>
References: <20210721113625.17299-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ecap0 can be configured to use pad ECAP0_IN_APWM_OUT (D18) which has a
signal connected to Pin 1 of J12 on EVM. Add support for adding this
pinmux so that pwm can be observed on pin 1 of Header J12

Also mark all un-used epwm and ecap pwm nodes as disabled.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 030712221188..24ce4942618d 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -288,6 +288,12 @@ AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
 			AM64X_IOPAD(0x0008, PIN_INPUT, 0) /* (N19) OSPI0_DQS */
 		>;
 	};
+
+	main_ecap0_pins_default: main-ecap0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
+		>;
+	};
 };
 
 &main_uart0 {
@@ -574,3 +580,53 @@ &pcie0_ep {
 	num-lanes = <1>;
 	status = "disabled";
 };
+
+&ecap0 {
+	/* PWM is available on Pin 1 of header J12 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_ecap0_pins_default>;
+};
+
+&ecap1 {
+	status = "disabled";
+};
+
+&ecap2 {
+	status = "disabled";
+};
+
+&epwm0 {
+	status = "disabled";
+};
+
+&epwm1 {
+	status = "disabled";
+};
+
+&epwm2 {
+	status = "disabled";
+};
+
+&epwm3 {
+	status = "disabled";
+};
+
+&epwm4 {
+	status = "disabled";
+};
+
+&epwm5 {
+	status = "disabled";
+};
+
+&epwm6 {
+	status = "disabled";
+};
+
+&epwm7 {
+	status = "disabled";
+};
+
+&epwm8 {
+	status = "disabled";
+};
-- 
2.31.1

