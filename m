Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1823E3A87F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFORqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:46:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56980 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFORqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:46:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FHhq4s014733;
        Tue, 15 Jun 2021 12:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623779032;
        bh=xAKySPq+CNE2Vuc5QvTzUTSiNxYnH0GAtBbkgC+2qfg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LWt36hJRxOEApCifqV1VTLvL7WNTwjD+ly7vJ4oZOCvCyBKqIP5oKvbXvrcKzGTOM
         XFilPVgQoaogsIZ5RaSDPlnbPzfNsow3QwhNUxb0hyLRjEabj4a7Jod+M3fKHk0qgU
         DetswsYmDXlt+DQ3Nya7Eg/yfkAN30Xil1zNhsS4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FHhqFr023209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 12:43:52 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 12:43:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 12:43:51 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FHhRGC009558;
        Tue, 15 Jun 2021 12:43:46 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] arm64: dts: ti: k3-am64-main: Reserve OCMRAM for DMSC-lite and secure proxy communication
Date:   Tue, 15 Jun 2021 23:13:24 +0530
Message-ID: <20210615174325.22853-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210615174325.22853-1-a-govindraju@ti.com>
References: <20210615174325.22853-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final 128KB in SRAM is reserved by default for DMSC-lite code and
secure proxy communication buffer. The memory region used for DMSC-lite
code can be optionally freed up by secure firmware API[1]. However, the
buffer for secure proxy communication is not configurable. This default
hardware configuration is unique for AM64.

Therefore, indicate the area reserved for DMSC-lite code and secure proxy
communication buffer in the oc_sram device tree node.

[1] - http://downloads.ti.com/tisci/esd/latest/6_topic_user_guides/security_handover.html#triggering-security-handover

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 693fe24e7f7a..6a883f4349cb 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -27,6 +27,14 @@
 		tfa-sram@0 {
 			reg = <0x0 0x1c000>;
 		};
+
+		dmsc-sram@1e0000 {
+			reg = <0x1e0000 0x1c000>;
+		};
+
+		sproxy-sram@1fc000 {
+			reg = <0x1fc000 0x4000>;
+		};
 	};
 
 	main_conf: syscon@43000000 {
-- 
2.17.1

