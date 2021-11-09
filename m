Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD25244A49F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhKIC3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbhKIC3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:29:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF40FC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 18:26:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p18so18084186plf.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 18:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xovCIAAU5pofSMeWtP54czW4maGEjZGkO8QeFrRIQTk=;
        b=e4/preGPlSWk95qmVJkS4xeVPT6dAY2jnQ3X7fvClPv3FdUT8chK7JEXCndXGoaksS
         Vb6eo+rqp56mN64WyzTVZ+c4m+N7FnfeGAhTQa9Rv9wloKesozNNxuPpowvQZ8MtdyK1
         L4jRDCzsvFsLjjzAWmpLCsholEPqtJ4opcp8NAWVJ6drA5SYf2XRE3yh8Ncpj/dJSKX9
         mRxsL0BCeitajLIrESWWEZc4NMypy+xB+zrwK8SskdmG4nSJD7GUuRc+JP82bYscWT97
         oqnbJ/bRTGrj6eHKBeDsFWaYjjsjt7nhOr1WK/4tFZExWJihX6+kS4gr/tl+mj8rGkDs
         Awzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xovCIAAU5pofSMeWtP54czW4maGEjZGkO8QeFrRIQTk=;
        b=fTX8b1oIR7KFFKLd4caioxDs0Y0jWMFW3ypepK/hYO73ZB8o+EUJCGI/ljQtmZUx4t
         HDoZ6HGdXZgaxuDndGdF2uOVzY8GVhAAbh+pALaUwncLjAyqwOxki/DK3zdEL2Aks6QD
         M2MvyECSK8x9oha3k8EhGrtkgeuNpfyAIF1mF9VO4+/aytc2cIf/XC/abtsgpU7AS/zk
         RpxAJmLEQymY4PTo/qbDpMRo+yuVChEuWbgpvWrpvwmsxZGsjrGlt9YSw0Rel7Ht9mn9
         GsRrSU5HAEybv6LzJEhCPq0P6hGYx/GEoTl7giiHPQCKQtje2sLcxBxAkP7Rnza7rU20
         H9UQ==
X-Gm-Message-State: AOAM530d6EN7jTjG/6RgZ+eHBBAPtba8NxfSotrFPOjtp12K/pAQd1xn
        +vsNhf15G2aCfa5smkXz/a1WeqiAx/ePoQ==
X-Google-Smtp-Source: ABdhPJy1Hm54FpGAARbZdw+4XYxjjOEvp9yjVdUeIk/K3Cn3qlozXKR6ztdBUyoU/yvyohP7DLQqJg==
X-Received: by 2002:a17:90b:2252:: with SMTP id hk18mr3307206pjb.218.1636424774426;
        Mon, 08 Nov 2021 18:26:14 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id om8sm589619pjb.12.2021.11.08.18.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:26:14 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/3] clk: qcom: smd-rpm: Add .is_prepared hook
Date:   Tue,  9 Nov 2021 10:25:58 +0800
Message-Id: <20211109022558.14529-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109022558.14529-1-shawn.guo@linaro.org>
References: <20211109022558.14529-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPM clocks are enabled/disabled through clk framework prepare/unprepare
hooks.  Without .is_prepared hook, those unused RPM clocks will not be
disabled by core function clk_unprepare_unused_subtree(), because
clk_core_is_prepared() always returns 0.

Add .is_prepared hook to clk_ops and return the clock prepare (enable)
state, so that those unused RPM clocks can be disabled by clk framework.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index f8be58121bd6..c8f058720e66 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -409,6 +409,13 @@ static int clk_smd_rpm_is_enabled(struct clk_hw *hw)
 	return r->enabled;
 }
 
+static int clk_smd_rpm_is_prepared(struct clk_hw *hw)
+{
+	struct clk_smd_rpm *r = to_clk_smd_rpm(hw);
+
+	return r->enabled;
+}
+
 static const struct clk_ops clk_smd_rpm_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
@@ -416,6 +423,7 @@ static const struct clk_ops clk_smd_rpm_ops = {
 	.round_rate	= clk_smd_rpm_round_rate,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
 	.is_enabled	= clk_smd_rpm_is_enabled,
+	.is_prepared	= clk_smd_rpm_is_prepared,
 };
 
 static const struct clk_ops clk_smd_rpm_branch_ops = {
@@ -423,6 +431,7 @@ static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.unprepare	= clk_smd_rpm_unprepare,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
 	.is_enabled	= clk_smd_rpm_is_enabled,
+	.is_prepared	= clk_smd_rpm_is_prepared,
 };
 
 DEFINE_CLK_SMD_RPM(msm8916, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
-- 
2.17.1

