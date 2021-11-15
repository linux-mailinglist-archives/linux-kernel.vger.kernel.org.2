Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6664500CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhKOJEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbhKOJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:01:13 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF5C06120A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:57:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636966661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RxPeFCT20glhLqQ5eY/Vl8C9iprAbdhuCAS4bnE3hdk=;
        b=cuorowxW6xc6iHoVQfS9e1jHkqtwUX4xURi/nX6M63g13f6/SOaeOSYOsg8dWw8wnLm27B
        MgEKZmwk5u/MLvWdX4lovVIvPBF/eEnuroj4BafGalRg3UOEAzFHZQG7Pv2xA3n2Bnh9h4
        wFIIFXNBkAR6cubvaxj5xkS4jjgCGRI=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] skbuff: Add helper function for head_frag and pfmemalloc
Date:   Mon, 15 Nov 2021 16:57:08 +0800
Message-Id: <20211115085708.13901-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of build_skb() has the same code, add skb_set_head_frag_pfmemalloc()
for it, at the same time, in-line skb_propagate_pfmemalloc().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/skbuff.h | 19 ++++++++++++-------
 net/core/skbuff.c      | 19 +++++--------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0bd6520329f6..3e26b80bde29 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3007,15 +3007,20 @@ static inline bool dev_page_is_reusable(const struct page *page)
 }
 
 /**
- *	skb_propagate_pfmemalloc - Propagate pfmemalloc if skb is allocated after RX page
- *	@page: The page that was allocated from skb_alloc_page
- *	@skb: The skb that may need pfmemalloc set
+ *	skb_set_head_frag_pfmemalloc - Set head_frag and pfmemalloc
+ *	@skb: The skb that may need head_frag and pfmemalloc set
+ *      @data: data buffer provided by caller
+ *      @frag_size: size of data, or 0 if head was kmalloced
  */
-static inline void skb_propagate_pfmemalloc(const struct page *page,
-					    struct sk_buff *skb)
+static inline void skb_set_head_frag_pfmemalloc(struct sk_buff *skb, void *data,
+						unsigned int frag_size)
 {
-	if (page_is_pfmemalloc(page))
-		skb->pfmemalloc = true;
+
+	if (likely(skb) && frag_size) {
+		skb->head_frag = 1;
+		if (page_is_pfmemalloc(virt_to_head_page(data)))
+			skb->pfmemalloc = 1;
+	}
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 67a9188d8a49..7b3d2bf746ae 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -255,11 +255,8 @@ struct sk_buff *build_skb(void *data, unsigned int frag_size)
 {
 	struct sk_buff *skb = __build_skb(data, frag_size);
 
-	if (skb && frag_size) {
-		skb->head_frag = 1;
-		if (page_is_pfmemalloc(virt_to_head_page(data)))
-			skb->pfmemalloc = 1;
-	}
+	skb_set_head_frag_pfmemalloc(skb, data, frag_size);
+
 	return skb;
 }
 EXPORT_SYMBOL(build_skb);
@@ -278,11 +275,8 @@ struct sk_buff *build_skb_around(struct sk_buff *skb,
 
 	__build_skb_around(skb, data, frag_size);
 
-	if (frag_size) {
-		skb->head_frag = 1;
-		if (page_is_pfmemalloc(virt_to_head_page(data)))
-			skb->pfmemalloc = 1;
-	}
+	skb_set_head_frag_pfmemalloc(skb, data, frag_size);
+
 	return skb;
 }
 EXPORT_SYMBOL(build_skb_around);
@@ -325,10 +319,7 @@ struct sk_buff *napi_build_skb(void *data, unsigned int frag_size)
 {
 	struct sk_buff *skb = __napi_build_skb(data, frag_size);
 
-	if (likely(skb) && frag_size) {
-		skb->head_frag = 1;
-		skb_propagate_pfmemalloc(virt_to_head_page(data), skb);
-	}
+	skb_set_head_frag_pfmemalloc(skb, data, frag_size);
 
 	return skb;
 }
-- 
2.32.0

