Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16F5350871
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhCaUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:44:21 -0400
Received: from st43p00im-zteg10061901.me.com ([17.58.63.168]:45584 "EHLO
        st43p00im-zteg10061901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236735AbhCaUnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617223420; bh=9rsRDeYyP6mevg5eT1EqueiLtS/VAtq14uRY9n3RQt8=;
        h=From:To:Subject:Date:Message-Id;
        b=g6TMMUVK5UMcAaTjFpjG2iF2DBSwD/4Yee72+iWELlQoQpS+UVqap76YRqBUNSbLT
         6nlDL6kqFWcPVJvBlI8Vbb7s6bEXVRWn3hGDPaMwbRuH7p/088YhXhSb0I3nKSwf2f
         NePcsS9eJMrUOZAQPEM3+K/LHzr+tyy7Hl2lLw6g+bgSHRAb/fGxFqKKJTPFSucHIG
         rl6236QbecLMRk31JPdtHGBzR/DQghGGHw58pE9M6vhM1C/4TSbYJQcvCqe4xquXh3
         Fmv8CE/OU8mTo9Gd1tUyIvlebitL6DfkkBnkQM0erFigPrRXJ5+n1OZJPv6E8EqGTW
         pOwO7Afk29L2w==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10061901.me.com (Postfix) with ESMTPSA id 1EBE286056A;
        Wed, 31 Mar 2021 20:43:38 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3 10/13] ARM: dts: sti: add the spinor controller node within stih407-family
Date:   Wed, 31 Mar 2021 22:42:25 +0200
Message-Id: <20210331204228.26107-11-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331204228.26107-1-avolmat@me.com>
References: <20210331204228.26107-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F08:2021-03-30=5F02,2021-03-31=5F08,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103310144
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

