Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830463CD4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhGSLxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:53:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhGSLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:53:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16J8sEki130168;
        Mon, 19 Jul 2021 03:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626684854;
        bh=P0p8GvAUCyAYZKTuQ5HqWppkxFzfMtSjgIjGyXyRRGQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dTFkLAHwkL6Ws2taGu6HNmNYbQIGt+fyRRcOL3r44aWq6wCcRiQ9LHlDnInzTX+Ab
         uuoM6j77e1ugeYwBs6jj/GN6H0Ob4NardzPZ9+HfnfrAgEKqjaFoGbUYaIFZzP3faC
         hfwE1clOJDCXx7r0LZ8MuhPN0uo7J6INO2SqFuic=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16J8sE80121290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jul 2021 03:54:14 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Jul 2021 03:54:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Jul 2021 03:54:14 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16J8s3hE047822;
        Mon, 19 Jul 2021 03:54:11 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-am642-sk: Add ecap0 node
Date:   Mon, 19 Jul 2021 14:24:01 +0530
Message-ID: <20210719085402.28569-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210719085402.28569-1-lokeshvutla@ti.com>
References: <20210719085402.28569-1-lokeshvutla@ti.com>
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

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index d3aa2901e6fd..eb0d10e6e787 100644
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
@@ -453,3 +459,9 @@ &pcie0_rc {
 &pcie0_ep {
 	status = "disabled";
 };
+
+&ecap0 {
+	/* PWM is available on Pin 1 of header J3 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_ecap0_pins_default>;
+};
-- 
2.30.0

