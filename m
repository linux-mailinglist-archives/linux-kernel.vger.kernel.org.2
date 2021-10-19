Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4DB432B40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJSAqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJSAqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B78E6103B;
        Tue, 19 Oct 2021 00:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634604231;
        bh=KRcaA+j1CSShmBtIgsG5VTNla29kY6brC8Flx7J25X4=;
        h=From:To:Cc:Subject:Date:From;
        b=ipSbIBXqM+Yr1wfoCecOZZnO9Qx7kse4aNnXoV0yV2hqXAwLS9sq3sSM7ITyNb7Rr
         Jd4zxtbC/qV+5dYHaF0LDGkaqGjxALt2G52fHXW0Balnk45v1a1lLLI2ZptDWavl5N
         9xBQK88Svs7Si5dRdlF6QlqSxp6O0IMoLlRNX1GENt9bK+DekZ9yrhMShnHJB8p0WP
         Ah114B7B3vSOv4rDOm7bEi1Wvgt3PNhLGEgez1MVU6xBox9NG3yOmuH+XPXPgTpvP2
         xzqDk5CLfSnhTj7biB+N02GgF7a80gZRQlhBP3BkC9MzA5ejfyOpI0elosRK6mBTp8
         tG7JQnlCWw6dA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] regulator: lp872x: Remove lp872x_dvs_state
Date:   Mon, 18 Oct 2021 17:43:35 -0700
Message-Id: <20211019004335.193492-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.1.637.gf443b226ca
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After this driver was converted to gpiod, clang started warning:

vers/regulator/lp872x.c:689:57: error: implicit conversion from
enumeration type 'enum lp872x_dvs_state' to different enumeration type
'enum gpiod_flags' [-Werror,-Wenum-conversion]
        dvs->gpio = devm_gpiod_get_optional(lp->dev, "ti,dvs", pinstate);
                    ~~~~~~~~~~~~~~~~~~~~~~~                    ^~~~~~~~
1 error generated.

lp872x_dvs_state was updated to have values from gpiod_flags but this is
not enough to avoid an implicit conversion warning from either GCC or
clang (although GCC enables this warning under -Wextra instead of -Wall
like clang so it is not seen under normal builds).

Eliminate lp872x_dvs_state in favor of using gpiod_flags everywhere so
that there is no more warning about an implicit conversion.

Fixes: 72bf80cf09c4 ("regulator: lp872x: replacing legacy gpio interface for gpiod")
Link: https://github.com/ClangBuiltLinux/linux/issues/1481
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/regulator/lp872x.c       | 14 +++++++-------
 include/linux/regulator/lp872x.h |  7 +------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 1dba5dbcd461..35d826fe9def 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -103,7 +103,7 @@ struct lp872x {
 	enum lp872x_id chipid;
 	struct lp872x_platform_data *pdata;
 	int num_regulators;
-	enum lp872x_dvs_state dvs_pin;
+	enum gpiod_flags dvs_pin;
 };
 
 /* LP8720/LP8725 shared voltage table for LDOs */
@@ -251,9 +251,9 @@ static int lp872x_regulator_enable_time(struct regulator_dev *rdev)
 static void lp872x_set_dvs(struct lp872x *lp, enum lp872x_dvs_sel dvs_sel,
 			struct gpio_desc *gpio)
 {
-	enum lp872x_dvs_state state;
+	enum gpiod_flags state;
 
-	state = dvs_sel == SEL_V1 ? DVS_HIGH : DVS_LOW;
+	state = dvs_sel == SEL_V1 ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 	gpiod_set_value(gpio, state);
 	lp->dvs_pin = state;
 }
@@ -269,7 +269,7 @@ static u8 lp872x_select_buck_vout_addr(struct lp872x *lp,
 	switch (buck) {
 	case LP8720_ID_BUCK:
 		if (val & LP8720_EXT_DVS_M) {
-			addr = (lp->dvs_pin == DVS_HIGH) ?
+			addr = (lp->dvs_pin == GPIOD_OUT_HIGH) ?
 				LP8720_BUCK_VOUT1 : LP8720_BUCK_VOUT2;
 		} else {
 			if (lp872x_read_byte(lp, LP8720_ENABLE, &val))
@@ -283,7 +283,7 @@ static u8 lp872x_select_buck_vout_addr(struct lp872x *lp,
 		if (val & LP8725_DVS1_M)
 			addr = LP8725_BUCK1_VOUT1;
 		else
-			addr = (lp->dvs_pin == DVS_HIGH) ?
+			addr = (lp->dvs_pin == GPIOD_OUT_HIGH) ?
 				LP8725_BUCK1_VOUT1 : LP8725_BUCK1_VOUT2;
 		break;
 	case LP8725_ID_BUCK2:
@@ -675,7 +675,7 @@ static const struct regulator_desc lp8725_regulator_desc[] = {
 static int lp872x_init_dvs(struct lp872x *lp)
 {
 	struct lp872x_dvs *dvs = lp->pdata ? lp->pdata->dvs : NULL;
-	enum lp872x_dvs_state pinstate;
+	enum gpiod_flags pinstate;
 	u8 mask[] = { LP8720_EXT_DVS_M, LP8725_DVS1_M | LP8725_DVS2_M };
 	u8 default_dvs_mode[] = { LP8720_DEFAULT_DVS, LP8725_DEFAULT_DVS };
 
@@ -841,7 +841,7 @@ static struct lp872x_platform_data
 
 	of_property_read_u8(np, "ti,dvs-vsel", (u8 *)&pdata->dvs->vsel);
 	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
-	pdata->dvs->init_state = dvs_state ? DVS_HIGH : DVS_LOW;
+	pdata->dvs->init_state = dvs_state ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
 	if (of_get_child_count(np) == 0)
 		goto out;
diff --git a/include/linux/regulator/lp872x.h b/include/linux/regulator/lp872x.h
index 8e7e0343c6e1..b62e45aa1dd3 100644
--- a/include/linux/regulator/lp872x.h
+++ b/include/linux/regulator/lp872x.h
@@ -40,11 +40,6 @@ enum lp872x_regulator_id {
 	LP872X_ID_MAX,
 };
 
-enum lp872x_dvs_state {
-	DVS_LOW  = GPIOD_OUT_LOW,
-	DVS_HIGH = GPIOD_OUT_HIGH,
-};
-
 enum lp872x_dvs_sel {
 	SEL_V1,
 	SEL_V2,
@@ -59,7 +54,7 @@ enum lp872x_dvs_sel {
 struct lp872x_dvs {
 	struct gpio_desc *gpio;
 	enum lp872x_dvs_sel vsel;
-	enum lp872x_dvs_state init_state;
+	enum gpiod_flags init_state;
 };
 
 /**

base-commit: 72bf80cf09c4693780ad93a31b48fa5a4e17a946
-- 
2.33.1.637.gf443b226ca

