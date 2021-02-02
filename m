Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC730BFD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhBBNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhBBNb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:31:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2C3F64F68;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=0k8G1hBpz4Np2I1ZDNqtU5gVCYWWxmCauHG4Ld/0WK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4qfx5bMt2weX0iSbqs43jbBq7MKFCkC+FAJ01PO13+R8QCwYAebtYke1AoVPZk9x
         bZuEFcOZHpH+IiAsJI1oTiGuJi6ou9tmvb1lV4y9zEWI0HOixjPBw9XQNYfDbNJeZy
         aMhJkU15oINMOcElK36EbUDelf3C/SLz4UIaNbg6RJgrIDxOlYIIIrcSgM/t/ATC9l
         9BBrR5GqhEHcxfONkpUSkWOTUgoR89XtR2VJvNGRHnjzYKlxLHvQm4TzF1fDtokOvd
         Kt5epQ4fiFS4iuE9AC2T9ql1IiZcBs+kpLmjjh6C2jOmDQWuX5H9/rEjjETWRR53sD
         5TJxwRQP/HImA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011yv-KY; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 05/13] arm64: dts: hisilicon: Add HI3670 PCI-E controller support
Date:   Tue,  2 Feb 2021 14:29:50 +0100
Message-Id: <301bbde15f7a248222745c8ab98c0e20ae877db0.1612271903.git.mchehab+huawei@kernel.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add PCI-E controller support for HiSilicon HI3670 SoC.

[mchehab+huawei@kernel.org: fix merge conflicts]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 64 +++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 5522a5de07a8..c0a0336a8ea4 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
 			#clock-cells = <1>;
 		};
 
+		pmctrl: pmctrl@fff31000 {
+			compatible = "hisilicon,hi3670-pmctrl", "syscon";
+			reg = <0x0 0xfff31000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		iomcu: iomcu@ffd7e000 {
 			compatible = "hisilicon,hi3670-iomcu", "syscon";
 			reg = <0x0 0xffd7e000 0x0 0x1000>;
@@ -660,6 +666,64 @@ gpio28: gpio@fff1d000 {
 			clock-names = "apb_pclk";
 		};
 
+		its_pcie: interrupt-controller@f4000000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0xf5100000 0x0 0x100000>;
+		};
+
+		pcie@f4000000 {
+			compatible = "hisilicon,kirin970-pcie", "hisilicon,kirin960-pcie";
+			reg = <0x0 0xf4000000 0x0 0x1000000>,
+			      <0x0 0xfc180000 0x0 0x1000>,
+			      <0x0 0xfc000000 0x0 0x80000>,
+			      <0x0 0xf5000000 0x0 0x2000>;
+			reg-names = "dbi", "apb", "phy", "config";
+			bus-range = <0x0  0x1>;
+			msi-parent = <&its_pcie>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x00000000
+				  0x0 0xf6000000
+				  0x0 0x02000000>;
+			num-lanes = <1>;
+			#interrupt-cells = <1>;
+			interrupts = <0 283 4>;
+			interrupt-names = "msi";
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0x0 0 0 1
+					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 2
+					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 3
+					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 4
+					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
+				 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
+				 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+			clock-names = "pcie_phy_ref", "pcie_aux",
+				      "pcie_apb_phy", "pcie_apb_sys",
+				      "pcie_aclk";
+			switch,reset-gpios = <&gpio7 0 0 >;
+			eth,reset-gpios = <&gpio25 2 0 >;
+			m_2,reset-gpios = <&gpio3 1 0 >;
+			mini1,reset-gpios = <&gpio27 4 0 >;
+
+			eth,clkreq-gpios = <&gpio20 6 0 >;
+			m_2,clkreq-gpios = <&gpio27 3 0 >;
+			mini1,clkreq-gpios = <&gpio17 0 0 >;
+
+			/*vboost iboost pre post main*/
+			eye_param = <0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie_clkreq_pmx_func &pcie_clkreq_cfg_func>;
+		};
+
 		/* UFS */
 		ufs: ufs@ff3c0000 {
 			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
-- 
2.29.2

