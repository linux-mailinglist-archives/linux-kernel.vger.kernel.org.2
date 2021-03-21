Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2C3434AE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhCUUmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:23 -0400
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:45751 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhCUUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359307; bh=Ppvhv+mB4h4GIHM6LvxVXZ3+CsPqmf1FZ/vPWrv2D2c=;
        h=From:To:Subject:Date:Message-Id;
        b=0H7iZ4gYe2/sBoHruhyLQuTpza+EFZHCBKj+0l5uOZfoxQb4yqm00Y78I0cWl+2YT
         WsqJ1QBVRYBwZxBzRnnlA3xstSswsSWk5dsZupD+ji4qfYHFwloUuqaKSgIIq+o5a2
         gulpxKG54mMrLkTkj8/9szLXNovN0UyZQBt0etNwWDUg12H50f70gFsRsZlDojspwU
         4iV6wFusgM2XXuEMnEMY6UeKu3NRyfkJDr49JWxncl8i5UkndErjK3pkyVlXZWW+i4
         xHdbSf2jhnQgAZx6rxBpRhahUPYtZwVRlihxYRKE7AdOAAI6G7b/eRPAKe+4u+q8GF
         FnPZ5IgbzSGeg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 00DA38C042B;
        Sun, 21 Mar 2021 20:41:45 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 08/16] ARM: dts: sti: update flexgen compatible within stih418-clock
Date:   Sun, 21 Mar 2021 21:40:30 +0100
Message-Id: <20210321204038.14417-9-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F05:2021-03-19=5F01,2021-03-21=5F05,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=734
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of new flexgen compatible within the clk-flexgen
driver, remove the clock-output-names entry from the flexgen nodes
and set the new proper compatible corresponding.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418-clock.dtsi | 96 ++--------------------------
 1 file changed, 5 insertions(+), 91 deletions(-)

diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 8fa092462102..35d12979cdf4 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -83,15 +83,12 @@
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
 			};
 		};
 
@@ -132,7 +129,7 @@
 
 			clk_s_c0_flexgen: clk-s-c0-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih418-c0";
 
 				clocks = <&clk_s_c0_pll0 0>,
 					 <&clk_s_c0_pll1 0>,
@@ -142,49 +139,6 @@
 					 <&clk_s_c0_quadfs 3>,
 					 <&clk_sysin>;
 
-				clock-output-names = "clk-icn-gpu",
-						     "clk-fdma",
-						     "clk-nand",
-						     "clk-hva",
-						     "clk-proc-stfe",
-						     "clk-tp",
-						     "clk-rx-icn-dmu",
-						     "clk-rx-icn-hva",
-						     "clk-icn-cpu",
-						     "clk-tx-icn-dmu",
-						     "clk-mmc-0",
-						     "clk-mmc-1",
-						     "clk-jpegdec",
-						     "clk-icn-reg",
-						     "clk-proc-bdisp-0",
-						     "clk-proc-bdisp-1",
-						     "clk-pp-dmu",
-						     "clk-vid-dmu",
-						     "clk-dss-lpc",
-						     "clk-st231-aud-0",
-						     "clk-st231-gp-1",
-						     "clk-st231-dmu",
-						     "clk-icn-lmi",
-						     "clk-tx-icn-1",
-						     "clk-icn-sbc",
-						     "clk-stfe-frc2",
-						     "clk-eth-phyref",
-						     "clk-eth-ref-phyclk",
-						     "clk-flash-promip",
-						     "clk-main-disp",
-						     "clk-aux-disp",
-						     "clk-compo-dvp",
-						     "clk-tx-icn-hades",
-						     "clk-rx-icn-hades",
-						     "clk-icn-reg-16",
-						     "clk-pp-hevc",
-						     "clk-clust-hevc",
-						     "clk-hwpe-hevc",
-						     "clk-fc-hevc",
-						     "clk-proc-mixer",
-						     "clk-proc-sc",
-						     "clk-avsp-hevc";
-
 				/*
 				 * ARM Peripheral clock for timers
 				 */
@@ -221,20 +175,13 @@
 
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
 
@@ -257,7 +204,7 @@
 
 			clk_s_d2_flexgen: clk-s-d2-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen-video", "st,flexgen";
+				compatible = "st,flexgen", "st,flexgen-stih418-d2";
 
 				clocks = <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>,
@@ -266,30 +213,6 @@
 					 <&clk_sysin>,
 					 <&clk_sysin>,
 					 <&clk_tmdsout_hdmi>;
-
-				clock-output-names = "clk-pix-main-disp",
-						     "",
-						     "",
-						     "",
-						     "",
-						     "clk-tmds-hdmi-div2",
-						     "clk-pix-aux-disp",
-						     "clk-denc",
-						     "clk-pix-hddac",
-						     "clk-hddac",
-						     "clk-sddac",
-						     "clk-pix-dvo",
-						     "clk-dvo",
-						     "clk-pix-hdmi",
-						     "clk-tmds-hdmi",
-						     "clk-ref-hdmiphy",
-						     "", "", "", "", "",
-						     "", "", "", "", "",
-						     "", "", "", "", "",
-						     "", "", "", "", "",
-						     "", "", "", "", "",
-						     "", "", "", "", "",
-						     "", "clk-vp9";
 			};
 		};
 
@@ -312,22 +235,13 @@
 
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

