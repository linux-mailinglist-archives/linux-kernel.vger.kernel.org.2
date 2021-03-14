Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0471C33A559
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhCNPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:13:52 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:39000 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233907AbhCNPNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:13:45 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id LSPzlDn2etpGHLSQ6lAQ8X; Sun, 14 Mar 2021 16:12:42 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1615734763; bh=bPt3Xo7JUBwWpbYRr+p2dw+OmrF+kpNURiohZr3XXj0=;
        h=From;
        b=D11kqISY/mpVZGkU3tE0cHvKaxFHypT8+V9EVFdl3DPbHOBac6gtnntpdPVuo6Z0X
         EAHd7ngttB82CLXheS3YLF7W3BGU9fhAtNK4uQI95qoNVexgac29PF5f+F444B4+vt
         xrfSRVxX6Payq6m34cbqq/EV2eWulsp6LQC6gfKURif505aC4AVcV6xLCzXFg3ymlO
         oLm011decIlLhtYL2YLngH8pk2IN9atm3ElFAc3wEP9jjamY38CsA9NEsld6GaBUpm
         cbK7otZpvnvEp7hZ2ZQWMWR/0SgqhNJ1izVh1UHrLDaOoxvEic0U1qNwHQQ/VCdYx9
         aNz103bOE58Tg==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=604e27eb cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=gUdohDFUAsczsVxzKVAA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: ti: dpll: add spread spectrum support
Date:   Sun, 14 Mar 2021 16:12:31 +0100
Message-Id: <20210314151233.23243-3-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210314151233.23243-1-dariobin@libero.it>
References: <20210314151233.23243-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfDCcah2L8AiZCR5ZNO4FJMg4iLk9zRZZUojTuqIoj2FZ6RtybJAp3t7FPpY9nlLSe0KSZhldj17oQtRdGxJ6QMFSxI68/CtX0wWkyugPmaxEmuyrSxCK
 3ycIPrgQBC4i/FV9M8O1q2i50lsk9tbh4Q4JVn+tWGzn7JnqEqiC3odweimA9BzDAhSDzLFOis0b7dgOaUkBspI37obPqPhoZOLg1ir7ZjLLVBoGtrPnaHZb
 CED/F/seORDr1wvC3S8N+S7zKAYanu8xZ6+snFEo3wNtNrZM8MYBbJjT+kCJ4RIW6PqxYgEonNt/3HRWViEa2L4zCRcunPgJqorZ2YbX10l8lNkRduqUzLHq
 JgNsH0APdOVtTFBxZ3T1EsYxs/PXptW4s0RhomgAxX+Ucb7JexAjDlBho+rtYt4YMUe9bj6QxhQb5Mvv6wePEQ47uJPG5Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for enabling and adjusting spread spectrum clocking have
been added.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

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

