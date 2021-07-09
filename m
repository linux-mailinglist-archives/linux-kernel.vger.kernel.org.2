Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625E53C1D19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 03:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhGIBdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 21:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhGIBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 21:33:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61483C061765
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 18:30:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q4so5340546ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 18:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89M3kJH8Z+ezz3X5xX4Jb+p6yEZY6o3ZbKwB3aRtLuw=;
        b=yoiW7ZFuSlfNOroLD2nvWqab6XWApbxovd9lF6axBaihMwQRpP5yZvXh1v5FrYjkfu
         t/EeMmokjrecX5fojZ6cQK1C3ZMr/TpiyNMvsv2M5yEC1xgBnmA3/i7u/2OK+uS6lxDy
         RiMuy8bhw22etISLo/TvxZmR2qNbjEhQ/urtbT0PAEzLFCYJkFAM9HTmRD/9QFo6yprM
         CGfwJhVLfDEMgc/WBrtKE2t4lza23imUcUn5ryHko2+KrT5brI4Gd9nRPKGAtxE6WExW
         g7jnsvWz1Tqe+Ewn0oMyTS/IbqX6jsOg8MBHLAIwIcMNEgjUloPNs8UTReO6ee/8IYhh
         ByHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89M3kJH8Z+ezz3X5xX4Jb+p6yEZY6o3ZbKwB3aRtLuw=;
        b=ZgA29A+fTUYehWlOOsO3ZA8USM1v+eVyacJM4vS2OF6vyjgFbwrRteNefZ9UByLvx1
         5lq67rap/OuJH7BrvTGZePDl9bscfcfVZtwG1USgWZ0gKMORf8LZiz7LAk5qBPGfRxDm
         nZ0tXgMoHi7e7O/3FbGDkgp7+bvgkR3PsE6QuABv/ZtigC6FSIZ0kQ9RlbXjbHs9B6Tj
         I+aG0A+zTCi3f7Uq4+cTQWLE1MDeGdEImybYVFF5otbiGUKvqHaPI+Urq8uYygmccqmr
         +fvvXdmtpBKu8tMDJ4EP/emhJA4eIdQEYz/nZuXA5NMowUiAf3UlHiV13+Bd+rynheji
         Jp2w==
X-Gm-Message-State: AOAM531gon79AOdG9bSQJFJHBB5/de4BcaBbkT+Mp7lHH84QHfSZws1x
        +wprkd0JdhpFn50+ViHMPMfDzw==
X-Google-Smtp-Source: ABdhPJzXXUETOMzQ3cJvd4xc+brSmZp2RHVeNURZ3nwD9/LEPByiDCUB1Xg17f/TFg7PhGPsTi5nWg==
X-Received: by 2002:a2e:7302:: with SMTP id o2mr18519317ljc.245.1625794250704;
        Thu, 08 Jul 2021 18:30:50 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u16sm405637ljj.113.2021.07.08.18.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 18:30:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] clk: qcom: gdsc: enable optional power domain support
Date:   Fri,  9 Jul 2021 04:30:40 +0300
Message-Id: <20210709013043.495233-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709013043.495233-1-dmitry.baryshkov@linaro.org>
References: <20210709013043.495233-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sm8250 dispcc and videocc registers are powered up by the MMCX power
domain. Currently we used a regulator to enable this domain on demand,
however this has some consequences, as genpd code is not reentrant.

Teach Qualcomm clock controller code about setting up power domains and
using them for gdsc control.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/common.c | 37 +++++++++++++++++++++++++++++++------
 drivers/clk/qcom/gdsc.c   |  5 +++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 60d2a78d1395..43d8f8feeb3c 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/reset-controller.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 
 #include "common.h"
 #include "clk-rcg.h"
@@ -224,6 +225,11 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
 }
 
+static void qcom_cc_pm_runtime_disable(void *data)
+{
+	pm_runtime_disable(data);
+}
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -241,6 +247,18 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	if (!cc)
 		return -ENOMEM;
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put(dev);
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, qcom_cc_pm_runtime_disable, dev);
+	if (ret)
+		goto err;
+
 	reset = &cc->reset;
 	reset->rcdev.of_node = dev->of_node;
 	reset->rcdev.ops = &qcom_reset_ops;
@@ -251,7 +269,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
 	ret = devm_reset_controller_register(dev, &reset->rcdev);
 	if (ret)
-		return ret;
+		goto err;
 
 	if (desc->gdscs && desc->num_gdscs) {
 		scd = devm_kzalloc(dev, sizeof(*scd), GFP_KERNEL);
@@ -262,11 +280,11 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 		scd->num = desc->num_gdscs;
 		ret = gdsc_register(scd, &reset->rcdev, regmap);
 		if (ret)
-			return ret;
+			goto err;
 		ret = devm_add_action_or_reset(dev, qcom_cc_gdsc_unregister,
 					       scd);
 		if (ret)
-			return ret;
+			goto err;
 	}
 
 	cc->rclks = rclks;
@@ -277,7 +295,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	for (i = 0; i < num_clk_hws; i++) {
 		ret = devm_clk_hw_register(dev, clk_hws[i]);
 		if (ret)
-			return ret;
+			goto err;
 	}
 
 	for (i = 0; i < num_clks; i++) {
@@ -286,14 +304,21 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
 		ret = devm_clk_register_regmap(dev, rclks[i]);
 		if (ret)
-			return ret;
+			goto err;
 	}
 
 	ret = devm_of_clk_add_hw_provider(dev, qcom_cc_clk_hw_get, cc);
 	if (ret)
-		return ret;
+		goto err;
+
+	pm_runtime_put(dev);
 
 	return 0;
+
+err:
+	pm_runtime_put(dev);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
 
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 51ed640e527b..9401d01533c8 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -427,6 +427,7 @@ int gdsc_register(struct gdsc_desc *desc,
 			continue;
 		scs[i]->regmap = regmap;
 		scs[i]->rcdev = rcdev;
+		scs[i]->pd.dev.parent = desc->dev;
 		ret = gdsc_init(scs[i]);
 		if (ret)
 			return ret;
@@ -439,6 +440,8 @@ int gdsc_register(struct gdsc_desc *desc,
 			continue;
 		if (scs[i]->parent)
 			pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
+		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+			pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
 	}
 
 	return of_genpd_add_provider_onecell(dev->of_node, data);
@@ -457,6 +460,8 @@ void gdsc_unregister(struct gdsc_desc *desc)
 			continue;
 		if (scs[i]->parent)
 			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
+		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
 	}
 	of_genpd_del_provider(dev->of_node);
 }
-- 
2.30.2

