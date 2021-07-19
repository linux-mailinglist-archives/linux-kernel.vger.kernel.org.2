Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8F3CD4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbhGSLxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:53:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbhGSLxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:53:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16J8sHpO130195;
        Mon, 19 Jul 2021 03:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626684857;
        bh=W24F9tFUk5DLS11lecrx/SJziuED8Fh6w5AIMu6c6lI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gbW/5on8X7hZHMUL9hHpI6I1h3fYYsTUmH9SkrWe7GuFao/TEPvF6GAJppujslAr+
         xIxX+MwTiI9sHZTwB418zuaauv6uSxdit3raSAmbt4IDH+E0KRmlw0lexBV41vISTu
         Z+xyX/bsyTjMoYJdjMQDNOXcGQuZGHrVNC9mpDTY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16J8sHAf003211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jul 2021 03:54:17 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Jul 2021 03:54:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Jul 2021 03:54:16 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16J8s3hF047822;
        Mon, 19 Jul 2021 03:54:14 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am642-evm: Add ecap0 node
Date:   Mon, 19 Jul 2021 14:24:02 +0530
Message-ID: <20210719085402.28569-5-lokeshvutla@ti.com>
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
signal connected to Pin 1 of J12 on EVM. Add support for adding this
pinmux so that pwm can be observed on pin 1 of Header J12

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 030712221188..7da1238cb1d6 100644
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
@@ -574,3 +580,9 @@ &pcie0_ep {
 	num-lanes = <1>;
 	status = "disabled";
 };
+
+&ecap0 {
+	/* PWM is available on Pin 1 of header J12 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_ecap0_pins_default>;
+};
-- 
2.30.0

