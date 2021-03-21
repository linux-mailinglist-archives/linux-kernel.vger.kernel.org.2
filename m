Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044433434B0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhCUUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:43 -0400
Received: from st43p00im-zteg10061901.me.com ([17.58.63.168]:34647 "EHLO
        st43p00im-zteg10061901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230324AbhCUUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359318; bh=jdxkkX2iOMFCu5vLMtxt0m50Kt2SC0QJ9iqjEUQZuEQ=;
        h=From:To:Subject:Date:Message-Id;
        b=yPxWvNbuSvUXhRvcm1QF02q1fmgjJ4wgYowvfpX4/TPccJBZzjeJlWRogXeSTQzb9
         OIgxEXOrCRTXGfBtkSZbiA/XcX6BC+pJLxrVZkwkQVjEp5JonG+i93BXCwSIQLrAlU
         J5khOmUxkB+NL0qO/Rb1rklG61z48MV/60bCPTXxw4xWz4YdcvcrYzqe3HcZc+zzu7
         bECvd/i1JovqJOBWz9pZZk47Z4yAwdNRf/AodlQZWVivblTKK1mLQSYRMxssTHKPLA
         s9RoUJr/vI/at9XJOP1ONNN3TSOtNiEibjKlx+1LLB7z33kM9OsfM0jwlNQH6uJ/Wz
         Hsogiu4QkU8BA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10061901.me.com (Postfix) with ESMTPSA id 58734860310;
        Sun, 21 Mar 2021 20:41:57 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 10/16] ARM: dts: sti: update flexgen compatible within stih410-clock
Date:   Sun, 21 Mar 2021 21:40:32 +0100
Message-Id: <20210321204038.14417-11-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F05:2021-03-19=5F01,2021-03-21=5F05,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=676 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of new flexgen compatible within the clk-flexgen
driver, remove the clock-output-names entry from the flexgen nodes
and set the new proper compatible corresponding.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih410-clock.dtsi | 95 ++--------------------------
 1 file changed, 6 insertions(+), 89 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 81a8c25d7ba5..04b0d7080353 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -83,16 +83,12 @@
 			};
 
 			clk_s_a0_flexgen: clk-s-a0-flexgen {
-				compatible = "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih410-a0";
 
 				#clock-cells = <1>;
 
 				clocks = <&clk_s_a0_pll 0>,
 					 <&clk_sysin>;
-
-				clock-output-names = "clk-ic-lmi0",
-						     "clk-ic-lmi1";
-				clock-critical = <CLK_IC_LMI0>;
 			};
 		};
 
@@ -135,7 +131,7 @@
 
 			clk_s_c0_flexgen: clk-s-c0-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih410-c0";
 
 				clocks = <&clk_s_c0_pll0 0>,
 					 <&clk_s_c0_pll1 0>,
@@ -145,52 +141,6 @@
 					 <&clk_s_c0_quadfs 3>,
 					 <&clk_sysin>;
 
-				clock-output-names = "clk-icn-gpu",
-						     "clk-fdma",
-						     "clk-nand",
-						     "clk-hva",
-						     "clk-proc-stfe",
-						     "clk-proc-tp",
-						     "clk-rx-icn-dmu",
-						     "clk-rx-icn-hva",
-						     "clk-icn-cpu",
-						     "clk-tx-icn-dmu",
-						     "clk-mmc-0",
-						     "clk-mmc-1",
-						     "clk-jpegdec",
-						     "clk-ext2fa9",
-						     "clk-ic-bdisp-0",
-						     "clk-ic-bdisp-1",
-						     "clk-pp-dmu",
-						     "clk-vid-dmu",
-						     "clk-dss-lpc",
-						     "clk-st231-aud-0",
-						     "clk-st231-gp-1",
-						     "clk-st231-dmu",
-						     "clk-icn-lmi",
-						     "clk-tx-icn-disp-1",
-						     "clk-icn-sbc",
-						     "clk-stfe-frc2",
-						     "clk-eth-phy",
-						     "clk-eth-ref-phyclk",
-						     "clk-flash-promip",
-						     "clk-main-disp",
-						     "clk-aux-disp",
-						     "clk-compo-dvp",
-						     "clk-tx-icn-hades",
-						     "clk-rx-icn-hades",
-						     "clk-icn-reg-16",
-						     "clk-pp-hades",
-						     "clk-clust-hades",
-						     "clk-hwpe-hades",
-						     "clk-fc-hades";
-				clock-critical = <CLK_PROC_STFE>,
-						 <CLK_ICN_CPU>,
-						 <CLK_TX_ICN_DMU>,
-						 <CLK_EXT2F_A9>,
-						 <CLK_ICN_LMI>,
-						 <CLK_ICN_SBC>;
-
 				/*
 				 * ARM Peripheral clock for timers
 				 */
@@ -227,20 +177,13 @@
 
 			clk_s_d0_flexgen: clk-s-d0-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen-audio", "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih410-d0";
 
 				clocks = <&clk_s_d0_quadfs 0>,
 					 <&clk_s_d0_quadfs 1>,
 					 <&clk_s_d0_quadfs 2>,
 					 <&clk_s_d0_quadfs 3>,
 					 <&clk_sysin>;
-
-				clock-output-names = "clk-pcm-0",
-						     "clk-pcm-1",
-						     "clk-pcm-2",
-						     "clk-spdiff",
-						     "clk-pcmr10-master",
-						     "clk-usb2-phy";
 			};
 		};
 
@@ -263,7 +206,7 @@
 
 			clk_s_d2_flexgen: clk-s-d2-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen-video", "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih407-d2";
 
 				clocks = <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>,
@@ -272,24 +215,7 @@
 					 <&clk_sysin>,
 					 <&clk_sysin>,
 					 <&clk_tmdsout_hdmi>;
-
-				clock-output-names = "clk-pix-main-disp",
-						     "clk-pix-pip",
-						     "clk-pix-gdp1",
-						     "clk-pix-gdp2",
-						     "clk-pix-gdp3",
-						     "clk-pix-gdp4",
-						     "clk-pix-aux-disp",
-						     "clk-denc",
-						     "clk-pix-hddac",
-						     "clk-hddac",
-						     "clk-sddac",
-						     "clk-pix-dvo",
-						     "clk-dvo",
-						     "clk-pix-hdmi",
-						     "clk-tmds-hdmi",
-						     "clk-ref-hdmiphy";
-						     };
+			};
 		};
 
 		clk_s_d3_quadfs: clk-s-d3-quadfs@9107000 {
@@ -311,22 +237,13 @@
 
 			clk_s_d3_flexgen: clk-s-d3-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih407-d3";
 
 				clocks = <&clk_s_d3_quadfs 0>,
 					 <&clk_s_d3_quadfs 1>,
 					 <&clk_s_d3_quadfs 2>,
 					 <&clk_s_d3_quadfs 3>,
 					 <&clk_sysin>;
-
-				clock-output-names = "clk-stfe-frc1",
-						     "clk-tsout-0",
-						     "clk-tsout-1",
-						     "clk-mchi",
-						     "clk-vsens-compo",
-						     "clk-frc1-remote",
-						     "clk-lpc-0",
-						     "clk-lpc-1";
 			};
 		};
 	};
-- 
2.17.1

