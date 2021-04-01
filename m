Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619F4351E44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhDASho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbhDASPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14313C08EBB4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=c3NHMokNs1b8tno3eOjUthKaxalrmwc/HgYhcw2Xxz8=; b=BsqwSopmQgPtxqHdmzCZE5PtlX
        0gVwJGAob6Q5U5IDW9cDwBSnffGCP31t0iqiJDVps7acTWEhLMRlA3E0sca83tBLkwy7xZGQNL4JV
        3DXOH2gmh0bZfPP96qLCxiPmE2aKi3D9tu6izALMdph4gjLpeKqubOxKbrf/6Z55C0vHjoFluYi2v
        Ia652XoWoBi4Vu2d0WCnnMuvURk6GCSqU2tlEIUMTYSpLlMSQzT8QsvG2oOX9DqhsgiaYREuIeqGB
        f/QvRjFB3ug439ML/wHxgbZFchxgpFqpcn67Eq8b40W+kkRQ/nmYPs4qzihJptH7VUvGS3s7VQ6Ny
        75meDvLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxam-006BoP-Ce; Thu, 01 Apr 2021 13:42:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42EBE307697;
        Thu,  1 Apr 2021 15:42:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E529C24C1A53E; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.530171303@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 8/9] rbtree: Remove const from the rb_find_add() comparator
References: <20210401131012.395311786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the rb_find_add() comparator to modify existing entries.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rbtree.h       |    2 +-
 kernel/events/uprobes.c      |    2 +-
 tools/include/linux/rbtree.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -248,7 +248,7 @@ rb_add(struct rb_node *node, struct rb_r
  */
 static __always_inline struct rb_node *
 rb_find_add(struct rb_node *node, struct rb_root *tree,
-	    int (*cmp)(struct rb_node *, const struct rb_node *))
+	    int (*cmp)(struct rb_node *, struct rb_node *))
 {
 	struct rb_node **link = &tree->rb_node;
 	struct rb_node *parent = NULL;
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -646,7 +646,7 @@ static inline int __uprobe_cmp_key(const
 	return uprobe_cmp(a->inode, a->offset, __node_2_uprobe(b));
 }
 
-static inline int __uprobe_cmp(struct rb_node *a, const struct rb_node *b)
+static inline int __uprobe_cmp(struct rb_node *a, struct rb_node *b)
 {
 	struct uprobe *u = __node_2_uprobe(a);
 	return uprobe_cmp(u->inode, u->offset, __node_2_uprobe(b));
--- a/tools/include/linux/rbtree.h
+++ b/tools/include/linux/rbtree.h
@@ -232,7 +232,7 @@ rb_add(struct rb_node *node, struct rb_r
  */
 static __always_inline struct rb_node *
 rb_find_add(struct rb_node *node, struct rb_root *tree,
-	    int (*cmp)(struct rb_node *, const struct rb_node *))
+	    int (*cmp)(struct rb_node *, struct rb_node *))
 {
 	struct rb_node **link = &tree->rb_node;
 	struct rb_node *parent = NULL;


