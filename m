Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F083B97F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhGAVJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234122AbhGAVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625173584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PLewHXDmPjFB924jxgbIi8PWfwqgckw1/ZnpEwhMiSQ=;
        b=HwQlxK+/ndboTWBsEC4w9yNbOhnE7jeVaw/21WeQnU7iaoky9BhQfLBPmdT6W/FnT/NE8e
        pAqdgwaFrXdEOVXnw2RReNecgEHh4UKc9GTWMiBis7EU5lLRiheAruQ6jNiSahGvBjmHxi
        bdoy/riMH0A62hrttbT9TI8apwbsRYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-zgHly7bGOOydyYagHFzIRw-1; Thu, 01 Jul 2021 17:06:23 -0400
X-MC-Unique: zgHly7bGOOydyYagHFzIRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87BFC1084F4C;
        Thu,  1 Jul 2021 21:06:22 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33DE65C230;
        Thu,  1 Jul 2021 21:06:22 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 332A74179DC7; Thu,  1 Jul 2021 18:06:06 -0300 (-03)
Message-ID: <20210701210458.413105321@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 01 Jul 2021 18:03:41 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 5/5] mm: vmstat_refresh: avoid queueing work item if cpu stats are clean
References: <20210701210336.358118649@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
@@ -1895,17 +1895,39 @@ static bool need_update(int cpu)
 }
 
 #ifdef CONFIG_PROC_FS
-static void refresh_vm_stats(struct work_struct *work)
+static bool need_drain_remote_zones(int cpu)
+{
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		struct per_cpu_pageset *p;
+
+		p = per_cpu_ptr(zone->pageset, cpu);
+
+		if (!p->pcp.count)
+			continue;
+		if (!p->expire)
+			continue;
+		if (zone_to_nid(zone) == cpu_to_node(cpu))
+			continue;
+
+		return true;
+	}
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
@@ -1919,9 +1941,15 @@ int vmstat_refresh(struct ctl_table *tab
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


