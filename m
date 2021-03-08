Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E117331483
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCHRTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhCHRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:38 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BDFC06174A;
        Mon,  8 Mar 2021 09:18:38 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w9so15786686edt.13;
        Mon, 08 Mar 2021 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AICUc7/WIpyKcr6PZSNCmOkXDiStUBOvDovzIM4PHc0=;
        b=IMMOE+olayuWnwpdCosd+VnWOE+l5I/V8Swj7e5oJkoyfsBmKklQvkxaIXB24/cqza
         Il0R5JV5EOjUSPNh6KegfM6VcSp+3ZTTxw49dbTjTbr2jac3vyNCCd/oVNgrjrXnEFXt
         iNZz/PHd5wXjSwRci3u7yVnR66TkEfB4c4L+Hx9gQ5UaH85Frm8UBjFe+RcQS9AN5v5p
         v+cKvzraES7nJ8QCc1p9gWogLcO5aOG5mRY4rYgB2YDSvFLuDc/dEZR2D5AVlx3AM1/d
         WATsI1ifLp6N0T937G8SY2IOZ2uPTUhjUquPjWUjROcTPnpxuO5BGDGqg5gYwVzOdSVD
         pJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AICUc7/WIpyKcr6PZSNCmOkXDiStUBOvDovzIM4PHc0=;
        b=eO9mQ3RtGoH+xT+1zakgloLKHLc/nQkrbbOukC7nsvN2DdMArkpEw82RALN3nMNsWb
         xxvm+jmb5Ss3QtIZ+D+pfYLLPVKi6elO6F+NfQqjaRisEFG3PbGdEZ72mOhUAg3PST7W
         VFYrMf2JiGJoE8azI60NXKm6o7U0xrKxcESNo1V1uyvTvlEY58WfDkp7HNyh73V7jtqh
         tIYfWaxOEkOJTt1LIr0blCNsAzN5IvH5OTkGdZT8F9qCHOLzXe36vk9GfOJpgBtXE/uw
         KIZpPxGalWaNxTAwiDa/b94Y2naH9p1Pi9eE8AzO+7ICmUYQMPmZ+BLSYxoiL6YUsXPQ
         Sr1g==
X-Gm-Message-State: AOAM533v720J+oMmTRmsHmi/3UPoZY4njBrAESZ+AvOXF4rFvpUWnQMv
        ce/7Clj4oJZ+mFZolUyaXyRehOpHmyk=
X-Google-Smtp-Source: ABdhPJwOMKO9OQ4XcBludL34Vaqc3ppmltZZNdItDdPx/DWvUQePT23vy6WJGJ2swzkRpwvmxbWUUg==
X-Received: by 2002:aa7:cf17:: with SMTP id a23mr23943922edy.30.1615223917333;
        Mon, 08 Mar 2021 09:18:37 -0800 (PST)
Received: from localhost.localdomain ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id r5sm7457714eds.49.2021.03.08.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:18:36 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/6] clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC
Date:   Mon,  8 Mar 2021 19:18:28 +0200
Message-Id: <13576ddb604a9097603d95cd2605275c20fb2f56.1615221459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
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

Additionally, since SENSOR[0-1] are not gated, unset the OWL_GATE_HW
configuration and drop the CLK_IGNORE_UNUSED flag in their definitions.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 48 ++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 69cd959205f5..abe8874353de 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -138,9 +138,16 @@ static struct clk_factor_table sd_factor_table[] = {
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
 
@@ -154,6 +161,13 @@ static struct clk_div_table rmii_ref_div_table[] = {
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
@@ -189,39 +203,39 @@ static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNE
 
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
-			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
-			OWL_FACTOR_HW(CMU_SENSORCLK, 0, 3, 0, bisp_factor_table),
-			CLK_IGNORE_UNUSED);
+			{ 0 },
+			OWL_DIVIDER_HW(CMU_SENSORCLK, 0, 4, 0, std12rate_div_table),
+			0);
 
-static OWL_COMP_FACTOR(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
+static OWL_COMP_DIV(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
 			OWL_MUX_HW(CMU_SENSORCLK, 4, 1),
-			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
-			OWL_FACTOR_HW(CMU_SENSORCLK, 8, 3, 0, bisp_factor_table),
-			CLK_IGNORE_UNUSED);
+			{ 0 },
+			OWL_DIVIDER_HW(CMU_SENSORCLK, 8, 4, 0, std12rate_div_table),
+			0);
 
 static OWL_COMP_FACTOR(sd0_clk, "sd0_clk", sd_clk_mux_p,
 			OWL_MUX_HW(CMU_SD0CLK, 9, 1),
-- 
2.30.1

