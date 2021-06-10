Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805933A347D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFJUHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:07:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2167C0617A6;
        Thu, 10 Jun 2021 13:05:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g8so1060882ejx.1;
        Thu, 10 Jun 2021 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Y+aHwlcnZkPSrYqvChf+Kbr1B3VKSxdsI8c9mE1nNE=;
        b=EpyOQUDfYGJ9ZVtaFp7XUoBlrRBvURH5jncEZ57YlJsClw9ldMcGZFvfOnRbC+2f9m
         qY+Iu8LMgMpIsFAzJO+gmUgfVklnP0GVVbpUXRHqtN0P447fvA6TeZ7BT5nMjjjTsYq0
         dDzpFUvNSOzuy9JQfogqRdX3Sp08hQYnoiliZvZTZWydh12xojayfA0j3vwbWYzdVXOc
         iAfMR3Br9rJioyHGWSS7Hmin/PmM4jNHaCrGIudThyxTvqsJ1yTsdRGphzVB9lMVPqzM
         ZIU73VO6/rLAef+j8Lt2c/g8PHpo6HA5c4MKdaQ7VCdM8+opobx7H66Fs+QEN++q0jFs
         ORBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Y+aHwlcnZkPSrYqvChf+Kbr1B3VKSxdsI8c9mE1nNE=;
        b=dzZ+JVBhGz4gk74+NyrQxZHOschsx1dnM2elvwPB4BgPwWq+evBT5lmpdSYFmkko5A
         y0YEfXZYj5YsH6vFPUdP8fS6lyrRrlAyRwjMEIC7RQo0ZKoBADr45XzOv//cJhorVrEr
         GxhNNZT0v0MNiC++ClbiVAZSYVQvEMKkL/BDfzFK4lAxKnP6zwEZP2FMMESI41V8Qhlg
         cK96fnB/HRG8TJxiqnpX7lHa48tVqygTKpFvKyEVWzEyxOpCxRo7BGPaoHQ3rdPautrk
         uuYg45ZDDNJ2AMJdcX6NT2STwt+ReRbcse5ZWGSXYNoWnWHy7Ti5afbt3K06jJOwT7hH
         xuzg==
X-Gm-Message-State: AOAM531MMkFzvQskxbRU4aLiSSM433s6PeMhDnyD2EvtsmaaBUQ9nrMW
        4EtqBm6reJtVzluAhba8ZxSj68pFPes=
X-Google-Smtp-Source: ABdhPJw3sTaDY/SYhXrGVqheFvg5MBLkOnqjeQILmRnwcnOU5LKV2tr5xeLDZ+6K6Z9SR2w082SniA==
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr275681ejc.389.1623355534392;
        Thu, 10 Jun 2021 13:05:34 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id du7sm1800978edb.1.2021.06.10.13.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 13:05:33 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
Date:   Thu, 10 Jun 2021 23:05:24 +0300
Message-Id: <21c1abd19a7089b65a34852ac6513961be88cbe1.1623354574.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few issues with the setup of the Actions Semi Owl S500 SoC's
clock chain involving AHPPREDIV, H and AHB clocks:

* AHBPREDIV clock is defined as a muxer only, although it also acts as
  a divider.
* H clock is using a wrong divider register offset
* AHB is defined as a multi-rate factor clock, but it is actually just
  a fixed pass clock.

Let's provide the following fixes:

* Change AHBPREDIV clock to an ungated OWL_COMP_DIV definition.
* Use the correct register shift value in the OWL_DIVIDER definition
  for H clock
* Drop the unneeded 'ahb_factor_table[]' and change AHB clock to an
  ungated OWL_COMP_FIXED_FACTOR definition.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v3:
 - Fixed the swapped flags between "ahbprediv_clk" and "ahb_clk" as noticed
   by Mani

Changes in v2:
 - Reverted the addition of the clock div table for H clock to support the
   '1' divider (according to the datasheet), even though the vendor
   implementation marks it as reserved
 
 drivers/clk/actions/owl-s500.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 42d6899755e6..cbeb51c804eb 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -153,11 +153,6 @@ static struct clk_factor_table hde_factor_table[] = {
 	{ 0, 0, 0 },
 };
 
-static struct clk_factor_table ahb_factor_table[] = {
-	{ 1, 1, 2 }, { 2, 1, 3 },
-	{ 0, 0, 0 },
-};
-
 static struct clk_div_table rmii_ref_div_table[] = {
 	{ 0, 4 }, { 1, 10 },
 	{ 0, 0 },
@@ -186,7 +181,6 @@ static struct clk_div_table nand_div_table[] = {
 
 /* mux clock */
 static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RATE_PARENT);
-static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
 
 /* gate clocks */
 static OWL_GATE(gpio_clk, "gpio_clk", "apb_clk", CMU_DEVCLKEN0, 18, 0, 0);
@@ -199,16 +193,25 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
 static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
-static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
+static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 2, 2, NULL, 0, 0);
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
+			CLK_SET_RATE_PARENT);
+
+static OWL_COMP_FIXED_FACTOR(ahb_clk, "ahb_clk", "h_clk",
+			{ 0 },
+			1, 1, 0);
+
 static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
 			OWL_MUX_HW(CMU_VCECLK, 4, 2),
 			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
-- 
2.32.0

