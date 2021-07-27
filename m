Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA953D737A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhG0KmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236279AbhG0KmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627382528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Qbz0iV5ut2He5qOAXTSp9B5zgu81FGfYA1TCbdLaM8M=;
        b=THe/XMKzGbNHddbmCOuqaJcK6K1Lp1A0SJXvj4QhaaSCJQb1DjGotEbEyfiOYOV5JKfBq9
        Xj07/3CdS87PgZgUxPry+xp8qZez0wQgbGHbeCVtbzJs1+gvSMTdXvOBEtvEPqDxTzFKY0
        vCc89Rfuac/WH+0xPZN+ljNC0wLhF9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-IPsNAgluPhWNJxLLnC0UPw-1; Tue, 27 Jul 2021 06:42:07 -0400
X-MC-Unique: IPsNAgluPhWNJxLLnC0UPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45862363AB;
        Tue, 27 Jul 2021 10:42:06 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DBDD10074E5;
        Tue, 27 Jul 2021 10:41:58 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B18DC4179BB2; Tue, 27 Jul 2021 07:41:49 -0300 (-03)
Message-ID: <20210727104119.714831752@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 27 Jul 2021 07:38:07 -0300
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
Subject: [patch 4/4] mm: vmstat_refresh: avoid queueing work item if cpu stats are clean
References: <20210727103803.464432924@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
@@ -1826,17 +1826,40 @@ static bool need_update(int cpu)
 }
 
 #ifdef CONFIG_PROC_FS
-static void refresh_vm_stats(struct work_struct *work)
+static bool need_drain_remote_zones(int cpu)
+{
+#ifdef CONFIG_NUMA
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
+
+		if (!pcp->count)
+			continue;
+
+		if (!pcp->expire)
+			continue;
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
@@ -1850,9 +1873,15 @@ int vmstat_refresh(struct ctl_table *tab
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


