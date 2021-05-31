Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761033954A5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhEaEhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 00:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhEaEgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 00:36:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6CBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 21:35:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u7so4587950plq.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 21:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHs8c9vGdjXi2giuywOaumDo2EmlRLA/sn7ZfRaihIo=;
        b=ZjaTTsW7dChI/1TWMdqo+HJVQgeE4uuo5w5gyenkQ3Ftwqh1OzRaAUqWB6964K/nNT
         AfeIGJmPE+rEujTOE+nn8NIAHBn8pUCDOM0LtqyT7hXmVgpHjPtLul19Y2wGrk5dNztp
         XV/o7yASeg5tXM5SjNTFm+P5kpidpK79TJk+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHs8c9vGdjXi2giuywOaumDo2EmlRLA/sn7ZfRaihIo=;
        b=dpKBXNAB0WNp50QM7TLnIWwA7eK4QJG7vnS5cOeZpc2oQM0XWJiCxPpGZEC2OJDVe8
         KghOFyK0rTn6DEDEW78+ZOcElFgCZNELxojkeJJEDSS3ie3eY4x9cYT7gorDSJuLDcnU
         /Ope4xXBZtKJml35mSc6RQWcyBTFkir3MUZ2W+GB8XZBtk+HMhKvj4PRzF7XBpnyWxbX
         2nD1GFx80DeRAk8TNJnahxWB7ycQmspK9wAAAuo140WiZpe23ak08UISykIAbXhOAy29
         m1eFS49rYHuRRbXmfkZibB7d8aJ00WCwxT/RF7KZz4wOPKg+Zu056xLfr6t7Av/XW0J4
         6/SQ==
X-Gm-Message-State: AOAM533chS6Z9Drnn9tk358ckAsa6cLgyvOkHSPIIGrfs2RgW1nokDSr
        pZvfPUQDer4xDtPNeYikyvOtng==
X-Google-Smtp-Source: ABdhPJxxgSMWMTn772k1ysuWnGkE1QOeHgmac5qTvTSd6ojr5RCWo9CeIZwcl08Tbiyh7nLDB3cKVQ==
X-Received: by 2002:a17:90a:5d93:: with SMTP id t19mr17272027pji.116.1622435706373;
        Sun, 30 May 2021 21:35:06 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c929:9e58:1e99:bfb5])
        by smtp.gmail.com with ESMTPSA id a9sm9366811pfo.69.2021.05.30.21.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:35:06 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH 1/3] soc: mtk-pm-domains: Fix the clock prepared issue
Date:   Mon, 31 May 2021 12:35:00 +0800
Message-Id: <20210531043502.2702645-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

In this new power domain driver, when adding one power domain
it will prepare the depenedent clocks at the same.
So we only do clk_bulk_enable/disable control during power ON/OFF.
When system suspend, the pm runtime framework will forcely power off
power domains. However, the dependent clocks are disabled but kept
preapred.

In MediaTek clock drivers, PLL would be turned ON when we do
clk_bulk_prepare control.

Clock hierarchy:
PLL -->
       DIV_CK -->
                 CLK_MUX
                 (may be dependent clocks)
                         -->
                             SUBSYS_CG
                             (may be dependent clocks)

It will lead some unexpected clock states during system suspend.
This patch will fix by doing prepare_enable/disable_unprepare on
dependent clocks at the same time while we are going to power on/off
any power domain.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/soc/mediatek/mtk-pm-domains.c | 31 +++++++--------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 0af00efa0ef8..536d8c64b2b4 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -211,7 +211,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_enable(pd->num_clks, pd->clks);
+	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
 	if (ret)
 		goto err_reg;
 
@@ -229,7 +229,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
-	ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
+	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
 	if (ret)
 		goto err_pwr_ack;
 
@@ -246,9 +246,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 err_disable_sram:
 	scpsys_sram_disable(pd);
 err_disable_subsys_clks:
-	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 err_pwr_ack:
-	clk_bulk_disable(pd->num_clks, pd->clks);
+	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 err_reg:
 	scpsys_regulator_disable(pd->supply);
 	return ret;
@@ -269,7 +269,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
-	clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
+	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 
 	/* subsys power off */
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
@@ -284,7 +284,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
-	clk_bulk_disable(pd->num_clks, pd->clks);
+	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 
 	scpsys_regulator_disable(pd->supply);
 
@@ -405,14 +405,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		pd->subsys_clks[i].clk = clk;
 	}
 
-	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
-	if (ret)
-		goto err_put_subsys_clocks;
-
-	ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
-	if (ret)
-		goto err_unprepare_clocks;
-
 	/*
 	 * Initially turn on all domains to make the domains usable
 	 * with !CONFIG_PM and to get the hardware in sync with the
@@ -427,7 +419,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		ret = scpsys_power_on(&pd->genpd);
 		if (ret < 0) {
 			dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
-			goto err_unprepare_clocks;
+			goto err_put_subsys_clocks;
 		}
 	}
 
@@ -435,7 +427,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 		ret = -EINVAL;
 		dev_err(scpsys->dev,
 			"power domain with id %d already exists, check your device-tree\n", id);
-		goto err_unprepare_subsys_clocks;
+		goto err_put_subsys_clocks;
 	}
 
 	if (!pd->data->name)
@@ -455,10 +447,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 
 	return scpsys->pd_data.domains[id];
 
-err_unprepare_subsys_clocks:
-	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
-err_unprepare_clocks:
-	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_subsys_clocks:
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 err_put_clocks:
@@ -537,10 +525,7 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 			"failed to remove domain '%s' : %d - state may be inconsistent\n",
 			pd->genpd.name, ret);
 
-	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
-
-	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 }
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

