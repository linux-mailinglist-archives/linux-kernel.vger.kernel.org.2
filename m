Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBA44E65F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhKLMeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:34:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235005AbhKLMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636720261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=pLuiDYLgPmajYco087Ip06c9bA3plVDRcQabP+vau0w=;
        b=ePtFdt6KGRLEemIp2rNfMRW4jcBsvnFtLz8cFUiNG3NkeZ7tNZVbjQsinzbLV6Ah30okau
        knPeU6RQCUgduMJd9fNSip3+va8HpI9hwH9I7KiYyEeWUSvlrdYonL9asGcRSktVL1/GQI
        2rbYHAz1Oy+8YRiH6y6RcCSfwLyMKkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Cf1v-CmyPZCXdb91AESrEw-1; Fri, 12 Nov 2021 07:30:58 -0500
X-MC-Unique: Cf1v-CmyPZCXdb91AESrEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C757B40C7;
        Fri, 12 Nov 2021 12:30:28 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EEFD19D9D;
        Fri, 12 Nov 2021 12:29:30 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 95B09437FFAF; Fri, 12 Nov 2021 09:29:05 -0300 (-03)
Message-ID: <20211112122642.275610107@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 12 Nov 2021 09:16:51 -0300
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
Subject: [patch v6 09/10] mm: vmstat: move need_update
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:
References: <20211112121642.693790927@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Move need_update() function up in vmstat.c, needed by next patch.
No code changes.

Remove a duplicate comment while at it.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/vmstat.c |   58 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -1865,6 +1865,35 @@ static const struct seq_operations vmsta
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
+		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
+			return true;
+
+		if (last_pgdat == zone->zone_pgdat)
+			continue;
+		last_pgdat = zone->zone_pgdat;
+		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
+		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
+			return true;
+	}
+	return false;
+}
+
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
@@ -1946,35 +1975,6 @@ static void vmstat_update(struct work_st
 }
 
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
-		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
-		struct per_cpu_nodestat *n;
-
-		/*
-		 * The fast way of checking if there are any vmstat diffs.
-		 */
-		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
-			return true;
-
-		if (last_pgdat == zone->zone_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
-		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
-		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
-			return true;
-	}
-	return false;
-}
-
-/*
  * Switch off vmstat processing and then fold all the remaining differentials
  * until the diffs stay at zero. The function is used by NOHZ and can only be
  * invoked when tick processing is not active.


