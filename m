Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7786239A35B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFCOgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:36:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55500 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhFCOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:36:33 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153EYhFm101948;
        Thu, 3 Jun 2021 09:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622730883;
        bh=gvdndIn3p5A380cJVF8NfVkgU13BPhDoSC1iDxbrYV8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eLC9R5qWEzAC7lw8pAAfN47LC98T9IictucqyDJJDh/l+fL4xPMCwUa0CZ7VUmO+y
         UIDajouOrM7/Ev55aDgV49W7juzgMxwYXcUaliAp3RsJM0p2Ka1BP8HbThdqCgGuMj
         yEO+KGdqxojPz0WCHZwz2HXr08fIfdpWWFvBBjEw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153EYhYd022184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 09:34:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 09:34:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 09:34:43 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153EYRDL011740;
        Thu, 3 Jun 2021 09:34:40 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for SERDES
Date:   Thu, 3 Jun 2021 20:04:26 +0530
Message-ID: <20210603143427.28735-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603143427.28735-1-kishon@ti.com>
References: <20210603143427.28735-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use external clock for all the SERDES used by PCIe controller. This will
make the same clock used by the local SERDES as well as the clock
provided to the PCIe connector.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 86f7ab511ee8..1b25a5ae9635 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy-cadence.h>
 
 / {
 	chosen {
@@ -639,7 +640,40 @@
 	clock-frequency = <100000000>;
 };
 
+&wiz0_pll1_refclk {
+	assigned-clocks = <&wiz0_pll1_refclk>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&wiz0_refclk_dig {
+	assigned-clocks = <&wiz0_refclk_dig>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&wiz1_pll1_refclk {
+	assigned-clocks = <&wiz1_pll1_refclk>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&wiz1_refclk_dig {
+	assigned-clocks = <&wiz1_refclk_dig>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&wiz2_pll1_refclk {
+	assigned-clocks = <&wiz2_pll1_refclk>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&wiz2_refclk_dig {
+	assigned-clocks = <&wiz2_refclk_dig>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
 &serdes0 {
+	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>;
+	assigned-clock-parents = <&wiz0_pll1_refclk>;
+
 	serdes0_pcie_link: link@0 {
 		reg = <0>;
 		cdns,num-lanes = <1>;
@@ -650,6 +684,9 @@
 };
 
 &serdes1 {
+	assigned-clocks = <&serdes1 CDNS_SIERRA_PLL_CMNLC>;
+	assigned-clock-parents = <&wiz1_pll1_refclk>;
+
 	serdes1_pcie_link: link@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
@@ -660,6 +697,9 @@
 };
 
 &serdes2 {
+	assigned-clocks = <&serdes2 CDNS_SIERRA_PLL_CMNLC>;
+	assigned-clock-parents = <&wiz2_pll1_refclk>;
+
 	serdes2_pcie_link: link@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
-- 
2.17.1

