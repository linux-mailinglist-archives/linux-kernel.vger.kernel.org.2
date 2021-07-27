Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1A43D737D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhG0KmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236320AbhG0KmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627382530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nCPk8zRVU9+28PEuxbOMSitdBrQsVWkjWXa+sF7HFvo=;
        b=ECNRgLFD1JqbnctolonxkkWDqOxEJUzcp2avS37fi+vpQLwiQZXVkhZhIedAvw/TqBYwdB
        fko9b6IQE7Ve6b1nY9zWhsncaCd/DR1jkluZhEZrukXB50hGdY8X7dxKvyXAUnH6TFAXfV
        +3Jv/USN8tlzwaxnyTsQ4DsqMQKYDfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-4H0gplPiPC-TkakPQhm1dg-1; Tue, 27 Jul 2021 06:42:09 -0400
X-MC-Unique: 4H0gplPiPC-TkakPQhm1dg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6765E3639F;
        Tue, 27 Jul 2021 10:42:08 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9FD569CBA;
        Tue, 27 Jul 2021 10:41:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id AC7F84179B92; Tue, 27 Jul 2021 07:41:49 -0300 (-03)
Message-ID: <20210727104119.660815689@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 27 Jul 2021 07:38:06 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 3/4] mm: vmstat: move need_update
References: <20210727103803.464432924@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move need_update() function up in vmstat.c, needed by next patch.
No code changes.

Remove a duplicate comment while at it.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6-vmstat-update/mm/vmstat.c
===================================================================
--- linux-2.6-vmstat-update.orig/mm/vmstat.c
+++ linux-2.6-vmstat-update/mm/vmstat.c
@@ -1794,6 +1794,37 @@ static const struct seq_operations vmsta
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
+		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		struct per_cpu_nodestat *n;
+
+		/*
+		 * The fast way of checking if there are any vmstat diffs.
+		 */
+		if (memchr_inv(pzstats->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
+			       sizeof(pzstats->vm_stat_diff[0])))
+			return true;
+
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
@@ -1874,42 +1905,6 @@ static void vmstat_update(struct work_st
 }
 
 /*
- * Switch off vmstat processing and then fold all the remaining differentials
- * until the diffs stay at zero. The function is used by NOHZ and can only be
- * invoked when tick processing is not active.
- */
-/*
- * Check if the diffs for a certain cpu indicate that
- * an update is needed.
- */
-static bool need_update(int cpu)
-{
-	pg_data_t *last_pgdat = NULL;
-	struct zone *zone;
-
-	for_each_populated_zone(zone) {
-		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
-		struct per_cpu_nodestat *n;
-
-		/*
-		 * The fast way of checking if there are any vmstat diffs.
-		 */
-		if (memchr_inv(pzstats->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
-			       sizeof(pzstats->vm_stat_diff[0])))
-			return true;
-
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


