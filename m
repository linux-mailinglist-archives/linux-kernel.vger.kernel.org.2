Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A437B1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEKWps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhEKWpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:45:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ACE961928;
        Tue, 11 May 2021 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773080;
        bh=8r9E2+l9Xa8KO4K7fU4X/mgB+hibwqHNTw6dpKt00Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IScAUwLI+oC3YEOKGII1weqMLx2SznHRMH7JAszFhrHzudzBlhhv2kBj7oivkUVYe
         y27eZ3P7Uk8M0QKcUw5AP12v8G0hqgIn2KBRSUdQPJqt+wifNMsTEcT1/devpCNTVB
         OKBtB38g8GpjdnH4RQpGOsX+IGPWFGn1fkmrDM1Wyqchur1rPVqp2QM7zrDYBkldKq
         aKSA1z1SPm0ndmkZIsOnrkSejYSj7m+xEL1cC51/oDCqQDAfGFVMn5M+iLMjex16a2
         5w7HUKu4ZXfhh3Fyub39/ZSxm6peCYEGaEWXlI0n5HZ68sXCn8Q0zUe2bTtxKzODCD
         iyFV17JU1oOVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D88715C0138; Tue, 11 May 2021 15:44:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] doc: Fix statement of RCU's memory-ordering requirements
Date:   Tue, 11 May 2021 15:44:36 -0700
Message-Id: <20210511224438.2892442-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1>
References: <20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sentence defining the relationship of accesses before a grace
period to read-side accesses following that same grace period was
missing a small word: "not".  This commit therefore adds it.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index a648b423ba0e..3f6ce41ee0c5 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -21,7 +21,7 @@ Any code that happens after the end of a given RCU grace period is guaranteed
 to see the effects of all accesses prior to the beginning of that grace
 period that are within RCU read-side critical sections.
 Similarly, any code that happens before the beginning of a given RCU grace
-period is guaranteed to see the effects of all accesses following the end
+period is guaranteed to not see the effects of all accesses following the end
 of that grace period that are within RCU read-side critical sections.
 
 Note well that RCU-sched read-side critical sections include any region
-- 
2.31.1.189.g2e36527f23

