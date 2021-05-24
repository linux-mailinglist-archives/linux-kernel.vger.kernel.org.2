Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1995B38E437
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhEXKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhEXKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:39:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9BC061574;
        Mon, 24 May 2021 03:37:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b9so5817044ejc.13;
        Mon, 24 May 2021 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DuEzwceNsnqYkEeiiZKaUdLTGoHWRI6KUHxHFfU1j4=;
        b=XasM8I+jWP45hASRQz2pDtCH3J/lY7Vm9kZLI+IH/vZEVthGGV4ROUbUeGU/qIqvVp
         tQdMMqtih8wQ0DYSJCMRCUO5g6Ijf+UZ4dkuZ++sRGlARBzMuJSSAyGvho6twoA3822C
         5gr5iumVWLsBjXgmmmQlppiFHgJFTQPpzdaQRA2Dbyd68/2B0Sv4HxV+DTliZouBpf15
         5C20k6fwKt2Bus2t0kdeOhktpkZwM+tnLrKHAJI8fCjg7cU2VKmRZAAlOzaEs+9zbFeQ
         M72Tu9DFhaNuDokzzr6XwgEwXbiI/9yg3yEhhcjLsg4SU953eiB17wRTlAEGBKVmRAUG
         iRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DuEzwceNsnqYkEeiiZKaUdLTGoHWRI6KUHxHFfU1j4=;
        b=omT1eIdGcv6wZopMFiVH2Pdc1S+EsN2/DCU4HBN0h8GwGoK9meCHf9/oOJfgNrf2Or
         TpahkTbXR00IVUud2rAhuSQIlfwVQMiHxc7ypeKOJ+bHl3rrJ+vy1fSopVNtaqfkyb7P
         y3YwIcOYerMW9vM97E43FAW6WfdPHQN88lv2Mu+a6efOjkJbwFbrGRQeHdPoagwhxuM6
         y3jD5Z5cZVi3sb995xn1+Fvc8QPSQyHwcbgbL08PcU0clULx9FCeoTb9NkuX+SYZ6Wwt
         dVZkMA2xXlhQGSHtkRgENtQrlPta0csqdlbhStatPlkCKFD3b0ldYCS6hq38q0/W2xkJ
         50NA==
X-Gm-Message-State: AOAM533n8mtBvSegyAD/vnDPmfyNvzOaiZv8UKKYn6Q7ZN50j/90YlID
        KniExJO38MlKIP0vhWMewRQ=
X-Google-Smtp-Source: ABdhPJwQ/2GEiSXKNvjACryhQkePleZPR6KX44B2C0K/pqg7dYhxGhpBo6XdnjV531KBhtbX0t4kCQ==
X-Received: by 2002:a17:907:2136:: with SMTP id qo22mr22269933ejb.246.1621852668092;
        Mon, 24 May 2021 03:37:48 -0700 (PDT)
Received: from localhost.localdomain (p200300f1370a3a00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:370a:3a00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id r15sm2616418edm.61.2021.05.24.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:37:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/3] clk: divider: Add re-usable determine_rate implementations
Date:   Mon, 24 May 2021 12:37:31 +0200
Message-Id: <20210524103733.554878-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
References: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
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
2.31.1

