Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DBC350870
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbhCaUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:44:18 -0400
Received: from st43p00im-ztfb10073301.me.com ([17.58.63.186]:60392 "EHLO
        st43p00im-ztfb10073301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236697AbhCaUnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617223416; bh=juyzAcWja1peAtly+ZqfcunSjhvziQOQK78108njBZM=;
        h=From:To:Subject:Date:Message-Id;
        b=eU2c98Vrfrmf2Sd0OHvcEoDSE3mcR2vN6GRQUHC1EH7w1HEI4cFFsy5IDBbNDh+p5
         QpXJ1Wp38VvpJ5WK8wQ/VXW/uY/iJU2H1A7hp6epxjUJyPpXWQn2DTQlXgSP11FhoR
         xs9JaIX0mYLyNs3r/aFn+IPMzwNzsC/WPH7vFCz1dKFo36UZGi17x6I4LSRyZvBZ6U
         qmhOG4oLIG6TMvsyRMjHZDt2Y3YrZn+rYOeJ7Iu59cMPUnn6DTPdolPTMyCxWNhBgg
         RVOyaNwOzwPyLLWXFPc2bmC+ylskoJv9hQ0U7zfDv8+NIsFVLoy062YR/JS2CyvMeh
         igH/SdDwJp4zA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 2DD8E2A0758;
        Wed, 31 Mar 2021 20:43:34 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3 09/13] ARM: dts: sti: update clkgen-fsyn entries in stih418-clock
Date:   Wed, 31 Mar 2021 22:42:24 +0200
Message-Id: <20210331204228.26107-10-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331204228.26107-1-avolmat@me.com>
References: <20210331204228.26107-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_10:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103310144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkgen-fsyn driver now embed the clock names (assuming the
right compatible is used). Remove all clock-output-names property
and update when necessary the compatible.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418-clock.dtsi | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index d628e656458d..e84c476b83ed 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -94,11 +94,6 @@
 			reg = <0x9103000 0x1000>;
 
 			clocks = <&clk_sysin>;
-
-			clock-output-names = "clk-s-c0-fs0-ch0",
-					     "clk-s-c0-fs0-ch1",
-					     "clk-s-c0-fs0-ch2",
-					     "clk-s-c0-fs0-ch3";
 		};
 
 		clk_s_c0: clockgen-c@9103000 {
@@ -150,15 +145,10 @@
 
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
@@ -179,15 +169,10 @@
 
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
@@ -210,15 +195,10 @@
 
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

