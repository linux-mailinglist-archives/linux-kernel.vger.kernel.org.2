Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751FD3B88D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhF3TBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 15:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232881AbhF3TBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 15:01:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8689F61435;
        Wed, 30 Jun 2021 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625079520;
        bh=W6gEMOAr2k2UB3Fh65shSZlku3WM8UiBWegNqvIZ6Rk=;
        h=From:To:Cc:Subject:Date:From;
        b=BSMBj2i7bybKz3mkfmukLLY4ThDQG73FCmWMcZ1WISayfld+dmOjV9V46JmMUOeFK
         pW5vXC/41g2xOGCCEvmvAK6irxSTqXAdJ8jcsuzY4rzf0lAinl2RGMz0ZI0qePdtEH
         zK3ReDHCW7qJTdwZgjfNdFCzUAOIuwSFxr66bK4D1/bPy1/SeWaSFEWysOSGf3zDiW
         fVh4GND751ToS/uyYTTBYfJzFb/bM7esKhsMyE9ENNaPqm6YxE48odzQIYiaMDRh+O
         MbNSNk0DBsu05LGZDQMpGOjRQLf5CppSiRPMMn7BoWM1cw03YLyerRdd7OQwNvCH+y
         dwGeUiTeLqgvA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH] clk: hisilicon: hi3559a: Drop __init markings everywhere
Date:   Wed, 30 Jun 2021 11:58:39 -0700
Message-Id: <20210630185839.3680834-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is a platform driver. The probe function can be called after
kernel init, and try to reference kernel memory that has been freed.
Drop the __init markings everywhere here to avoid referencing initdata
from non-init code. Fixes modpost warnings.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Fixes: 6c81966107dc ("clk: hisilicon: Add clock driver for hi3559A SoC")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3559a.c | 39 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index b1f19c43b558..56012a3d0219 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -107,25 +107,25 @@ static const struct hisi_fixed_rate_clock hi3559av100_fixed_rate_clks_crg[] = {
 };
 
 
