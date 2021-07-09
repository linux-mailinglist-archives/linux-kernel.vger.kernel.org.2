Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C573C28D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGISMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhGISMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625854178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PLewHXDmPjFB924jxgbIi8PWfwqgckw1/ZnpEwhMiSQ=;
        b=HgJigSKHqBNy+uRt2byI9qssg1utnyEuzTqNmd3DtkQDHjS6vvW4aZzwRkiFmV0OnIDpmR
        V27dCkEetxQIqmIztodmNEmZQbLpCb91AREly09uHmbNKM7jjbAHoShPE1rRspqCszeWGc
        AYKVpkL2cVkBnbF+LK2W7U41b09t1HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-47HzS6GfNBy2U3kKwvSrsg-1; Fri, 09 Jul 2021 14:09:37 -0400
X-MC-Unique: 47HzS6GfNBy2U3kKwvSrsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5129F100B3AC;
        Fri,  9 Jul 2021 18:09:36 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A032419D9F;
        Fri,  9 Jul 2021 18:09:32 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 5F0594179BA8; Fri,  9 Jul 2021 15:09:28 -0300 (-03)
Message-ID: <20210709174428.339306008@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 14:37:31 -0300
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
Subject: [patch 5/5] mm: vmstat_refresh: avoid queueing work item if cpu stats are clean
References: <20210709173726.457181806@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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


