Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D469D3C9252
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhGNUqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhGNUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626295432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NOoD2/2V5PI0619caVdZ2JPYRoKE0aKRTduLdN9MHGU=;
        b=hQEIQqf3z8e+w5EKZp4vgn2SJQQsfHyY7WO63BvQ/sMdkBjbtTsmWjFQYOwJIJkfwvq9E/
        8Qwe0iFRq5oU/Is0KqzMPlFwKkCakTFzeYu1p2h+wLXqCrCWSf1HfmKGTkbPeupqRb22D1
        B9oLQTugpueW89qGEzvVVZLObcu36WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-zL94yXtCM7iBCJ6PoJuNow-1; Wed, 14 Jul 2021 16:43:50 -0400
X-MC-Unique: zL94yXtCM7iBCJ6PoJuNow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F32DE804147;
        Wed, 14 Jul 2021 20:43:48 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 202075D6AB;
        Wed, 14 Jul 2021 20:43:45 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 01BDD4175296; Wed, 14 Jul 2021 17:43:37 -0300 (-03)
Message-ID: <20210714204233.741030446@fuller.cnet>
User-Agent: quilt/0.66
Date:   Wed, 14 Jul 2021 17:42:09 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 4/5] mm: vmstat: move need_update
References: <20210714204205.245522189@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move need_update() function up in vmstat.c, needed by next patch. 
No code changes.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


Index: linux-2.6-vmstat-update/mm/vmstat.c
===================================================================
--- linux-2.6-vmstat-update.orig/mm/vmstat.c
+++ linux-2.6-vmstat-update/mm/vmstat.c
@@ -1853,6 +1853,40 @@ static const struct seq_operations vmsta
 static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
 int sysctl_stat_interval __read_mostly = HZ;
 
+/*
+ * Check if the diffs for a certain cpu indicate that
+ * an update is needed.
+ */
+static bool need_update(int cpu)
+{
+	pg_data_t *last_pgdat = NULL;
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		struct per_cpu_pageset *p = per_cpu_ptr(zone->pageset, cpu);
+		struct per_cpu_nodestat *n;
+		/*
+		 * The fast way of checking if there are any vmstat diffs.
+		 */
+		if (memchr_inv(p->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
+			       sizeof(p->vm_stat_diff[0])))
+			return true;
+#ifdef CONFIG_NUMA
+		if (memchr_inv(p->vm_numa_stat_diff, 0, NR_VM_NUMA_STAT_ITEMS *
+			       sizeof(p->vm_numa_stat_diff[0])))
+			return true;
+#endif
+		if (last_pgdat == zone->zone_pgdat)
+			continue;
+		last_pgdat = zone->zone_pgdat;
+		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
+		if (memchr_inv(n->vm_node_stat_diff, 0, NR_VM_NODE_STAT_ITEMS *
+			       sizeof(n->vm_node_stat_diff[0])))
+		    return true;
+	}
+	return false;
+}
+
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
@@ -1938,40 +1972,6 @@ static void vmstat_update(struct work_st
  * invoked when tick processing is not active.
  */
 /*
- * Check if the diffs for a certain cpu indicate that
- * an update is needed.
- */
-static bool need_update(int cpu)
-{
-	pg_data_t *last_pgdat = NULL;
-	struct zone *zone;
-
-	for_each_populated_zone(zone) {
-		struct per_cpu_pageset *p = per_cpu_ptr(zone->pageset, cpu);
-		struct per_cpu_nodestat *n;
-		/*
-		 * The fast way of checking if there are any vmstat diffs.
-		 */
-		if (memchr_inv(p->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
-			       sizeof(p->vm_stat_diff[0])))
-			return true;
-#ifdef CONFIG_NUMA
-		if (memchr_inv(p->vm_numa_stat_diff, 0, NR_VM_NUMA_STAT_ITEMS *
-			       sizeof(p->vm_numa_stat_diff[0])))
-			return true;
-#endif
-		if (last_pgdat == zone->zone_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
-		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
-		if (memchr_inv(n->vm_node_stat_diff, 0, NR_VM_NODE_STAT_ITEMS *
-			       sizeof(n->vm_node_stat_diff[0])))
-		    return true;
-	}
-	return false;
-}
-
-/*
  * Switch off vmstat processing and then fold all the remaining differentials
  * until the diffs stay at zero. The function is used by NOHZ and can only be
  * invoked when tick processing is not active.


