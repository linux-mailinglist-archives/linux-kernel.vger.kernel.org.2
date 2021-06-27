Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFD3B559E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 00:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhF0Wmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhF0Wmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 18:42:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFFFC061766;
        Sun, 27 Jun 2021 15:40:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id q14so22642267eds.5;
        Sun, 27 Jun 2021 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGONBXxvlhJmqdlV0gc3mwlikq8hNJaflhau0UlR32c=;
        b=tZrzV+ig6jKUQBbzQWnL09J6iWbBXMV6GCuURJsqjq/LgXjRJkkGGoivmqEqqOLnUG
         IdxSmPH8hvG/bHKoVrNBur1zg80tQ7vjBWb6tMpa6SjEt9BZsvIUP817R3FwS7R+3s1+
         efcA74IJEoL8Ld52nywX7Afxkdba3Tk+pqimGw6MYVudeiVpq75O3xpinBAd3irc4eQL
         jOI+NEfYN2iZW8DaFj5s6MYteT2hLpptvQ5wKKNC6SDux7rNsfsxxeeQ4BZp+5Agh3qH
         l2qyTIMuXAyB+Z1Fq7eZtWJ+xwDcfGqrKGIRl+DesRHahvXHsr5ToMK3F3VfG4OHsNur
         zl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGONBXxvlhJmqdlV0gc3mwlikq8hNJaflhau0UlR32c=;
        b=cqO2mG25LrX/TH6iBPZmu/abJCDX+hKCUpXgNMR9Qa0HSmXgYLAhjyv2vDZbTLrPRm
         4+EkqJhKaIzCbooSxNSlosZ0zCZkdmO3CvVpdsHf5sbuY9eIqk6EynhW3K2jbFPTCJAn
         LN3nG7j1H1vjVeqVqdpAXlIAQLa8u8mERFb6nnwM44mf9gXP2Y5kB3epIZfUmFAPW9ed
         8nUZ2GOHcSpdLksY84m78qmm2Dpq3P7uS4s97RFQFmux9mFe5fgjb5zB8QlAQTTQkhW6
         fekgzGEif5spXLlSV7qWwVP4uWOC5kL8PtJoHMFbRvplEzng+DbW3hldsHoVStvIggfM
         kOZw==
X-Gm-Message-State: AOAM531BErNlw27zJ8TCXh2kEULK2rXAhbyZIVt3oDfIlvoEeKLKk+0P
        c6+jI0kjg85spl1t7g1lfa0dmKRVVYM=
X-Google-Smtp-Source: ABdhPJwaBo9OJa6uSLaQbTxVXjuNc27ehqTlKZ3Gf9dHqHGB3kIAQP/8zSGbtC6DahQ4NzLAmgERbQ==
X-Received: by 2002:a05:6402:1103:: with SMTP id u3mr29293230edv.342.1624833618675;
        Sun, 27 Jun 2021 15:40:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-bd64-8b00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:bd64:8b00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id jz27sm6048861ejc.33.2021.06.27.15.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 15:40:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/3] clk: divider: Add re-usable determine_rate implementations
Date:   Mon, 28 Jun 2021 00:39:57 +0200
Message-Id: <20210627223959.188139-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are useful when running on 32-bit systems to increase the upper
supported frequency limit. clk_ops.round_rate returns a signed long
which limits the maximum rate on 32-bit systems to 2^31 (or approx.
2.14GHz). clk_ops.determine_rate internally uses an unsigned long so
the maximum rate on 32-bit systems is 2^32 or approx. 4.29GHz.

To avoid code-duplication switch over divider_{ro_,}round_rate_parent
to use the new divider_{ro_,}determine_rate functions.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk-divider.c    | 75 +++++++++++++++++++++++++++++-------
 include/linux/clk-provider.h |  6 +++
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 344997203f0e..87ba4966b0e8 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -343,16 +343,63 @@ static int clk_divider_bestdiv(struct clk_hw *hw, struct clk_hw *parent,
 	return bestdiv;
 }
 
+int divider_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
+			   const struct clk_div_table *table, u8 width,
+			   unsigned long flags)
+{
+	int div;
+
+	div = clk_divider_bestdiv(hw, req->best_parent_hw, req->rate,
+				  &req->best_parent_rate, table, width, flags);
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(divider_determine_rate);
+
+int divider_ro_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
+			      const struct clk_div_table *table, u8 width,
+			      unsigned long flags, unsigned int val)
+{
+	int div;
+
+	div = _get_div(table, val, flags, width);
+
+	/* Even a read-only clock can propagate a rate change */
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+		if (!req->best_parent_hw)
+			return -EINVAL;
+
+		req->best_parent_rate = clk_hw_round_rate(req->best_parent_hw,
+							  req->rate * div);
+	}
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(divider_ro_determine_rate);
+
 long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 			       unsigned long rate, unsigned long *prate,
 			       const struct clk_div_table *table,
 			       u8 width, unsigned long flags)
 {
-	int div;
+	struct clk_rate_request req = {
+		.rate = rate,
+		.best_parent_rate = *prate,
+		.best_parent_hw = parent,
+	};
+	int ret;
 
-	div = clk_divider_bestdiv(hw, parent, rate, prate, table, width, flags);
+	ret = divider_determine_rate(hw, &req, table, width, flags);
+	if (ret)
+		return ret;
 
-	return DIV_ROUND_UP_ULL((u64)*prate, div);
+	*prate = req.best_parent_rate;
+
+	return req.rate;
 }
 EXPORT_SYMBOL_GPL(divider_round_rate_parent);
 
@@ -361,23 +408,23 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 				  const struct clk_div_table *table, u8 width,
 				  unsigned long flags, unsigned int val)
 {
-	int div;
-
-	div = _get_div(table, val, flags, width);
+	struct clk_rate_request req = {
+		.rate = rate,
+		.best_parent_rate = *prate,
+		.best_parent_hw = parent,
+	};
+	int ret;
 
-	/* Even a read-only clock can propagate a rate change */
-	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
-		if (!parent)
-			return -EINVAL;
+	ret = divider_ro_determine_rate(hw, &req, table, width, flags, val);
+	if (ret)
+		return ret;
 
-		*prate = clk_hw_round_rate(parent, rate * div);
-	}
+	*prate = req.best_parent_rate;
 
-	return DIV_ROUND_UP_ULL((u64)*prate, div);
+	return req.rate;
 }
 EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
 
-
 static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *prate)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 162a2e5546a3..d83b829305c0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -629,6 +629,12 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 				  unsigned long rate, unsigned long *prate,
 				  const struct clk_div_table *table, u8 width,
 				  unsigned long flags, unsigned int val);
+int divider_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
+			   const struct clk_div_table *table, u8 width,
+			   unsigned long flags);
+int divider_ro_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
+			      const struct clk_div_table *table, u8 width,
+			      unsigned long flags, unsigned int val);
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		const struct clk_div_table *table, u8 width,
 		unsigned long flags);
-- 
2.32.0

