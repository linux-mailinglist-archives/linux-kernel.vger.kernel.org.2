Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7E426D08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbhJHOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242870AbhJHOvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633704572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NArv3S58ujKjQmhiljvuEd6/crx29Ev28ADQgvj+g9c=;
        b=McZEu+aojgWq9vXQBWV4zoG8FnjHr3olsRl9Y5f0SJ81lqTjWRIk3EsiO0l6AUkzQTG6YI
        u8c5Ye6Bre6NgQtHlbz9HBtOJjZSW5mGtUd04WEZOyZFhmgTirIOJ46bC/2bVECjBOYGyv
        SDFKuZXmB1ZnDwzYAFpo5FUbtw5IVv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-yJA9HIBcN1OpefaWNlY7hw-1; Fri, 08 Oct 2021 10:49:31 -0400
X-MC-Unique: yJA9HIBcN1OpefaWNlY7hw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56FB618D6A31;
        Fri,  8 Oct 2021 14:49:30 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CE455C1CF;
        Fri,  8 Oct 2021 14:49:05 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 90F3942A51CF; Fri,  8 Oct 2021 11:48:20 -0300 (-03)
Date:   Fri, 8 Oct 2021 11:48:20 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: [patch v4] rt-tests: add task isolation activation to
 cyclictest/oslat
Message-ID: <20211008144820.GA3986@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Check whether task isolation is configured, right before the latency
sensitive loop, and if so, activate it.

Use chisol util-linux tool to configure task isolation externally.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2187d98..2e13046 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -515,10 +515,13 @@ static void *timerthread(void *param)
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
-	int stopped = 0;
+	int stopped = 0, ret = 0;
 	cpu_set_t mask;
 	pthread_t thread;
 	unsigned long smi_now, smi_old = 0;
+#ifdef PR_ISOL_CFG_GET
+	unsigned long long isol_mask = 0;
+#endif
 
 	memset(&stop, 0, sizeof(stop));
 
@@ -623,11 +626,20 @@ static void *timerthread(void *param)
 
 	stat->threadstarted++;
 
+#ifdef PR_ISOL_CFG_GET
+	ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &isol_mask, 0);
+	if (ret != -1 && isol_mask != 0) {
+		ret = prctl(PR_ISOL_ACTIVATE_SET, &isol_mask, 0, 0);
+		if (ret == -1)
+			fatal("prctl PR_ISOL_ACTIVATE_SET");
+	}
+#endif
+
 	while (!shutdown) {
 
 		uint64_t diff;
 		unsigned long diff_smi = 0;
-		int sigs, ret;
+		int sigs;
 
 		/* Wait for next period */
 		switch (par->mode) {
@@ -775,6 +787,14 @@ static void *timerthread(void *param)
 	}
 
 out:
+#ifdef PR_ISOL_ACTIVATE_SET
+	if (isol_mask != 0) {
+		ret = prctl(PR_ISOL_ACTIVATE_SET, &isol_mask, 0, 0);
+		if (ret == -1)
+			fatal("prctl PR_ISOL_ACTIVATE_SET");
+	}
+#endif
+
 	if (refresh_on_max) {
 		pthread_mutex_lock(&refresh_on_max_lock);
 		/* We could reach here with both shutdown and allstopped unset (0).
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 50ddc81..2105af0 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -31,6 +31,7 @@
 #include <limits.h>
 #include <stdbool.h>
 
+#include <linux/prctl.h>
 #include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/sysinfo.h>
@@ -383,9 +384,20 @@ static void insert_bucket(struct thread *t, stamp_t value)
 
 static void doit(struct thread *t)
 {
+#ifdef PR_ISOL_CFG_GET
+	int ret;
+	unsigned long long isol_mask;
+#endif
+
 	stamp_t ts1, ts2;
 	workload_fn workload_fn = g.workload->w_fn;
 
+#ifdef PR_ISOL_CFG_GET
+	ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &isol_mask, 0);
+	if (ret != -1 && isol_mask != 0)
+		TEST0(prctl(PR_ISOL_ACTIVATE_SET, &isol_mask, 0, 0, 0));
+#endif
+
 	frc(&ts2);
 	do {
 		workload_fn(t->dst_buf, t->src_buf, g.workload_mem_size);
@@ -393,6 +405,13 @@ static void doit(struct thread *t)
 		insert_bucket(t, ts1 - ts2);
 		ts2 = ts1;
 	} while (g.cmd == GO);
+
+#ifdef PR_ISOL_CFG_GET
+	if (isol_mask != 0) {
+		isol_mask = 0;
+		TEST0(prctl(PR_ISOL_ACTIVATE_SET, &isol_mask, 0, 0, 0));
+	}
+#endif
 }
 
 static int set_fifo_prio(int prio)

