Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2234D565
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhC2Qr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:47:28 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:47149 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231233AbhC2QrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:47:20 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id Quy8lKyqctpGHQuyHliOlT; Mon, 29 Mar 2021 18:42:34 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1617036154; bh=A7Yl6FKxkm2C9ghiH0A6dvX1s7om13H0SCUntMXsDPM=;
        h=From;
        b=X+1015sso90k1diClnOtz11URnNnNU8HM9buWydLF9/h2zNvzruTpZxKDYgAduGtv
         IHKTgXZ/2u9a6OGYPmy4Gb4QhD6CAlTVruF3c7geTxC6IJvLPr/ALIPw+Y1K+oah9l
         m+OKZRaQCnI+CejEUrF1lTapl19NFEnfjnjuyIry/FI4loPhDKnpwAMR18GWuag51e
         Vap/m2fuCHG7j3YJngYKAkT3sJjZyrzFqxvBupwyWufmhYIiUXdZkVdLAfC7QoVppv
         nIpQoRZ5J/lPYFkDqbU8cg2U86akt6WTy4RkZ4dTvrC/KDjvzKHdN+VY5Hf+YcaCH+
         izK8vO7Ggga0w==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=6062037a cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=IXkOJODCewQtKEFu2i4A:9 a=fCgQI5UlmZDRPDxm0A3o:22
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Dario Binacchi <dariobin@libero.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: ti: dpll: add spread spectrum support
Date:   Mon, 29 Mar 2021 18:42:19 +0200
Message-Id: <20210329164222.26794-3-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329164222.26794-1-dariobin@libero.it>
References: <20210329164222.26794-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfOR5sfuN7CDFFUQ88TsfF0HHMJBZaMkZQKbATvMx0SfTeVaDp7fVsaCecIeyLBX8/d+G1bstcZDBADy2NQJIrQIptnGEweg1OqaE4mJjica+kR8FyFLb
 /AmZxcJHouBpWLUiZ5mUizeJOATj8KKHjfr3K3UHGLz2FiulZO3rJmbARCXty3Gx0Hq1EGoK23EhhXdjWuKubVdCF3PL4Z2h+up08N3uSNzotfvXWbN1YsYB
 Yv2DyW6geKfO8IwFL/eaAd4EnZ057kJzisqZkqLMT5hUdJRtMHl7uPoY6UvacysCvRrO3yGtRo+Ob2OoRCUJMtSt3VDtS7IHuyKPtVX3mIFv/6K5eF4Czgqv
 enL3vIMt0btjlpT+bkh/9S1VoEyh1XKHM4NxwpEAzdJGGXxXoSOG2QzVtu9mWA+C5TNyKfz7Q4ofP1PUNKj7kIQave2mgJ8GXtsX9w5W1n5kPyj/7apemJyC
 nOUoG9MwC0EIn4WT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for enabling and adjusting spread spectrum clocking have
been added.

Signed-off-by: Dario Binacchi <dariobin@libero.it>

---

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

