Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451183F61E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbhHXPoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238586AbhHXPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629819794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SRYxxgJ63pDRsrO9ZE9g90mvC3z/w/yOFtU3rThZSs4=;
        b=YGaZvJQsR7iR3SNF54dPWC4eb4O4Ndzs+ihry+wBh0Xkv7mv8f2ipSjLfGuXT6Z5UW93Qa
        cnS3jesRcR7/SyZwe0ZYXwVKovfEH9b3z4pRCSChNHhXenazkSEuwz4YiDfOTG4L7iAkgB
        66KCmawTCRLVvVu+7F6JBpvU9PNZbcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-k3wnSLAoOpqm7RsidLxbjg-1; Tue, 24 Aug 2021 11:43:12 -0400
X-MC-Unique: k3wnSLAoOpqm7RsidLxbjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44206190A7A6;
        Tue, 24 Aug 2021 15:43:11 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F6BD282DC;
        Tue, 24 Aug 2021 15:43:03 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id CA2A8416CE49; Tue, 24 Aug 2021 12:42:52 -0300 (-03)
Date:   Tue, 24 Aug 2021 12:42:52 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: rt-tests: add task isolation activation to cyclictest/oslat
Message-ID: <20210824154252.GA105087@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Check whether task isolation is configured, right before the latency
sensitive loop, and if so, activate it.

Use chisol util-linux tool to configure task isolation externally.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -509,7 +509,7 @@ static void *timerthread(void *param)
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
-	int stopped = 0;
+	int ret, stopped = 0;
 	cpu_set_t mask;
 	pthread_t thread;
 	unsigned long smi_now, smi_old = 0;
@@ -617,11 +617,21 @@ static void *timerthread(void *param)
 
 	stat->threadstarted++;
 
+#ifdef PR_ISOL_GET
+        ret = prctl(PR_ISOL_GET, 0, 0, 0, 0);
+        if (ret != -1) {
+                unsigned long mask = ret;
+
+                ret = prctl(PR_ISOL_CTRL_SET, mask, 0, 0);
+                if (ret == -1)
+                        fatal("prctl PR_ISOL_CTRL_SET");
+        }
+#endif
 	while (!shutdown) {
 
 		uint64_t diff;
 		unsigned long diff_smi = 0;
-		int sigs, ret;
+		int sigs;
 
 		/* Wait for next period */
 		switch (par->mode) {
@@ -769,6 +779,12 @@ static void *timerthread(void *param)
 	}
 
 out:
+#ifdef PR_ISOL_GET
+	ret = prctl(PR_ISOL_CTRL_SET, 0, 0, 0);
+	if (ret == -1)
+		fatal("prctl PR_ISOL_CTRL_SET");
+#endif
+
 	if (refresh_on_max) {
 		pthread_mutex_lock(&refresh_on_max_lock);
 		/* We could reach here with both shutdown and allstopped unset (0).
Index: rt-tests/src/oslat/oslat.c
===================================================================
--- rt-tests.orig/src/oslat/oslat.c
+++ rt-tests/src/oslat/oslat.c
@@ -351,9 +351,21 @@ static void insert_bucket(struct thread
 
 static void doit(struct thread *t)
 {
+#ifdef PR_ISOL_GET
+	int ret;
+#endif
 	stamp_t ts1, ts2;
 	workload_fn workload_fn = g.workload->w_fn;
 
+#ifdef PR_ISOL_GET
+	ret = prctl(PR_ISOL_GET, 0, 0, 0, 0);
+	if (ret != -1) {
+		unsigned long mask = ret;
+
+		TEST0(prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0));
+	}
+#endif
+
 	frc(&ts2);
 	do {
 		workload_fn(t->dst_buf, t->src_buf, g.workload_mem_size);
@@ -361,6 +373,10 @@ static void doit(struct thread *t)
 		insert_bucket(t, ts1 - ts2);
 		ts2 = ts1;
 	} while (g.cmd == GO);
+
+#ifdef PR_ISOL_GET
+	TEST0(prctl(PR_ISOL_CTRL_SET, 0, 0, 0, 0));
+#endif
 }
 
 static int set_fifo_prio(int prio)

