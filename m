Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7273B55A0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhF0Wms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 18:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhF0Wmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 18:42:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F9AC061767;
        Sun, 27 Jun 2021 15:40:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t3so1120192edt.12;
        Sun, 27 Jun 2021 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqEIUvOwohephlofOmmLb1b6WQ3FllXjftCHIKtplvw=;
        b=HAfLAE1x+EPiIb0XwvCnjIHAB8HTdRQi7GAec5mhFOjoxeTGDf79Eaq3apk/rFqNEl
         6NbS2Qeahwd0zvVZxd1YLlrtTAiFSQK5KF5GCIBsv2I7jO7i3FTKK5K9Oubiu7RbTZTz
         aS+dpZALDh3S6XbJCIMKSUFWgXez3r1L3x8LSY/e29h7aNAk0qq9O1z0N4R5rW3xTKU+
         NJiYHE7+0DPmm2/98nR87AC3svI7wdBliptt2jjgEeS1kL4GCJBCMBcOQ27dWSnJs6km
         ajcKvt2ptrSBK65Y0wknPaXO08qdzGGpWy1YxNbJ+Zi3SNbJpwoDQ9aHxCO7WKVlrKxm
         8MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqEIUvOwohephlofOmmLb1b6WQ3FllXjftCHIKtplvw=;
        b=Wcj0+aXOkBhgPQNT7nv6Au8B1dUgF4uqUOta63wGTXeCrIfbtKAgKWkVf85uzhWNgS
         XxGW3HwlFTNfzi+cfYLvInqqou/wFvbiyWjZPBGJNAbgCWPIadi2nLlR9zrptdnggnFE
         8hACu3Fy9Z2Ug1k+ipXYEnpbMSFo6KAdO8Di99I8j3SKnAfzShcViq3M4XPp0ygWFzSP
         v/vjr4y39XS8M/xxhwfSPV4JLm0chwV0/hSv13PFbKkbC435NJrI8SOwxCSunOXCiUri
         y1N7LincHiJ9osTmQcvMIzodps9c63VemFhYk/bEzTAEmnEA+XYuohTvXcQ0MJMBEAlO
         HG+Q==
X-Gm-Message-State: AOAM531YlLmh95KypuZ8xpsKOkxtft52+vd1MJQ22MWY2tPlVdWz6iVw
        UVAULbvLAXOOTTInufq3+y8=
X-Google-Smtp-Source: ABdhPJywEW1+u5KxW6llw9kTPdI0GqiJdUzUBLg1j+arDS1xVMKwcrZwv0PdPAqjmPwah2kzL+H9Kg==
X-Received: by 2002:a05:6402:1d11:: with SMTP id dg17mr29628425edb.30.1624833619402;
        Sun, 27 Jun 2021 15:40:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-bd64-8b00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:bd64:8b00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id jz27sm6048861ejc.33.2021.06.27.15.40.18
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
Subject: [PATCH v3 2/3] clk: divider: Switch from .round_rate to .determine_rate by default
Date:   Mon, 28 Jun 2021 00:39:58 +0200
Message-Id: <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
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
2.32.0

