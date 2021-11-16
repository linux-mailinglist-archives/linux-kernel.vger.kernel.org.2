Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0EA4531CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhKPMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:10:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236231AbhKPMIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:08:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1459961414;
        Tue, 16 Nov 2021 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637064350;
        bh=e7+yzDZOLvstJHIWR1WcsOs+RKbc+SNcRppOEfI6ixw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNJfkLZWEdJ2AJmSTQzzvu+A+2uP27adn+sj1kNQJ+A3X2AxvqoTF8tXA+AJrfLEr
         nFFOjqJq+zRUBlP6gPmbF2IlKcJZaqPFlXx7NtbaPwF45/eh8L4tqsDihTI8EcE2Lh
         0JZvWgeQmA3aXrm9RfIaSoGv5M6Ivb9f2URiwDnjEwcP77W/ROK2jHfgJmqs1Clf0C
         MFE3A1rUV53z4fhFco0DFTz2su8AhBrbWLpg/y1+YZAipR/2acRy78UlqrjUx0x2WD
         9Ehv6Ibz6XNtJxdMgBbdzFs8xo9qScdpa8vzgACbmQz49+3cWsFKxay7kU9LDROirI
         pZ/VSiFx/Q1gQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mmxDe-00A9CI-Gc; Tue, 16 Nov 2021 12:05:46 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Wei Xu" <xuwei5@hisilicon.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] clk: clk-hi3670: mark some clocks as CLK_IS_CRITICAL
Date:   Tue, 16 Nov 2021 12:05:44 +0000
Message-Id: <69e24043e4c3e085b926282a5e528b8bd232ab7e.1637064075.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637064075.git.mchehab+huawei@kernel.org>
References: <cover.1637064075.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks can't be disabled or the device stops working.

Mark those with CLK_IS_CRITICAL.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RESEND 0/2] at: https://lore.kernel.org/all/cover.1637064075.git.mchehab+huawei@kernel.org/

 drivers/clk/hisilicon/clk-hi3670.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
