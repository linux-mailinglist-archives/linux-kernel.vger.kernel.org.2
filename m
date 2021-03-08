Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242AF331486
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCHRTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhCHRSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07A6C06174A;
        Mon,  8 Mar 2021 09:18:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id p1so15879370edy.2;
        Mon, 08 Mar 2021 09:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuSqF/+tR6w6hB+x1Uu0uM7BqIArmfrJ4/0Ov0bZDcg=;
        b=CpHy2AxxZkQOKJ5vTL78ALTyJudnco/llkKoO+8MqNTeBkjnGuHWSaoPaLdYocS9rf
         oq5zB6pxphbbon1105jB9I1Yw8kithmLe2sfHZpPvTt3NJXAE4cJYswwhV+X1TS9FtJR
         YFFQslhp2dGlq83xnUI1K59HCnDRBtpQ96tcKVLLc7m8YjsxGfd1UMY5xHUKkftxJbQT
         Jz9jdwPoS20gIxu6jRRj36ywdUfnQFRnUFNGSfaV+fiZgPpA5aSWoRyemLRSoXm9npp8
         9dwF8iv6m7SjAvw4azcDLVsCi2+COQc0k0peRMbTHLoglVHIsD4OLgI+qLAsmlsPEcQ6
         IusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuSqF/+tR6w6hB+x1Uu0uM7BqIArmfrJ4/0Ov0bZDcg=;
        b=Up+/kgN+4ORyMwrWwI+Jwmik8Kxp3RCKNEra5YxaELXqXwK09KNHcvOqudEpuerBNa
         mgdspPxRSg1q6YO7WI9Sb4r5L+F5Yi+rSNF26N7CElG76pR/eL+J/wTK1EKrR6oXTLdQ
         bMU1zd+MV2xp7bqgeHsPV+qJ0Yj017CHcx7h/yf/N3qFjWAbwhGzO2PeX4cRRboFkJ62
         Xjny0qZT6cexUz+yKk0Lroa80PzexiNScePDIGbx6C4G66x0zsWIycNBtRJIdm9S3OVl
         5f0pbb8/yW/fRJRPlyG9K6wqWA8N+9s5HdkBi0XPk8owlG5SFZE5iHbzKIwtr6PTDn5X
         Q1lA==
X-Gm-Message-State: AOAM533UuHvj4FBgLp08lirRcJGd6vn0QAhsJWxlO2BE/TktsWLUdbL7
        5Js7FAHV0Juw5NwDANq2HOE=
X-Google-Smtp-Source: ABdhPJxIgTkVrCZhhOdRhVmRIDyXrXzryucFllf5C3GVfJFvElo0nySIC4woACC7JO0Vw0m0JmihLw==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr23067927edd.283.1615223918506;
        Mon, 08 Mar 2021 09:18:38 -0800 (PST)
Received: from localhost.localdomain ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id r5sm7457714eds.49.2021.03.08.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:18:38 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
Date:   Mon,  8 Mar 2021 19:18:29 +0200
Message-Id: <58225ced4893018792d581c0476a0f1c70e08907.1615221459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few issues with the setup of the Actions Semi Owl S500 SoC's
clock chain involving AHPPREDIV, H and AHB clocks:

* AHBPREDIV clock is defined as a muxer only, although it also acts as
  a divider.
* H clock is defined as a standard divider, although the raw value zero
  is not supported.
* AHB is defined as a multi-rate factor clock, but it is actually just
  a fixed pass clock.

Let's provide the following fixes:

* Change AHBPREDIV clock to an ungated OWL_COMP_DIV definition.
* Add a clock div table 'h_div_table' for the H clock to drop the
  unsupported 0 rate and use the correct register shift value in the
  OWL_DIVIDER definition.
* Drop the unneeded 'ahb_factor_table[]' and change AHB clock to an
  ungated OWL_COMP_FIXED_FACTOR definition.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index abe8874353de..b9e434173b4f 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -151,9 +151,9 @@ static struct clk_factor_table hde_factor_table[] = {
 	{ 0, 0, 0 },
 };
 
-static struct clk_factor_table ahb_factor_table[] = {
-	{ 1, 1, 2 }, { 2, 1, 3 },
-	{ 0, 0, 0 },
+static struct clk_div_table h_div_table[] = {
+	{ 1, 2 }, { 2, 3 }, { 3, 4 },
+	{ 0, 0 },
 };
 
 static struct clk_div_table rmii_ref_div_table[] = {
@@ -184,7 +184,6 @@ static struct clk_div_table nand_div_table[] = {
 
 /* mux clock */
 static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RATE_PARENT);
-static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
 
 /* gate clocks */
 static OWL_GATE(gpio_clk, "gpio_clk", "apb_clk", CMU_DEVCLKEN0, 18, 0, 0);
@@ -197,16 +196,25 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
 static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
-static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
+static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 2, 2, h_div_table, 0, 0);
 static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
 static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
 
 /* factor clocks */
-static OWL_FACTOR(ahb_clk, "ahb_clk", "h_clk", CMU_BUSCLK1, 2, 2, ahb_factor_table, 0, 0);
 static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 4, de_factor_table, 0, 0);
 static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 4, de_factor_table, 0, 0);
 
 /* composite clocks */
+static OWL_COMP_DIV(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p,
+			OWL_MUX_HW(CMU_BUSCLK1, 8, 3),
+			{ 0 },
+			OWL_DIVIDER_HW(CMU_BUSCLK1, 12, 2, 0, NULL),
+			0);
+
+static OWL_COMP_FIXED_FACTOR(ahb_clk, "ahb_clk", "h_clk",
+			{ 0 },
+			1, 1, CLK_SET_RATE_PARENT);
+
 static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
 			OWL_MUX_HW(CMU_VCECLK, 4, 2),
 			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
-- 
2.30.1

