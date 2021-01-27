Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D37305820
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhA0KTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhA0KRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:17:07 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D580AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:16:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id jx18so1054836pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qD/+ILMyGECjEd3sRp/n8SMb4ogY29j6AgT3rjADA+4=;
        b=KzcHxGOyDvWv4raQ3TTACVbnQg+7SPcSMZMDZKyI1t4yt/ZEq79MSdoQ4FirvBlWHV
         RgrJoAFGWCY/oKFny5UUtAt6zrxq4ICeG2kkPqpCxX+5lrnmGJoe3R3Vuv0KGv2sZf+h
         RLhzyT0o8TVLryscaSC9gstDup3jotDm5dSR6npnCDOTlJvQuW39QUB40/FHUxfNz723
         0I5FiJnR3f48PdfWODCnE4jnPzaSEmiBu4D6PI9BEgxHwxW+20k7d3iiPYVigJob8mv5
         WMrtmcth7rBOQZhdyvr0fdG1bEkqZegU+1SnfqAU5G1EoxbuHuAe+JDjaqK00MlR4xB0
         Fvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qD/+ILMyGECjEd3sRp/n8SMb4ogY29j6AgT3rjADA+4=;
        b=PWPseGJ9c1yulf5oFuSdfBXl/wWE8eTVrPWDyceIPHb3FZS78KMEU683PdQlOH5inX
         I0Vxoq8E75K9pScJ7tgWKU29diI1dU8AXqymU6ctL54iSAgDtIBJ4gCRRAm8qUCv2ix/
         sgrzfojFzZ6MN8f/Knn4DqtPTAv6famR2GddyHjgdHiu0vEQjsIpXU8IMsTTm9TyP1gN
         4sX0NsOjT6ulcxHzcIPWbxp8bl1EZVPPztYMfdo/EwZ990ynrTxfJD0KJlirg3VgE6BP
         T/UpfTGP4NsqVWMvxSm88ekWByDdzcCSGAUExM0+Tu7c52fZeD2vUuYy+usiK81peirC
         uxrw==
X-Gm-Message-State: AOAM5314e3IA+0D0ikPRY8q8Zuif37VAnOVgekAKR5lx4E4HLZPS3waI
        Fi/u6Zfw8jF1T89p51rePXZU7w==
X-Google-Smtp-Source: ABdhPJxGsXfWTcttw7F47U9+G1CN8zo2akW3kfzmjmdHuEvkqOWGsx6ypxG0VFxZ5L4f+lx+aK1FWQ==
X-Received: by 2002:a17:90b:4c0b:: with SMTP id na11mr4764827pjb.45.1611742586379;
        Wed, 27 Jan 2021 02:16:26 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id s21sm1768166pga.12.2021.01.27.02.16.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 02:16:25 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] memory: tegra: Remove calls to dev_pm_opp_set_clkname()
Date:   Wed, 27 Jan 2021 15:46:22 +0530
Message-Id: <0f22cc1791d8b88c50a9790c2dc19455b34ec7b0.1611742564.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point calling dev_pm_opp_set_clkname() with the "name"
parameter set to NULL, this is already done by the OPP core at setup
time and should work as it is.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2: Update tegra124 as well.

Krzysztof, please take this through your tree, it doesn't have any
dependency in the OPP tree.
---
 drivers/memory/tegra/tegra124-emc.c | 13 ++-----------
 drivers/memory/tegra/tegra20-emc.c  | 13 ++-----------
 drivers/memory/tegra/tegra30-emc.c  | 13 ++-----------
 3 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 9706550bdd5d..bee8d9f79b04 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1399,21 +1399,14 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
-	struct opp_table *clk_opp_table, *hw_opp_table;
+	struct opp_table *hw_opp_table;
 	int err;
 
-	clk_opp_table = dev_pm_opp_set_clkname(emc->dev, NULL);
-	err = PTR_ERR_OR_ZERO(clk_opp_table);
-	if (err) {
-		dev_err(emc->dev, "failed to set OPP clk: %d\n", err);
-		return err;
-	}
-
 	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
 	err = PTR_ERR_OR_ZERO(hw_opp_table);
 	if (err) {
 		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
-		goto put_clk_table;
+		return err;
 	}
 
 	err = dev_pm_opp_of_add_table(emc->dev);
@@ -1442,8 +1435,6 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 	dev_pm_opp_of_remove_table(emc->dev);
 put_hw_table:
 	dev_pm_opp_put_supported_hw(hw_opp_table);
-put_clk_table:
-	dev_pm_opp_put_clkname(clk_opp_table);
 
 	return err;
 }
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 686aaf477d8a..d653a6be8d7f 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -911,21 +911,14 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_process_id);
-	struct opp_table *clk_opp_table, *hw_opp_table;
+	struct opp_table *hw_opp_table;
 	int err;
 
-	clk_opp_table = dev_pm_opp_set_clkname(emc->dev, NULL);
-	err = PTR_ERR_OR_ZERO(clk_opp_table);
-	if (err) {
-		dev_err(emc->dev, "failed to set OPP clk: %d\n", err);
-		return err;
-	}
-
 	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
 	err = PTR_ERR_OR_ZERO(hw_opp_table);
 	if (err) {
 		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
-		goto put_clk_table;
+		return err;
 	}
 
 	err = dev_pm_opp_of_add_table(emc->dev);
@@ -954,8 +947,6 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 	dev_pm_opp_of_remove_table(emc->dev);
 put_hw_table:
 	dev_pm_opp_put_supported_hw(hw_opp_table);
-put_clk_table:
-	dev_pm_opp_put_clkname(clk_opp_table);
 
 	return err;
 }
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 44ac155936aa..6985da0ffb35 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1483,21 +1483,14 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
-	struct opp_table *clk_opp_table, *hw_opp_table;
+	struct opp_table *hw_opp_table;
 	int err;
 
-	clk_opp_table = dev_pm_opp_set_clkname(emc->dev, NULL);
-	err = PTR_ERR_OR_ZERO(clk_opp_table);
-	if (err) {
-		dev_err(emc->dev, "failed to set OPP clk: %d\n", err);
-		return err;
-	}
-
 	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
 	err = PTR_ERR_OR_ZERO(hw_opp_table);
 	if (err) {
 		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
-		goto put_clk_table;
+		return err;
 	}
 
 	err = dev_pm_opp_of_add_table(emc->dev);
@@ -1526,8 +1519,6 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 	dev_pm_opp_of_remove_table(emc->dev);
 put_hw_table:
 	dev_pm_opp_put_supported_hw(hw_opp_table);
-put_clk_table:
-	dev_pm_opp_put_clkname(clk_opp_table);
 
 	return err;
 }
-- 
2.25.0.rc1.19.g042ed3e048af

