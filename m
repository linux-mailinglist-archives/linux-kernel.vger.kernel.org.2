Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80CC398DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFBPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:03:06 -0400
Received: from smtp-35-i2.italiaonline.it ([213.209.12.35]:55738 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231934AbhFBPDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:03:00 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([79.17.119.101])
        by smtp-35.iol.local with ESMTPA
        id oSLqlJ7WDsptioSLwlKAsn; Wed, 02 Jun 2021 17:00:16 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1622646016; bh=hqdToKdXep6rD2t3+5/OUkGokVRGwUGIXwri9qp4guU=;
        h=From;
        b=lMCqwkrCY79cVf3zHr14Swwpg+GwFMCMUWVLQbaIeD12HwwDSy9Jkhj/VWHGKg8NQ
         UqZBEcN4CM2RpUKzOA3a0iLkJuyan/TD6RIcXmx/abP2Zi0vsxU5P9PX4PvvKQC8iE
         dm7DHu89gmn66U0+6osUrTDFF3MldEgXUxeLot7qyhdypTs+vEfkEIM4Jss7sr8MYJ
         1UZWY7imtOgmaApXBRyTLb9klt0wDDuj5Dkg+SPTWCvCtk3s9VH7ex4pzKsK2fHSTa
         v6qmks/58/6mc0ShCZeiN2dBshMl9Ed2c7WjhZXV7xHFMf0AAWwVIlgfKOa5KIb3g8
         yJrffJTjfXSDg==
X-CNFS-Analysis: v=2.4 cv=Bo1Yfab5 c=1 sm=1 tr=0 ts=60b79d00 cx=a_exe
 a=do1bHx4A/kh2kuTIUQHSxQ==:117 a=do1bHx4A/kh2kuTIUQHSxQ==:17 a=VwQbUJbxAAAA:8
 a=IXkOJODCewQtKEFu2i4A:9 a=5yUOnwQy5QICz8m5uxDm:22 a=AjGcO6oz07-iQ99wixmX:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Dario Binacchi <dariobin@libero.it>,
        Tero Kristo <kristo@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v7 2/5] dt-bindings: ti: dpll: add spread spectrum support
Date:   Wed,  2 Jun 2021 17:00:05 +0200
Message-Id: <20210602150009.17531-3-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602150009.17531-1-dariobin@libero.it>
References: <20210602150009.17531-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfBLCgayubmjjCLak38s7cr4yfgaSyVJdTZ7yaAhrXkgcbkYka3zLoybxIsD243u5wKsZ/OFYitHRJqiGhNihDE8qZ2AYhVn+0BbDUHPRDHwIEKKczfZN
 80RAQ0xpxCKhIhR88pIEw7Zh6ZwOL8TRRb6bs4ViNT3m5zewvZw70PaeGGjejO/AjFhDhxR483eSZLDal2v8nbAzH8R3oGl8lFxECYj7yUx3F/XTdA/hKL7z
 1OR1AGEo9TAnq1KmExzf5O32Ws0iw2f1nKMkxvGnLjLGCokGjXHB2ulxpPdxPJfzuHQuOWoKCRL65dKw6MmcfyA8CwKmxNePjoI4VytTPfo39jhlw+U2kSpV
 TSU5GUMeY5DMuLTpKhQKgUtD0PAbwUy1RXI3aTuaIbU+8PcCMAIPPh5LgVvst9eublV5XnnPMQAkE8Sj9By25StkCCo9fF9mBuQriVcYoV6AZuGqOIQqFAU7
 h4w5AD8oy2Tzimo6Pvb8B+mM1pCn5QMrytfscTjldnWeXAd1zkRjxqxdv80KwozvtOJ+5RlBZC0Iz6HEvVJakC27Km+Jivh6H3hNitvRCuGj1Icrht98RE/u
 XXU=
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

