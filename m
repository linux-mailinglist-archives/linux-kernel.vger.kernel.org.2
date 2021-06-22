Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832153B050D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhFVMrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFVMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:47:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22170C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:45:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c5so3672263pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hh+0HwIuJla9qurMm0TA5UWDdrteWeuId7ejGIiRXrk=;
        b=Pp7ukjnpmKmoovuKkJNuHQQ0zXfDG7gV4e5uhXQLLIo9ayc2QYmJJzNjf1ARwz9sYl
         0Wz9IH8egumOny/QiJ7tHIVCeFLxsB3M1/Ucv7LuFUd4AbaZo92U7qpiZeOWEqyfZh7Z
         4LRBYBYVDfq8fBrFkJ1AiEEIplujxbI0jtKHrg7ZViGHIB65HxyH3rgqm7SzZGPvDHPV
         s6SSoEo9iDza1ljdONiQbR92eXtqWdczWmg577ssbo7AK/CRixaDKElHDeY6qxEm7ZEE
         Hqx+Tj6byzoQMryczsMTT0/+OhFODXVHfMj4PuTRB6KABSjSyyZ/jStoHugcP3UNZB3s
         6vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hh+0HwIuJla9qurMm0TA5UWDdrteWeuId7ejGIiRXrk=;
        b=b5ND7LzgRW2A3VH6YDev/y0w3536ZZehOZM8Vz0RKspGQPP0ELNAOdcBN+jfJGy5Z6
         CBDu0MA2d/CxkUqtC6bVdMxGbDevLlT/Waywg7aHgFARbbmzTBiSHglktaIyaIopdffC
         pXQAWKRi2SXjB67RJkmAG/qBUeEj7ODv0bQXzviD8vSFfOwzj7KgjNjz9O/6qFJCzC1o
         CSs1VYZbVRWkTOxLITtWJiWe8m6WECeWtgPIUFseQgPlQdTyIQO/LPa8Qdyzf1fKGjRt
         WtRRFn33Mjnhjkc42wFiHPZ5yQiuVs0zI+TIggH1oDbO6iBIWJlxM5G/+6K4nQLgqfAE
         4f3g==
X-Gm-Message-State: AOAM533hocvt9Kmxk6h/q7CIij1uFZENMicDSiDLLDHKXNB3vnwxEBWp
        ykJlMbSrsDfYWZBTb60HYsU=
X-Google-Smtp-Source: ABdhPJz1aCWcGDiCCuK1uu+VR5m4NgehOxX1A5OMIW7tT7xK1VBmOXBGvs+gn/1C53fxNnMNxUlWcQ==
X-Received: by 2002:a62:2b95:0:b029:2ff:2040:4f1c with SMTP id r143-20020a622b950000b02902ff20404f1cmr3508751pfr.49.1624365927695;
        Tue, 22 Jun 2021 05:45:27 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id g3sm2393626pjl.17.2021.06.22.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:45:26 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id B5601902A9B;
        Tue, 22 Jun 2021 12:45:23 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH v3 2/2] regulator: da9063: Add support for full-current mode.
Date:   Tue, 22 Jun 2021 12:45:20 +0000
Message-Id: <91d2d1954575d6a5be980985512a1ef68551d533.1624365748.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <b04c90a1a1a489d980bf8c524288f71b8f0a6982.1624365748.git.plr.vincent@gmail.com>
References: <b04c90a1a1a489d980bf8c524288f71b8f0a6982.1624365748.git.plr.vincent@gmail.com>
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
V2 -> V3:
- ACTUALLY skip DA9063_ID_BCORES_MERGED_OD when not full-current, and
  vice-versa.
- head put in brown paper bag
V1 -> V2:
- skip DA9063_ID_BCORES_MERGED_OD when not full-current, and vice-versa
- cc linux-kernel ML
- fix subject prefix

 drivers/regulator/da9063-regulator.c | 73 ++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 21f4ddb37b09..efcd9ceedd26 100644
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
@@ -742,7 +790,9 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 		/* Skip regulator IDs depending on merge mode configuration */
 		switch (id) {
 		case DA9063_ID_BCORE1:
+		case DA9063_ID_BCORE1_OD:
 		case DA9063_ID_BCORE2:
+		case DA9063_ID_BCORE2_OD:
 			if (bcores_merged) {
 				id++;
 				continue;
@@ -756,6 +806,7 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 			}
 			break;
 		case DA9063_ID_BCORES_MERGED:
+		case DA9063_ID_BCORES_MERGED_OD:
 			if (!bcores_merged) {
 				id++;
 				continue;
@@ -768,6 +819,20 @@ static int da9063_regulator_probe(struct platform_device *pdev)
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

