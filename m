Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70D33A33F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFJT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:26:17 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:34598 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhFJT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:26:14 -0400
Received: by mail-il1-f173.google.com with SMTP id w14so2918485ilv.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZO4h+PYJOf6ZfOfwhNt7/7Z/XLn2xofEcctKVO8NNKs=;
        b=kW3vUZ34Jg0z7b8YWn5WOik7kunMU2bkK85BgKtIcOiZPG4VRqpj5Y9dCv7fb/7EIG
         0CPfmSBIItmGNF4ni4gSZ/VIsSMQNref054WRaGh3xhJB8Pna4/u27bBGe/t6/ZU2Vj4
         diUyLXA3BKhNQn8OJaYmwNcwMpDJ3ktNFJh/WCMHqACgUVGqgM3hh+7q7jPl2HLhEZU7
         th2gddESeNyzgbJGKvZeQIg7CEKVacq0Es6SAQcwf5aFP91c+vy7prFQeb8Adt/RAk6C
         Ye+D9XdueFYLCUEKrkQMFXAmYVzi+CYZcSPQkrPfU1nKH1iTYvMFvRycbOg+k1NJE9bT
         c23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZO4h+PYJOf6ZfOfwhNt7/7Z/XLn2xofEcctKVO8NNKs=;
        b=CW1JJCrNmTjHCONm3u5JDuQp3Rm5qybZ2IBvWJ59NXoV6m6EkW7SD9af2vOC4FJmZM
         VFfR5JxVbjIMth1wAvV1mY0Z+tF/5Exj/X4bqqS7tMvqnddZEf1OI5ZtZOczgliUbT12
         ruZCne6G8zLkDf+fBu0nwk7BFgnxfk+2P5mtgZu1Kpn32TZgCNFdMQ1HOM1S1DEMxMfq
         LQ8KDGUOCGaaFSTKaWc9g0y6MYW8iff/1e10u9Gzf29nCU5FAXqbF7t6cKU/HK5BIChG
         RIc7BRH24oM+1He1LMlcYlmikz7/LY7ka130ykFyx9Pbi0Y7dwE9sNPphEKe/rHOCBRA
         BNjQ==
X-Gm-Message-State: AOAM530ZfqHWAFRgFp7v8x3fxceQeCZh9yIziq/svCs0ZSHq+KPhkBpA
        CxN2KkQSvM68Qalvqmt1TxnvuA==
X-Google-Smtp-Source: ABdhPJw6AQYL4X41gV2hfYbUd8Sv9roceSUw7Jv5IkGJN0QRwBCW1QVu5zCXdtI4TJE6outi8P7SZg==
X-Received: by 2002:a05:6e02:1068:: with SMTP id q8mr276336ilj.276.1623352997667;
        Thu, 10 Jun 2021 12:23:17 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w21sm2028684iol.52.2021.06.10.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:23:17 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/8] net: ipa: pass mem_id to ipa_table_reset_add()
Date:   Thu, 10 Jun 2021 14:23:05 -0500
Message-Id: <20210610192308.2739540-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610192308.2739540-1-elder@linaro.org>
References: <20210610192308.2739540-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass a memory region ID rather than the address of a memory region
descriptor to ipa_table_reset_add() to simplify callers.  Similarly,
pass memory region IDs to ipa_table_init_add().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index 95a4c2aceb010..f7ee75bfba748 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -256,14 +256,15 @@ static dma_addr_t ipa_table_addr(struct ipa *ipa, bool filter_mask, u16 count)
 }
 
 static void ipa_table_reset_add(struct gsi_trans *trans, bool filter,
-				u16 first, u16 count, const struct ipa_mem *mem)
+				u16 first, u16 count, enum ipa_mem_id mem_id)
 {
 	struct ipa *ipa = container_of(trans->gsi, struct ipa, gsi);
+	const struct ipa_mem *mem = &ipa->mem[mem_id];
 	dma_addr_t addr;
 	u32 offset;
 	u16 size;
 
-	/* Nothing to do if the table memory regions is empty */
+	/* Nothing to do if the table memory region is empty */
 	if (!mem->size)
 		return;
 
@@ -284,7 +285,6 @@ static void ipa_table_reset_add(struct gsi_trans *trans, bool filter,
 static int
 ipa_filter_reset_table(struct ipa *ipa, enum ipa_mem_id mem_id, bool modem)
 {
-	const struct ipa_mem *mem = &ipa->mem[mem_id];
 	u32 ep_mask = ipa->filter_map;
 	u32 count = hweight32(ep_mask);
 	struct gsi_trans *trans;
@@ -309,7 +309,7 @@ ipa_filter_reset_table(struct ipa *ipa, enum ipa_mem_id mem_id, bool modem)
 		if (endpoint->ee_id != ee_id)
 			continue;
 
-		ipa_table_reset_add(trans, true, endpoint_id, 1, mem);
+		ipa_table_reset_add(trans, true, endpoint_id, 1, mem_id);
 	}
 
 	gsi_trans_commit_wait(trans);
@@ -367,15 +367,13 @@ static int ipa_route_reset(struct ipa *ipa, bool modem)
 		count = IPA_ROUTE_AP_COUNT;
 	}
 
+	ipa_table_reset_add(trans, false, first, count, IPA_MEM_V4_ROUTE);
 	ipa_table_reset_add(trans, false, first, count,
-			    &ipa->mem[IPA_MEM_V4_ROUTE]);
-	ipa_table_reset_add(trans, false, first, count,
-			    &ipa->mem[IPA_MEM_V4_ROUTE_HASHED]);
+			    IPA_MEM_V4_ROUTE_HASHED);
 
