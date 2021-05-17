Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EDC386B88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbhEQUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbhEQUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:38:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9ECC061573;
        Mon, 17 May 2021 13:37:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so295658wmg.3;
        Mon, 17 May 2021 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyvXp9JIBkDb38VgDaE0Gu4BsKjCEQ64wDu6xyl4Vh0=;
        b=DX84cj7xin3BlWyZgOKjH3yfQPEykMnICRJ+G0I6oNuOUNGPdz8KeChDbJlir7EMRP
         Uxdop8zZVE7Fill0n8PhWvG9CdYqUebfpq6jWxBAFxioA7pNcZcPEgNPfPfVPAbB6WdK
         xlx63HsBayRF/4MHi5nuUu+km9R1o4Isn7CKU3UfyXyT2w1pSeJ2gqo1zw7XKRy4ihOx
         e9HESr/2vFcM93lmUroLtAWN1AGEjVEkMQOIYaN3/cPtR2YLl4dLpmIcsreBhCz4Wyfd
         DxbXYK8UkYkXV8QfeaMLY/4qo+LyEeSsfMQjT0GCvPdT0+Ct0riMxTI/Y0O6z0z742Gj
         WU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyvXp9JIBkDb38VgDaE0Gu4BsKjCEQ64wDu6xyl4Vh0=;
        b=IiZXUuM9uhkkgw2SET2krCIozdFS8R56LvpUbaLayHEHU9I9WIk8Q34s1ofyGP1g4y
         A4o3rTeCDKPNfewVPpfUvjCrpJn5bojx04a9yIsBQwUlNLgCk3Ws6HtZOQfO9k1DMR1w
         XV51rchthFVfmSs/vgrOhNK5VIPiFGi4n/8E5rhoU8VPfkkrAmXULQUNttVt8IyZvNF/
         eN2NreQ7oPGTpAtgKkM3DMO3YwUa0ygjvjL/VGaCvGfvrS4/MrRArowxhLUwkIBMhvgU
         R0wevGHAFh3vx5rp2Y9aywux9Gigxr9n2D3oqEtzlEHA1M4+gQmV6ePolPJE5FGdImzZ
         8YTA==
X-Gm-Message-State: AOAM530Rx8twrX+j+VrUDMSyQA3EQ6b6S69Ihiu+MQo7ehDWk+rMmiuB
        co6Vg0hpZjjcI53L9YBYPl+gNmSSE88=
X-Google-Smtp-Source: ABdhPJyVPcoCkDKXCWePaIDmy/NoeGPDwPZ+hww3qa91Mk6i6IYJg+EBt5pMIkiGK8r+xrX0PfVEdg==
X-Received: by 2002:a05:600c:3796:: with SMTP id o22mr840081wmr.139.1621283855411;
        Mon, 17 May 2021 13:37:35 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371adf00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371a:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id p6sm3840448wma.4.2021.05.17.13.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:37:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 2/3] clk: meson: regmap: switch to determine_rate for the dividers
Date:   Mon, 17 May 2021 22:37:23 +0200
Message-Id: <20210517203724.1006254-3-martin.blumenstingl@googlemail.com>
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

