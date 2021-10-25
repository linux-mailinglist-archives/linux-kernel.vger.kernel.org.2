Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3A439686
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhJYMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhJYMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:46:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EDCC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:44:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c4so10795127pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U205qA0D781B6BaETFIwO9vBDYC4f6gXi1xSjPP3fXU=;
        b=g1CwdOIb6G3OfFsqliVbTjyWQceAZOwYXt44/ZnnPt2Jia+VgVq7stwEsXdnKAlgdu
         ztpDf54id5sZIcG6BJj8gH6PlHg9XnomEXcqgJ39sf+/vc+9wosB14P0CR6PtI2BkwfO
         vLAf0Nzhq2ahclTirUPK9SZ5lJJQR2IXbVCrjM9zPYUInwBDtUN68vUofy3S7HWpcb22
         ZP0QGT7zV4ZXfkpZu5QEzpRQRKPrsVAWJSr0uFRQv/R/qW9QmxwXSgNdjBaeC204LCp2
         RX8u3SVBuruiHeJdIJloznfKo0o6ad7ODEUX+QbevHx5RA4Ql6AmwfCSzsdQoN4C+Ywl
         MBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U205qA0D781B6BaETFIwO9vBDYC4f6gXi1xSjPP3fXU=;
        b=h9jKc3ANd+TDY+MGv5QD8QPvNlxDV+nwelAkxPeeTeXR3bbol/F7QnP2ylBkPynr2y
         cKdCXVzAMQT1pNRNUeYJElAamWY1zUxF1eeJE68G/iGrRe/MKuPlaM1K6soChbp19X00
         DrtsW9Q/zUpTAGyHIg1ZIoqaDpXzUTbcitDAfHmijTLjia9cCcpwtEYFrOao0rIC/AzP
         iicLI95WMzr6UQNE4qw5CaZurRpya+eTNt/5q04paCNnDx+E6lXrsmfOd23YezutF9/V
         WtsN5y9sjd6OrCHNTQMmFztmhnSUjZhMf9WWlrppIKvaXmYvBrdKTXtUCCMP1fsDgMYM
         p2Yw==
X-Gm-Message-State: AOAM532bjyf9O5gpPueuVAkL/7BOwpNmjA712onoMKxoLdVcPxY+Uwt7
        y+VgZvAu8TRFzF+ro3YWqcVrfA==
X-Google-Smtp-Source: ABdhPJz1eITwLyRpzzpaOiB0M7R2BWkp27hRsKyc5Soj3i18Pmn5EURUsGknMYb9ZKpjVihvM5mzlw==
X-Received: by 2002:a62:e816:0:b0:47b:d98e:f934 with SMTP id c22-20020a62e816000000b0047bd98ef934mr14348848pfi.83.1635165851469;
        Mon, 25 Oct 2021 05:44:11 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id h1sm9400347pjf.10.2021.10.25.05.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 05:44:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, mhocko@kernel.org, shakeelb@google.com,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: list_lru: only add memcg-aware lrus to the global lru list
Date:   Mon, 25 Oct 2021 20:43:53 +0800
Message-Id: <20211025124353.55781-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non-memcg-aware lru is always skiped when traversing the global lru
list, which is not efficient. We can only add the memcg-aware lru to the
global lru list instead to make traversing more efficient.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 7572f8e70b86..0cd5e89ca063 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -15,18 +15,29 @@
 #include "slab.h"
 
 #ifdef CONFIG_MEMCG_KMEM
-static LIST_HEAD(list_lrus);
+static LIST_HEAD(memcg_list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
 
+static inline bool list_lru_memcg_aware(struct list_lru *lru)
+{
+	return lru->memcg_aware;
+}
+
 static void list_lru_register(struct list_lru *lru)
 {
+	if (!list_lru_memcg_aware(lru))
+		return;
+
 	mutex_lock(&list_lrus_mutex);
-	list_add(&lru->list, &list_lrus);
+	list_add(&lru->list, &memcg_list_lrus);
 	mutex_unlock(&list_lrus_mutex);
 }
 
 static void list_lru_unregister(struct list_lru *lru)
 {
+	if (!list_lru_memcg_aware(lru))
+		return;
+
 	mutex_lock(&list_lrus_mutex);
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
@@ -37,11 +48,6 @@ static int lru_shrinker_id(struct list_lru *lru)
 	return lru->shrinker_id;
 }
 
-static inline bool list_lru_memcg_aware(struct list_lru *lru)
-{
-	return lru->memcg_aware;
-}
-
 static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 {
@@ -457,9 +463,6 @@ static int memcg_update_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return 0;
-
 	for_each_node(i) {
 		if (memcg_update_list_lru_node(&lru->node[i],
 					       old_size, new_size))
@@ -482,9 +485,6 @@ static void memcg_cancel_update_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return;
-
 	for_each_node(i)
 		memcg_cancel_update_list_lru_node(&lru->node[i],
 						  old_size, new_size);
@@ -497,7 +497,7 @@ int memcg_update_all_list_lrus(int new_size)
 	int old_size = memcg_nr_cache_ids;
 
 	mutex_lock(&list_lrus_mutex);
-	list_for_each_entry(lru, &list_lrus, list) {
+	list_for_each_entry(lru, &memcg_list_lrus, list) {
 		ret = memcg_update_list_lru(lru, old_size, new_size);
 		if (ret)
 			goto fail;
@@ -506,7 +506,7 @@ int memcg_update_all_list_lrus(int new_size)
 	mutex_unlock(&list_lrus_mutex);
 	return ret;
 fail:
-	list_for_each_entry_continue_reverse(lru, &list_lrus, list)
+	list_for_each_entry_continue_reverse(lru, &memcg_list_lrus, list)
 		memcg_cancel_update_list_lru(lru, old_size, new_size);
 	goto out;
 }
@@ -543,9 +543,6 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return;
-
 	for_each_node(i)
 		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
@@ -555,7 +552,7 @@ void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 	struct list_lru *lru;
 
 	mutex_lock(&list_lrus_mutex);
-	list_for_each_entry(lru, &list_lrus, list)
+	list_for_each_entry(lru, &memcg_list_lrus, list)
 		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
-- 
2.11.0

