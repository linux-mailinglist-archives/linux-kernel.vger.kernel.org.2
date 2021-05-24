Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D4238E43A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhEXKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbhEXKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:39:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE40C061574;
        Mon, 24 May 2021 03:37:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id f18so10848329ejq.10;
        Mon, 24 May 2021 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9PoKK0/f5+W8bgWFgVSBXS4bTp3NbAEIo6GlJr5v8A=;
        b=XUPX+sm0RNbOl3akoKmJdcug6VvbFVss7IrvGZFOHF5FdfguqhCkHq65S57Ilk5f/3
         p1ua+E5zOQJNBiRMiDO4wEoSWhudhNUp6/urdIjRJ0NPeMruTG16PCnnzvPg7YKphCDK
         vJOtSZ4qClvDCcAOIYO/ELwFVrOuf5PY8qRqB70zHxMgrkJ2RfvIiNR9Mh4ISz7xCDij
         q2rtBm7rl6vNUlTiN5sBRevkobxNR6APjypX8tKGkS4dOTT1U8ll3tR2YXRhyD38X3T+
         8xP5YJdM1DoyqaIAawr1D5GwvpTLbOxHLiir78pNcbOucV7CcWdyJvb5teip623/IF6D
         hCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9PoKK0/f5+W8bgWFgVSBXS4bTp3NbAEIo6GlJr5v8A=;
        b=ZlvOgSQIkGLbm45he3dE3OsUsz7R+A/4gdam5QNhpsgCnFg7ysrD4u/KFNLWqUeV7t
         M8IgY2g871KtvVpzRvLgSG+k/UkD6+FjVUp5lzGVT7WaONbCmIl/eV+RHuWk0LXb7UWQ
         Iy22AZ82x2Etmu68PjLogsASw7oKzFGbEW8SdkVe9+JIfgVsVZO+WiSQiaUw9v9tclBk
         d9HCMaHZPf8yP/NX1gGdZ054XSYKKDbIZXZEFQ4452NR6C25A5sJb+htjh4RCVoPu28f
         HxySQSRnx9v29qQsTX1HoB1C4VjqS7TnTOW2XUvncUUOWCmbmynA7hXwLBQ3ujSj+O7K
         HK5Q==
X-Gm-Message-State: AOAM531PqK7Up52L4XLY4t2t++03UNWoWbRFQyZeZd0b29xSch0uGYon
        H9iJd////e78khjinf5uaCg=
X-Google-Smtp-Source: ABdhPJxji7Msow1IjPo9+v0JxjQuF/MZH2cI9E+oqnbxbvprgU3c/OuibsfJWHOyfd84x1jHbdz2jw==
X-Received: by 2002:a17:906:fc1e:: with SMTP id ov30mr22364766ejb.526.1621852669408;
        Mon, 24 May 2021 03:37:49 -0700 (PDT)
Received: from localhost.localdomain (p200300f1370a3a00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:370a:3a00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id r15sm2616418edm.61.2021.05.24.03.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:37:49 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/3] clk: meson: regmap: switch to determine_rate for the dividers
Date:   Mon, 24 May 2021 12:37:33 +0200
Message-Id: <20210524103733.554878-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
References: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-regmap.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index dcd1757cc5df..8ad8977cf1c2 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -75,8 +75,8 @@ static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
 				   div->width);
 }
 
-static long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				      unsigned long *prate)
+static int clk_regmap_div_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
@@ -87,18 +87,17 @@ static long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (div->flags & CLK_DIVIDER_READ_ONLY) {
 		ret = regmap_read(clk->map, div->offset, &val);
 		if (ret)
-			/* Gives a hint that something is wrong */
-			return 0;
+			return ret;
 
 		val >>= div->shift;
 		val &= clk_div_mask(div->width);
 
-		return divider_ro_round_rate(hw, rate, prate, div->table,
-					     div->width, div->flags, val);
+		return divider_ro_determine_rate(hw, req, div->table,
+						 div->width, div->flags, val);
 	}
 
-	return divider_round_rate(hw, rate, prate, div->table, div->width,
-				  div->flags);
+	return divider_determine_rate(hw, req, div->table, div->width,
+				      div->flags);
 }
 
 static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -123,14 +122,14 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_regmap_divider_ops = {
 	.recalc_rate = clk_regmap_div_recalc_rate,
-	.round_rate = clk_regmap_div_round_rate,
+	.determine_rate = clk_regmap_div_determine_rate,
 	.set_rate = clk_regmap_div_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_regmap_divider_ops);
 
 const struct clk_ops clk_regmap_divider_ro_ops = {
 	.recalc_rate = clk_regmap_div_recalc_rate,
-	.round_rate = clk_regmap_div_round_rate,
+	.determine_rate = clk_regmap_div_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_regmap_divider_ro_ops);
 
-- 
2.31.1

