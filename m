Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24344A494
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhKIC3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbhKIC25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:28:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7104C061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 18:26:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y1so18120953plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 18:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dn7bTjyF97h5pOYcvg0nMMFKfe5z/l5Yp8vYnJTswg8=;
        b=QqILa7vZYOHZqY2pTqI3VrPT91GdR0sHAynMtgr42WqpHSx7z/+WzfVs4jJls0roqq
         jA+AlDuXxhtm8RhjZoarggWgbuzHtDB3OIB4amt+IOWuL4MJxwA6eMjBbNkSqq1x9jY7
         +FCa8zMrVrmae2jkeA12iYbP1KScPQsiwbnm6CSTCHhDhaFl7GqKiQ28UI5ot83y+zOa
         FaPF9DNXS9SRHrhtNww1gqmMsLXHmwiRmcmJ+qBtaT6uq8VLvYg+Vuh7mmyAdwHd8h/P
         gAS+zCoWOsT9lbvEhna3vu2hzv718l+itLa0E8zo64/iDwU15TJdgjGY+GsDVLv9Ii7j
         mr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dn7bTjyF97h5pOYcvg0nMMFKfe5z/l5Yp8vYnJTswg8=;
        b=CDsVP/naL+TWKbv3zxTlcrwRYpWEy1HgR67JOyxH9MKNdu6gJWAx0T26mIwVm0hPZt
         0I/XNbP663pWMlg87cNoeWo1xnpv8pk+mAlpBz+YX4dC0t4Bz4uM+SW3Rq7nvtjNDrpX
         1aTfIB6MXZrPBfS6cim8n+/uWMJ1ECPZzTBigTcs9it7Q0ohDXyfAJicYQ6iS1+1u8v4
         5ME4hdhyKD+0po2bIp29bHukmEe3CiK4cji/Y5OD4wlMTqDmZEgHlmad7XoWW3TXz0BU
         ep+CsW7qICcWBRtxv/5BpCnhMihdINMdKGDflNM9022OtCkuqLynlSvfr2FEFCL0uHlS
         Owhw==
X-Gm-Message-State: AOAM5338iPCilAU+AGy1bgomdXh/qNExOB5uwSSsrCGScQqVE0TYvMgQ
        E5iGLxxY8CaJ1VA17EfjSAUq+g==
X-Google-Smtp-Source: ABdhPJwVqVOVLYSPs6unLVilZWisq2b4SzFrDO4tlPg6VClvc//qyIkowLHJFMBSSmaZwepLwI/kCw==
X-Received: by 2002:a17:90b:3ec6:: with SMTP id rm6mr3301992pjb.41.1636424772385;
        Mon, 08 Nov 2021 18:26:12 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id om8sm589619pjb.12.2021.11.08.18.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:26:12 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/3] clk: qcom: smd-rpm: Add .is_enabled hook
Date:   Tue,  9 Nov 2021 10:25:57 +0800
Message-Id: <20211109022558.14529-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109022558.14529-1-shawn.guo@linaro.org>
References: <20211109022558.14529-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPM clock enabling state can be found with 'enabled' in struct
clk_smd_rpm.  Add .is_enabled hook so that clk_summary in debugfs can
show a correct enabling state for RPM clocks.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 6695a43a3d73..f8be58121bd6 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -402,18 +402,27 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
 	return 0;
 }
 
+static int clk_smd_rpm_is_enabled(struct clk_hw *hw)
+{
+	struct clk_smd_rpm *r = to_clk_smd_rpm(hw);
+
+	return r->enabled;
+}
+
 static const struct clk_ops clk_smd_rpm_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
 	.set_rate	= clk_smd_rpm_set_rate,
 	.round_rate	= clk_smd_rpm_round_rate,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
+	.is_enabled	= clk_smd_rpm_is_enabled,
 };
 
 static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
+	.is_enabled	= clk_smd_rpm_is_enabled,
 };
 
 DEFINE_CLK_SMD_RPM(msm8916, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
-- 
2.17.1

