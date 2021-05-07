Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20D5376924
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhEGQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234440AbhEGQ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620406643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=h4E6LMUOwxUgdkNVzwo77vN2ykIjCnu70MVW4GN+mng=;
        b=fN/K9B0D8rNGmMa28UsqcsWJ7m4NYL+fGuZ0FoSy/zHYR81WzcsO/pHBC09edZ7i5EmTWb
        gBzn1sCBN8CQ2QrX5JXRbHP5LLzTfa1Bxl31MnDFimgBqTDNTv3ne6HtLpYUNQJFg44vDk
        cJ1QmTBEKFVW4rYUc43qtd33D0B92jU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-HbI4XHsCMXOk_FajH5--7Q-1; Fri, 07 May 2021 12:57:20 -0400
X-MC-Unique: HbI4XHsCMXOk_FajH5--7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76C2E1854E24;
        Fri,  7 May 2021 16:57:19 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CF2D36E0;
        Fri,  7 May 2021 16:57:19 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EB3C741887F4; Fri,  7 May 2021 13:57:10 -0300 (-03)
Date:   Fri, 7 May 2021 13:57:10 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] Revert "isolcpus: Affine unbound kernel threads to
 housekeeping cpus"
Message-ID: <20210507165710.GA429056@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



commit 9cc5b8656892a72438ee7deb introduced a new housekeeping flag,
HK_FLAG_KTHREAD, that when enabled sets the CPU affinity for the 
kthreadd process (therefore all unbounded kernel threads created
from that point on will use the housekeeping cpumask).

This is not necessary, since its possible to control placement of
kthreadd from userspace:

# taskset -c -p 0 `pgrep kthreadd`
pid 2's current affinity list: 1
pid 2's new affinity list: 0

Unbounded kernel threads started from that point on will inherit
the kthreadd cpumask.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/include/linux/sched/isolation.h
===================================================================
--- linux-2.6.orig/include/linux/sched/isolation.h
+++ linux-2.6/include/linux/sched/isolation.h
@@ -14,7 +14,6 @@ enum hk_flags {
 	HK_FLAG_DOMAIN		= (1 << 5),
 	HK_FLAG_WQ		= (1 << 6),
 	HK_FLAG_MANAGED_IRQ	= (1 << 7),
-	HK_FLAG_KTHREAD		= (1 << 8),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
Index: linux-2.6/kernel/kthread.c
===================================================================
--- linux-2.6.orig/kernel/kthread.c
+++ linux-2.6/kernel/kthread.c
@@ -27,7 +27,6 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <linux/numa.h>
-#include <linux/sched/isolation.h>
 #include <trace/events/sched.h>
 
 
@@ -405,8 +404,7 @@ struct task_struct *__kthread_create_on_
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task,
-				     housekeeping_cpumask(HK_FLAG_KTHREAD));
+		set_cpus_allowed_ptr(task, cpu_possible_mask);
 	}
 	kfree(create);
 	return task;
@@ -655,7 +653,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_FLAG_KTHREAD));
+	set_cpus_allowed_ptr(tsk, cpu_possible_mask);
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
Index: linux-2.6/kernel/sched/isolation.c
===================================================================
--- linux-2.6.orig/kernel/sched/isolation.c
+++ linux-2.6/kernel/sched/isolation.c
@@ -140,8 +140,7 @@ static int __init housekeeping_nohz_full
 {
 	unsigned int flags;
 
-	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
-		HK_FLAG_MISC | HK_FLAG_KTHREAD;
+	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC;
 
 	return housekeeping_setup(str, flags);
 }

