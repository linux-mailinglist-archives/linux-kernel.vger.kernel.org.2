Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E134163E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbhIWRKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242279AbhIWRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:10:50 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8708DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:09:18 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d20-20020ac81194000000b002a53ffbd04dso17652780qtj.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=OUW6ESXYhfqq2DkGKa3CiMnHY3LiOLy+08GCk+0nAY4=;
        b=cdXqJUE8lQxq65l8Lwvx/zb1vqNJNgJcMyF84gUPPqgmUlT1nBDovcRm365+V/WpmR
         5vmCU4+fquaKwj20VL7MFDEyzEIPHWxGTLP6cLKvUt+TpnDHu/FIdhoIR+2qzjcqP1BA
         0H66FgEbh2EmIH0Z5COqjBi+/IhfQnCZNpM5fG94HT8/XY2mPqUHHtO0aqlamgRR1qPg
         NxxXar5BUpwrliXhNLzd1S4VEesyJxrWkzSKsgHY52c3nhogWjaruSdFS2ELQnAuIH2T
         8p3C3JFapCrRol5os9nnI7ZjVfrtvxXVoXtzAdpKXUfoSk7OOwTGGQPPxR5koK35Wex/
         rQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=OUW6ESXYhfqq2DkGKa3CiMnHY3LiOLy+08GCk+0nAY4=;
        b=16b2stwcXacqXCeINBeRZe0X+2Vqh5NcB9wgk7pmnluZu9W+BDGKx8Wj3ulEeYs354
         UTU+WL0MVr4fZRaO5tcXcFdDzg/rhy+qZt9YXUXxnD9tvaOReKdzw2jHiRxTgDVTPWm8
         4WvD7l9+9MCzsZx51zeTQu9Z+4ob2UKJ3QyVBBa4tgwoczhdviAPJvMmV554FZgC1kU6
         tEgHQLdyiYCckmnXm02TVfwTKX7dpaIYxc/v8MdqJgBZQX1s7nA9qtcOrRkGBSUBqa9k
         dS6NPZjZ9cTsz/rBM9PoKvQO36cJVAun0G62mEVu7Bgn/vrajRa+Xndmn3zdgjXMmhgL
         BXqg==
X-Gm-Message-State: AOAM531hbVFkITkH36PwCh7VYDG89K+Mj9AfN7uZmqW8l6fIl6QPZ8a/
        oSn6H0mGAEyo6SdpuAEAtemxzLX1tLBTg3v4Ew==
X-Google-Smtp-Source: ABdhPJx15vOBZzRIsRc3a63biJmnRxVlbZwwiqCo0vhjjqz0Jt41GveXUY9AFCd0p80TOEqrECRQjbyALoHT6m9pGQ==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:12eb:: with SMTP id
 w11mr5674527qvv.10.1632416957736; Thu, 23 Sep 2021 10:09:17 -0700 (PDT)
Date:   Thu, 23 Sep 2021 17:09:07 +0000
Message-Id: <20210923170908.2184404-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH] tracing/cfi: Fix cmp_entries_* functions signature mismatch
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        samitolvanen@google.com, ndesaulniers@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_CFI_CLANG=y, attempting to read an event histogram will cause
the kernel to panic due to failed CFI check.

    1. echo 'hist:keys=common_pid' >> events/sched/sched_switch/trigger
    2. cat >> events/sched/sched_switch/hist
    3. kernel panices on attempting to read hist

This happens because the sort() function expects a generic
int (*)(const void *, const void *) pointer for the compare function.
To prevent this CFI failure, change tracing map cmp_entries_* function
signatures to match this.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 kernel/trace/tracing_map.c | 40 ++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index d6bddb157ef2..a8c80ebbf9da 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -834,19 +834,21 @@ int tracing_map_init(struct tracing_map *map)
 	return err;
 }
 
-static int cmp_entries_dup(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_dup(const void *__a, const void *__b)
 {
 	int ret = 0;
+	const struct tracing_map_sort_entry *a
+		= *(const struct tracing_map_sort_entry **)__a;
+	const struct tracing_map_sort_entry *b
+		= *(const struct tracing_map_sort_entry **)__b;
 
-	if (memcmp((*a)->key, (*b)->key, (*a)->elt->map->key_size))
+	if (memcmp(a->key, b->key, a->elt->map->key_size))
 		ret = 1;
 
 	return ret;
 }
 
-static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_sum(const void *__a, const void *__b)
 {
 	const struct tracing_map_elt *elt_a, *elt_b;
 	struct tracing_map_sort_key *sort_key;
@@ -854,9 +856,13 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
 	tracing_map_cmp_fn_t cmp_fn;
 	void *val_a, *val_b;
 	int ret = 0;
+	const struct tracing_map_sort_entry *a
+		= *(const struct tracing_map_sort_entry **)__a;
+	const struct tracing_map_sort_entry *b
+		= *(const struct tracing_map_sort_entry **)__b;
 
-	elt_a = (*a)->elt;
-	elt_b = (*b)->elt;
+	elt_a = a->elt;
+	elt_b = b->elt;
 
 	sort_key = &elt_a->map->sort_key;
 
@@ -873,8 +879,7 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
 	return ret;
 }
 
-static int cmp_entries_key(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_key(const void *__a, const void *__b)
 {
 	const struct tracing_map_elt *elt_a, *elt_b;
 	struct tracing_map_sort_key *sort_key;
@@ -882,9 +887,13 @@ static int cmp_entries_key(const struct tracing_map_sort_entry **a,
 	tracing_map_cmp_fn_t cmp_fn;
 	void *val_a, *val_b;
 	int ret = 0;
+	const struct tracing_map_sort_entry *a
+		= *(const struct tracing_map_sort_entry **)__a;
+	const struct tracing_map_sort_entry *b
+		= *(const struct tracing_map_sort_entry **)__b;
 
-	elt_a = (*a)->elt;
-	elt_b = (*b)->elt;
+	elt_a = a->elt;
+	elt_b = b->elt;
 
 	sort_key = &elt_a->map->sort_key;
 
@@ -989,10 +998,8 @@ static void sort_secondary(struct tracing_map *map,
 			   struct tracing_map_sort_key *primary_key,
 			   struct tracing_map_sort_key *secondary_key)
 {
-	int (*primary_fn)(const struct tracing_map_sort_entry **,
-			  const struct tracing_map_sort_entry **);
-	int (*secondary_fn)(const struct tracing_map_sort_entry **,
-			    const struct tracing_map_sort_entry **);
+	int (*primary_fn)(const void *, const void *);
+	int (*secondary_fn)(const void *, const void *);
 	unsigned i, start = 0, n_sub = 1;
 
 	if (is_key(map, primary_key->field_idx))
@@ -1061,8 +1068,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
 			     unsigned int n_sort_keys,
 			     struct tracing_map_sort_entry ***sort_entries)
 {
-	int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
-			      const struct tracing_map_sort_entry **);
+	int (*cmp_entries_fn)(const void *, const void *);
 	struct tracing_map_sort_entry *sort_entry, **entries;
 	int i, n_entries, ret;
 

base-commit: 58e2cf5d794616b84f591d4d1276c8953278ce24
-- 
2.33.0.685.g46640cef36-goog

