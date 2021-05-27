Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD6392F47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhE0NSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbhE0NS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:18:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADB7C06138A;
        Thu, 27 May 2021 06:16:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g7so816596edm.4;
        Thu, 27 May 2021 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulSg/i7gd6RTh8QJ8jOfropMdLv/b3cGBvHL1IErnoo=;
        b=g3J4cgHio4vsbIZucBQnjwlG734pqs3X3lsRI1bnvJZywWO9L2QF7hr/cbf12z0L5/
         XH1JfmZ1Y+L8CYAk8A6IFa78iKiRJfaNz2q4m/6h5cFT9u2oli3u3M2z9RuA+JKBRAsS
         gpC7yTkGnTSCOw0BeQdeFW++CapQ9FhIBPQc0YppbmDUhkUL6DxtvYgaKaT7OP0yHnif
         eZfU8ekeFcv1JpzDbBAjbfWQtH35WdHsReIPbMm+RNWFe+7KLpx6GgqAcVLtDoizg6Bt
         gM2FBGPrnyFd+HFAflguEZZ70gOFzAWjM4A/nGo87wUuuzATjbFTdeo9waDSnRswummK
         wmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulSg/i7gd6RTh8QJ8jOfropMdLv/b3cGBvHL1IErnoo=;
        b=fOINlGCW7mXx/UnfIqEMUkW+TjNzGaaOP7jZ5VQPYP/lWyzBXInvDAt1O+PZsn9jkV
         ETlNR616PvdMuuekpFwpiQtuznCwhmAKdGSRZ7CAnQhTboffFhT8/f4wGpu/s/M8/ECn
         NNLthn/FIC/H2Sa/tR9P8eEGjClczJIdE/Gdl7LWG8nEwgt1VY2XNep9G4XrIJbJhzZE
         it0Tc/TjOwE3FJpJN5KSxYrHC7wc9WXneASlTmgJDcOo23M5gswgME6ICdNKjwEWEJP8
         6TnABtWypgyYLJm/WMXV64n8NGqihMUXfuBwoY2NLzhfdE7ex+kV610UACZjiAjXqKwQ
         HdgQ==
X-Gm-Message-State: AOAM530oBHyiFT9T0yRUiEK6ovdpWBiI+0dwciph09q8bWZ3JPMZ/AQ1
        PSbgMwx4ABkr+LtRO5+RWrw=
X-Google-Smtp-Source: ABdhPJw1+cQGW1kZHgbPN8hgvc86gnCqSumGYxtyk8LAT/fpJ+G/7LYxpr/DfN1fy1sD/50qgpp9rQ==
X-Received: by 2002:a05:6402:1d39:: with SMTP id dh25mr4071249edb.113.1622121411213;
        Thu, 27 May 2021 06:16:51 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id r23sm1104206edq.59.2021.05.27.06.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:16:50 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/6] clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC
Date:   Thu, 27 May 2021 16:16:41 +0300
Message-Id: <288f7a0a677a6bd8a3007b8b126f5a4637ec772e.1622119892.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following clocks of the Actions Semi Owl S500 SoC have been defined
to use a shared clock factor table 'bisp_factor_table[]': DE[1-2], VCE,
VDE, BISP, SENSOR[0-1]

There are several issues involved in this approach:

* 'bisp_factor_table[]' describes the configuration of a regular 8-rates
  divider, so its usage is redundant. Additionally, judging by the BISP
  clock context, it is incomplete since it maps only 8 out of 12
  possible entries.

* The clocks mentioned above are not identical in terms of the available
  rates, therefore cannot rely on the same factor table. Specifically,
  BISP and SENSOR* are standard 12-rate dividers so their configuration
  should rely on a proper clock div table, while VCE and VDE require a
  factor table that is a actually a subset of the one needed for DE[1-2]
  clocks.

Let's fix this by implementing the following:

* Add new factor tables 'de_factor_table' and 'hde_factor_table' to
  properly handle DE[1-2], VCE and VDE clocks.

* Add a common div table 'std12rate_div_table' for BISP and SENSOR[0-1]
  clocks converted to OWL_COMP_DIV.

* Drop the now unused 'bisp_factor_table[]'.

Additionally, drop the CLK_IGNORE_UNUSED flag for SENSOR[0-1] since
there is no reason to always keep ON those clocks.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v2:
 - Re-added OWL_GATE_HW to SENSOR[0-1], according to the datasheet they
   are gated, even though the vendor implementation states the opposite

 drivers/clk/actions/owl-s500.c | 44 ++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 42abdf964044..42d6899755e6 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -140,9 +140,16 @@ static struct clk_factor_table sd_factor_table[] = {
 	{ 0, 0, 0 },
 };
 
