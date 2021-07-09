Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7593C28DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGISM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhGISMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625854179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=19tls8OjvtWjWLwlcefOmP1Rdb22JP7IKeOD5zyYcGA=;
        b=DyTE9PA+F91LG18i8AEdFLejnsdf2MSRSud0qPrDiQcrhVgD56yoAgC5TSuDdqtHxKG9Us
        AwFvmtF/LRTTR2aVQFFz/E0uShfSi4xXwROTM7tPlajtoiYd5/qSs4sYt42KaIEhrSIjnQ
        xHMlW4/1KNOLNtMOudZ6cTW7nem4CtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-8lFVz9DOPCuGF7jmxAd6vg-1; Fri, 09 Jul 2021 14:09:37 -0400
X-MC-Unique: 8lFVz9DOPCuGF7jmxAd6vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7622C804302;
        Fri,  9 Jul 2021 18:09:36 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B685560843;
        Fri,  9 Jul 2021 18:09:32 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 58D414179BA1; Fri,  9 Jul 2021 15:09:28 -0300 (-03)
Message-ID: <20210709174428.287342519@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 14:37:30 -0300
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
References: <20210709173726.457181806@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
@@ -1860,6 +1860,40 @@ static const struct seq_operations vmsta
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
@@ -1945,40 +1979,6 @@ static void vmstat_update(struct work_st
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


