Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0003434B3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhCUUmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:50 -0400
Received: from st43p00im-ztdg10073201.me.com ([17.58.63.177]:34375 "EHLO
        st43p00im-ztdg10073201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230379AbhCUUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359327; bh=Q2D+GfnSz9xlfYItrPsH8bhVvd92JdmC7OMWqbsn6Zw=;
        h=From:To:Subject:Date:Message-Id;
        b=dePHH4na4qgHQ+BAEyzERbzhvRLNiVO2IoJpDS3R7W20B/j2IdmLOFs14Fvhu8L2S
         hhrWG/hFRmw8/ubQI2dV44SU8l+QyEqB48csJNbKAUkmzgS+1m5LI6hmFTS7aAfvqg
         o1cHtxkr1gz55WpEF/NMaBs44Cb1z3ejgGHhx9KbC2HRCad8Mq+6nZf1gyNYQxcn37
         A5hk0tQl6O5usGK9emb6Qf+SZx3BVhYqYyNBQpFf8r7ya3UtLmtiFz3zC4pUa8GXrc
         KfHuUDnizvAB/bA9qQwiLtpPmxduiorncfFT8CJDQA/eeIlacl4wnbPCVSslxO5YB8
         PHBeDSrpb8ynA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 7042522222F;
        Sun, 21 Mar 2021 20:42:06 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 13/16] ARM: dts: sti: update clkgen-pll entries in stih418-clock
Date:   Sun, 21 Mar 2021 21:40:35 +0100
Message-Id: <20210321204038.14417-14-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F02:2021-03-19=5F02,2021-03-21=5F02,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=983 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkgen-pll driver now embed the clock names (assuming the
right compatible is used). Remove all clock-output-names property
and update when necessary the compatible.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418-clock.dtsi | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 35d12979cdf4..d628e656458d 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -39,8 +39,6 @@
 				compatible = "st,stih418-clkgen-plla9";
 
 				clocks = <&clk_sysin>;
-
-				clock-output-names = "clockgen-a9-pll-odf";
 			};
 		};
 
@@ -75,11 +73,9 @@
 
 			clk_s_a0_pll: clk-s-a0-pll {
 				#clock-cells = <1>;
-				compatible = "st,clkgen-pll0";
+				compatible = "st,clkgen-pll0-a0";
 
 				clocks = <&clk_sysin>;
-
-				clock-output-names = "clk-s-a0-pll-ofd-0";
 			};
 
 			clk_s_a0_flexgen: clk-s-a0-flexgen {
@@ -111,20 +107,16 @@
 
 			clk_s_c0_pll0: clk-s-c0-pll0 {
 				#clock-cells = <1>;
-				compatible = "st,clkgen-pll0";
+				compatible = "st,clkgen-pll0-c0";
 
 				clocks = <&clk_sysin>;
-
-				clock-output-names = "clk-s-c0-pll0-odf-0";
 			};
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
 				#clock-cells = <1>;
-				compatible = "st,clkgen-pll1";
+				compatible = "st,clkgen-pll1-c0";
 
 				clocks = <&clk_sysin>;
-
-				clock-output-names = "clk-s-c0-pll1-odf-0";
 			};
 
 			clk_s_c0_flexgen: clk-s-c0-flexgen {
-- 
2.17.1