-static struct clk_factor_table bisp_factor_table[] = {
-	{ 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
-	{ 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
+static struct clk_factor_table de_factor_table[] = {
+	{ 0, 1, 1 }, { 1, 2, 3 }, { 2, 1, 2 }, { 3, 2, 5 },
+	{ 4, 1, 3 }, { 5, 1, 4 }, { 6, 1, 6 }, { 7, 1, 8 },
+	{ 8, 1, 12 },
+	{ 0, 0, 0 },
+};
+
+static struct clk_factor_table hde_factor_table[] = {
+	{ 0, 1, 1 }, { 1, 2, 3 }, { 2, 1, 2 }, { 3, 2, 5 },
+	{ 4, 1, 3 }, { 5, 1, 4 }, { 6, 1, 6 }, { 7, 1, 8 },
 	{ 0, 0, 0 },
 };
 
@@ -156,6 +163,13 @@ static struct clk_div_table rmii_ref_div_table[] = {
 	{ 0, 0 },
 };
 
+static struct clk_div_table std12rate_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
+	{ 4, 5 }, { 5, 6 }, { 6, 7 }, { 7, 8 },
+	{ 8, 9 }, { 9, 10 }, { 10, 11 }, { 11, 12 },
+	{ 0, 0 },
+};
+
 static struct clk_div_table i2s_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
@@ -191,39 +205,39 @@ static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNE
 
 /* factor clocks */
 static OWL_FACTOR(ahb_clk, "ahb_clk", "h_clk", CMU_BUSCLK1, 2, 2, ahb_factor_table, 0, 0);
-static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 3, bisp_factor_table, 0, 0);
-static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 3, bisp_factor_table, 0, 0);
+static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 4, de_factor_table, 0, 0);
+static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 4, de_factor_table, 0, 0);
 
 /* composite clocks */
 static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
 			OWL_MUX_HW(CMU_VCECLK, 4, 2),
 			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
-			OWL_FACTOR_HW(CMU_VCECLK, 0, 3, 0, bisp_factor_table),
+			OWL_FACTOR_HW(CMU_VCECLK, 0, 3, 0, hde_factor_table),
 			0);
 
 static OWL_COMP_FACTOR(vde_clk, "vde_clk", hde_clk_mux_p,
 			OWL_MUX_HW(CMU_VDECLK, 4, 2),
 			OWL_GATE_HW(CMU_DEVCLKEN0, 25, 0),
-			OWL_FACTOR_HW(CMU_VDECLK, 0, 3, 0, bisp_factor_table),
+			OWL_FACTOR_HW(CMU_VDECLK, 0, 3, 0, hde_factor_table),
 			0);
 
-static OWL_COMP_FACTOR(bisp_clk, "bisp_clk", bisp_clk_mux_p,
+static OWL_COMP_DIV(bisp_clk, "bisp_clk", bisp_clk_mux_p,
 			OWL_MUX_HW(CMU_BISPCLK, 4, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
-			OWL_FACTOR_HW(CMU_BISPCLK, 0, 3, 0, bisp_factor_table),
+			OWL_DIVIDER_HW(CMU_BISPCLK, 0, 4, 0, std12rate_div_table),
 			0);
 
-static OWL_COMP_FACTOR(sensor0_clk, "sensor0_clk", sensor_clk_mux_p,
+static OWL_COMP_DIV(sensor0_clk, "sensor0_clk", sensor_clk_mux_p,
 			OWL_MUX_HW(CMU_SENSORCLK, 4, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
-			OWL_FACTOR_HW(CMU_SENSORCLK, 0, 3, 0, bisp_factor_table),
-			CLK_IGNORE_UNUSED);
+			OWL_DIVIDER_HW(CMU_SENSORCLK, 0, 4, 0, std12rate_div_table),
+			0);
 
-static OWL_COMP_FACTOR(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
+static OWL_COMP_DIV(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
 			OWL_MUX_HW(CMU_SENSORCLK, 4, 1),
 			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
-			OWL_FACTOR_HW(CMU_SENSORCLK, 8, 3, 0, bisp_factor_table),
-			CLK_IGNORE_UNUSED);
+			OWL_DIVIDER_HW(CMU_SENSORCLK, 8, 4, 0, std12rate_div_table),
+			0);
 
 static OWL_COMP_FACTOR(sd0_clk, "sd0_clk", sd_clk_mux_p,
 			OWL_MUX_HW(CMU_SD0CLK, 9, 1),
-- 
2.31.1

