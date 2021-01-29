Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B274308645
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhA2HLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:11:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:17133 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhA2HLP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:11:15 -0500
IronPort-SDR: IbZdoV5P3mdCSrB6tss1RR+fdYyUSyljsILNOPmhgGE7/E0U60gsNthVt+NQXg2owMx6fybiYe
 zXQ1F1OORO3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="180456118"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="180456118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 23:09:29 -0800
IronPort-SDR: JbDe8kmDtyO/QiOEAYEqPJTG49kANFj/Hqen8sxpE7z3NHJRqTnYhOSZqtkBxPiwkouDiXczWU
 VJcoYjyRZqzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="474428973"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2021 23:09:27 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/2] perf util: Change intlist int to unsigned long
Date:   Fri, 29 Jan 2021 15:08:53 +0800
Message-Id: <20210129070854.29312-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to let intlist support address.

One potential problem is it can't support negative number. But
so far, there is no such kind of use case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
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

