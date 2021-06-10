Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FD73A33FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhFJT0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:26:38 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:37406 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhFJT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:26:29 -0400
Received: by mail-io1-f52.google.com with SMTP id q7so28310717iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HL9o9ctxrHknoeR61K9dgQ4l+oTFbtzywLTa0WvXVK4=;
        b=V3iQh2CjsxmYxYGd5hCEgcOBM7sZS0HvKHFoLXi8Cbk1sgvDD71iZ5U8R/rieoh4lT
         bbA+bywVRsFbXHz5BuIcB444Xa7ujBo9uqopLIwuik90lIfbkrF0dEDzsdBqC+qkEkd/
         r46DWGHEM233gdrx6RyoUfrvEyzN+Y+QczU1mhZWGbWBPdWa3fRH5TR8o8XKtWwttekA
         uabxkM8MjFbeasUqF9n/nxvNb7N+vLGbuA4+d13scN+TpBNy77s2v3p+u8oLBitMTGk5
         Vii0MU2S8tKH6VOrZnkqz5W9fUaC3EMNpzP0V+HtVUdDqOfq9NSlEBzFXkYdZtE+H0hl
         ZwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HL9o9ctxrHknoeR61K9dgQ4l+oTFbtzywLTa0WvXVK4=;
        b=E64aPcgwzFpE6Ajut9kstXZqnlTDfNu6cmoO+UHDJhFNadqIOQoUg4pGxycz0CmEnV
         jMdhdM68KiW+Vcy+7H8o3nCuYifworX+MeGrLPMcU/pn0rKxMT2C4ekG2fam266eWv0i
         GkrdVapeZQjUXUseLWHsPUxc2EZIg94it2+jPqhLngJFtTs7UcM8jzsoKJ7Z+n9U13Fz
         OzTnGN469f6puhH0UUT8F0+zvS9lQxz2LI+PdMQf45WYfmhbXtXtEBqo4Caq04x90HSq
         wr18XUCDU6Vw9ptyKd/771dB8urOZFBjOUDMjGtHgbEsADid16oleCOS2M1GxgeOctxj
         e/kw==
X-Gm-Message-State: AOAM533Exhgsn6E+fuvHAxxtGY6ZEQfMXDHmkVFnJeLVNMdSXYroxfSq
        IkEA230M/eEfADxAMp8gUjLCmA==
X-Google-Smtp-Source: ABdhPJzpU4D3z4QomuSprLiM4T9fCmLxTozvveww/Hmo/GwHhNDiLFvPmLlBaWrTr5T8ZUVT+kycUw==
X-Received: by 2002:a05:6638:3885:: with SMTP id b5mr206110jav.68.1623352998699;
        Thu, 10 Jun 2021 12:23:18 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w21sm2028684iol.52.2021.06.10.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:23:18 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/8] net: ipa: pass memory id to ipa_table_valid_one()
Date:   Thu, 10 Jun 2021 14:23:06 -0500
Message-Id: <20210610192308.2739540-7-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610192308.2739540-1-elder@linaro.org>
References: <20210610192308.2739540-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop passing most of the Boolean flags to ipa_table_valid_one(), and
just pass a memory region ID to it instead.  We still need to
indicate whether we're operating on a routing or filter table.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 44 +++++++++++++------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index f7ee75bfba748..679855b1d5495 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -150,29 +150,16 @@ static void ipa_table_validate_build(void)
 }
 
 static bool
-ipa_table_valid_one(struct ipa *ipa, bool route, bool ipv6, bool hashed)
+ipa_table_valid_one(struct ipa *ipa, enum ipa_mem_id mem_id, bool route)
 {
+	const struct ipa_mem *mem = &ipa->mem[mem_id];
 	struct device *dev = &ipa->pdev->dev;
-	const struct ipa_mem *mem;
 	u32 size;
 
-	if (route) {
-		if (ipv6)
-			mem = hashed ? &ipa->mem[IPA_MEM_V6_ROUTE_HASHED]
-				     : &ipa->mem[IPA_MEM_V6_ROUTE];
-		else
-			mem = hashed ? &ipa->mem[IPA_MEM_V4_ROUTE_HASHED]
-				     : &ipa->mem[IPA_MEM_V4_ROUTE];
+	if (route)
 		size = IPA_ROUTE_COUNT_MAX * sizeof(__le64);
-	} else {
-		if (ipv6)
-			mem = hashed ? &ipa->mem[IPA_MEM_V6_FILTER_HASHED]
-				     : &ipa->mem[IPA_MEM_V6_FILTER];
-		else
-			mem = hashed ? &ipa->mem[IPA_MEM_V4_FILTER_HASHED]
-				     : &ipa->mem[IPA_MEM_V4_FILTER];
+	else
 		size = (1 + IPA_FILTER_COUNT_MAX) * sizeof(__le64);
-	}
 
 	if (!ipa_cmd_table_valid(ipa, mem, route, ipv6, hashed))
 		return false;
@@ -185,9 +172,8 @@ ipa_table_valid_one(struct ipa *ipa, bool route, bool ipv6, bool hashed)
 	if (hashed && !mem->size)
 		return true;
 
-	dev_err(dev, "IPv%c %s%s table region size 0x%02x, expected 0x%02x\n",
-		ipv6 ? '6' : '4', hashed ? "hashed " : "",
-		route ? "route" : "filter", mem->size, size);
+	dev_err(dev, "%s table region %u size 0x%02x, expected 0x%02x\n",
+		route ? "route" : "filter", mem_id, mem->size, size);
 
 	return false;
 }
@@ -195,16 +181,16 @@ ipa_table_valid_one(struct ipa *ipa, bool route, bool ipv6, bool hashed)
 /* Verify the filter and route table memory regions are the expected size */
 bool ipa_table_valid(struct ipa *ipa)
 {
-	bool valid = true;
+	bool valid;
 
-	valid = valid && ipa_table_valid_one(ipa, false, false, false);
-	valid = valid && ipa_table_valid_one(ipa, false, false, true);
-	valid = valid && ipa_table_valid_one(ipa, false, true, false);
-	valid = valid && ipa_table_valid_one(ipa, false, true, true);
-	valid = valid && ipa_table_valid_one(ipa, true, false, false);
-	valid = valid && ipa_table_valid_one(ipa, true, false, true);
-	valid = valid && ipa_table_valid_one(ipa, true, true, false);
-	valid = valid && ipa_table_valid_one(ipa, true, true, true);
+	valid = ipa_table_valid_one(IPA_MEM_V4_FILTER, false);
+	valid = valid && ipa_table_valid_one(IPA_MEM_V4_FILTER_HASHED, false);
+	valid = valid && ipa_table_valid_one(IPA_MEM_V6_FILTER, false);
+	valid = valid && ipa_table_valid_one(IPA_MEM_V6_FILTER_HASHED, false);
+	valid = valid && ipa_table_valid_one(IPA_MEM_V4_ROUTE, true);
+	valid = valid && ipa_table_valid_one(IPA_MEM_V4_ROUTE_HASHED, true);
+	valid = valid && ipa_table_valid_one(IPA_MEM_V6_ROUTE, true);
+	valid = valid && ipa_table_valid_one(IPA_MEM_V6_ROUTE_HASHED, true);
 
 	return valid;
 }
-- 
2.27.0

