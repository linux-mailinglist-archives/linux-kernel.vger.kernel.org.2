Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA5342CFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJNBjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNBjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:39:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A916C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:37:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so5271089yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=IPQvsABWBlV/Yj3zwRFYTVspiMO6ztBhBPWI5Nu6GEU=;
        b=KNx7rQqSV743LN1E5HrfN/qhRsmQiwXPugSCVTPbZhv/4U4rmRogixTfkgZ2ya0g95
         cch+DSIYg8nxwMLsZhqkFzwZojhTjhZ1W3dljvnoefqdqOaBPK8mN+07WqbkOTIJCP61
         gLsU1pd+ghgpYY4hlE0CTVnr9VybucE2U9AMytuZlN8Ez5Nk8NtiHptQuNSnfnpEgTj9
         YC/blsNZRoaBj6w7wczJ5r1KRz4aKOcadeFSjO5YvtbKktfVtCkWoESbU+Mi1go9b5s5
         H8lL9QsuPpOWtjhDTYudlRi1zea5y5334AumQBF2gycf5wA0bNiejOG8PiXFl89cW7f1
         8T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=IPQvsABWBlV/Yj3zwRFYTVspiMO6ztBhBPWI5Nu6GEU=;
        b=WZin0PbnKrHSlARoVs6Iqdvfj118eVHUXSe/46izJQ+mao4KJmzYdXhcxICSsEQfh6
         nqR02R4b75edV7Gl8yjPJ0ENRU9U/pW1A4InoJqrqwNTtoZSg4qc24vcPU63azEP7SrM
         5V95zyjf/F8UVuDk1C+Yh7ZdhL22Aao76BUPo4Sogd79O0/LkrUBv1MOwYhv3JHzrGMk
         d+9kgtX0GNNhX/6L6bJL2PVcZPvTRZ3YDEql4MZbMzs+zAF642fP6TsUT1cv4Qz9VzGK
         n1Kpb6ktNzQUm/Z0QckD0Om4n+UABmI9OIhmDgBSdFLoVrqVPF8EPYBKn+j61o0HvOkj
         yuWw==
X-Gm-Message-State: AOAM531rX97puDaHsKSeoSpxz2byQ49V7xJomrPZ+xYSnqKb3j6xPA8Z
        oJWC5/3I1p7Of8l5u8EuxyR+VEiJna1u9YaNzw==
X-Google-Smtp-Source: ABdhPJwO6vGwqPw42VEhFhh6+zm3I78iAki63GabOfRCoUpI8dP0okgq7itUMTPtOFI8jTz0bgetyuAXcAKFqNo8sQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:dc9e:eab7:5722:3ffe])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:701:: with SMTP id
 k1mr3519923ybt.298.1634175431590; Wed, 13 Oct 2021 18:37:11 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:37:03 -0700
Message-Id: <20211014013704.2854890-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2] tracing/cfi: Fix cmp_entries_* functions signature mismatch
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
    2. cat events/sched/sched_switch/hist
    3. kernel panics on attempting to read hist

This happens because the sort() function expects a generic
int (*)(const void *, const void *) pointer for the compare function.
To prevent this CFI failure, change tracing map cmp_entries_* function
signatures to match this.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v2:
  - Code style clean up, per Steve
  - Commit message typo fix, per Steve

 kernel/trace/tracing_map.c | 40 ++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index d6bddb157ef2..4f91a81dd838 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -834,20 +834,26 @@ int tracing_map_init(struct tracing_map *map)
 	return err;
 }
 
-static int cmp_entries_dup(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_dup(const void *A, const void *B)
 {
+	const struct tracing_map_sort_entry **pa = A;
+	const struct tracing_map_sort_entry **pb = B;
+	const struct tracing_map_sort_entry *a = *pa;
+	const struct tracing_map_sort_entry *b = *pb;
 	int ret = 0;
 
-	if (memcmp((*a)->key, (*b)->key, (*a)->elt->map->key_size))
+	if (memcmp(a->key, b->key, a->elt->map->key_size))
 		ret = 1;
 
 	return ret;
 }
 
-static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_sum(const void *A, const void *B)
 {
+	const struct tracing_map_sort_entry **pa = A;
+	const struct tracing_map_sort_entry **pb = B;
+	const struct tracing_map_sort_entry *a = *pa;
+	const struct tracing_map_sort_entry *b = *pb;
 	const struct tracing_map_elt *elt_a, *elt_b;
 	struct tracing_map_sort_key *sort_key;
 	struct tracing_map_field *field;
@@ -855,8 +861,8 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
 	void *val_a, *val_b;
 	int ret = 0;
 
-	elt_a = (*a)->elt;
-	elt_b = (*b)->elt;
+	elt_a = a->elt;
+	elt_b = b->elt;
 
 	sort_key = &elt_a->map->sort_key;
 
@@ -873,9 +879,12 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
 	return ret;
 }
 
-static int cmp_entries_key(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_key(const void *A, const void *B)
 {
+	const struct tracing_map_sort_entry **pa = A;
+	const struct tracing_map_sort_entry **pb = B;
+	const struct tracing_map_sort_entry *a = *pa;
+	const struct tracing_map_sort_entry *b = *pb;
 	const struct tracing_map_elt *elt_a, *elt_b;
 	struct tracing_map_sort_key *sort_key;
 	struct tracing_map_field *field;
@@ -883,8 +892,8 @@ static int cmp_entries_key(const struct tracing_map_sort_entry **a,
 	void *val_a, *val_b;
 	int ret = 0;
 
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
 

base-commit: 348949d9a4440abdab3b1dc99a9bb660e8c7da7c
-- 
2.33.0.1079.g6e70778dc9-goog

