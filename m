Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0B44E659
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhKLMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234951AbhKLMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636720251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bJ7vHiy3ivTh4CSkey/7bIPE11CwdZSYfCRnZCn3tqs=;
        b=aLIRbPfzlLMhKHqzpBnKu0HMduj/RRJeSxXxdJg6sZPcBKgG4FtcP65Impcsc8fPOd9/wh
        etJ4R1E2RR1hJAYhED4KQklxZhBzAv4erbghZjCOcnXkbxUq6FDC7McG8d7nPWlp+NJgdQ
        bC63fggvLTD9gQyqoDIpcK01k5T+vfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-MWGiAlzxOQOHN3T6Ca2Fog-1; Fri, 12 Nov 2021 07:30:50 -0500
X-MC-Unique: MWGiAlzxOQOHN3T6Ca2Fog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B511856F28;
        Fri, 12 Nov 2021 12:30:27 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DE00177C0;
        Fri, 12 Nov 2021 12:29:30 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 99A18437FFB8; Fri, 12 Nov 2021 09:29:05 -0300 (-03)
Message-ID: <20211112122642.411256911@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 12 Nov 2021 09:16:52 -0300
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
Subject: [patch v6 10/10] mm: vmstat_refresh: avoid queueing work item if cpu stats are clean
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:
References: <20211112121642.693790927@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

It is not necessary to queue work item to run refresh_vm_stats 
on a remote CPU if that CPU has no dirty stats and no per-CPU
allocations for remote nodes.

This fixes sosreport hang (which uses vmstat_refresh) with 
spinning SCHED_FIFO process.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/vmstat.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -1895,6 +1895,31 @@ static bool need_update(int cpu)
 }
 
 #ifdef CONFIG_PROC_FS
+static bool need_drain_remote_zones(int cpu)
+{
+#ifdef CONFIG_NUMA
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		struct per_cpu_pages *pcp;
+
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
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
 static void refresh_vm_stats(struct work_struct *work)
 {
 	refresh_cpu_vm_stats(true);
@@ -1904,8 +1929,12 @@ int vmstat_refresh(struct ctl_table *tab
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
-	int err;
-	int i;
+	int i, cpu;
+	struct work_struct __percpu *works;
+
+	works = alloc_percpu(struct work_struct);
+	if (!works)
+		return -ENOMEM;
 
 	/*
 	 * The regular update, every sysctl_stat_interval, may come later
@@ -1919,9 +1948,19 @@ int vmstat_refresh(struct ctl_table *tab
 	 * transiently negative values, report an error here if any of
 	 * the stats is negative, so we know to go looking for imbalance.
 	 */
-	err = schedule_on_each_cpu(refresh_vm_stats);
-	if (err)
-		return err;
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, refresh_vm_stats);
+		if (need_update(cpu) || need_drain_remote_zones(cpu))
+			schedule_work_on(cpu, work);
+	}
+	for_each_online_cpu(cpu)
+		flush_work(per_cpu_ptr(works, cpu));
+	cpus_read_unlock();
+	free_percpu(works);
+
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 		/*
 		 * Skip checking stats known to go negative occasionally.


