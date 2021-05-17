Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F23386B87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbhEQUi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbhEQUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:38:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED4CC06175F;
        Mon, 17 May 2021 13:37:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so291089wmh.4;
        Mon, 17 May 2021 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdlOUWCFrqhk74UvYiMcqHdWI1N1+oYHII4ZRq2kZ3Q=;
        b=iGYBbJ7VV+sih5JcSVBhAw+WygMf8lzLPqsrC86lDfO6oZdOx7a8AdYoopCJYyhvOQ
         7VM0R4hkIWexulCPuRs5G41v6DhcisDIhFvO5wY5mO4iy5ZFgM2wAHmzLbJIjlVFdMRs
         K8gas4JH270iFfnPW2id7L0eyizQl3gPfQ0R95gZc5aOKqPfziCTyJ6e4hhCWIFJ1iKP
         1cBuDoA6YvvMtU3s4N3IuPdOSXoFR7dAncB8QyfG7cFtYDQ8S12Mo7in+3ySv0fgOSad
         VOBaglZ5ViFafsKgH1SGAlSl9rkV/J/9Ln2shol0Wx6uxgghiDW7KItMlGX/CMfHvvKZ
         AfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdlOUWCFrqhk74UvYiMcqHdWI1N1+oYHII4ZRq2kZ3Q=;
        b=f3hF24tCsbQfCtrNRjbuph9o7+nyZ2+sTpBO8XurAMlJSXGDbnQjx6wco6V1pg3Vwr
         67SmmVZglzy+TT5hvxpmLTz6J1360d1C8VPM/LlOwCO/XJth41zx6tt3VVoisgoqmM1S
         gkqOKlRLwGXJWrGP4np7Zc0BXz4jgVNGG5wL3u6Aqpc+EpOIQ9wOjjygqi2Q1Yff3R2M
         ZgpkHklbfOpd9GpLcS/ztVGkDBhh2hs/SmZxtj8qj6xt272VvFhfkB93lJBm2t4DRxur
         pR/UUgAgh5uwrN0SLV3mpMvc4rZ9HWUh+D0PX3sh1aPZq4SQIyEpm20YcCGuqWIBB2r5
         rzbw==
X-Gm-Message-State: AOAM530h3VRXQPEqQ9Tv1IEWE40pxZiAQCTsmt6hIBrHYSP6NrzHvGSd
        Gi50960eLM6EtbZRSsU+kHeeu+sb6dE=
X-Google-Smtp-Source: ABdhPJyUym/2wMl+zRWG2tm3iJbsKFKDbcljcr3Vp0/EZQwKDXOiJPSAJif7+TfZO0XWr0cKN3EUuw==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr1351729wmj.109.1621283856162;
        Mon, 17 May 2021 13:37:36 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371adf00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371a:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id p6sm3840448wma.4.2021.05.17.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:37:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 3/3] clk: meson: pll: switch to determine_rate for the PLL ops
Date:   Mon, 17 May 2021 22:37:24 +0200
Message-Id: <20210517203724.1006254-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
References: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This increases the maxmium supported frequency on 32-bit systems from
2^31 (signed long as used by clk_ops.round_rate, maximum value:
approx. 2.14GHz) to 2^32 (unsigned long as used by
clk_ops.determine_rate, maximum value: approx. 4.29GHz).
On Meson8/8b/8m2 the HDMI PLL and it's OD (post-dividers) are
capable of running at up to 2.97GHz. So switch the divider
implementation in clk-regmap to clk_ops.determine_rate to support these
higher frequencies on 32-bit systems.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-pll.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 49f27fe53213..9e55617bc3b4 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -242,8 +242,8 @@ static int meson_clk_get_pll_settings(unsigned long rate,
 	return best ? 0 : -EINVAL;
 }
 
-static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *parent_rate)
+static int meson_clk_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
@@ -251,22 +251,26 @@ static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long round;
 	int ret;
 
-	ret = meson_clk_get_pll_settings(rate, *parent_rate, &m, &n, pll);
+	ret = meson_clk_get_pll_settings(req->rate, req->best_parent_rate,
+					 &m, &n, pll);
 	if (ret)
-		return meson_clk_pll_recalc_rate(hw, *parent_rate);
+		return ret;
 
-	round = __pll_params_to_rate(*parent_rate, m, n, 0, pll);
+	round = __pll_params_to_rate(req->best_parent_rate, m, n, 0, pll);
 
-	if (!MESON_PARM_APPLICABLE(&pll->frac) || rate == round)
-		return round;
+	if (!MESON_PARM_APPLICABLE(&pll->frac) || req->rate == round) {
+		req->rate = round;
+		return 0;
+	}
 
 	/*
 	 * The rate provided by the setting is not an exact match, let's
 	 * try to improve the result using the fractional parameter
 	 */
-	frac = __pll_params_with_frac(rate, *parent_rate, m, n, pll);
+	frac = __pll_params_with_frac(req->rate, req->best_parent_rate, m, n, pll);
+	req->rate = __pll_params_to_rate(req->best_parent_rate, m, n, frac, pll);
 
-	return __pll_params_to_rate(*parent_rate, m, n, frac, pll);
+	return 0;
 }
 
 static int meson_clk_pll_wait_lock(struct clk_hw *hw)
@@ -419,7 +423,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
  */
 const struct clk_ops meson_clk_pcie_pll_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
-	.round_rate	= meson_clk_pll_round_rate,
+	.determine_rate	= meson_clk_pll_determine_rate,
 	.is_enabled	= meson_clk_pll_is_enabled,
 	.enable		= meson_clk_pcie_pll_enable,
 	.disable	= meson_clk_pll_disable
@@ -429,7 +433,7 @@ EXPORT_SYMBOL_GPL(meson_clk_pcie_pll_ops);
 const struct clk_ops meson_clk_pll_ops = {
 	.init		= meson_clk_pll_init,
 	.recalc_rate	= meson_clk_pll_recalc_rate,
-	.round_rate	= meson_clk_pll_round_rate,
+	.determine_rate	= meson_clk_pll_determine_rate,
 	.set_rate	= meson_clk_pll_set_rate,
 	.is_enabled	= meson_clk_pll_is_enabled,
 	.enable		= meson_clk_pll_enable,
-- 
2.31.1

