Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E928308693
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhA2HiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:38:16 -0500
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:48929 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232333AbhA2HhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1611905748; bh=9rsRDeYyP6mevg5eT1EqueiLtS/VAtq14uRY9n3RQt8=;
        h=From:To:Subject:Date:Message-Id;
        b=uMepP64XF4Vy4Z0EbwIORVCQW36/Q9H3dLRmrY7sajIDz6cbnlc9zT3R6rD/o/2QL
         J2vuEXdF0SUeeaZUSRiGlQDFayFsXakOw3ZrdFv1UTb0HM8QylMK446BKylqokPsyl
         IwWSmp/7jfTi5POwcjVwa30kT+kdEI0IDkGKq7cyPcmNss2V7miSuOnoSgEzYE0q8U
         4epvUrO+cfRtEDDyFHEdQ5kNe7JpXQg4+sHli+5JZJixXsjr2UmOYperKw2cIHIJTF
         5DGK0xsXPAlQ1sSHXmLRYUdF7cDQxnPtYS7GvCuYK7nK6FMTzmwh/hcrTePzeQbPCt
         F8brPCw20j6qw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id 7154F9A01CE;
        Fri, 29 Jan 2021 07:35:27 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 1/3] ARM: dts: sti: add the spinor controller node within stih407-family
Date:   Fri, 29 Jan 2021 08:34:45 +0100
Message-Id: <20210129073447.18778-2-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129073447.18778-1-avolmat@me.com>
References: <20210129073447.18778-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-29_03:2021-01-28,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101290039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STiH407 family (and further versions STiH410/STiH418) embedded
a serial flash controller allowing fast access to SPI-NOR.
This commit adds the corresponding node, relying on the st-spi-fsm
drivers.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v2: commit log improvement

 arch/arm/boot/dts/stih407-family.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 23a1746f3baa..21f3347a91d6 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -616,6 +616,21 @@
 			st,lpc-mode = <ST_LPC_MODE_CLKSRC>;
 		};
 
+		spifsm: spifsm@9022000{
+			compatible = "st,spi-fsm";
+			reg = <0x9022000 0x1000>;
+			reg-names = "spi-fsm";
+			clocks = <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
+			clock-names = "emi_clk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fsm>;
+			st,syscfg = <&syscfg_core>;
+			st,boot-device-reg = <0x8c4>;
+			st,boot-device-spi = <0x68>;
+
+			status = "disabled";
+		};
+
 		sata0: sata@9b20000 {
 			compatible = "st,ahci";
 			reg = <0x9b20000 0x1000>;
-- 
2.17.1

