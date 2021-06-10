Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DB3A3490
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhFJUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:08:45 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33503 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhFJUIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:08:42 -0400
Received: by mail-ed1-f50.google.com with SMTP id f5so29499317eds.0;
        Thu, 10 Jun 2021 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5s5zP/EpVmQlg+h4gF15kZmB35/4iHQZ0hsmxTTSidA=;
        b=ZcDHeQCfU3xuLBg/ff8ZVxP3QEJh44QstkFQbqEO/WkAG9OEcz+EccVNsfb/omDjlZ
         1Pg/8cPtATJuwnnCuHpWzVh0Y1JAuIUKnq5dc/jnU9+D2s3vTvPN8hF7u5IwuMm5bpMJ
         OjyF6k9lfYju95dcoQEjmVm85BZErOzPKXdpis4GSXiHV9mrDXw3yMRieXweKHiZJohF
         c3YkThq/srKQUoNDRqy0kgXjV604wYYaSWjsDLdUyRHEBLL9wSwTc9Gr1PtRhr1FFqGR
         2F2OClDV5kTTMrYeUkn7/iwgyyHeQSMyC7JOy9tlOief5d5zSS8VPbnQzdlhsUnz8YLp
         zvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5s5zP/EpVmQlg+h4gF15kZmB35/4iHQZ0hsmxTTSidA=;
        b=W7e7Y2EWCxD2GTPrfSryYDdzAX/xvWhMnkjzjtUhgXWxdvlTR/jHsV4EO+flxnXS6D
         rTMeSF/DuFENTHXOJkqPUqICQ391PZdelEOyPLUMLwV1J0LnYh6YnAHP0nQwjG2+wFMr
         plQarJN3fOzG0NwCkH2Y4IhzjXtQRmO2xB7dw5pRhOOyiqEBrUQFRcYgPOsOv2RjYaZx
         r5Kog1vMa62Ygaw7vEdA5M5Zec0cVSRXnj67UArZgyrS+sN5ZlkTVAw9nu2BbxkuVM0v
         UxTnE10SzJUQIDSuZ/INfSjcD7tBb1S17Cz88eyBJFnkpL6eNFQjUUYiD5BEbtFnvBf2
         ig2w==
X-Gm-Message-State: AOAM531GVih/I2q3QkJce5kocaB7hsu3P1K2Mf3iqKPFIMkekO8pKqnd
        AQCJ3WPW5sb2yVjBxPCeInw=
X-Google-Smtp-Source: ABdhPJyivZXimEWadRgV/aYVj01+OaW49bNWMM4ljD6CJm/rvZyowhXl8auyIg1AF7TKHcpl4hSceA==
X-Received: by 2002:a50:8dc6:: with SMTP id s6mr242695edh.50.1623355533111;
        Thu, 10 Jun 2021 13:05:33 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id du7sm1800978edb.1.2021.06.10.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 13:05:32 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/6] clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC
Date:   Thu, 10 Jun 2021 23:05:23 +0300
Message-Id: <e675820a46cd9930d8d576c6cae61d41c1a8416f.1623354574.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by tag from Mani

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
2.32.0