index 4d05a71683a5..d5813132df9c 100644
--- a/drivers/clk/hisilicon/clk-hi3670.c
+++ b/drivers/clk/hisilicon/clk-hi3670.c
@@ -82,13 +82,13 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_PPLL2_EN_ACPU, "ppll2_en_acpu", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x0, 3, 0, },
 	{ HI3670_PPLL3_EN_ACPU, "ppll3_en_acpu", "clk_ppll3",
-	  CLK_SET_RATE_PARENT, 0x0, 27, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x0, 27, 0, },
 	{ HI3670_PPLL1_GT_CPU, "ppll1_gt_cpu", "clk_ppll1",
 	  CLK_SET_RATE_PARENT, 0x460, 16, 0, },
 	{ HI3670_PPLL2_GT_CPU, "ppll2_gt_cpu", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x460, 18, 0, },
 	{ HI3670_PPLL3_GT_CPU, "ppll3_gt_cpu", "clk_ppll3",
-	  CLK_SET_RATE_PARENT, 0x460, 20, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x460, 20, 0, },
 	{ HI3670_CLK_GATE_PPLL2_MEDIA, "clk_gate_ppll2_media", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x410, 27, 0, },
 	{ HI3670_CLK_GATE_PPLL3_MEDIA, "clk_gate_ppll3_media", "clk_ppll3",
@@ -166,7 +166,7 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_CLK_CCI400_BYPASS, "clk_cci400_bypass", "clk_ddrc_freq",
 	  CLK_SET_RATE_PARENT, 0x22C, 28, 0, },
 	{ HI3670_CLK_GATE_CCI400, "clk_gate_cci400", "clk_ddrc_freq",
-	  CLK_SET_RATE_PARENT, 0x50, 14, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x50, 14, 0, },
 	{ HI3670_CLK_GATE_SD, "clk_gate_sd", "clk_mux_sd_sys",
 	  CLK_SET_RATE_PARENT, 0x40, 17, 0, },
 	{ HI3670_HCLK_GATE_SD, "hclk_gate_sd", "clk_div_sysbus",
@@ -248,15 +248,15 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_CLK_GATE_AO_ASP, "clk_gate_ao_asp", "clk_div_ao_asp",
 	  CLK_SET_RATE_PARENT, 0x0, 26, 0, },
 	{ HI3670_PCLK_GATE_PCTRL, "pclk_gate_pctrl", "clk_div_ptp",
-	  CLK_SET_RATE_PARENT, 0x20, 31, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x20, 31, 0, },
 	{ HI3670_CLK_CSI_TRANS_GT, "clk_csi_trans_gt", "clk_div_csi_trans",
-	  CLK_SET_RATE_PARENT, 0x30, 24, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x30, 24, 0, },
 	{ HI3670_CLK_DSI_TRANS_GT, "clk_dsi_trans_gt", "clk_div_dsi_trans",
 	  CLK_SET_RATE_PARENT, 0x30, 25, 0, },
 	{ HI3670_CLK_GATE_PWM, "clk_gate_pwm", "clk_div_ptp",
 	  CLK_SET_RATE_PARENT, 0x20, 0, 0, },
 	{ HI3670_ABB_AUDIO_EN0, "abb_audio_en0", "clk_gate_abb_192",
-	  CLK_SET_RATE_PARENT, 0x30, 8, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x30, 8, 0, },
 	{ HI3670_ABB_AUDIO_EN1, "abb_audio_en1", "clk_gate_abb_192",
 	  CLK_SET_RATE_PARENT, 0x30, 9, 0, },
 	{ HI3670_ABB_AUDIO_GT_EN0, "abb_audio_gt_en0", "abb_audio_en0",
@@ -331,9 +331,9 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_clks[] = {
 	{ HI3670_CLK_GATE_DSI_TRANS, "clk_gate_dsi_trans", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0xF4, 1, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_PTP, "clk_andgt_ptp", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xF8, 5, CLK_GATE_HIWORD_MASK, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0xF8, 5, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_OUT0, "clk_andgt_out0", "clk_ppll0",
-	  CLK_SET_RATE_PARENT, 0xF0, 10, CLK_GATE_HIWORD_MASK, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0xF0, 10, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_OUT1, "clk_andgt_out1", "clk_ppll0",
 	  CLK_SET_RATE_PARENT, 0xF0, 11, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLKGT_DP_AUDIO_PLL_AO, "clkgt_dp_audio_pll_ao", "clk_ppll6",
@@ -569,9 +569,9 @@ static const struct hisi_gate_clock hi3670_sctrl_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_SPI, "pclk_gate_spi", "clk_div_ioperi",
 	  CLK_SET_RATE_PARENT, 0x1B0, 10, 0, },
 	{ HI3670_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_ufs_subsys",
-	  CLK_SET_RATE_PARENT, 0x1B0, 14, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x1B0, 14, 0, },
 	{ HI3670_CLK_GATE_UFSIO_REF, "clk_gate_ufsio_ref", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0x1b0, 12, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x1b0, 12, 0, },
 	{ HI3670_PCLK_AO_GPIO0, "pclk_ao_gpio0", "clk_div_aobus",
 	  CLK_SET_RATE_PARENT, 0x160, 11, 0, },
 	{ HI3670_PCLK_AO_GPIO1, "pclk_ao_gpio1", "clk_div_aobus",
@@ -593,7 +593,7 @@ static const struct hisi_gate_clock hi3670_sctrl_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_SYSCNT, "pclk_gate_syscnt", "clk_div_aobus",
 	  CLK_SET_RATE_PARENT, 0x160, 19, 0, },
 	{ HI3670_CLK_GATE_SYSCNT, "clk_gate_syscnt", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0x160, 20, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x160, 20, 0, },
 	{ HI3670_CLK_GATE_ASP_SUBSYS_PERI, "clk_gate_asp_subsys_peri",
 	  "clk_mux_asp_subsys_peri",
 	  CLK_SET_RATE_PARENT, 0x170, 6, 0, },
@@ -703,7 +703,7 @@ static const struct hisi_gate_clock hi3670_media1_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_DISP_NOC_SUBSYS, "pclk_gate_disp_noc_subsys", "clk_div_sysbus",
 	  CLK_SET_RATE_PARENT, 0x10, 18, 0, },
 	{ HI3670_ACLK_GATE_DISP_NOC_SUBSYS, "aclk_gate_disp_noc_subsys", "clk_gate_vivobusfreq",
-	  CLK_SET_RATE_PARENT, 0x10, 17, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x10, 17, 0, },
 	{ HI3670_PCLK_GATE_DSS, "pclk_gate_dss", "pclk_gate_disp_noc_subsys",
 	  CLK_SET_RATE_PARENT, 0x00, 14, 0, },
 	{ HI3670_ACLK_GATE_DSS, "aclk_gate_dss", "aclk_gate_disp_noc_subsys",
-- 
2.33.1

