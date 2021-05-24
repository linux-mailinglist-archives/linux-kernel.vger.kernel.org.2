Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164BF38E439
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhEXKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhEXKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:39:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A517C061756;
        Mon, 24 May 2021 03:37:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id df21so31362151edb.3;
        Mon, 24 May 2021 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=br2LAkdVkinf4lfGstyxEISEcfDBPafEL/ugOBpOFVs=;
        b=jBG36Q7wVbObvnVdapVzc2TMCF8/w76fE0SYz7u7B6tf90Wm9+dknqvhzTcg438hqe
         pEfe3AYnEqFqkDKgH3+bFnLVJHRcJe3/CeFL+vq5rAx0jgY8W9iIFdqNbQgM+j+1U/zC
         i6MJTN2kuvIOLos3h70NLtEQXg3SkcIw/G+UrFp9gMcUhaLCiJaa91mmp4sSCP803kSz
         7nIu3z79jlPd6MUe5aTQoSMHHuDkgw2baFY/C6WuO2q8zDk5f/bn0cwSHdHH9+TXXD1Z
         E/if+uwcI+knAjSClWqUZiCXjS5+MlDMi3ke3z/MNBxIUkjAzX/l3wl1qAqGmhPFHERp
         5dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=br2LAkdVkinf4lfGstyxEISEcfDBPafEL/ugOBpOFVs=;
        b=C+HxUTpUsF9Mv7IK3qno/BAhj1yOTxvZoFFpJLgrW0jx7hW2EY89XgKr1WKFnF1dLX
         LUOhuZ6F9ov8RQqDsDrtHizt47yxqm4vz/XnEUjjvI6Js5V+Z6krNh2vnsv4ZKpgF+bu
         H5OjIQNwpFD+rDkuRWuozuSmdaNMXrYtvWc6aLUfg7XzrFYi9W6oxpfoXuRzWJMQ1WVY
         sVY5klKt3IDB7l4aViUbjwZRadzB9Lj3U7Uryb5c0Igs8U+04q2anbB2KMEb3ifRBtLL
         VNwZf/JGAPNPVh74qRDsbZi4QZerOz47dy9Te+J3ySuk+Ao60wnGOh2nvYM0FV/DKO1h
         UIJw==
X-Gm-Message-State: AOAM5302EoOfda7+Qx7cQsVEuztVUQD+bul0u+vUzrKFA67A/02QjbRV
        mbw3sT3O4ayzxG4Dhq78vEo=
X-Google-Smtp-Source: ABdhPJwJC01A6NC8Z1rC637INdrccXaNZyehezoGsf+7Q+DiLbQiYHmT9xwZwNar4OnjaZlO3+UK+A==
X-Received: by 2002:aa7:d413:: with SMTP id z19mr25021347edq.37.1621852668811;
        Mon, 24 May 2021 03:37:48 -0700 (PDT)
Received: from localhost.localdomain (p200300f1370a3a00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:370a:3a00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id r15sm2616418edm.61.2021.05.24.03.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:37:48 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/3] clk: divider: Switch from .round_rate to .determine_rate by default
Date:   Mon, 24 May 2021 12:37:32 +0200
Message-Id: <20210524103733.554878-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
References: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.determine_rate is meant to replace .round_rate. The former comes with a
benefit which is especially relevant on 32-bit systems: since
.determine_rate uses an "unsigned long" (compared to a "signed long"
which is used by .round_rate) the maximum value on 32-bit systems
increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).
Switch to a .determine_rate implementation by default so 32-bit systems
can benefit from the increased maximum value as well as so we have one
fewer user of .round_rate.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk-divider.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 87ba4966b0e8..9e05e81116af 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -425,8 +425,8 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 }
 EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
 
-static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static int clk_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
 
@@ -437,13 +437,13 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 		val = clk_div_readl(divider) >> divider->shift;
 		val &= clk_div_mask(divider->width);
 
-		return divider_ro_round_rate(hw, rate, prate, divider->table,
-					     divider->width, divider->flags,
-					     val);
+		return divider_ro_determine_rate(hw, req, divider->table,
+						 divider->width,
+						 divider->flags, val);
 	}
 
-	return divider_round_rate(hw, rate, prate, divider->table,
-				  divider->width, divider->flags);
+	return divider_determine_rate(hw, req, divider->table, divider->width,
+				      divider->flags);
 }
 
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
@@ -500,14 +500,14 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_divider_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
-	.round_rate = clk_divider_round_rate,
+	.determine_rate = clk_divider_determine_rate,
 	.set_rate = clk_divider_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_divider_ops);
 
 const struct clk_ops clk_divider_ro_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
-	.round_rate = clk_divider_round_rate,
+	.determine_rate = clk_divider_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
 
-- 
2.31.1

