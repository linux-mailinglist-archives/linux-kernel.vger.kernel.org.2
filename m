Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C981D38B6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbhETTP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:15:58 -0400
Received: from smtp-34-i2.italiaonline.it ([213.209.12.34]:37658 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237243AbhETTPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:15:48 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([82.60.150.250])
        by smtp-34.iol.local with ESMTPA
        id jo6clK7DY5WrZjo6llTD7d; Thu, 20 May 2021 21:13:26 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1621538006; bh=hqdToKdXep6rD2t3+5/OUkGokVRGwUGIXwri9qp4guU=;
        h=From;
        b=hUnDQhl5+FF2LtbPN7uCikaowH+8P7C86snzpG/1Tf+vWsTDBsuRKVHvoQ2aOYMES
         4Z2S0V67pN6sKF/K5z916FF6y0aBSe8EvnqEhhi0j9g+2O5OiKIX1uKE4HbtXzc+cK
         NxX+/xlDORmR+cmI53zMRmFPCI5rVxUnpVuBfX/t6sF4R2MVWnKB7oE2UDieaWjDXf
         wZRaBhSwoiB2n9Q+b2Pc4UKO0d9qWODS68PSXin9PE8ShklA3jzdQ5AJ0WEtkj710S
         ehZHG6D6SzfL/nIm+k1QrJ47oMsmFO+IL3fatKy1N87f6jz/BWHyWkqOEvp5zRmZms
         Sf9ll4JMJYslQ==
X-CNFS-Analysis: v=2.4 cv=W4/96Tak c=1 sm=1 tr=0 ts=60a6b4d6 cx=a_exe
 a=QSJ1svMVA5tvcuOEAX2Bgw==:117 a=QSJ1svMVA5tvcuOEAX2Bgw==:17 a=VwQbUJbxAAAA:8
 a=IXkOJODCewQtKEFu2i4A:9 a=5yUOnwQy5QICz8m5uxDm:22 a=AjGcO6oz07-iQ99wixmX:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dariobin@libero.it>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 2/5] dt-bindings: ti: dpll: add spread spectrum support
Date:   Thu, 20 May 2021 21:13:02 +0200
Message-Id: <20210520191306.21711-3-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520191306.21711-1-dariobin@libero.it>
References: <20210520191306.21711-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfAzkv4+WDkc+LoumzzdwPTDPiSFA5uUBkTMVOM508MuLoM3Q2faBmN1k+QAdcgNX5NOGEVjg9tBcmIYTRSroXmcdEK7zPo/tefGJnvExs3j74OUKiFJh
 Ut89JdsOoowGPe2maxf5Uj3uJjyJwyRh5NdjcfhWRTt6dYJAz9AnIhD1sfLvyvaOsGY5JcGbM4vVhg28za2vyC4a6AteHt7IYNp0mZefo+YyPWXvwIdYVAiF
 v0E+QoC/uRqbuHNXQkJh0ni8ab/04nzQHC74xiUH3QBpoJp/ckvQusGqkSMoTYGWXzvItNGSNXoDyl1oijHoTbBCV5eqB8eDjSRsMhJf6/ZGgjrP7WyM8qHq
 7twrMKZU+Sn58oKkxsJVLNuqHg1amTwwFPkSHr//5XtLON4HnkxP8+VAhUCpzewqhwT3gat0QwDSxitp0TiS7cF+tEGMV8rGSh9r0V2YGEk8GM2Gu65a45zT
 dKkKSrWuLrQTEnBhTM5p9b/6W+7LkZf83wc6TUhzGAyq4+ZZMoqNPB7D1dvP4QD5yndEDvN/NRv5HyEc9jiyVhyVBTwzx4opwITSi/4BOEh1Lg+xzhxlcmfy
 1fo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for enabling and adjusting spread spectrum clocking have
been added.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
Reviewed-by: Rob Herring <robh@kernel.org>

---

(no changes since v4)

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

