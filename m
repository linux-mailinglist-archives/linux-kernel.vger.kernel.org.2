Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF93B0247
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhFVLGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhFVLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:06:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF8EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:04:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so2059272pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/JvZf7jTZBk8zsPbhxzWMuOv03TiJWX1A731dqbNvBU=;
        b=I1O3SL9rx0A4o4hW/vlGFwNh5x3ad8Kv6lZBx1U/P4w5s7JMVbSaHMUPGr4e78E9yy
         YGdu9B1Gi6ju4f7lDAoXXbVkdPzFlMSajZ367J/XMsJy4gpZVEy08QqisboU5xGJfZBJ
         /LzDbZeBf5PiiZiXmxutZE25oC9P+vaXSjvyHfIc5+2m1uhmVepjHa14TXqIfgvpwfVL
         JjaETKg/EZcsqLyNbJ+aS0Eea8xTB2Mf2tn7K9TU+oVSzQaDY7kauvjC8L2Y7mJQzP22
         VWZzl/X7W2DHREKRUnbfX9Pu2k657VvGAHwvP4kUWYpPi51dntBfYFg2Ze6q735c/EaZ
         bXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JvZf7jTZBk8zsPbhxzWMuOv03TiJWX1A731dqbNvBU=;
        b=DVvn2se33UlTXK/E+PkLB25KOdLH3JIjxRuqSF7pCvemig8aWDyGkGsC6qWHxQpyDR
         SlxXUFS7/Wm5+dneMXGdfPyYc5kF1lCUzy5FWSCeUqdnvsnpuuHASAPDs10i2SHKEZ5C
         74v2ieV9LtxF6vkTMhumYE1IdDBlFrPADO7AOGNfgot9qLB6HpSDod2XuzjPIAaKnBqO
         d4piJm26xK40Bz77fo5ij5KUm5jCj/ZApPlomzm/0AdKVGOKU2Jz3LH4lYE6CWE+F3hf
         cAkgwaM512BFwWWroPDE0Pvsm6N16YOdKZFXllnFAJCBDRqTV1286ES0U7MLw71i2Umy
         1eqg==
X-Gm-Message-State: AOAM531arSLmXoVhJVDJup7YvDDmJ1FbigXQMfjHv2HZ/O++aRiWWe39
        5KwbTjATENeeOZkRNCDGGNQ=
X-Google-Smtp-Source: ABdhPJyygRNpHjbGfiNg1fs0lwx3vh3I/tWK0zpe4yJTYR95HMs0KrmuVTEjGeOglGgoIkoR3QSHuw==
X-Received: by 2002:a17:902:8484:b029:101:7016:fb7b with SMTP id c4-20020a1709028484b02901017016fb7bmr22017440plo.23.1624359844071;
        Tue, 22 Jun 2021 04:04:04 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id o14sm19010043pgk.82.2021.06.22.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 04:04:03 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 9B38A902A9B;
        Tue, 22 Jun 2021 11:04:01 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH v2 2/2] regulator: da9063: Add support for full-current mode.
