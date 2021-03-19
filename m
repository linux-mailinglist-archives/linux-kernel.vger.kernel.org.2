Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA2E3414A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhCSFUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:20:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59800 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhCSFUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:20:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12J5K5ko074980;
        Fri, 19 Mar 2021 00:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616131205;
        bh=Nqb5Y9w6GzD7efCnp25xTU04yZN1xmH5JCVJA9fhh/0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cmp2vDGPN297sg9VA6xKajzxp5plZTguzTYxKY+vcVVHpvogGygHteNWQD1SFqZxx
         6e64qO/+bwNaEt5hUTgt4QZSi8XHeJlEtI3qU4wO+FZCZ1oHu0VT+wI5trm4TDnsGR
         Xw1PPWrMKKc3OS7MwacfIB9Qjk65CtEL/SQjEZLI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12J5K45U081042
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 00:20:05 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 00:20:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 00:20:03 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12J5JqE2079026;
        Fri, 19 Mar 2021 00:20:01 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am642: reserve gpio in mcu domain for firmware usage
Date:   Fri, 19 Mar 2021 10:49:50 +0530
Message-ID: <20210319051950.17549-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319051950.17549-1-a-govindraju@ti.com>
References: <20210319051950.17549-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio0 subsystem present in MCU domain might be used by firmware and is
not pinned out in evm/sk. Therefore, reserve it for MCU firmware.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 5 +++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 9522f104d979..385d99a3bc4f 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -310,6 +310,11 @@
 	};
 };
 
+/* mcu_gpio0 is reserved for mcu firmware usage */
+&mcu_gpio0 {
+	status = "reserved";
+};
+
 &mcu_i2c0 {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 3a5bee4b0b0c..282fb4185db9 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -220,6 +220,11 @@
 	status = "disabled";
 };
 
+/* mcu_gpio0 is reserved for mcu firmware usage */
+&mcu_gpio0 {
+	status = "reserved";
+};
+
 &sdhci1 {
 	/* SD/MMC */
 	vmmc-supply = <&vdd_mmc1>;
-- 
2.17.1

