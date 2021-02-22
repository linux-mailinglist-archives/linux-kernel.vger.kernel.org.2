Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF79D322059
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhBVTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232971AbhBVTm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:42:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D833F64E3F;
        Mon, 22 Feb 2021 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022939;
        bh=+mUDeuOWLKyEBqA8AdkAHb887NlhdAD1/y956h82d2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNV9HDGqtP1nSoySEYrlCpxBWY98eBDqY+mPelE+Ew5lCo3lA1nCZWcbfBe8D0ohl
         95zZhv/RQFPNaE95pqP34cvhmdf42f/7V/SC1uT7F2ff/y0g5rzuQZmtMnm5ycUrJG
         J0X9rAZBEVNYIYYxYFYtU3K8d5ONnwC6OQ60PgfFuLs+yvozNAjMTGd38mtIw9TvJa
         PmxQQGVlgZ74as5wcFmkaUPOJSDYaedKZSoNZw4vDUlzWZ3guwWki+/ppBEPeck0h1
         T6sPxcMrrJLqEIShvCEJCnNoKU/mW08j6WYDrCnKI/q7itr0EUVHokihVrwNPQO2Pv
         ancRfLohkWzsw==
Received: by pali.im (Postfix)
        id EEFD7F04; Mon, 22 Feb 2021 20:42:16 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH mvebu v3 03/10] clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM clock
Date:   Mon, 22 Feb 2021 20:41:51 +0100
Message-Id: <20210222194158.12342-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222194158.12342-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <kabel@kernel.org>

Remove the .set_parent method in clk_pm_cpu_ops.

This method was supposed to be needed by the armada-37xx-cpufreq driver,
but was never actually called due to wrong assumptions in the cpufreq
driver. After this was fixed in the cpufreq driver, this method is not
needed anymore.

Signed-off-by: Marek Behún <kabel@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks")
---
 drivers/clk/mvebu/armada-37xx-periph.c | 28 --------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index f5746f9ea929..6507bd2c5f31 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -440,33 +440,6 @@ static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
 	return val;
 }
 
-static int clk_pm_cpu_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct clk_pm_cpu *pm_cpu = to_clk_pm_cpu(hw);
-	struct regmap *base = pm_cpu->nb_pm_base;
-	int load_level;
-
-	/*
-	 * We set the clock parent only if the DVFS is available but
-	 * not enabled.
-	 */
-	if (IS_ERR(base) || armada_3700_pm_dvfs_is_enabled(base))
-		return -EINVAL;
-
-	/* Set the parent clock for all the load level */
-	for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
-		unsigned int reg, mask,  val,
-			offset = ARMADA_37XX_NB_TBG_SEL_OFF;
-
-		armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
-
-		val = index << offset;
-		mask = ARMADA_37XX_NB_TBG_SEL_MASK << offset;
-		regmap_update_bits(base, reg, mask, val);
-	}
-	return 0;
-}
-
 static unsigned long clk_pm_cpu_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
 {
@@ -592,7 +565,6 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_pm_cpu_ops = {
 	.get_parent = clk_pm_cpu_get_parent,
-	.set_parent = clk_pm_cpu_set_parent,
 	.round_rate = clk_pm_cpu_round_rate,
 	.set_rate = clk_pm_cpu_set_rate,
 	.recalc_rate = clk_pm_cpu_recalc_rate,
-- 
2.20.1

