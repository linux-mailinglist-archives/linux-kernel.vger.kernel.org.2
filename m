Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECE308DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhA2T6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233127AbhA2Txd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:53:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAD4364E40;
        Fri, 29 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949926;
        bh=ygweX2/0R4x98GDDaiFr4D90OTDW02BhB/598asBbtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzD5I7PouP3ZcgbYpoW08KqcBb3MDauEWRNWdtT6/hdI8UfDvQE/wtK5AFLv2DxTp
         OfPZnzlalLvezR7rcTSFaWN/Dn7bRl7aXkP1Mc6ThkcOrgMNnUL70Nq8USSS7+qvDX
         GXDHwlZhMuHSrTba6jjYxX8L0h5TgJLnGz7KdkJmfPexggoo5IWNysRzD0qwXsCjsK
         MShjhMWGQDvcv2kjh9a0uD9Q4cCkswLcaxNpM9q9FqtpWcte0f3hFp7Xb9U18WjiYN
         IahWwYReOapvYSOoaakmajQovkxBrT+RduD0POhqHaknVtPh/bLHCsEZ/gM7muFfbU
         T1t7RR+/qXQbw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l5ZoI-007Wje-Vy; Fri, 29 Jan 2021 20:52:02 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/14] staging: hikey9xx: hi6421v600-regulator: use some regmap helpers
Date:   Fri, 29 Jan 2021 20:51:48 +0100
Message-Id: <5bdd7988fb9bf5d3ebee03724cf73cc04d9bc47b.1611949675.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611949675.git.mchehab+huawei@kernel.org>
References: <cover.1611949675.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver was ported to use regmap, let's use
some help functions in order to simplify the code a little
bit.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 45 ++-----------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 9e319fa11137..7090107b9ec2 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -95,17 +95,6 @@ static const unsigned int ldo34_voltages[] = {
 		.eco_uA			= ecoamp,			       \
 	}
 
-static int hi6421_spmi_regulator_is_enabled(struct regulator_dev *rdev)
-{
-	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	struct hi6421_spmi_pmic *pmic = sreg->pmic;
-	u32 reg_val;
-
-	regmap_read(pmic->map, rdev->desc->enable_reg, &reg_val);
-
-	return ((reg_val & rdev->desc->enable_mask) != 0);
-}
-
 static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
@@ -136,34 +125,6 @@ static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 				  rdev->desc->enable_mask, 0);
 }
 
-static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
-{
-	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	struct hi6421_spmi_pmic *pmic = sreg->pmic;
-	u32 reg_val;
-
-	regmap_read(pmic->map, rdev->desc->vsel_reg, &reg_val);
-
-	return (reg_val & rdev->desc->vsel_mask) >> (ffs(rdev->desc->vsel_mask) - 1);
-}
-
-static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
-						 unsigned int selector)
-{
-	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	struct hi6421_spmi_pmic *pmic = sreg->pmic;
-	u32 reg_val;
-
-	if (selector >= rdev->desc->n_voltages)
-		return -EINVAL;
-
-	reg_val = selector << (ffs(rdev->desc->vsel_mask) - 1);
-
-	/* set voltage selector */
-	return regmap_update_bits(pmic->map, rdev->desc->vsel_reg,
-				  rdev->desc->vsel_mask, reg_val);
-}
-
 static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
@@ -214,13 +175,13 @@ hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 }
 
 static const struct regulator_ops hi6421_spmi_ldo_rops = {
-	.is_enabled = hi6421_spmi_regulator_is_enabled,
+	.is_enabled = regulator_is_enabled_regmap,
 	.enable = hi6421_spmi_regulator_enable,
 	.disable = hi6421_spmi_regulator_disable,
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_iterate,
-	.get_voltage_sel = hi6421_spmi_regulator_get_voltage_sel,
-	.set_voltage_sel = hi6421_spmi_regulator_set_voltage_sel,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_mode = hi6421_spmi_regulator_get_mode,
 	.set_mode = hi6421_spmi_regulator_set_mode,
 	.get_optimum_mode = hi6421_spmi_regulator_get_optimum_mode,
-- 
2.29.2

