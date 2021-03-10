Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440873342EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhCJQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:20:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53900 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhCJQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:19:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AGJguU001100;
        Wed, 10 Mar 2021 10:19:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615393182;
        bh=NS617L7GBDvhALxjhlVPMrApfi+ZXBRnh8cjYPPANU0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TQhf+wok2HD58xslWBLC8Be2jdnXq4ZJqx6OD/XK2uwmqzrshdTU0T0wChXqQthhz
         HpDx8aR/CpbmCIK68KHgqAym5fo6OKod1h9dftjy3pqDTOHpgTRxipJmtPuVQxj/4Y
         Vlcykwmh86zCvlJrx0N6fEzRmicyxNrebxXpl4UY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AGJgWh022942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 10:19:42 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 10:19:41 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 10:19:42 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AGJPxt058353;
        Wed, 10 Mar 2021 10:19:37 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <a-govindraju@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio modules
Date:   Wed, 10 Mar 2021 21:49:22 +0530
Message-ID: <20210310161924.22256-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310161924.22256-1-a-govindraju@ti.com>
References: <20210310161924.22256-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

There are 6 gpio instances inside SoC with 2 groups as show below:
    Group one: wkup_gpio0, wkup_gpio1
    Group two: main_gpio0, main_gpio2, main_gpio4, main_gpio6

Only one instance from each group can be used at a time. So use main_gpio0
and wkup_gpio0 in current linux context and disable the rest of the nodes.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 4a7182abccf5..b493f939b09a 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -122,6 +122,22 @@
 	status = "disabled";
 };
 
+&main_gpio2 {
+	status = "disabled";
+};
+
+&main_gpio4 {
+	status = "disabled";
+};
+
+&main_gpio6 {
+	status = "disabled";
+};
+
+&wkup_gpio1 {
+	status = "disabled";
+};
+
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
-- 
2.17.1

