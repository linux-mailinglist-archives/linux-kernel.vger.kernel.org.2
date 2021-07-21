Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831B93D0E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhGULJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:09:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34402 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbhGUK4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:56:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16LBagsh058786;
        Wed, 21 Jul 2021 06:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626867402;
        bh=D4NmLUs3UlfPiqgvotqTScLaeN1iSSzMQoE9snEy5vo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ttfALl4zNzI1NzT9gHciOr5yujy57KlJl9sWZJ247t3eRMT1O+Dd6GmEB9ZCSC4Sc
         O0mPtCeuEzBmWo6oXma5QR6KbeJIDIex45rX2ud+JftZ+MyaKts2xq6n9BDtZo0BZC
         aklVVyVwkuJER7iEvIqhEL7896N7GqtBkQnT0Ysw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16LBagJD089847
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 06:36:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 06:36:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 06:36:41 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16LBaQBp115096;
        Wed, 21 Jul 2021 06:36:39 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-am642-sk: Add pwm nodes
Date:   Wed, 21 Jul 2021 17:06:25 +0530
Message-ID: <20210721113625.17299-5-lokeshvutla@ti.com>
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
signal connected to Pin 1 of J3. Add support for adding this pinmux so
that pwm can be observed on pin 1 of Header J3

Also mark all un-used epwm and ecap pwm nodes as disabled.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 64 ++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index d3aa2901e6fd..6b45cdeeeefa 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -210,6 +210,12 @@ AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
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
 
 &mcu_uart0 {
@@ -453,3 +459,61 @@ &pcie0_rc {
 &pcie0_ep {
 	status = "disabled";
 };
+
+&ecap0 {
+	/* PWM is available on Pin 1 of header J3 */
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
+	/*
+	 * EPWM4_A, EPWM4_B is available on Pin 32 and 33 on J4 (RPi hat)
+	 * But RPi Hat will be used for other use cases, so marking epwm4 as disabled.
+	 */
+	status = "disabled";
+};
+
+&epwm5 {
+	/*
+	 * EPWM5_A, EPWM5_B is available on Pin 29 and 31 on J4 (RPi hat)
+	 * But RPi Hat will be used for other use cases, so marking epwm5 as disabled.
+	 */
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