+	ipa_table_reset_add(trans, false, first, count, IPA_MEM_V6_ROUTE);
 	ipa_table_reset_add(trans, false, first, count,
-			    &ipa->mem[IPA_MEM_V6_ROUTE]);
-	ipa_table_reset_add(trans, false, first, count,
-			    &ipa->mem[IPA_MEM_V6_ROUTE_HASHED]);
+			    IPA_MEM_V6_ROUTE_HASHED);
 
 	gsi_trans_commit_wait(trans);
 
@@ -429,10 +427,12 @@ int ipa_table_hash_flush(struct ipa *ipa)
 
 static void ipa_table_init_add(struct gsi_trans *trans, bool filter,
 			       enum ipa_cmd_opcode opcode,
-			       const struct ipa_mem *mem,
-			       const struct ipa_mem *hash_mem)
+			       enum ipa_mem_id mem_id,
+			       enum ipa_mem_id hash_mem_id)
 {
 	struct ipa *ipa = container_of(trans->gsi, struct ipa, gsi);
+	const struct ipa_mem *hash_mem = &ipa->mem[hash_mem_id];
+	const struct ipa_mem *mem = &ipa->mem[mem_id];
 	dma_addr_t hash_addr;
 	dma_addr_t addr;
 	u16 hash_count;
@@ -473,20 +473,16 @@ int ipa_table_setup(struct ipa *ipa)
 	}
 
 	ipa_table_init_add(trans, false, IPA_CMD_IP_V4_ROUTING_INIT,
-			   &ipa->mem[IPA_MEM_V4_ROUTE],
-			   &ipa->mem[IPA_MEM_V4_ROUTE_HASHED]);
+			   IPA_MEM_V4_ROUTE, IPA_MEM_V4_ROUTE_HASHED);
 
 	ipa_table_init_add(trans, false, IPA_CMD_IP_V6_ROUTING_INIT,
-			   &ipa->mem[IPA_MEM_V6_ROUTE],
-			   &ipa->mem[IPA_MEM_V6_ROUTE_HASHED]);
+			   IPA_MEM_V6_ROUTE, IPA_MEM_V6_ROUTE_HASHED);
 
 	ipa_table_init_add(trans, true, IPA_CMD_IP_V4_FILTER_INIT,
-			   &ipa->mem[IPA_MEM_V4_FILTER],
-			   &ipa->mem[IPA_MEM_V4_FILTER_HASHED]);
+			   IPA_MEM_V4_FILTER, IPA_MEM_V4_FILTER_HASHED);
 
 	ipa_table_init_add(trans, true, IPA_CMD_IP_V6_FILTER_INIT,
-			   &ipa->mem[IPA_MEM_V6_FILTER],
-			   &ipa->mem[IPA_MEM_V6_FILTER_HASHED]);
+			   IPA_MEM_V6_FILTER, IPA_MEM_V6_FILTER_HASHED);
 
 	gsi_trans_commit_wait(trans);
 
-- 
2.27.0

