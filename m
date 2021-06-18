Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2F3AD0DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhFRRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhFRRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:03:55 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A26EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a6so7802412ioe.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5X++ZMQgQPQwkDUzKNJ9qZUoWVgJ/Ufw/Erm7Z0OcB0=;
        b=IfJm9xqmpWI1KkewnBXdsds4xNZjdhStK24T7jjpdPS6gNjXm+KCTGyKwbTTWWsQBP
         o6GCaxxSSbIRZUGJ7pOu9uXRfBldNdXwvprnnauI487GQGqjnj1PhH61NljLOltGRRn2
         AWueQNi1AX0SUOG9MXta6asACDMxOH+/CRfpnc2jVymV+GBhqxF/CA2qAs2O++U2+SeI
         knjwtA6xM8qbopTn7mAo6B4SsYvERsCmbJPnGwyblENCGj+yZvSvx7xy2jB2ChYUrOKz
         kijW2P+24GF2YOKxTBzzQR7mtQqRAjTlqv72tWhrGnF5ainviPjxgtc9Di0U37Y6kmSI
         macA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5X++ZMQgQPQwkDUzKNJ9qZUoWVgJ/Ufw/Erm7Z0OcB0=;
        b=V/3KLKQhktaukwYi6FsRvL5UEGTYH2co5F650/4s/EPXaGGoGd075mR3r9kj4lDs3M
         ZxcQu4McyKPohtsOycidHMEVmYTZ7SQx7TPTSNH0B3ZZpNIXrZgaQvLqobUl0g9gJ4Qs
         +BpH2CTbDmvn/bOlFx5SnDpK0Lj/jItD6RarL0+cxlQDn8Em2cimdvKioXcTX3RWyyH8
         6pNx0iFxwe4toZht/U5r0UPHGYlD+M/85dbqtyf6MJVcu89Tm7L3vmX/xgTBRafxwa5/
         QnxGZ7UQ6fFL/n3eB8B2EV8zRjGzbroY8frcjd8xEBOVqpM/v8TY6pNBsBRtdcWSYkfB
         OWDA==
X-Gm-Message-State: AOAM5302dj8vHjwqbK4eN9fGLxGqxhVbsrh90gz8EdR3MqhzaYMwYxBp
        UdQW5vyxsfpenDa3NUSMiVw=
X-Google-Smtp-Source: ABdhPJyV/fx9o6/YbHPiLb9fSBgGWOlpHza/ozW/81DBqN+3tV27NLC1whFGdWXICJ3lXjDLJ8S8ug==
X-Received: by 2002:a05:6602:14cd:: with SMTP id b13mr4406522iow.193.1624035704090;
        Fri, 18 Jun 2021 10:01:44 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m5sm4377698iov.31.2021.06.18.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:01:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1748E27C005B;
        Fri, 18 Jun 2021 13:01:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 18 Jun 2021 13:01:42 -0400
X-ME-Sender: <xms:ddHMYH7VNLqzgitoOpGqwt5uvwe4ZGPdBrlbWZ5P9DRrPCn-P44siw>
    <xme:ddHMYM42bBypBjX11dtAemGg7-z3qA9geqpwPpOXtqnJXE9rjnA4L9Wb_03EKfDv6
    Nkpq-xjfSyFbULWjg>
X-ME-Received: <xmr:ddHMYOfBmHRjP2NtILaMbmxmYP3hHfNBy__YGU5ywaUaFtcFVssG42U95GE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ddHMYIKFFztOsIURW2u1zhw8jYtWF608ldbRXh54yE1fvii59QTd4w>
    <xmx:ddHMYLJoEleTW85dD8NMywd2mcyZq3lbYBUwt04_pxHnYAVEy9lT8g>
    <xmx:ddHMYBwc5f0otuwTguXpJl84XBkFrpcCtlyLc2dUcS9_C1mIFCxBUA>
    <xmx:dtHMYBifAQpI5uIN93U95cHJAYULiQTMdi7j22G7hin8x06E6TFSYg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 13:01:41 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/4] locking/lockdep: Fix the dep path printing for backwards BFS
Date:   Sat, 19 Jun 2021 01:01:07 +0800
Message-Id: <20210618170110.3699115-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618170110.3699115-1-boqun.feng@gmail.com>
References: <20210618170110.3699115-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use the same code to print backwards lock dependency path as the
forwards lock dependency path, and this could result into incorrect
printing because for a backwards lock_list ->trace is not the call trace
where the lock of ->class is acquired.

