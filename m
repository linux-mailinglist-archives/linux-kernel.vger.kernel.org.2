Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF6352002
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhDATix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:38:53 -0400
Received: from smtp-17-i2.italiaonline.it ([213.209.12.17]:59214 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235330AbhDATiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:38:52 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id S38SlkFJgtpGHS38Zly35h; Thu, 01 Apr 2021 21:37:51 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1617305871; bh=w5zE/nnncsLL9tS2y4P86qvOqWWWEomS3J6KCrNrdms=;
        h=From;
        b=koptiVMx5H2h2giBsZuq0ulg1Xxs2HxqW/G5U0/cBslbmykHQXZGKiVt+CMKs+DmP
         eVK0a6zUoDeqdx/c6U7iz7styPqSVc4bxOjQhY0UZ6QbqM7cPCuMaF83UpuTpd0uXS
         Idvo0kCSlKhKNitEu6BlQW4XSwZ1ZSmcLCWBxmAUBCTyNN/2X/Yv7D1YEbs2ieRDJ3
         71qMn8yeeqYZeK3UoaO17PZHZ0k2n0zapaIJV5BNR6PaE0wldH1XB2uYNmXbk4EL8U
         41qE3hQCCTGK6/97Z40YQ7Ew1WLEFPMLsW5e+JLUT7jP3eStZmlXFSYjK6ybOPr8mf
         Xdtw3lR2V7FkA==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=6066210f cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17 a=VwQbUJbxAAAA:8
 a=IXkOJODCewQtKEFu2i4A:9 a=5yUOnwQy5QICz8m5uxDm:22 a=AjGcO6oz07-iQ99wixmX:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Dario Binacchi <dariobin@libero.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v4 2/5] dt-bindings: ti: dpll: add spread spectrum support
Date:   Thu,  1 Apr 2021 21:37:38 +0200
Message-Id: <20210401193741.24639-3-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401193741.24639-1-dariobin@libero.it>
References: <20210401193741.24639-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfBlw2Mp5JJU6vyf14yZAflC6VIrElHTuPW2Z29hVlQ7oe8qgAWXk4e8U5Wsh5yGlzxR2cKRaZBI+LQLOJk3SHrgjfQcIkLEGQzYua+bYSqjH10iJQSj4
 7XD/aIhKtMPJeD6btI/4z6ukUU1w9HpWLREBr7a9OLKy8Yq3QJGod3WEmESJBI+72tFgQgcEHqmSqq/5Tqi8Nfl/2roLe7LC6ONBFnN5CzmlFDvC47TdaItP
 yeLB8p3aFaGaBr+yvfB9/hUMIjmeRohTCbJ4I8SVe4yFjgKg4TV6IVOjrn7Y4um2SydXfYwG6GBTPVJCBbyTthtsGoFEA6Xq8wD+BROkTsu9jYFG5KnbuL0F
 rjRgU4TVLHCdI0eRMN5Mzvt495iWIwHljgO6+BwhPS2BhLai2kx2oUQXbK4MHxt6tnLWx2Y+0oYZ8cqZ7fRlIComAWMsHLykuzucNEOIxy+Bj3/9HB4Qz11z
 WiyPiP5Eu6P+hBdx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for enabling and adjusting spread spectrum clocking have
been added.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v4:
- Add Rob Herring review tag.

Changes in v3:
- Add '-hz' suffix to "ti,ssc-modfreq" binding.

 .../devicetree/bindings/clock/ti/dpll.txt     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
index df57009ff8e7..37a7cb6ad07d 100644
--- a/Documentation/devicetree/bindings/clock/ti/dpll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
@@ -42,6 +42,11 @@ Required properties:
 	"idlest" - contains the idle status register base address
 	"mult-div1" - contains the multiplier / divider register base address
 	"autoidle" - contains the autoidle register base address (optional)
+	"ssc-deltam" - DPLL supports spread spectrum clocking (SSC), contains
+		       the frequency spreading register base address (optional)
+	"ssc-modfreq" - DPLL supports spread spectrum clocking (SSC), contains
+		        the modulation frequency register base address
+			(optional)
   ti,am3-* dpll types do not have autoidle register
   ti,omap2-* dpll type does not support idlest / autoidle registers
 
@@ -51,6 +56,14 @@ Optional properties:
 	- ti,low-power-stop : DPLL supports low power stop mode, gating output
 	- ti,low-power-bypass : DPLL output matches rate of parent bypass clock
 	- ti,lock : DPLL locks in programmed rate
+	- ti,min-div : the minimum divisor to start from to round the DPLL
+		       target rate
+	- ti,ssc-deltam : DPLL supports spread spectrum clocking, frequency
+			  spreading in permille (10th of a percent)
+	- ti,ssc-modfreq-hz : DPLL supports spread spectrum clocking, spread
+			      spectrum modulation frequency
+	- ti,ssc-downspread : DPLL supports spread spectrum clocking, boolean
+			      to enable the downspread feature
 
 Examples:
 	dpll_core_ck: dpll_core_ck@44e00490 {
@@ -83,3 +96,10 @@ Examples:
 		clocks = <&sys_ck>, <&sys_ck>;
 		reg = <0x0500>, <0x0540>;
 	};
+
+	dpll_disp_ck: dpll_disp_ck {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-no-gate-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x0498>, <0x0448>, <0x0454>, <0x044c>, <0x0450>;
+	};
-- 
2.17.1

