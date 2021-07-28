Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5A3D9076
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhG1O0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhG1OZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:25:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604A8C0617A3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:24:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m9so3295987ljp.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORimO8D42kAHhnXfoY653OGm+8ilcZTSD9Rm8q3p1bo=;
        b=QJdRABVp43c7JWRg8sbdKu6k+iBY7vTqpmXGlj/FeZzkEkG0i2omtElZod1AQGXI+J
         xVcYDap+fs7EweFwsu5TGdUi+b4kz0H14GE78mjrH+cwSAyJhxf26ZxMCYO0v/D+/kPt
         p73Cs8lzaG9gsFIorWc4P2FunLeHMpnaVREsNm6j+2URPW65Id04ee0oiY8qxio2CzmZ
         taYFAte0h2oRGq3fYRMftGNkXj4bxAZYQFGpZXn5fQeL7Bu2ezzJemFEF5o+0dJrZGsz
         E+WOBQiLRdGamNCkP2YOv9JdXV9kA7AIYSc13BAOiwVt9ddt+haN4UPVrQ0WIOZ10NSb
         aB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORimO8D42kAHhnXfoY653OGm+8ilcZTSD9Rm8q3p1bo=;
        b=nPdCz2XLUy74cEfLaCmzoKEslmQ9g4Ik3htN38RJkoFRttGLyBK6sA35cbq0d+xCUK
         wh678r0LSvv4/yxO1hGA1DOoK/c//tH3iUfnGNN+INyPBRBbYNektnG+ahV2YQV98N3Y
         HMm399IxFbjkA7uKpPIWfIc9yazyKi1SYb3A2777vqJ2KIdCvoNEpwdy5I0RvwguYWVT
         K2z10mMiXD+BCJ+VY+bWzH7u1u5cvHaCcNV8dD6fy3BFUMY2HZ0YdhhsXk7C3fETqe9o
         OecnBOmOBowYURDMLYB6bYJVavs/Wnk/W+Z+7tXmdn/IGPtnsYuTZ/vx/nkXsaGdQgFt
         ccDw==
X-Gm-Message-State: AOAM532Q+g4Qh/j+/qnbANQ/qLiM18C5up+zkspAzk9bG/Iu4VmzOV5o
        mVb+54HcKidFVQEVbWHDrJtWAg==
X-Google-Smtp-Source: ABdhPJyeHeYmfbX0mRutc4wBGIzl3E+3k3LZVsC7Z0deZwgnV/53DecPXbUtBDHZbzjGmXyhXbm+uw==
X-Received: by 2002:a2e:9605:: with SMTP id v5mr97711ljh.178.1627482293728;
        Wed, 28 Jul 2021 07:24:53 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h4sm15610lft.184.2021.07.28.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 07:24:53 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/5] clk: qcom: use common code for qcom_cc_probe_by_index
Date:   Wed, 28 Jul 2021 17:24:44 +0300
Message-Id: <20210728142445.774158-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210728142445.774158-1-dmitry.baryshkov@linaro.org>
References: <20210728142445.774158-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite qcom_cc_map and qcom_cc_probe_by_index to use (new)
qcom_cc_map_by_index, removing code duplication and opening a way to
have more common code in qcom_cc_map*.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/common.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 60d2a78d1395..ed7c516a597a 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -69,20 +69,26 @@ int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map, u8 src)
 }
 EXPORT_SYMBOL_GPL(qcom_find_src_index);
 
-struct regmap *
-qcom_cc_map(struct platform_device *pdev, const struct qcom_cc_desc *desc)
+static struct regmap *
+qcom_cc_map_by_index(struct platform_device *pdev, const struct qcom_cc_desc *desc, int index)
 {
 	void __iomem *base;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 
 	return devm_regmap_init_mmio(dev, base, desc->config);
 }
+
+struct regmap *
+qcom_cc_map(struct platform_device *pdev, const struct qcom_cc_desc *desc)
+{
+	return qcom_cc_map_by_index(pdev, desc, 0);
+}
 EXPORT_SYMBOL_GPL(qcom_cc_map);
 
 void
@@ -313,15 +319,8 @@ int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 			   const struct qcom_cc_desc *desc)
 {
 	struct regmap *regmap;
-	struct resource *res;
-	void __iomem *base;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return -ENOMEM;
 
-	regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
+	regmap = qcom_cc_map_by_index(pdev, desc, index);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.30.2

