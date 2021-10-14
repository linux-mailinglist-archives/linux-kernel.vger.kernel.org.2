Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03742D1B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 06:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhJNEy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhJNEy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:54:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 21:52:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso5731545ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 21:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=Mmh3d0ofqlev8/A8K/1ajEqde3yvJSmZNHvBZZp9dxQ=;
        b=s1Fw3cp8w+CCXBfuG55o3e7d4d6vSHZEuLdaIe4SNzmnThdTIQOdkzfaTbehwQ3ojs
         BS2NvF3O7DiVBVUr84hJ39R9AKvDMytBF8cirbYS0gu6iPoqd8YKLZG3xC/JyD+5aznV
         gYv5jSKFznD2R55huhYGA3gOZVbA49tIkSBRLoKmj5DTAIlVkrRFxScWWXLcCOoguzg0
         OkJD/V7p3vn7/atyayi26lbnBonwXu2tV0X0xmxGzfoBZajkbwm/KtEoftLKfma7tgPy
         IGvy9VkGDWpZcHgVHCpkzRqnH3MO8q/OcYF+YndP1c4cu/kmplJ1+v+prfgdDs8xgj4l
         P7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=Mmh3d0ofqlev8/A8K/1ajEqde3yvJSmZNHvBZZp9dxQ=;
        b=0ErjKQST4RSrzURv1KtqJQYbFoYw9MyYMmVLFfH2EdCkAIOoet2Vc8KwznjV5Dzhg1
         up/QjtteyYz+iBsQafjwbT58S+gYTB6E7eJhL79nCj9/+PDDMPrmleLk8L2NLFPWvLPy
         o1qsIEkMA1frHK+kiICJCNK/jyYcQDQZPZgRd9Xb8LjXWje5mJbaQAkHDY08dy3pSWMO
         RDI9w5WP2jsQKHeYW/klGBL3nmyltWRClrYMtDfWq2thXZaRenqG+wKWGCAIt2tHHZji
         jt2MplCPxSL5gQgKeAcX4n0e0lrw7Sn6ubV75Lkm0mzzvyFa//3gRrdYze+0b9QValmO
         N7LQ==
X-Gm-Message-State: AOAM5313rcL9GWqwazUXVc8lOSMgGg716pcgmzwSzf72EXS23cDqzUm4
        OpuYy0MnKtDEld76mOpiHw39f1/sGyRh08Ox2w==
X-Google-Smtp-Source: ABdhPJycGWPujsiqT6VpAUK/MHj2trj6BPXdk7SifteymPqBqT+Es7+ih6zJcKvo9hD6kt4B2KYuckXDmljvYKyR/g==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:ee63:d633:8396:3928])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:150e:: with SMTP id
 q14mr4487116ybu.98.1634187143830; Wed, 13 Oct 2021 21:52:23 -0700 (PDT)
Date:   Wed, 13 Oct 2021 21:52:17 -0700
Message-Id: <20211014045217.3265162-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3] tracing/cfi: Fix cmp_entries_* functions signature mismatch
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        samitolvanen@google.com, ndesaulniers@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        kernel test robot <lkp@intel.com>,
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

Also, fix the build error reported by the kernel test robot [1].

[1] https://lore.kernel.org/r/202110141140.zzi4dRh4-lkp@intel.com/

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v3:
  - Fix build error, reported by kernel test robot

Changes in v2:
  - Code style clean up, per Steve
  - Commit message typo fix, per Steve


 kernel/trace/tracing_map.c | 40 ++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index d6bddb157ef2..39bb56d2dcbe 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -834,29 +834,35 @@ int tracing_map_init(struct tracing_map *map)
 	return err;
 }
 
-static int cmp_entries_dup(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_dup(const void *A, const void *B)
 {
+	const struct tracing_map_sort_entry *a, *b;
 	int ret = 0;
 
-	if (memcmp((*a)->key, (*b)->key, (*a)->elt->map->key_size))
+	a = *(const struct tracing_map_sort_entry **)A;
+	b = *(const struct tracing_map_sort_entry **)B;
+
+	if (memcmp(a->key, b->key, a->elt->map->key_size))
 		ret = 1;
 
 	return ret;
 }
 
-static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_sum(const void *A, const void *B)
 {
 	const struct tracing_map_elt *elt_a, *elt_b;
+	const struct tracing_map_sort_entry *a, *b;
 	struct tracing_map_sort_key *sort_key;
 	struct tracing_map_field *field;
 	tracing_map_cmp_fn_t cmp_fn;
 	void *val_a, *val_b;
 	int ret = 0;
 
-	elt_a = (*a)->elt;
-	elt_b = (*b)->elt;
+	a = *(const struct tracing_map_sort_entry **)A;
+	b = *(const struct tracing_map_sort_entry **)B;
+
+	elt_a = a->elt;
+	elt_b = b->elt;
 
 	sort_key = &elt_a->map->sort_key;
 
@@ -873,18 +879,21 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
 	return ret;
 }
 
-static int cmp_entries_key(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_key(const void *A, const void *B)
 {
 	const struct tracing_map_elt *elt_a, *elt_b;
+	const struct tracing_map_sort_entry *a, *b;
 	struct tracing_map_sort_key *sort_key;
 	struct tracing_map_field *field;
 	tracing_map_cmp_fn_t cmp_fn;
 	void *val_a, *val_b;
 	int ret = 0;
 
-	elt_a = (*a)->elt;
-	elt_b = (*b)->elt;
+	a = *(const struct tracing_map_sort_entry **)A;
+	b = *(const struct tracing_map_sort_entry **)B;
+
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

