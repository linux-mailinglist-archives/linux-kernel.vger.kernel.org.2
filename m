Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09FF30BF7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhBBNcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232353AbhBBNb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:31:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D88DF64F61;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=Tmpg5G8Q5WWZwkwEzV2K4ehCcH+3UNaSq0kO2M0KaCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUkXaIK68CSCM4Vaqzz+PupuMY7Sx73apJkS8Xl4sbkCGrzk8MrdEzhZE6j+RdKe9
         +izykXTBqxMbvIJiuJZFJ4bk6rsKfrIqVE3mINm2G5XA2BdaD5xENhF2Pw66Zz+iKe
         eWG7PDVyR51IWYcV9BWvGOqM4e++q49pG3jQFfCPOmxT8wf2MgHQt6LHKk/Yhzt6cc
         p/eXYzxcfCN4Qeas+X4jSHM69+9Tn9cnrjHeg+oled73uFHHa+9K6k4kv010HteMkq
         mrbZJSUNjLc+IMrNjNivP3karOUuCWU26EnB4r0G8V1Ib6B9Bs5BhWiv782OSctKVU
         1LjICCl9cFN1g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011zH-Tr; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] arm64: dts: hisilicon: cleanup Hikey 970 PCI schema
Date:   Tue,  2 Feb 2021 14:29:58 +0100
Message-Id: <c966e7788af64dbd384d2e9def204533d73e8a97.1612271903.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612271903.git.mchehab+huawei@kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original schema was not generic enough and not
properly documented. Those got updated via some driver
changes.

Apply those changes also to Hikey 970 schema.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi      | 18 +++++++++---------
 .../boot/dts/hisilicon/hikey970-pmic.dtsi      |  1 -
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index c0a0336a8ea4..7e96d5eda13a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -673,11 +673,12 @@ its_pcie: interrupt-controller@f4000000 {
 		};
 
 		pcie@f4000000 {
-			compatible = "hisilicon,kirin970-pcie", "hisilicon,kirin960-pcie";
+			compatible = "hisilicon,kirin970-pcie";
 			reg = <0x0 0xf4000000 0x0 0x1000000>,
 			      <0x0 0xfc180000 0x0 0x1000>,
 			      <0x0 0xfc000000 0x0 0x80000>,
 			      <0x0 0xf5000000 0x0 0x2000>;
+			pci-supply = <&ldo33>;
 			reg-names = "dbi", "apb", "phy", "config";
 			bus-range = <0x0  0x1>;
 			msi-parent = <&its_pcie>;
@@ -705,19 +706,18 @@ &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
 				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
 				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
 				 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+
 			clock-names = "pcie_phy_ref", "pcie_aux",
 				      "pcie_apb_phy", "pcie_apb_sys",
 				      "pcie_aclk";
-			switch,reset-gpios = <&gpio7 0 0 >;
-			eth,reset-gpios = <&gpio25 2 0 >;
-			m_2,reset-gpios = <&gpio3 1 0 >;
-			mini1,reset-gpios = <&gpio27 4 0 >;
 
-			eth,clkreq-gpios = <&gpio20 6 0 >;
-			m_2,clkreq-gpios = <&gpio27 3 0 >;
-			mini1,clkreq-gpios = <&gpio17 0 0 >;
+			reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
+				      <&gpio3 1 0 >, <&gpio27 4 0 >;
 
-			/*vboost iboost pre post main*/
+			clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
+				       <&gpio17 0 0 >;
+
+			/* vboost iboost pre post main */
 			eye_param = <0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
 
 			pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
index 8cf45b962fea..49afcd7c00ce 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -73,7 +73,6 @@ ldo33: LDO33 { /* PEX8606 */
 					regulator-name = "ldo33";
 					regulator-min-microvolt = <2500000>;
 					regulator-max-microvolt = <3300000>;
-					regulator-boot-on;
 				};
 
 				ldo34: LDO34 { /* GPS AUX IN VDD */
-- 
2.29.2

