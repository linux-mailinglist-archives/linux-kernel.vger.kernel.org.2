Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A3437F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhJVUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234389AbhJVUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441F76128E;
        Fri, 22 Oct 2021 20:48:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sz-000QL6-Cy;
        Fri, 22 Oct 2021 16:48:41 -0400
Message-ID: <20211022204841.234765965@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 17/40] tracing/cfi: Fix cmp_entries_* functions signature mismatch
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

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

Link: https://lkml.kernel.org/r/20211014045217.3265162-1-kaleshsingh@google.com

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
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
 
-- 
2.33.0
