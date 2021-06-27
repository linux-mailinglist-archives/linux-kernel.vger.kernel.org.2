Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5F3B55A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 00:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhF0Wmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 18:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhF0Wmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 18:42:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC2C061574;
        Sun, 27 Jun 2021 15:40:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t3so22637733edc.7;
        Sun, 27 Jun 2021 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RGvFAm9Ts+UzLEA4XCpJmqflkt+KrOpeV6KcGxPufo=;
        b=lx2WKNqvydIxgPqbA9zQ9ngA2x1DrB09LYObbLZfVaFLrAo7/hK0BuEwpdUQXFwwAc
         eWtg17oO5QFwAAnoP5Aa/zmODTUvlZLnWrv778ysdLrO7G9eUgsE4SM727kwmnUbrILb
         Nv3PhnBLvgygh2rAOFCI+oJ01xV/pDTBYlq6QKBS67G6/jsGPjWiBvDhCp5MORh17mGf
         AbnY8YXD8PVw50EO9EuefIT45qeIzdcJOnvzDU9j3NNtSSyV/R2BlUgUyQPMXbjwD6II
         8KtTlAJm3+5UPu4Dmf/nrqgf6LVWEuVW1hYa0gzi44319BkFbM9lM/STIH2tkfnNIeaH
         VfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RGvFAm9Ts+UzLEA4XCpJmqflkt+KrOpeV6KcGxPufo=;
        b=MnUZ6lW1fjxfC0fE+So0SdP0hpsEsCn8kMrzGWUzX24b190UxAccyRFrzBpfvrI2bu
         s3rn8FhIcoX9Kky3sa+tkELnqB+9H+MNVrdbB1y/a6ln0jRpZdwOHxxi9RPfXqk0LxXF
         1iwkuE3IZMHNvKulk9e++QdR1iee2+5rLi7mRF6vr5cCkr73LhWVojAauQhChkxM4Suq
         remqCqiBj2Z1vAhn/pYD5h12Lyn4kOZlqRlXm1B3Bk0uYdyz8IGJjzSXQ7mwdn7cNA0R
         KbegTaYUFuW4EQVkKXLQEJrvtbCZuz0m7EhXbKWDycVYpkVyXz4sExILwa9KngVnMPOf
         +7gw==
X-Gm-Message-State: AOAM531OpamddxY/NCD9c7AEByNoW2BlEdsqsSBjjkiuK4lT8BofxClO
        nHEfn20QB2ZZJgAgTswhoxg=
X-Google-Smtp-Source: ABdhPJwtBJNk1GE9pddy37EiixHhFNKzp8fbC0MRAbqMv+j7mhB9VGsAF3sYuSOdKXVboJ25Up0Vpg==
X-Received: by 2002:aa7:c845:: with SMTP id g5mr29233940edt.306.1624833620156;
        Sun, 27 Jun 2021 15:40:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-bd64-8b00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:bd64:8b00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id jz27sm6048861ejc.33.2021.06.27.15.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 15:40:19 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/3] clk: meson: regmap: switch to determine_rate for the dividers
Date:   Mon, 28 Jun 2021 00:39:59 +0200
Message-Id: <20210627223959.188139-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
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
2.32.0

