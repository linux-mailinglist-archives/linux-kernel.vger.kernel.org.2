Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23F32C470
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357186AbhCDAN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240516AbhCDABD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:01:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFF0B64F4B;
        Thu,  4 Mar 2021 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816022;
        bh=ZNOxLKNlBGfyZrpu0Qsz3RIOaw62Am55XbSLBEJKILg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsfNia68ku6fDo/51dwayamk1BUiY/2v6Irc9ckn8M/yFWuIrTjyZaM0I4SsaIinh
         Dko9h943mASJwfXiB/soflVOVPzjTK9RLsA/WndfZ4CRNmL6vUqLK61382D62wflWy
         cBW2S0dTEAlC+LeVk1BBbXasVnGpB940alZvdi2YWmjZ56+OmTGBAMl5XQuUA8vaQk
         U7a7JRVflfdB9cpMYs8iwbi/+bCFWsuVWS1d0evcAR4rA2EpxEsEXqkY6L/mVe6Rne
         lW6q/ADaQrdAfZCluBl36RwwbZQtfA7RzJw+vFx7/mw0mcrsNkXsqJbRrS+OuF3YyY
         LdxiTvpCyXrhw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Akira Yokosawa <akiyks@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/10] rculist: Replace reference to atomic_ops.rst
Date:   Wed,  3 Mar 2021 16:00:13 -0800
Message-Id: <20210304000019.22459-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

The hlist_nulls_for_each_entry_rcu() docbook header references the
atomic_ops.rst file, which was removed in commit f0400a77ebdc ("atomic:
Delete obsolete documentation").  This commit therefore substitutes a
section in memory-barriers.txt discussing the use of barrier() in loops.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist_nulls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index ff3e947..d8afdb8 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -161,7 +161,7 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
  *
  * The barrier() is needed to make sure compiler doesn't cache first element [1],
  * as this loop can be restarted [2]
- * [1] Documentation/core-api/atomic_ops.rst around line 114
+ * [1] Documentation/memory-barriers.txt around line 1533
  * [2] Documentation/RCU/rculist_nulls.rst around line 146
  */
 #define hlist_nulls_for_each_entry_rcu(tpos, pos, head, member)			\
-- 
2.9.5

