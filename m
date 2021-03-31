Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA0E350865
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbhCaUni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:43:38 -0400
Received: from st43p00im-zteg10073401.me.com ([17.58.63.181]:36923 "EHLO
        st43p00im-zteg10073401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236662AbhCaUnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617223400; bh=Ge/uIA5hLdNP9ltZO4wkWhRW01e4mo9aC5X6GiyNNoM=;
        h=From:To:Subject:Date:Message-Id;
        b=A2MJjRYIsjeyQwa37OksOOVr3ar5NfnyVeavS1lylH3X/IiYbAEw8Hvob+lqCHzTL
         UD6K6JlYNelXYAE0l656lGv2z6k3csHwhSp1y4EfP5Ay5Jv+TEpj7c7l0QrdCnVek8
         ga4JNbykSHi3j7zhAUSnuqcToXtm11eikhmNPx1C9q365dmFm6t5M5yTWA8DhEoz4T
         hEXemnDiKV2hwrwkPe5Nbs1C+Fp21WVUzvZXd3mXYCRD+H0TdLtNkBW9oHKbJFGzSQ
         bMMzLlFeO9GoCT3dRS4grqZE6CP+MAQTCGmh4ydc+wNSnK4LWHDmpWdxQ6RKh+tLrz
         Glulmty+ORPYw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10073401.me.com (Postfix) with ESMTPSA id F1AC85E03FF;
        Wed, 31 Mar 2021 20:43:19 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3 04/13] ARM: dts: sti: update clkgen-pll entries in stih407-clock
Date:   Wed, 31 Mar 2021 22:42:19 +0200
Message-Id: <20210331204228.26107-5-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331204228.26107-1-avolmat@me.com>
References: <20210331204228.26107-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F08:2021-03-31=5F02,2021-03-31=5F08,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 mlxlogscore=996 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103310144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkgen-pll driver now embed the clock names (assuming the
right compatible is used). Remove all clock-output-names property
and update when necessary the compatible.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index ecd568777e5f..2603226a6ca8 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -36,8 +36,6 @@
 				compatible = "st,stih407-clkgen-plla9";
 
 				clocks = <&clk_sysin>;
-
-				clock-output-names = "clockgen-a9-pll-odf";
 			};
 		};
 
@@ -74,12 +72,9 @@
 
 			clk_s_a0_pll: clk-s-a0-pll {
 				#clock-cells = <1>;
-				compatible = "st,clkgen-pll0";
+				compatible = "st,clkgen-pll0-a0";
 
 				clocks = <&clk_sysin>;
-
-				clock-output-names = "clk-s-a0-pll-ofd-0";
-				clock-critical = <0>; /* clk-s-a0-pll-ofd-0 */
 			};
 
 			clk_s_a0_flexgen: clk-s-a0-flexgen {
@@ -112,21 +107,16 @@
 
 			clk_s_c0_pll0: clk-s-c0-pll0 {
 				#clock-cells = <1>;
-				compatible = "st,clkgen-pll0";
+				compatible = "st,clkgen-pll0-c0";
 
 				clocks = <&clk_sysin>;
-
-				clock-output-names = "clk-s-c0-pll0-odf-0";
-				clock-critical = <0>; /* clk-s-c0-pll0-odf-0 */
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

