Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA508351DA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbhDASap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbhDASFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:05:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6CDC08EC38
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=++xeuLjBBsNI4r6jcihoV/IZAG+/t6ASVr7NAS7QF0U=; b=XAQnZ2g8eg01wy3yT6Pm+KimS+
        NS/7SzsrlL3JdPeF6o38xJHuzaV2Xnc+ToOb49bK6+FibenXTYuy2jKnlDmSjGVezN29x+F8LfsME
        BQKC23XfUvuj7e++Cwne8/DArMOzfC/QGX1O2gin+gqghe5Ry4FxYdTouKj7z3CNp0fFvlqUsg6XE
        gSknIM8+ZHH2kxrIjJIPi7xF/DdG6TyBGTf+Mv5Ccih1Po9BuWKAp6PCN9pH3Nj2cu7PgrbLnsRii
        vVnQb09gKIUPIjtUSPoFaeg3V/YOPtBYg++cDSBy8NxI96iOF0LzoJ9QGPOpcuxRJ8wzZz6yh7Q2Q
        p5/QbM+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxag-009isb-Oy; Thu, 01 Apr 2021 13:44:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01C93303DA3;
        Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C983024C1A501; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.171523833@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 2/9] sched: Implement core-sched assertions
References: <20210401131012.395311786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -268,18 +268,24 @@ static void __sched_core_flip(bool enabl
 	cpus_read_unlock();
 }
 
-static void __sched_core_enable(void)
+static void sched_core_assert_empty(void)
 {
-	// XXX verify there are no cookie tasks (yet)
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&cpu_rq(cpu)->core_tree));
+}
 
+static void __sched_core_enable(void)
+{
 	static_branch_enable(&__sched_core_enabled);
 	__sched_core_flip(true);
+	sched_core_assert_empty();
 }
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
+	sched_core_assert_empty();
 	__sched_core_flip(false);
 	static_branch_disable(&__sched_core_enabled);
 }


