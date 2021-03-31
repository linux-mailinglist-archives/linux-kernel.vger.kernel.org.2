Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AE350863
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhCaUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:43:36 -0400
Received: from st43p00im-zteg10072001.me.com ([17.58.63.167]:45022 "EHLO
        st43p00im-zteg10072001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236657AbhCaUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617223394; bh=Ve4jsESrp8OiRYiXnom06JM7XAJznVi4sZGNOiytr3g=;
        h=From:To:Subject:Date:Message-Id;
        b=HZCDpWmy3Unk9YqkhBWusy5o9lAVrd/shU6/AwRFl+bZKaHGqN7rLYNyfma0xUHUD
         hu/3AG78v71GKjG5qFRjMXhQFZN4K7nOODcYzRdRcvlFXVRrEQTXSDR36pJ7ewiDL6
         eXrznOKzwPXRvByHme2NRE49Xwm6eta8jMm0oFAIDYUVgiMijY4aBRYhjmod2E981+
         3JF8C0xT1JBDoH5MGK08BbS6psEGucPbTcHm3tSK/V812eBpI7inpAbBdpViS1K5PJ
         Ks0V9R6CPjwRrlQCO1hHa7Yv5EGoLJohferw1cA3JDyb1uDgmvlsL155vuunKM76YZ
         osNc3RnoFtNrw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id D8D04C0564;
        Wed, 31 Mar 2021 20:43:12 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3 02/13] ARM: dts: sti: update flexgen compatible within stih407-clock
Date:   Wed, 31 Mar 2021 22:42:17 +0200
Message-Id: <20210331204228.26107-3-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331204228.26107-1-avolmat@me.com>
References: <20210331204228.26107-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_10:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=714 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103310144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of new flexgen compatible within the clk-flexgen
driver, remove the clock-output-names entry from the flexgen nodes
and set the new proper compatible corresponding.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 85 ++--------------------------
 1 file changed, 6 insertions(+), 79 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 1ab40db7c91a..ecd568777e5f 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -83,15 +83,12 @@
 			};
 
 			clk_s_a0_flexgen: clk-s-a0-flexgen {
-				compatible = "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih407-a0";
 
 				#clock-cells = <1>;
 
 				clocks = <&clk_s_a0_pll 0>,
 					 <&clk_sysin>;
-
-				clock-output-names = "clk-ic-lmi0";
-				clock-critical = <CLK_IC_LMI0>;
 			};
 		};
 
@@ -134,7 +131,7 @@
 
 			clk_s_c0_flexgen: clk-s-c0-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih407-c0";
 
 				clocks = <&clk_s_c0_pll0 0>,
 					 <&clk_s_c0_pll1 0>,
@@ -144,45 +141,6 @@
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
-						     "clk-compo-dvp";
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
@@ -219,18 +177,13 @@
 
 			clk_s_d0_flexgen: clk-s-d0-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen-audio", "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih407-d0";
 
 				clocks = <&clk_s_d0_quadfs 0>,
 					 <&clk_s_d0_quadfs 1>,
 					 <&clk_s_d0_quadfs 2>,
 					 <&clk_s_d0_quadfs 3>,
 					 <&clk_sysin>;
-
-				clock-output-names = "clk-pcm-0",
-						     "clk-pcm-1",
-						     "clk-pcm-2",
-						     "clk-spdiff";
 			};
 		};
 
@@ -253,7 +206,7 @@
 
 			clk_s_d2_flexgen: clk-s-d2-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen-video", "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih407-d2";
 
 				clocks = <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>,
@@ -262,24 +215,7 @@
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
@@ -301,22 +237,13 @@
 
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