Fix this by introducing a separate function on printing the backwards
dependency path. Also add a few comments about the printing while we are
at it.

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 108 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48d736aa03b2..3b32cd9cdfd0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2304,7 +2304,56 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 }
 
 /*
- * printk the shortest lock dependencies from @start to @end in reverse order:
+ * Dependency path printing:
+ *
+ * After BFS we get a lock dependency path (linked via ->parent of lock_list),
+ * printing out each lock in the dependency path will help on understanding how
+ * the deadlock could happen. Here are some details about dependency path
+ * printing:
+ *
+ * 1)	A lock_list can be either forwards or backwards for a lock dependency,
+ * 	for a lock dependency A -> B, there are two lock_lists:
+ *
+ * 	a)	lock_list in the ->locks_after list of A, whose ->class is B and
+ * 		->links_to is A. In this case, we can say the lock_list is
+ * 		"A -> B" (forwards case).
+ *
+ * 	b)	lock_list in the ->locks_before list of B, whose ->class is A
+ * 		and ->links_to is B. In this case, we can say the lock_list is
+ * 		"B <- A" (bacwards case).
+ *
+ * 	The ->trace of both a) and b) point to the call trace where B was
+ * 	acquired with A held.
+ *
+ * 2)	A "helper" lock_list is introduced during BFS, this lock_list doesn't
+ * 	represent a certain lock dependency, it only provides an initial entry
+ * 	for BFS. For example, BFS may introduce a "helper" lock_list whose
+ * 	->class is A, as a result BFS will search all dependencies starting with
+ * 	A, e.g. A -> B or A -> C.
+ *
+ * 	The notation of a forwards helper lock_list is like "-> A", which means
+ * 	we should search the forwards dependencies starting with "A", e.g A -> B
+ * 	or A -> C.
+ *
+ * 	The notation of a bacwards helper lock_list is like "<- B", which means
+ * 	we should search the backwards dependencies ending with "B", e.g.
+ * 	B <- A or B <- C.
+ */
+
+/*
+ * printk the shortest lock dependencies from @root to @leaf in reverse order.
+ *
+ * We have a lock dependency path as follow:
+ *
+ *    @root                                                                 @leaf
+ *      |                                                                     |
+ *      V                                                                     V
+ *	          ->parent                                   ->parent
+ * | lock_list | <--------- | lock_list | ... | lock_list  | <--------- | lock_list |
+ * |    -> L1  |            | L1 -> L2  | ... |Ln-2 -> Ln-1|            | Ln-1 -> Ln|
+ *
+ * , so it's natural that we start from @leaf and print every ->class and
+ * ->trace until we reach the @root.
  */
 static void __used
 print_shortest_lock_dependencies(struct lock_list *leaf,
@@ -2332,6 +2381,61 @@ print_shortest_lock_dependencies(struct lock_list *leaf,
 	} while (entry && (depth >= 0));
 }
 
+/*
+ * printk the shortest lock dependencies from @leaf to @root.
+ *
+ * We have a lock dependency path (from a backwards search) as follow:
+ *
+ *    @leaf                                                                 @root
+ *      |                                                                     |
+ *      V                                                                     V
+ *	          ->parent                                   ->parent
+ * | lock_list | ---------> | lock_list | ... | lock_list  | ---------> | lock_list |
+ * | L2 <- L1  |            | L3 <- L2  | ... | Ln <- Ln-1 |            |    <- Ln  |
+ *
+ * , so when we iterate from @leaf to @root, we actually print the lock
+ * dependency path L1 -> L2 -> .. -> Ln in the non-reverse order.
+ *
+ * Another thing to notice here is that ->class of L2 <- L1 is L1, while the
+ * ->trace of L2 <- L1 is the call trace of L2, in fact we don't have the call
+ * trace of L1 in the dependency path, which is alright, because most of the
+ * time we can figure out where L1 is held from the call trace of L2.
+ */
+static void __used
+print_shortest_lock_dependencies_backwards(struct lock_list *leaf,
+					   struct lock_list *root)
+{
+	struct lock_list *entry = leaf;
+	const struct lock_trace *trace = NULL;
+	int depth;
+
+	/*compute depth from generated tree by BFS*/
+	depth = get_lock_depth(leaf);
+
+	do {
+		print_lock_class_header(entry->class, depth);
+		if (trace) {
+			printk("%*s ... acquired at:\n", depth, "");
+			print_lock_trace(trace, 2);
+			printk("\n");
+		}
+
+		/*
+		 * Record the pointer to the trace for the next lock_list
+		 * entry, see the comments for the function.
+		 */
+		trace = entry->trace;
+
+		if (depth == 0 && (entry != root)) {
+			printk("lockdep:%s bad path found in chain graph\n", __func__);
+			break;
+		}
+
+		entry = get_lock_parent(entry);
+		depth--;
+	} while (entry && (depth >= 0));
+}
+
 static void
 print_irq_lock_scenario(struct lock_list *safe_entry,
 			struct lock_list *unsafe_entry,
@@ -2449,7 +2553,7 @@ print_bad_irq_dependency(struct task_struct *curr,
 	prev_root->trace = save_trace();
 	if (!prev_root->trace)
 		return;
-	print_shortest_lock_dependencies(backwards_entry, prev_root);
+	print_shortest_lock_dependencies_backwards(backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
-- 
2.30.2

