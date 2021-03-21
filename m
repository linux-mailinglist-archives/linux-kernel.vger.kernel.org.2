Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF683434B4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCUUmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:52 -0400
Received: from st43p00im-zteg10073401.me.com ([17.58.63.181]:36732 "EHLO
        st43p00im-zteg10073401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230419AbhCUUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359330; bh=C1Ns+nw92kiQ7Sg5p1H67pDMGTa6rHwk9Y/oyL76Kcc=;
        h=From:To:Subject:Date:Message-Id;
        b=h6dRGG0DP8iwirMRB+6gxl7Wkw7DIALOcLxheEi+WPZXDT+skNdNkSZbqn/nB95Vt
         ay37E+sWKIde6vurLPS3ihSKcVkDtn6oeFwQDCD+EInRNNt7FFJ18lZezCj0d4LsHG
         +7/BL5Zfn3dupK2ErkUAKefeZSqCujNK55x99NZqwXdENZ3YY0eTjf7SfiAu6pnP/I
         wW5Bi6O76HLdMUek4FfC8OODdWQWTP87WiBh39VG3/GIM+AR9dGt6t9ylyrPnveeEo
         1ln/R9Zb0G4fEqOnbQW56gqVIeEt7q797RZfpepZedSDu2MPsevUi+L8RAxc5FQx79
         gDxevO/zfarbA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10073401.me.com (Postfix) with ESMTPSA id 8A29D5E0611;
        Sun, 21 Mar 2021 20:42:09 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 14/16] ARM: dts: sti: update clkgen-fsyn entries in stih407-clock
Date:   Sun, 21 Mar 2021 21:40:36 +0100
Message-Id: <20210321204038.14417-15-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F02:2021-03-19=5F01,2021-03-21=5F02,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=981 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkgen-fsyn driver now embed the clock names (assuming the
right compatible is used). Remove all clock-output-names property
and update when necessary the compatible.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 2603226a6ca8..9cce9541e26b 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -93,12 +93,6 @@
 			reg = <0x9103000 0x1000>;
 
 			clocks = <&clk_sysin>;
-
-			clock-output-names = "clk-s-c0-fs0-ch0",
-					     "clk-s-c0-fs0-ch1",
-					     "clk-s-c0-fs0-ch2",
-					     "clk-s-c0-fs0-ch3";
-			clock-critical = <0>; /* clk-s-c0-fs0-ch0 */
 		};
 
 		clk_s_c0: clockgen-c@9103000 {
@@ -150,15 +144,10 @@
 
 		clk_s_d0_quadfs: clk-s-d0-quadfs@9104000 {
 			#clock-cells = <1>;
-			compatible = "st,quadfs";
+			compatible = "st,quadfs-d0";
 			reg = <0x9104000 0x1000>;
 
 			clocks = <&clk_sysin>;
-
-			clock-output-names = "clk-s-d0-fs0-ch0",
-					     "clk-s-d0-fs0-ch1",
-					     "clk-s-d0-fs0-ch2",
-					     "clk-s-d0-fs0-ch3";
 		};
 
 		clockgen-d0@9104000 {
@@ -179,15 +168,10 @@
 
 		clk_s_d2_quadfs: clk-s-d2-quadfs@9106000 {
 			#clock-cells = <1>;
-			compatible = "st,quadfs";
+			compatible = "st,quadfs-d2";
 			reg = <0x9106000 0x1000>;
 
 			clocks = <&clk_sysin>;
-
-			clock-output-names = "clk-s-d2-fs0-ch0",
-					     "clk-s-d2-fs0-ch1",
-					     "clk-s-d2-fs0-ch2",
-					     "clk-s-d2-fs0-ch3";
 		};
 
 		clockgen-d2@9106000 {
@@ -210,15 +194,10 @@
 
 		clk_s_d3_quadfs: clk-s-d3-quadfs@9107000 {
 			#clock-cells = <1>;
-			compatible = "st,quadfs";
+			compatible = "st,quadfs-d3";
 			reg = <0x9107000 0x1000>;
 
 			clocks = <&clk_sysin>;
-
-			clock-output-names = "clk-s-d3-fs0-ch0",
-					     "clk-s-d3-fs0-ch1",
-					     "clk-s-d3-fs0-ch2",
-					     "clk-s-d3-fs0-ch3";
 		};
 
 		clockgen-d3@9107000 {
-- 
2.17.1

