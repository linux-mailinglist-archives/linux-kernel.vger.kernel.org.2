Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1D73DBF92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhG3UVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231500AbhG3UVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627676460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=a0MRiXhMesi6Xu141xxbrQC/8qScgm+e3IO9BCTOUEI=;
        b=NWfQgjFmxoT4nrO6wdwIlKZL1XUBgrcz/d9QL1BVfO3HDg1odBIp7yXi7NY4S+JFqaIuaY
        uFinhgZqY7sE5uxGTCM9RilU7fuUBZr6mtho7f3+9KltYnr+O2NwgbH44zP4KYoPfNDbli
        NsWKKsgnk4QM4klr2NX0r5VjDlj+LYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-bocp-FgTOViO9cTTJrRfuA-1; Fri, 30 Jul 2021 16:20:59 -0400
X-MC-Unique: bocp-FgTOViO9cTTJrRfuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C566801AE3;
        Fri, 30 Jul 2021 20:20:58 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 077833AC1;
        Fri, 30 Jul 2021 20:20:58 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8846441752B7; Fri, 30 Jul 2021 17:20:28 -0300 (-03)
Message-ID: <20210730202010.331065257@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 30 Jul 2021 17:18:31 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 4/4] mm: vmstat_refresh: avoid queueing work item if cpu stats are clean
References: <20210730201827.269106165@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to queue work item to run refresh_vm_stats 
on a remote CPU if that CPU has no dirty stats and no per-CPU
allocations for remote nodes.

This fixes sosreport hang (which uses vmstat_refresh) with 
spinning SCHED_FIFO process.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6-vmstat-update/mm/vmstat.c
===================================================================
--- linux-2.6-vmstat-update.orig/mm/vmstat.c
+++ linux-2.6-vmstat-update/mm/vmstat.c
@@ -1826,17 +1826,42 @@ static bool need_update(int cpu)
 }
 
 #ifdef CONFIG_PROC_FS
-static void refresh_vm_stats(struct work_struct *work)
+static bool need_drain_remote_zones(int cpu)
+{
+#ifdef CONFIG_NUMA
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		struct per_cpu_pages *pcp;
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+
+		if (!pcp->count)
+			continue;
+
+		if (!pcp->expire)
+			continue;
+
+		if (zone_to_nid(zone) == cpu_to_node(cpu))
+			continue;
+
+		return true;
+	}
+#endif
+
+	return false;
+}
+
+static long refresh_vm_stats(void *arg)
 {
 	refresh_cpu_vm_stats(true);
+	return 0;
 }
 
 int vmstat_refresh(struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
-	int err;
-	int i;
+	int i, cpu;
 
 	/*
 	 * The regular update, every sysctl_stat_interval, may come later
@@ -1850,9 +1875,15 @@ int vmstat_refresh(struct ctl_table *tab
 	 * transiently negative values, report an error here if any of
 	 * the stats is negative, so we know to go looking for imbalance.
 	 */
-	err = schedule_on_each_cpu(refresh_vm_stats);
-	if (err)
-		return err;
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		if (need_update(cpu) || need_drain_remote_zones(cpu))
+			work_on_cpu(cpu, refresh_vm_stats, NULL);
+
+		cond_resched();
+	}
+	put_online_cpus();
+
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 		/*
 		 * Skip checking stats known to go negative occasionally.


