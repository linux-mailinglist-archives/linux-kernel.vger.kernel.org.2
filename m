Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93303386B86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbhEQUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbhEQUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:38:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D5CC061756;
        Mon, 17 May 2021 13:37:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so7808808wrr.2;
        Mon, 17 May 2021 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCbbANbTil/Vrfbw1G3IhNkJm7dU8yXSwvHs1y3tpsY=;
        b=Ig2cEeZXfTcxBH7AcezHBXy2YHwkj1VuIxO0VHK8W7rFHK8lNf6G9QCH7LviBZzYFa
         5igJsfTmsZaPj5qHvrs4QExmaiHnz1ZODSipDAn5D/2n6G0BlTOw/S1mP0slZMr/C7ZI
         vyfyUnJ9M5WjdfulYUVhRUfqQwVQcnfWnwqKEeAtscVoYWvaeShV6P7K+ptF2C+CAQO4
         T8ptCnZJkJxF7Yc5MZypq5EHCDEY2mzxBRVxlID1k4J/aMuRJxpfdv8i+XTs/POYTtOh
         3smkcRDol97lMRou/JH2kPSr3FUzTN7W6KLB+s7FJgh0LYgeRM4tAQutl571OMZf8DR7
         w/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCbbANbTil/Vrfbw1G3IhNkJm7dU8yXSwvHs1y3tpsY=;
        b=qm4e849c9DgDsybpMh6yw8t5dW6wFcNFfBWxm82x0psFZa6cANtigCQoxNEWnxMT1C
         8wlbWt8D+OnpXb4cnv+QmpRPRl/B3RrX6bECgpPCdN99KTIJQJDHpwMquddEV24yUrqB
         B90g07DwQg8sVnZfat9mO+ho5G9uwA4a6oe6gN0nIrXdYAJTive3tEGPDGTWK9u/yDzA
         d7Vek86WJ2O23PHVZ/J72fA4h374gBc14IKvtQ0ivr1uSNYWTSvb5tUhG8ECZ+iBqZzL
         Q3J+kdkWzUnHG5cm6q4LE7sR3bvecgVtKeBv3PDnVOPwNLLQMIUikVfQj0f2bT2Q6u8l
         2JhA==
X-Gm-Message-State: AOAM530sA32khy+9H09Q+J+HhUZkMzAXRtNVl3CJHIsYT8lBtbfDdS0j
        RXeuNEXmnnmn1k42XxGS1K4=
X-Google-Smtp-Source: ABdhPJzQogUEFH902p6lXpnk8H8EXfpQe8tUurU5DTO7pDQR6ficNO6/ZS0v/hDIoPOE+CAzNx/Whg==
X-Received: by 2002:a5d:4b89:: with SMTP id b9mr1815668wrt.238.1621283854559;
        Mon, 17 May 2021 13:37:34 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371adf00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371a:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id p6sm3840448wma.4.2021.05.17.13.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:37:34 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-clk@vger.kernel.org
Cc:     khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 1/3] clk: divider: Add re-usable determine_rate implementations
Date:   Mon, 17 May 2021 22:37:22 +0200
Message-Id: <20210517203724.1006254-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
References: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
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

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk-divider.c    | 39 +++++++++++++++++++++++++++++++++++-
 include/linux/clk-provider.h |  6 ++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 344997203f0e..24c94d2a3643 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -377,7 +377,6 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 }
 EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
 
-
 static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *prate)
 {
@@ -399,6 +398,44 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 				  divider->width, divider->flags);
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
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		    const struct clk_div_table *table, u8 width,
 		    unsigned long flags)
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

