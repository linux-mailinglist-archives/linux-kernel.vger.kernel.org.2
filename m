Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FFA3A8F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFPDXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhFPDXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:23:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 299A6613C2;
        Wed, 16 Jun 2021 03:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623813676;
        bh=H/1rsxHk8ldroOc2+bi7w574v2BCSyir0ZtMa99Tvns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ak4D+cP32X7Yl7slNXj0+783UpJ9FByLmWHAKV/geREVCHo/6YJba1kXFom/wdPmC
         DbRSB/5eUwVgk5DSI9wOAdEn/iPagIJbKcwAeJPMsgt6DzFRN8NvCSyOK0kGqZGO7C
         3hF66t74y2hPfm29zLySP0LlpB4yhUc6JBd/+ML4aK/5GMvclAIShjiQrwOds4c9Vn
         0a4onM2CsctRRCWcKYItD5BKM2WqZmgvmNUzs+62JyUTz3vQOF6HdYdAXFRpw/VM+c
         soZLf4m/ToH+miHTFXdcr0n22CGthb/ip7ngvOKBLpQi0OO+6dK6+mNk491T1uCQm6
         hQ6ngyb4wJBTA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/8] membarrier: Document why membarrier() works
Date:   Tue, 15 Jun 2021 20:21:06 -0700
Message-Id: <b648efcb72feb257b9fe004bd132f581805ec0d6.1623813516.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had a nice comment at the top of membarrier.c explaining why membarrier
worked in a handful of scenarios, but that consisted more of a list of
things not to forget than an actual description of the algorithm and why it
should be expected to work.

Add a comment explaining my understanding of the algorithm.  This exposes a
couple of implementation issues that I will hopefully fix up in subsequent
patches.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/sched/membarrier.c | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index b5add64d9698..3173b063d358 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -7,6 +7,61 @@
 #include "sched.h"
 
 /*
+ * The basic principle behind the regular memory barrier mode of membarrier()
+ * is as follows.  For each CPU, membarrier() operates in one of two
+ * modes.  Either it sends an IPI or it does not. If membarrier() sends an
+ * IPI, then we have the following sequence of events:
+ *
+ * 1. membarrier() does smp_mb().
+ * 2. membarrier() does a store (the IPI request payload) that is observed by
+ *    the target CPU.
+ * 3. The target CPU does smp_mb().
+ * 4. The target CPU does a store (the completion indication) that is observed
+ *    by membarrier()'s wait-for-IPIs-to-finish request.
+ * 5. membarrier() does smp_mb().
+ *
+ * So all pre-membarrier() local accesses are visible after the IPI on the
+ * target CPU and all pre-IPI remote accesses are visible after
+ * membarrier(). IOW membarrier() has synchronized both ways with the target
+ * CPU.
+ *
+ * (This has the caveat that membarrier() does not interrupt the CPU that it's
+ * running on at the time it sends the IPIs. However, if that is the CPU on
+ * which membarrier() starts and/or finishes, membarrier() does smp_mb() and,
+ * if not, then membarrier() scheduled, and scheduling had better include a
+ * full barrier somewhere for basic correctness regardless of membarrier.)
+ *
+ * If membarrier() does not send an IPI, this means that membarrier() reads
+ * cpu_rq(cpu)->curr->mm and that the result is not equal to the target
+ * mm.  Let's assume for now that tasks never change their mm field.  The
+ * sequence of events is:
+ *
+ * 1. Target CPU switches away from the target mm (or goes lazy or has never
+ *    run the target mm in the first place). This involves smp_mb() followed
+ *    by a write to cpu_rq(cpu)->curr.
+ * 2. membarrier() does smp_mb(). (This is NOT synchronized with any action
+ *    done by the target.)
+ * 3. membarrier() observes the value written in step 1 and does *not* observe
+ *    the value written in step 5.
+ * 4. membarrier() does smp_mb().
+ * 5. Target CPU switches back to the target mm and writes to
+ *    cpu_rq(cpu)->curr. (This is NOT synchronized with any action on
+ *    membarrier()'s part.)
+ * 6. Target CPU executes smp_mb()
+ *
+ * All pre-schedule accesses on the remote CPU are visible after membarrier()
+ * because they all precede the target's write in step 1 and are synchronized
+ * to the local CPU by steps 3 and 4.  All pre-membarrier() accesses on the
+ * local CPU are visible on the remote CPU after scheduling because they
+ * happen before the smp_mb(); read in steps 2 and 3 and that read preceeds
+ * the target's smp_mb() in step 6.
+ *
+ * However, tasks can change their ->mm, e.g., via kthread_use_mm().  So
+ * tasks that switch their ->mm must follow the same rules as the scheduler
+ * changing rq->curr, and the membarrier() code needs to do both dereferences
+ * carefully.
+ *
+ *
  * For documentation purposes, here are some membarrier ordering
  * scenarios to keep in mind:
  *
-- 
2.31.1