Date:   Tue, 22 Jun 2021 11:03:56 +0000
Message-Id: <43ed1ed9032d15077928bd04bec69d7b8ab46cb0.1624359253.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <b04c90a1a1a489d980bf8c524288f71b8f0a6982.1624359253.git.plr.vincent@gmail.com>
References: <b04c90a1a1a489d980bf8c524288f71b8f0a6982.1624359253.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the ability of merging some power outputs, this chip has
an overdrive/full-current mode.
BCORE1, BCORE2 and BPRO have this ability, in which case the legal
current draw is increased from 2 amps to 2.5 amps (at the expense of
a quiescent current increase), and the configurable current limits
are doubled.
So add configuration alternatives for these new combinations, with their
updated current limits.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
V1 -> V2:
- skip DA9063_ID_BCORES_MERGED_OD when not full-current, and vice-versa
- cc linux-kernel ML
- fix subject prefix

 drivers/regulator/da9063-regulator.c | 70 ++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 21f4ddb37b09..1193b2eb8c07 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -31,14 +31,19 @@
 enum {
 	/* BUCKs */
 	DA9063_ID_BCORE1,
+	DA9063_ID_BCORE1_OD,
 	DA9063_ID_BCORE2,
+	DA9063_ID_BCORE2_OD,
 	DA9063_ID_BPRO,
+	DA9063_ID_BPRO_OD,
 	DA9063_ID_BMEM,
 	DA9063_ID_BIO,
 	DA9063_ID_BPERI,
 
 	/* BCORE1 and BCORE2 in merged mode */
 	DA9063_ID_BCORES_MERGED,
+	/* BCORE1 and BCORE2 in merged and full-current mode */
+	DA9063_ID_BCORES_MERGED_OD,
 	/* BMEM and BIO in merged mode */
 	DA9063_ID_BMEM_BIO_MERGED,
 	/* When two BUCKs are merged, they cannot be reused separately */
@@ -186,7 +191,8 @@ static const unsigned int da9063_buck_b_limits[] = {
 };
 
 /*
- * Current limits array (in uA) for merged BCORE1 and BCORE2.
+ * Current limits array (in uA) for merged BCORE1 and BCORE2, or
+ * BCORE1, BCORE2, BPRO in fullcurrent mode.
  * Entry indexes corresponds to register values.
  */
 static const unsigned int da9063_bcores_merged_limits[] = {
@@ -203,6 +209,16 @@ static const unsigned int da9063_bmem_bio_merged_limits[] = {
 	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
 };
 
+/*
+ * Current limits array (in uA) for merged BCORE
+ * in full-current mode.
+ * Entry indexes corresponds to register values.
+ */
+static const unsigned int da9063_bcores_merged_fullcurrent_limits[] = {
+	2000000, 2400000, 2800000, 3200000, 3600000, 4000000, 4400000, 4800000,
+	5200000, 5600000, 6000000, 6400000, 6800000, 7200000, 7600000, 8000000
+};
+
 static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
@@ -454,18 +470,36 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
 	},
+	{
+		DA9063_BUCK(DA9063, BCORE1_OD, 300, 10, 1570,
+			    da9063_bcores_merged_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
+		DA9063_BUCK_COMMON_FIELDS(BCORE1),
+	},
 	{
 		DA9063_BUCK(DA9063, BCORE2, 300, 10, 1570,
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE2_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE2),
 	},
+	{
+		DA9063_BUCK(DA9063, BCORE2_OD, 300, 10, 1570,
+			    da9063_bcores_merged_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE2_ILIM_MASK),
+		DA9063_BUCK_COMMON_FIELDS(BCORE2),
+	},
 	{
 		DA9063_BUCK(DA9063, BPRO, 530, 10, 1800,
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_B, DA9063_BPRO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPRO),
 	},
+	{
+		DA9063_BUCK(DA9063, BPRO_OD, 530, 10, 1800,
+			    da9063_bcores_merged_limits,
+			    DA9063_REG_BUCK_ILIM_B, DA9063_BPRO_ILIM_MASK),
+		DA9063_BUCK_COMMON_FIELDS(BPRO),
+	},
 	{
 		DA9063_BUCK(DA9063, BMEM, 800, 20, 3340,
 			    da9063_buck_b_limits,
@@ -491,6 +525,13 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 		/* BCORES_MERGED uses the same register fields as BCORE1 */
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
 	},
+	{
+		DA9063_BUCK(DA9063, BCORES_MERGED_OD, 300, 10, 1570,
+			    da9063_bcores_merged_fullcurrent_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
+		/* BCORES_MERGED uses the same register fields as BCORE1 */
+		DA9063_BUCK_COMMON_FIELDS(BCORE1),
+	},
 	{
 		DA9063_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
 			    da9063_bmem_bio_merged_limits,
@@ -545,12 +586,12 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 static struct da9063_dev_model regulators_models[] = {
 	{
 		.regulator_info = da9063_regulator_info,
-		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
+		.n_regulators = ARRAY_SIZE(da9063_regulator_info) - 4,
 		.type = PMIC_TYPE_DA9063,
 	},
 	{
 		.regulator_info = da9063_regulator_info,
-		.n_regulators = ARRAY_SIZE(da9063_regulator_info) - 6,
+		.n_regulators = ARRAY_SIZE(da9063_regulator_info) - 4 - 6,
 		.type = PMIC_TYPE_DA9063L,
 	},
 	{ }
@@ -600,12 +641,16 @@ static const struct regulator_init_data *da9063_get_regulator_initdata(
 
 static struct of_regulator_match da9063_matches[] = {
 	[DA9063_ID_BCORE1]           = { .name = "bcore1"           },
+	[DA9063_ID_BCORE1_OD]        = { .name = "bcore1-od"        },
 	[DA9063_ID_BCORE2]           = { .name = "bcore2"           },
+	[DA9063_ID_BCORE2_OD]        = { .name = "bcore2-od"        },
 	[DA9063_ID_BPRO]             = { .name = "bpro",            },
+	[DA9063_ID_BPRO_OD]          = { .name = "bpro-od",         },
 	[DA9063_ID_BMEM]             = { .name = "bmem",            },
 	[DA9063_ID_BIO]              = { .name = "bio",             },
 	[DA9063_ID_BPERI]            = { .name = "bperi",           },
 	[DA9063_ID_BCORES_MERGED]    = { .name = "bcores-merged"    },
+	[DA9063_ID_BCORES_MERGED_OD] = { .name = "bcores-merged-od" },
 	[DA9063_ID_BMEM_BIO_MERGED]  = { .name = "bmem-bio-merged", },
 	[DA9063_ID_LDO3]             = { .name = "ldo3",            },
 	[DA9063_ID_LDO7]             = { .name = "ldo7",            },
@@ -685,7 +730,7 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 	struct da9063_regulators *regulators;
 	struct da9063_regulator *regl;
 	struct regulator_config config;
-	bool bcores_merged, bmem_bio_merged;
+	bool bcores_merged, bmem_bio_merged, bcore1_od, bcore2_od, bpro_od;
 	int id, irq, n, n_regulators, ret, val;
 
 	regl_pdata = da9063_parse_regulators_dt(pdev, &da9063_reg_matches);
@@ -714,6 +759,9 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 		return ret;
 	}
 	bcores_merged = val & DA9063_BCORE_MERGE;
+	bpro_od = val & DA9063_BPRO_OD;
+	bcore2_od = val & DA9063_BCORE2_OD;
+	bcore1_od = val & DA9063_BCORE1_OD;
 	bmem_bio_merged = val & DA9063_BUCK_MERGE;
 
 	n_regulators = model->n_regulators;
@@ -768,6 +816,20 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 			}
 			break;
 		}
+		if (
+			(id == DA9063_ID_BCORE1    &&  bcore1_od) ||
+			(id == DA9063_ID_BCORE1_OD && !bcore1_od) ||
+			/* BCORES_MERGED uses the same fullcurrent bit as BCORE1 */
+			(id == DA9063_ID_BCORES_MERGED    &&  bcore1_od) ||
+			(id == DA9063_ID_BCORES_MERGED_OD && !bcore1_od) ||
+			(id == DA9063_ID_BCORE2    &&  bcore2_od) ||
+			(id == DA9063_ID_BCORE2_OD && !bcore2_od) ||
+			(id == DA9063_ID_BPRO    &&  bpro_od) ||
+			(id == DA9063_ID_BPRO_OD && !bpro_od)
+		) {
+			id++;
+			continue;
+		}
 
 		/* Initialise regulator structure */
 		regl = &regulators->regulator[n];
-- 
2.32.0

