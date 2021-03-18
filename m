Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB6340BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhCRR1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:27:43 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:60290 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232125AbhCRR1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:27:14 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id MwPulsZ9jtpGHMwQRlfgiu; Thu, 18 Mar 2021 18:27:13 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1616088433; bh=wOVMM8fe4k6pPP97MUyM+VmdNWuzQWM6uK83ju/ajGI=;
        h=From;
        b=rdg4N/0cyb33V1brFRYb6CGlqrfTpU5A2q4PqN/R6z5AufJQ2f4xSyp83ZcDIFxko
         KO4i61gSf4+J3YcduFoS3uHdeO0rPq9F996ZXVX9M3Z7BPWA4mK+0qZYQzDsbmOvyf
         PiNpu4QSH5MFEd+ZFv6/JFkkJEsPDAH8KrdWt6LPmFDnNyPTUo7SVwRofwOCivTIys
         2BUJrRwNgpR2S7zQZhpzQmN5sZvklC3LrTB7mlqBX1iHn/Avs5x1m6ZF42JkdpptO4
         mptgRBJocGvxjNyObrysmHiosRt7l8Ea90XZoTwMQT/3M2xPljpyrZTBJ2ket08aq4
         cbIQRNLiX4Y/A==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=60538d71 cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=gUdohDFUAsczsVxzKVAA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: ti: dpll: add spread spectrum support
Date:   Thu, 18 Mar 2021 18:26:24 +0100
Message-Id: <20210318172627.12173-3-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318172627.12173-1-dariobin@libero.it>
References: <20210318172627.12173-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfE7cZ8YkxtFmG0Psp4XifQ7ICm7GXAILORL5K/V9b+vqby/yBwGvOwdJ2yTis2NoFLyR8f+C1aGCRI486vKmcBIzDiju/ZZx1OLv1nde0UGfxLwzSA5x
 aws3zPJREAb/jZ/sGiEjiP6GSCBNRTVmtxisBTRj268qNRSN41m99V0YvaensOKcvyRAyQ23SptkpJ/gf1Yv5vOt0rOG07kXmqh/dy531o+usygl/lpLyzg9
 eligt6yxB+3v5kEpBTjSmOXHL3bYBciVFm7SmoaT1HDc3DdPPHaVg93b8+P/oLVwWkKFaeov3+WSbsMVCu9m5uvMPEhSNpesPlLXESyt/L4ss+t6tHDhnf28
 J+xuYdB0z2mKqe2WXwupiqWe2DSbv8Q+JGu6HZyyCWuCa1j3RmhcEhPGHlg8VWk4HJH2LsoX1akKfDKsHoyPItjph0CqM0vTKzUrGFcAFgrJb04AfOk9URY8
 MwRyZJ0AGFawXAig
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for enabling and adjusting spread spectrum clocking have
been added.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

(no changes since v1)

 .../devicetree/bindings/clock/ti/dpll.txt     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
index df57009ff8e7..0810ae073294 100644
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
+	- ti,ssc-modfreq : DPLL supports spread spectrum clocking, spread
+			   spectrum modulation frequency in kHz
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

