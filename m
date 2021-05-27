Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C83392F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhE0NSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbhE0NS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:18:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE227C061760;
        Thu, 27 May 2021 06:16:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e24so722046eds.11;
        Thu, 27 May 2021 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcmFmBVnSnD2tbZxnT4h9jKt0idY/F3KyHEdb6MSBsw=;
        b=oJ0iLczWf4eZuaHoL7tZS2LoUrhyj6CAVRTV0v323hwoOv76Vufe8zxV6wNc0/yNvJ
         EsOOUH6YFWkvi8zVxTFESKsM9YawhiaT3jnE6PNG61NsPsTXggzOnaLURn2fqOWCDbLr
         8eA2m9FQbz42drScgFJ4ww3l65k5rWGIF7uzcskiiVkDBFZbAIOyLn01/M08UXDY3Kh4
         Nx0sk8NLNNp6HkY3xO05wFYYwkw8D4RTWCzKzQ3iXrNuE1AmdRYic3vXl5m6aejNIQf0
         CnHBYTZ4eEMBc+IVlor9u0XryzWSnXQakJp1VHzPx7OA10Tq+EeTLyg1lUaQD94J/FGx
         yzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcmFmBVnSnD2tbZxnT4h9jKt0idY/F3KyHEdb6MSBsw=;
        b=YKDwaZFC29UJk0eoqoBm+qaldZ+EF1JcMzz4/3paLS6BlqDZfxUpBABygr8GULbA/b
         ItScUQOE0Wid8+wyu+wlr/hnUB1Gj/qQOIclzNqNwQBVk7KZYTbd2zsK5bbEP+qSpqW8
         kElHhVwD9iIt/BYxJ9SQ3l1ota54X6oABn8vUb+zCZnqcaG5EK51gAIsuS2WlIoZ2CUs
         1hdcoXlEV5WK25nqAGNT8PeokhqADET2K8pUcZ8leg66GyrL9/oJ9aU5mGEb3nB4Cekg
         H9GWtnlzAM0x8f+7ukE/0MWgo8I/ZMRLEqCRVQStf1apynMqf/WKWS9yE9b4apG1vOVH
         fTyQ==
X-Gm-Message-State: AOAM533H63DHwUtjOM0XXFIY63Gvc5SqIPbeH8fZ5RRwgVzYQEPV2BfZ
        eF5ZCbN4yKIao4X3pe4618U=
X-Google-Smtp-Source: ABdhPJyk49pY9W9zEZpUEEZqUfetKa2dcWj2MrSsrk/DyOLArCQT27PkU+BRwqnYTnkoPPhi8Gp/dQ==
X-Received: by 2002:a05:6402:128d:: with SMTP id w13mr4013434edv.253.1622121412443;
        Thu, 27 May 2021 06:16:52 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id r23sm1104206edq.59.2021.05.27.06.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:16:52 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
Date:   Thu, 27 May 2021 16:16:42 +0300
Message-Id: <107776b4a4e752ef83b143114d2baf52bf8c4107.1622119892.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
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
Changes in v2:
 - Reverted the addition of the clock div table for H clock to support the
   '1' divider (according to the datasheet), even though the vendor
   implementation marks it as reserved
 
 drivers/clk/actions/owl-s500.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 42d6899755e6..257923bd5386 100644
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
2.31.1

