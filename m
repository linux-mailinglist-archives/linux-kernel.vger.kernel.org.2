Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D642933907E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhCLO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhCLO4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C74A664FF5;
        Fri, 12 Mar 2021 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560972;
        bh=e6aLLo9i99t687jAHqhOEFnsHr18eT8QCSrvSWuados=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUhJxiZeYkiZg60n/mwk/bIMEUsg5shOlU6VNI2OH3Tj8GuivdojXazw7yLkoONxl
         haNcALVeBW/iCIlsBPtrO7bG3ioNhfb4Y4xhZZdqgsVsNgYjyVt/WYN26pUs+S+pOP
         LIZfrTdZPuJV6ykrDyZRcwpYLaOiTcLlV5ZQ40kzLtNvyANbc9en63zCd6ah1HsCS1
         rt+9Y+V7yHt3oKZOmZZ6g1KmPVNC/23tgbT7s+J8UeKkNP7VC82RoDHZUQTLNPwixz
         3R0FfFJcf9KJKLL3jT10W5UtkcF4zHP8plIv49sivvZ2r/gd3rGB0TZGJQ/6QJE5tQ
         4+YwXI9ZrL4Lw==
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 4/7] regulator: mediatek: Add regulators_node to description
Date:   Fri, 12 Mar 2021 15:55:42 +0100
Message-Id: <20210312145545.26050-4-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312145545.26050-1-matthias.bgg@kernel.org>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Define the regulator node under which the regulators are described.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/regulator/mt6323-regulator.c |  3 +++
 drivers/regulator/mt6358-regulator.c |  4 ++++
 drivers/regulator/mt6397-regulator.c | 10 +++-------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index ff9016170db37..8b22ded43ab8a 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -42,6 +42,7 @@ struct mt6323_regulator_info {
 	.desc = {							\
 		.name = #vreg,						\
 		.of_match = of_match_ptr(match),			\
+		.regulators_node = of_match_ptr("mt6323regulator"),	\
 		.ops = &mt6323_volt_range_ops,				\
 		.type = REGULATOR_VOLTAGE,				\
 		.id = MT6323_ID_##vreg,					\
@@ -66,6 +67,7 @@ struct mt6323_regulator_info {
 	.desc = {							\
 		.name = #vreg,						\
 		.of_match = of_match_ptr(match),			\
+		.regulators_node = of_match_ptr("mt6323regulator"),	\
 		.ops = &mt6323_volt_table_ops,				\
 		.type = REGULATOR_VOLTAGE,				\
 		.id = MT6323_ID_##vreg,					\
@@ -88,6 +90,7 @@ struct mt6323_regulator_info {
 	.desc = {							\
 		.name = #vreg,						\
 		.of_match = of_match_ptr(match),			\
+		.regulators_node = of_match_ptr("mt6323regulator"),	\
 		.ops = &mt6323_volt_fixed_ops,				\
 		.type = REGULATOR_VOLTAGE,				\
 		.id = MT6323_ID_##vreg,					\
diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 13cb6ac9a8929..f5c478d7baaf2 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -44,6 +44,7 @@ struct mt6358_regulator_info {
 	.desc = {	\
 		.name = #vreg,	\
 		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("mt6358regulator"),	\
 		.ops = &mt6358_volt_range_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,		\
@@ -74,6 +75,7 @@ struct mt6358_regulator_info {
 	.desc = {	\
 		.name = #vreg,	\
 		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("mt6358regulator"),	\
 		.ops = &mt6358_volt_table_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,	\
@@ -99,6 +101,7 @@ struct mt6358_regulator_info {
 	.desc = {	\
 		.name = #vreg,	\
 		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("mt6358regulator"),	\
 		.ops = &mt6358_volt_range_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,	\
@@ -124,6 +127,7 @@ struct mt6358_regulator_info {
 	.desc = {	\
 		.name = #vreg,	\
 		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("mt6358regulator"),	\
 		.ops = &mt6358_volt_fixed_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,	\
diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 0a30df5e414fc..9e8589f773eaa 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -42,6 +42,7 @@ struct mt6397_regulator_info {
 	.desc = {							\
 		.name = #vreg,						\
 		.of_match = of_match_ptr(match),			\
+		.regulators_node = of_match_ptr("mt6397regulator"),	\
 		.ops = &mt6397_volt_range_ops,				\
 		.type = REGULATOR_VOLTAGE,				\
 		.id = MT6397_ID_##vreg,					\
@@ -70,6 +71,7 @@ struct mt6397_regulator_info {
 	.desc = {							\
 		.name = #vreg,						\
 		.of_match = of_match_ptr(match),			\
+		.regulators_node = of_match_ptr("mt6397regulator"),	\
 		.ops = &mt6397_volt_table_ops,				\
 		.type = REGULATOR_VOLTAGE,				\
 		.id = MT6397_ID_##vreg,					\
@@ -89,6 +91,7 @@ struct mt6397_regulator_info {
 	.desc = {							\
 		.name = #vreg,						\
 		.of_match = of_match_ptr(match),			\
+		.regulators_node = of_match_ptr("mt6397regulator"),	\
 		.ops = &mt6397_volt_fixed_ops,				\
 		.type = REGULATOR_VOLTAGE,				\
 		.id = MT6397_ID_##vreg,					\
@@ -396,16 +399,9 @@ static const struct platform_device_id mt6397_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, mt6397_platform_ids);
 
-static const struct of_device_id mt6397_of_match[] = {
-	{ .compatible = "mediatek,mt6397-regulator", },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, mt6397_of_match);
-
 static struct platform_driver mt6397_regulator_driver = {
 	.driver = {
 		.name = "mt6397-regulator",
-		.of_match_table = of_match_ptr(mt6397_of_match),
 	},
 	.probe = mt6397_regulator_probe,
 	.id_table = mt6397_platform_ids,
-- 
2.30.1

