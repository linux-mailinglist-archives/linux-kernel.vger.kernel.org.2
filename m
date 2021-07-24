Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335CB3D4712
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 12:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhGXJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 05:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235164AbhGXJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:42:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 589BF60D07;
        Sat, 24 Jul 2021 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627122165;
        bh=xrzdaky1jXwZzHuj3uvir0PDOvFShyxwGIbATejD61U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TP/22rBmS5qt0gkT+VQItc0LQ42UIDPU6NgBUvc3oFR2r3fDcCvRfB+1gPVGRutkG
         AJ8MG8r9N3FFcJmp5AE8ksZBAp3rePPQX0M+ZldvOaE738t4O3ZLSIuBH+2l/4giA7
         cnyot6Mgq2w+UrcCC2CwsRGSLOMF1Hbv0CLRkwXtpZxt10orSwLIZCBDQvu8E5WNVN
         HEkUz6h1E4CeR229dluOHjEbbZLHm5oKtFPevMvDf5nyn1E923DSUuFiJl2fk3Hd7Y
         k2wiMaNvCW6M0oPWVY4WqZxEss0C+n+FxeI47hu3DQkTVPVgXh3/Dh22/IMILsOhWG
         rHyVZOwUG5DDg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m7Enr-00BJmw-1x; Sat, 24 Jul 2021 12:22:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] regulator: hi6421v600: use lowercase for ldo
Date:   Sat, 24 Jul 2021 12:22:41 +0200
Message-Id: <395510cffeb39aebd1763cc5de1cb00a2c40e461.1627121912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627121912.git.mchehab+huawei@kernel.org>
References: <cover.1627121912.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As lowercase is generally preferred for node names, while it is
not too late, change the LDO DT properties to lower case.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 23cdf90944e9..f71e7661b6d7 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -73,14 +73,14 @@ static const unsigned int ldo34_voltages[] = {
  */
 #define HI6421V600_LDO(_id, vtable, ereg, emask, vreg,			       \
 		       odelay, etime, ecomask, ecoamp)			       \
-	[HI6421V600_##_id] = {						       \
+	[hi6421v600_##_id] = {						       \
 		.desc = {						       \
 			.name		= #_id,				       \
 			.of_match        = of_match_ptr(#_id),		       \
 			.regulators_node = of_match_ptr("regulators"),	       \
 			.ops		= &hi6421_spmi_ldo_rops,	       \
 			.type		= REGULATOR_VOLTAGE,		       \
-			.id		= HI6421V600_##_id,		       \
+			.id		= hi6421v600_##_id,		       \
 			.owner		= THIS_MODULE,			       \
 			.volt_table	= vtable,			       \
 			.n_voltages	= ARRAY_SIZE(vtable),		       \
@@ -185,46 +185,46 @@ static const struct regulator_ops hi6421_spmi_ldo_rops = {
 
 /* HI6421v600 regulators with known registers */
 enum hi6421_spmi_regulator_id {
-	HI6421V600_LDO3,
-	HI6421V600_LDO4,
-	HI6421V600_LDO9,
-	HI6421V600_LDO15,
-	HI6421V600_LDO16,
-	HI6421V600_LDO17,
-	HI6421V600_LDO33,
-	HI6421V600_LDO34,
+	hi6421v600_ldo3,
+	hi6421v600_ldo4,
+	hi6421v600_ldo9,
+	hi6421v600_ldo15,
+	hi6421v600_ldo16,
+	hi6421v600_ldo17,
+	hi6421v600_ldo33,
+	hi6421v600_ldo34,
 };
 
 static struct hi6421_spmi_reg_info regulator_info[] = {
-	HI6421V600_LDO(LDO3, ldo3_voltages,
+	HI6421V600_LDO(ldo3, ldo3_voltages,
 		       0x16, 0x01, 0x51,
 		       20000, 120,
 		       0, 0),
-	HI6421V600_LDO(LDO4, ldo4_voltages,
+	HI6421V600_LDO(ldo4, ldo4_voltages,
 		       0x17, 0x01, 0x52,
 		       20000, 120,
 		       0x10, 10000),
-	HI6421V600_LDO(LDO9, ldo9_voltages,
+	HI6421V600_LDO(ldo9, ldo9_voltages,
 		       0x1c, 0x01, 0x57,
 		       20000, 360,
 		       0x10, 10000),
-	HI6421V600_LDO(LDO15, ldo15_voltages,
+	HI6421V600_LDO(ldo15, ldo15_voltages,
 		       0x21, 0x01, 0x5c,
 		       20000, 360,
 		       0x10, 10000),
-	HI6421V600_LDO(LDO16, ldo15_voltages,
+	HI6421V600_LDO(ldo16, ldo15_voltages,
 		       0x22, 0x01, 0x5d,
 		       20000, 360,
 		       0x10, 10000),
-	HI6421V600_LDO(LDO17, ldo17_voltages,
+	HI6421V600_LDO(ldo17, ldo17_voltages,
 		       0x23, 0x01, 0x5e,
 		       20000, 120,
 		       0x10, 10000),
-	HI6421V600_LDO(LDO33, ldo17_voltages,
+	HI6421V600_LDO(ldo33, ldo17_voltages,
 		       0x32, 0x01, 0x6d,
 		       20000, 120,
 		       0, 0),
-	HI6421V600_LDO(LDO34, ldo34_voltages,
+	HI6421V600_LDO(ldo34, ldo34_voltages,
 		       0x33, 0x01, 0x6e,
 		       20000, 120,
 		       0, 0),
-- 
2.31.1

