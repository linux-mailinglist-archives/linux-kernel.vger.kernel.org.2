Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D81307105
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhA1IOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:14:25 -0500
Received: from st43p00im-ztbu10073701.me.com ([17.58.63.183]:49595 "EHLO
        st43p00im-ztbu10073701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231690AbhA1IIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1611820691; bh=LIfpvi/CeAZsNwLDcOcpd47eJbyY1m6zbqe5JJoe9sU=;
        h=From:To:Subject:Date:Message-Id;
        b=z4xoQzQmFfGosBgPnU500zNFp04pgs2MRBqSp392pK3Mh7eOMXSUyMKge7Zg3wAUu
         CcBSTGTR2HdL37kn7WQfocE4zTaPKkMDuojeOVFUebRuAC8wr3LNODbE2GK08xLt2R
         Auy2T09DIXINGBmcORvY/39RkwsFt5FJo5sZJNuVJi77Mh+XromKE2YvAq/Yam5zhM
         oF0y5BGP6UAKFZYjNtL4nnvMghCpcJrsUAaCKrQU5xMJea9QZWby+5tOUIPcYxAF0z
         BWCL5SmjZXvrUjHhz507pu1f5NQXYNd+ljFE3DQA7Od/gS7mq99YXXXzEvhznfzqFl
         Vh+CRO7tLuRFw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10073701.me.com (Postfix) with ESMTPSA id 8477F4C040A;
        Thu, 28 Jan 2021 07:58:09 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 1/2] ARM: dts: sti: add the spinor controller node within stih407-family
Date:   Thu, 28 Jan 2021 08:58:06 +0100
Message-Id: <20210128075806.10318-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_02:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101280039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the spinor controller node within stih407-family.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
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

