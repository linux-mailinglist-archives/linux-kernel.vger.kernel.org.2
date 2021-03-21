Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581643434B6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhCUUm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:56 -0400
Received: from st43p00im-ztbu10073601.me.com ([17.58.63.184]:37217 "EHLO
        st43p00im-ztbu10073601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230516AbhCUUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359336; bh=juyzAcWja1peAtly+ZqfcunSjhvziQOQK78108njBZM=;
        h=From:To:Subject:Date:Message-Id;
        b=KXmRqMls5SuqqpWBNn2JviOebbVuvvEY29ZWXY3jjMWZRwFLUetyZOHQdB9FFOjq0
         eeLkMHSFHjGbgB5jXc9eKANS6EscrdZ/kejb5KAtcRKXw1FQWKrjQiJyRCRlMHHY1X
         iy2kpCZkvnJ/n9h3MtAvwdtBdnoML3Xw5gSffyZt/dDddSZfI9zct/dqhaoVjVioUM
         wZMjDUWb5RbsEDulOQYQd3i62TU2D2Nd5IKk30tGbf/S1Z1HT7A4x8hNe8qs1K98J5
         S6GKK4fNIawCBUn8UCg7+DYf3XaKxvQYAsqH1jF0xx2fahsUbUmORica6gcH9T9BKX
         o0efjrpZsfKZg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 17000820404;
        Sun, 21 Mar 2021 20:42:15 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 16/16] ARM: dts: sti: update clkgen-fsyn entries in stih418-clock
Date:   Sun, 21 Mar 2021 21:40:38 +0100
Message-Id: <20210321204038.14417-17-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-21_05:2021-03-19,2021-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103210167
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