-static const char *fmc_mux_p[] __initconst = {
+static const char *fmc_mux_p[] = {
 	"24m", "75m", "125m", "150m", "200m", "250m", "300m", "400m"
 };
 
-static const char *mmc_mux_p[] __initconst = {
+static const char *mmc_mux_p[] = {
 	"100k", "25m", "49p5m", "99m", "187p5m", "150m", "198m", "400k"
 };
 
-static const char *sysapb_mux_p[] __initconst = {
+static const char *sysapb_mux_p[] = {
 	"24m", "50m",
 };
 
-static const char *sysbus_mux_p[] __initconst = {
+static const char *sysbus_mux_p[] = {
 	"24m", "300m"
 };
 
-static const char *uart_mux_p[] __initconst = { "50m", "24m", "3m" };
+static const char *uart_mux_p[] = { "50m", "24m", "3m" };
 
-static const char *a73_clksel_mux_p[] __initconst = {
+static const char *a73_clksel_mux_p[] = {
 	"24m", "apll", "1000m"
 };
 
@@ -136,7 +136,7 @@ static const u32 sysbus_mux_table[]	= { 0, 1 };
 static const u32 uart_mux_table[]	= { 0, 1, 2 };
 static const u32 a73_clksel_mux_table[] = { 0, 1, 2 };
 
-static struct hisi_mux_clock hi3559av100_mux_clks_crg[] __initdata = {
+static struct hisi_mux_clock hi3559av100_mux_clks_crg[] = {
 	{
 		HI3559AV100_FMC_MUX, "fmc_mux", fmc_mux_p, ARRAY_SIZE(fmc_mux_p),
 		CLK_SET_RATE_PARENT, 0x170, 2, 3, 0, fmc_mux_table,
@@ -181,7 +181,7 @@ static struct hisi_mux_clock hi3559av100_mux_clks_crg[] __initdata = {
 	},
 };
 
-static struct hisi_gate_clock hi3559av100_gate_clks[] __initdata = {
+static struct hisi_gate_clock hi3559av100_gate_clks[] = {
 	{
 		HI3559AV100_FMC_CLK, "clk_fmc", "fmc_mux",
 		CLK_SET_RATE_PARENT, 0x170, 1, 0,
@@ -336,7 +336,7 @@ static struct hisi_gate_clock hi3559av100_gate_clks[] __initdata = {
 	},
 };
 
-static struct hi3559av100_pll_clock hi3559av100_pll_clks[] __initdata = {
+static struct hi3559av100_pll_clock hi3559av100_pll_clks[] = {
 	{
 		HI3559AV100_APLL_CLK, "apll", NULL, 0x0, 0, 24, 24, 3, 28, 3,
 		0x4, 0, 12, 12, 6
@@ -502,7 +502,7 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 	}
 }
 
-static __init struct hisi_clock_data *hi3559av100_clk_register(
+static struct hisi_clock_data *hi3559av100_clk_register(
 	struct platform_device *pdev)
 {
 	struct hisi_clock_data *clk_data;
@@ -549,7 +549,7 @@ static __init struct hisi_clock_data *hi3559av100_clk_register(
 	return ERR_PTR(ret);
 }
 
-static __init void hi3559av100_clk_unregister(struct platform_device *pdev)
+static void hi3559av100_clk_unregister(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
@@ -568,8 +568,7 @@ static const struct hisi_crg_funcs hi3559av100_crg_funcs = {
 	.unregister_clks = hi3559av100_clk_unregister,
 };
 
-static struct hisi_fixed_rate_clock hi3559av100_shub_fixed_rate_clks[]
-	__initdata = {
+static struct hisi_fixed_rate_clock hi3559av100_shub_fixed_rate_clks[] = {
 	{ HI3559AV100_SHUB_SOURCE_SOC_24M, "clk_source_24M", NULL, 0, 24000000UL, },
 	{ HI3559AV100_SHUB_SOURCE_SOC_200M, "clk_source_200M", NULL, 0, 200000000UL, },
 	{ HI3559AV100_SHUB_SOURCE_SOC_300M, "clk_source_300M", NULL, 0, 300000000UL, },
@@ -587,16 +586,16 @@ static struct hisi_fixed_rate_clock hi3559av100_shub_fixed_rate_clks[]
 
 /* shub mux clk */
 static u32 shub_source_clk_mux_table[] = {0, 1, 2, 3};
-static const char *shub_source_clk_mux_p[] __initconst = {
+static const char *shub_source_clk_mux_p[] = {
 	"clk_source_24M", "clk_source_200M", "clk_source_300M", "clk_source_PLL"
 };
 
 static u32 shub_uart_source_clk_mux_table[] = {0, 1, 2, 3};
-static const char *shub_uart_source_clk_mux_p[] __initconst = {
+static const char *shub_uart_source_clk_mux_p[] = {
 	"clk_uart_32K", "clk_uart_div_clk", "clk_uart_div_clk", "clk_source_24M"
 };
 
-static struct hisi_mux_clock hi3559av100_shub_mux_clks[] __initdata = {
+static struct hisi_mux_clock hi3559av100_shub_mux_clks[] = {
 	{
 		HI3559AV100_SHUB_SOURCE_CLK, "shub_clk", shub_source_clk_mux_p,
 		ARRAY_SIZE(shub_source_clk_mux_p),
@@ -615,7 +614,7 @@ static struct hisi_mux_clock hi3559av100_shub_mux_clks[] __initdata = {
 static struct clk_div_table shub_spi_clk_table[] = {{0, 8}, {1, 4}, {2, 2}};
 static struct clk_div_table shub_uart_div_clk_table[] = {{1, 8}, {2, 4}};
 
-static struct hisi_divider_clock hi3559av100_shub_div_clks[] __initdata = {
+static struct hisi_divider_clock hi3559av100_shub_div_clks[] = {
 	{ HI3559AV100_SHUB_SPI_SOURCE_CLK, "clk_spi_clk", "shub_clk", 0, 0x20, 24, 2,
 	  CLK_DIVIDER_ALLOW_ZERO, shub_spi_clk_table,
 	},
@@ -625,7 +624,7 @@ static struct hisi_divider_clock hi3559av100_shub_div_clks[] __initdata = {
 };
 
 /* shub gate clk */
-static struct hisi_gate_clock hi3559av100_shub_gate_clks[] __initdata = {
+static struct hisi_gate_clock hi3559av100_shub_gate_clks[] = {
 	{
 		HI3559AV100_SHUB_SPI0_CLK, "clk_shub_spi0", "clk_spi_clk",
 		0, 0x20, 1, 0,
@@ -697,7 +696,7 @@ static int hi3559av100_shub_default_clk_set(void)
 	return 0;
 }
 
-static __init struct hisi_clock_data *hi3559av100_shub_clk_register(
+static struct hisi_clock_data *hi3559av100_shub_clk_register(
 	struct platform_device *pdev)
 {
 	struct hisi_clock_data *clk_data = NULL;
@@ -751,7 +750,7 @@ static __init struct hisi_clock_data *hi3559av100_shub_clk_register(
 	return ERR_PTR(ret);
 }
 
-static __init void hi3559av100_shub_clk_unregister(struct platform_device *pdev)
+static void hi3559av100_shub_clk_unregister(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

