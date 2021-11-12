Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB6E44E658
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhKLMdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234918AbhKLMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636720245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=mk8Lc/epZDJG4H6beRHNWxGBm9jFccAh/Y1cz1OuUy4=;
        b=dVQBIhqNBnkHs/Ip4XllVfm78zW2+skxcY+pMcrXKyUT8XbpU3I8KqAS6mp92kzzTGoddl
        kIEjy8PRyCCpVZzNXlvqNIF5+9Wv6gUyNA0NgHpuNxAqKpBMgJS/+7RS7BEFIDIwuoIQRS
        pf2WLO1brn4bAB7WJ3CXu9DRJ4xr1yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-Ap5-CJ50OLCR3QdNdtx1Dg-1; Fri, 12 Nov 2021 07:30:44 -0500
X-MC-Unique: Ap5-CJ50OLCR3QdNdtx1Dg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6513587D57D;
        Fri, 12 Nov 2021 12:30:30 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1339F56AA9;
        Fri, 12 Nov 2021 12:30:30 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8DA79437FF98; Fri, 12 Nov 2021 09:29:05 -0300 (-03)
Message-ID: <20211112122641.953894539@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 12 Nov 2021 09:16:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v6 07/10] task isolation: enable return to userspace processing
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:
References: <20211112121642.693790927@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Enable processing of pending task isolation work if per-CPU vmstats
are out of sync with global vmstats.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/task_isolation.h |   22 +++++++++++++++++++++-
 kernel/task_isolation.c        |   13 +++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -5,6 +5,9 @@
 
 #ifdef CONFIG_CPU_ISOLATION
 
+#include <linux/vmstat.h>
+#include <uapi/linux/prctl.h>
+
 struct isol_info {
 	/* Which features have been configured */
 	u64 conf_mask;
@@ -51,7 +54,24 @@ void isolation_exit_to_user_mode(void);
 
 static inline int task_isol_has_work(void)
 {
-	return 0;
+	int cpu, ret;
+	struct isol_info *i;
+
+	if (likely(current->isol_info == NULL))
+		return 0;
+
+	i = current->isol_info;
+	if (i->active_mask != ISOL_F_QUIESCE)
+		return 0;
+
+	if (!(i->quiesce_mask & ISOL_F_QUIESCE_VMSTATS))
+		return 0;
+
+	cpu = get_cpu();
+	ret = per_cpu(vmstat_dirty, cpu);
+	put_cpu();
+
+	return ret;
 }
 
 #else
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -23,6 +23,13 @@
 
 void __tsk_isol_exit(struct task_struct *tsk)
 {
+	struct isol_info *i;
+
+	i = tsk->isol_info;
+	if (!i)
+		return;
+
+	static_key_slow_dec(&vmstat_sync_enabled);
 }
 
 void __tsk_isol_free(struct task_struct *tsk)
@@ -41,6 +48,12 @@ static struct isol_info *tsk_isol_alloc_
 	if (unlikely(!info))
 		return ERR_PTR(-ENOMEM);
 
+	preempt_disable();
+	init_sync_vmstat();
+	preempt_enable();
+
+	static_key_slow_inc(&vmstat_sync_enabled);
+
 	return info;
 }
 


