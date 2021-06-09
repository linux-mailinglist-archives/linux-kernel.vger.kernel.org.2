Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9D3A0A13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhFICdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:33:49 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:45942 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFICds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:33:48 -0400
Received: by mail-qk1-f182.google.com with SMTP id d196so17211890qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 19:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+z22K7cJoTfII0wjMzy+SPaF3NKWYN2M9CZgeLR5zms=;
        b=BKmXVQWTjHB2QWFXKDRwLKowO0o4ik8S3RamZyscSljtvVhOtG5sUjq1bbC9btwN5/
         yZWpar+E+oBsBs3WauDZHSOHZ6O32WvvyLvCTyyrihk/SMDRHlFFlVAcYtGeMNjqkgCG
         Y8xwrLig0Pk1+/HGbwAHZN2m7GgXxpcLHnzgAiQUj/vnEPgvGFy9uBKsmNimmcwAiGSg
         itO0KQ+JK3uyeIgv/G+8VBpjXWUlfoC7+woObbwBhcrs3DEhCUO8Iwr4ziYnf1NKG0Ew
         NGQWwWoKiMVTj0HW4lirUgVKtSLxGgLVlIuUIXkHRUqKX4zCnrpS53jK1/sAYVo+Ee9D
         C1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+z22K7cJoTfII0wjMzy+SPaF3NKWYN2M9CZgeLR5zms=;
        b=ZFoJ2/izGxwOCeeayq6tblgzl+SGrNLRlwsy03QhFvIz5dZRHC+2APKcWBpm6jdv53
         C+9E8J7Wj/gRx1DyUrkHIpGBW3zpjMc9NG/XGWcYvv2jkp23ZmE9q+PGKdwhsyWjWowa
         oQgarFcoPsCa3UMh6Ra11JIu2RZu6aLUHtsnPXPr/MDlVoZUsSAB3feXy3u3qArqF995
         EUfcXsFoo8hRisBH6MJWcO6JmrSIZoaiUvsv2nBY9Iler6RMenaRzDCbC4BbMS28XXr4
         OhalgrOgd5zPIqxGS6SBrVEPeawB6tffLOSsjaG2JBajuPsuyeOFiFeaPlV4BjAvS+X1
         2+/A==
X-Gm-Message-State: AOAM530O6DXdX6GFq0ZUvRjs2Tdysd6BGx421uQa3McgzAWqjyYSZvNO
        uE1hC5+vl2ghydSjJPgBLkLmVQ==
X-Google-Smtp-Source: ABdhPJz2g+nBQFafQ5Ceao0dQXXJmQLwCSRZnYw1kdhpdxgJU8Ea/m3zpyB7RtospbzBHSCYeZ3gCw==
X-Received: by 2002:a37:a70d:: with SMTP id q13mr17280596qke.295.1623205839654;
        Tue, 08 Jun 2021 19:30:39 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id o12sm13083568qki.44.2021.06.08.19.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 19:30:39 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] clk: qcom: clk-alpha-pll: fix CAL_L write in alpha_pll_fabia_prepare
Date:   Tue,  8 Jun 2021 22:28:52 -0400
Message-Id: <20210609022852.4151-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caught this when looking at alpha-pll code. Untested but it is clear that
this was intended to write to PLL_CAL_L_VAL and not PLL_ALPHA_VAL.

Fixes: 691865bad627 ("clk: qcom: clk-alpha-pll: Add support for Fabia PLL calibration")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 94b53c7db2f7f..eaedcceb766f9 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1255,7 +1255,7 @@ static int alpha_pll_fabia_prepare(struct clk_hw *hw)
 		return ret;
 
 	/* Setup PLL for calibration frequency */
-	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), cal_l);
+	regmap_write(pll->clkr.regmap, PLL_CAL_L_VAL(pll), cal_l);
 
 	/* Bringup the PLL at calibration frequency */
 	ret = clk_alpha_pll_enable(hw);
-- 
2.26.1

