Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E244E699
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhKLMrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235015AbhKLMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636721063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=07tzMqXv12iaWMqTpTIcNBD9UmGHdMlURwGO7Ojc1Pc=;
        b=hB9OnDv3xfc/+kICnsfJWKY+L5ZsWf3cBM7aawSGy78Ya2XBOik95iqoUa45kuUsc9JISh
        dw8k34XPGtJeOvIjm5ma58xvoBcBXRGvhJHeNHI0oa8/ySwiTbxMiTpjXdIxy/aa+Qh8EQ
        iI3U4rQhEyM38BGdeLF+0BEkrHyj/fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-3wTRJwW4NLSNQYe1-eWRAQ-1; Fri, 12 Nov 2021 07:44:20 -0500
X-MC-Unique: 3wTRJwW4NLSNQYe1-eWRAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74810804142;
        Fri, 12 Nov 2021 12:44:19 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4028319C59;
        Fri, 12 Nov 2021 12:44:02 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 46C47437FF94; Fri, 12 Nov 2021 09:42:32 -0300 (-03)
Message-ID: <20211112123750.815948331@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 12 Nov 2021 09:35:37 -0300
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
Subject: [patch v7 06/10] task isolation: sync vmstats conditional on changes
References: <20211112123531.497831890@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than syncing VM-stats on every return to userspace
(or VM-entry), keep track of changes through a per-CPU bool.

This improves performance when enabling task isolated
for vcpu VMs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/vmstat.h |   13 ++++++++++++-
 mm/vmstat.c            |   29 ++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h
+++ linux-2.6/include/linux/vmstat.h
@@ -22,7 +22,18 @@ int sysctl_vm_numa_stat_handler(struct c
 #endif
 
 #ifdef CONFIG_SMP
-void sync_vmstat(void);
+DECLARE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+extern struct static_key vmstat_sync_enabled;
+
+void __sync_vmstat(void);
+static inline void sync_vmstat(void)
+{
+	if (static_key_false(&vmstat_sync_enabled))
+		__sync_vmstat();
+}
+
+void init_sync_vmstat(void);
 #else
 static inline void sync_vmstat(void)
 {
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -306,6 +306,24 @@ void set_pgdat_percpu_threshold(pg_data_
 	}
 }
 
+struct static_key vmstat_sync_enabled;
+DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+static inline void mark_vmstat_dirty(void)
+{
+	if (!static_key_false(&vmstat_sync_enabled))
+		return;
+
+	raw_cpu_write(vmstat_dirty, true);
+}
+
+void init_sync_vmstat(void)
+{
+	raw_cpu_write(vmstat_dirty, true);
+}
+
+EXPORT_SYMBOL_GPL(vmstat_dirty);
+
 /*
  * For use when we know that interrupts are disabled,
  * or when we know that preemption is disabled and that
@@ -338,6 +356,7 @@ void __mod_zone_page_state(struct zone *
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -376,6 +395,7 @@ void __mod_node_page_state(struct pglist
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -574,6 +594,7 @@ static inline void mod_zone_state(struct
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	mark_vmstat_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -642,6 +663,7 @@ static inline void mod_node_state(struct
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	mark_vmstat_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -1082,6 +1104,7 @@ static void fill_contig_page_info(struct
 			info->free_blocks_suitable += blocks <<
 						(order - suitable_order);
 	}
+	mark_vmstat_dirty();
 }
 
 /*
@@ -1434,6 +1457,7 @@ static void walk_zones_in_node(struct se
 		if (!nolock)
 			spin_unlock_irqrestore(&zone->lock, flags);
 	}
+	mark_vmstat_dirty();
 }
 #endif
 
@@ -1499,6 +1523,7 @@ static void pagetypeinfo_showfree_print(
 		}
 		seq_putc(m, '\n');
 	}
+	mark_vmstat_dirty();
 }
 
 /* Print out the free pages at each order for each migatetype */
@@ -1917,6 +1942,7 @@ static void vmstat_update(struct work_st
 				this_cpu_ptr(&vmstat_work),
 				round_jiffies_relative(sysctl_stat_interval));
 	}
+	mark_vmstat_dirty();
 }
 
 /*
@@ -2003,13 +2029,14 @@ static void vmstat_shepherd(struct work_
 		round_jiffies_relative(sysctl_stat_interval));
 }
 
-void sync_vmstat(void)
+void __sync_vmstat(void)
 {
 	int cpu;
 
 	cpu = get_cpu();
 
 	refresh_cpu_vm_stats(false);
+	raw_cpu_write(vmstat_dirty, false);
 	put_cpu();
 
 	/*


