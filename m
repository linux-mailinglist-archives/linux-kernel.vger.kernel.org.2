Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C322348ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCYHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:53:08 -0400
Received: from st43p00im-zteg10071901.me.com ([17.58.63.169]:54565 "EHLO
        st43p00im-zteg10071901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhCYHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616658742; bh=juyzAcWja1peAtly+ZqfcunSjhvziQOQK78108njBZM=;
        h=From:To:Subject:Date:Message-Id;
        b=W2hfsjgDSrX3x0xuXFK0fn4YfSS8YF9bYY+QpH3XGOYTDWKMUMPqF18qHma4D5pxQ
         XK00RUEfFv6WQZlB45MmjbHq0Tw5kqL++CYSH1qhC5Iq5oroEvWO6YjsQOYSOpxuj8
         lEcJe4cBuAsqibSF8d8pGLB0PWEGzfG4c4oiqfvZXMFLKWKh3RuWzlIb9lgAvgJG3B
         hrMVqEw+XBwl0kEM/nYBhBBsuQexyqJ9GQCqwpWXJd7fHNMXNR1MljtLJmLYlDCc4t
         Cf9ZE5G27sWsG6c2WvXUly6CHwAB6c6JAFmiw4cT43IOBpyXIANwkw7Te7hZZ9nf5p
         ak4ChE7hbm8nA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id 56492D80B1F;
        Thu, 25 Mar 2021 07:52:21 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 16/16] ARM: dts: sti: update clkgen-fsyn entries in stih418-clock
Date:   Thu, 25 Mar 2021 08:50:18 +0100
Message-Id: <20210325075018.6598-17-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325075018.6598-1-avolmat@me.com>
References: <20210325075018.6598-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-24=5F14:2021-03-24=5F01,2021-03-24=5F14,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250059
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

