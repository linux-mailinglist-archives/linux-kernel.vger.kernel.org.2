Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF4312267
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBGIL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:11:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:18006 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGIL4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:11:56 -0500
IronPort-SDR: 2FKl7M9tULCosPW9luabX92Xg7jaGfJ9YfQjEWMG9W9YLE78kxg9c1ltAqGwNvMJQmZ3MyyaXO
 Z3ckstg79Ifw==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="266423824"
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="266423824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 00:10:10 -0800
IronPort-SDR: o9rjD4BPlKBzGnQ3GOx3NtxN2RAvEhAluJtzVuG55wHb1SChZrLabTsHscu5m4lqIf2A/vNQHe
 4J2iCi/Kpvjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="486538861"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2021 00:10:06 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 1/2] perf util: Change intlist int to unsigned long
Date:   Sun,  7 Feb 2021 16:09:34 +0800
Message-Id: <20210207080935.31784-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to let intlist support address.

One potential problem is it can't support negative number. But
so far, there is no such kind of use case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v3:
   No change.

 v2:
   New in v2.

 tools/perf/util/intlist.c     | 27 ++++++++++++++++-----------
 tools/perf/util/intlist.h     | 10 +++++-----
 tools/perf/util/probe-event.c |  2 +-
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/intlist.c b/tools/perf/util/intlist.c
index 84e5304e151a..934092199f89 100644
--- a/tools/perf/util/intlist.c
+++ b/tools/perf/util/intlist.c
@@ -13,7 +13,7 @@
 static struct rb_node *intlist__node_new(struct rblist *rblist __maybe_unused,
 					 const void *entry)
 {
-	int i = (int)((long)entry);
+	unsigned long i = (unsigned long)entry;
 	struct rb_node *rc = NULL;
 	struct int_node *node = malloc(sizeof(*node));
 
@@ -41,15 +41,20 @@ static void intlist__node_delete(struct rblist *rblist __maybe_unused,
 
 static int intlist__node_cmp(struct rb_node *rb_node, const void *entry)
 {
-	int i = (int)((long)entry);
+	unsigned long i = (unsigned long)entry;
 	struct int_node *node = container_of(rb_node, struct int_node, rb_node);
 
-	return node->i - i;
+	if (node->i > i)
+		return 1;
+	else if (node->i < i)
+		return -1;
+
+	return 0;
 }
 
-int intlist__add(struct intlist *ilist, int i)
+int intlist__add(struct intlist *ilist, unsigned long i)
 {
-	return rblist__add_node(&ilist->rblist, (void *)((long)i));
+	return rblist__add_node(&ilist->rblist, (void *)i);
 }
 
 void intlist__remove(struct intlist *ilist, struct int_node *node)
@@ -58,7 +63,7 @@ void intlist__remove(struct intlist *ilist, struct int_node *node)
 }
 
 static struct int_node *__intlist__findnew(struct intlist *ilist,
-					   int i, bool create)
+					   unsigned long i, bool create)
 {
 	struct int_node *node = NULL;
 	struct rb_node *rb_node;
@@ -67,9 +72,9 @@ static struct int_node *__intlist__findnew(struct intlist *ilist,
 		return NULL;
 
 	if (create)
-		rb_node = rblist__findnew(&ilist->rblist, (void *)((long)i));
+		rb_node = rblist__findnew(&ilist->rblist, (void *)i);
 	else
-		rb_node = rblist__find(&ilist->rblist, (void *)((long)i));
+		rb_node = rblist__find(&ilist->rblist, (void *)i);
 
 	if (rb_node)
 		node = container_of(rb_node, struct int_node, rb_node);
@@ -77,12 +82,12 @@ static struct int_node *__intlist__findnew(struct intlist *ilist,
 	return node;
 }
 
-struct int_node *intlist__find(struct intlist *ilist, int i)
+struct int_node *intlist__find(struct intlist *ilist, unsigned long i)
 {
 	return __intlist__findnew(ilist, i, false);
 }
 
-struct int_node *intlist__findnew(struct intlist *ilist, int i)
+struct int_node *intlist__findnew(struct intlist *ilist, unsigned long i)
 {
 	return __intlist__findnew(ilist, i, true);
 }
@@ -93,7 +98,7 @@ static int intlist__parse_list(struct intlist *ilist, const char *s)
 	int err;
 
 	do {
-		long value = strtol(s, &sep, 10);
+		unsigned long value = strtol(s, &sep, 10);
 		err = -EINVAL;
 		if (*sep != ',' && *sep != '\0')
 			break;
diff --git a/tools/perf/util/intlist.h b/tools/perf/util/intlist.h
index 5c19ee001299..e336b174d0c7 100644
--- a/tools/perf/util/intlist.h
+++ b/tools/perf/util/intlist.h
@@ -9,7 +9,7 @@
 
 struct int_node {
 	struct rb_node rb_node;
-	int i;
+	unsigned long i;
 	void *priv;
 };
 
@@ -21,13 +21,13 @@ struct intlist *intlist__new(const char *slist);
 void intlist__delete(struct intlist *ilist);
 
 void intlist__remove(struct intlist *ilist, struct int_node *in);
-int intlist__add(struct intlist *ilist, int i);
+int intlist__add(struct intlist *ilist, unsigned long i);
 
 struct int_node *intlist__entry(const struct intlist *ilist, unsigned int idx);
-struct int_node *intlist__find(struct intlist *ilist, int i);
-struct int_node *intlist__findnew(struct intlist *ilist, int i);
+struct int_node *intlist__find(struct intlist *ilist, unsigned long i);
+struct int_node *intlist__findnew(struct intlist *ilist, unsigned long i);
 
-static inline bool intlist__has_entry(struct intlist *ilist, int i)
+static inline bool intlist__has_entry(struct intlist *ilist, unsigned long i)
 {
 	return intlist__find(ilist, i) != NULL;
 }
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8eae2afff71a..137f19c5b686 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1074,7 +1074,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
 	}
 
 	intlist__for_each_entry(ln, lr->line_list) {
-		for (; ln->i > l; l++) {
+		for (; ln->i > (unsigned long)l; l++) {
 			ret = show_one_line(fp, l - lr->offset);
 			if (ret < 0)
 				goto end;
-- 
2.17.1

