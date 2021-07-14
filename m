Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BE43C9254
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhGNUqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232046AbhGNUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626295434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SKuk+h7htDa9dNYFdUt3m5hrD3QQHm7oWsA1+l2m0cc=;
        b=V3YiEEnjLGPDMUr00emTQEVmdcIC2B6XMRCqeiBjDVuupMnZf8AQJWB+6v0z11AVUA7Hok
        Biga5zrmucfKmRIpEeZDlOP2e3C24Xatcw9slNtOFmvbPDNo4wrlUZTDiQY1BCQ7l1VJxK
        KUwq2zH89Vx6ghXSfeBV9l1x6Bn+ojw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-f5YpUWGnOLq4ZxmVnCuteQ-1; Wed, 14 Jul 2021 16:43:50 -0400
X-MC-Unique: f5YpUWGnOLq4ZxmVnCuteQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E982E1936B6A;
        Wed, 14 Jul 2021 20:43:48 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0986260C13;
        Wed, 14 Jul 2021 20:43:45 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EB64B4172EDB; Wed, 14 Jul 2021 17:43:36 -0300 (-03)
Message-ID: <20210714204233.648529431@fuller.cnet>
User-Agent: quilt/0.66
Date:   Wed, 14 Jul 2021 17:42:06 -0300
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
Subject: [patch 1/5] sched: isolation: introduce quiesce_on_exit_to_usermode isolcpu flags
References: <20210714204205.245522189@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new isolcpus flag "quiesce_on_exit_to_usermode" to enable
quiescing of deferred actions on return to userspace.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6-vmstat-update/include/linux/sched/isolation.h
===================================================================
--- linux-2.6-vmstat-update.orig/include/linux/sched/isolation.h
+++ linux-2.6-vmstat-update/include/linux/sched/isolation.h
@@ -15,6 +15,7 @@ enum hk_flags {
 	HK_FLAG_WQ		= (1 << 6),
 	HK_FLAG_MANAGED_IRQ	= (1 << 7),
 	HK_FLAG_KTHREAD		= (1 << 8),
+	HK_FLAG_QUIESCE_URET	= (1 << 9),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
Index: linux-2.6-vmstat-update/kernel/sched/isolation.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/sched/isolation.c
+++ linux-2.6-vmstat-update/kernel/sched/isolation.c
@@ -173,6 +173,12 @@ static int __init housekeeping_isolcpus_
 			continue;
 		}
 
+		if (!strncmp(str, "quiesce_on_exit_to_usermode,", 28)) {
+			str += 28;
+			flags |= HK_FLAG_QUIESCE_URET;
+			continue;
+		}
+
 		/*
 		 * Skip unknown sub-parameter and validate that it is not
 		 * containing an invalid character.
Index: linux-2.6-vmstat-update/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-2.6-vmstat-update.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-2.6-vmstat-update/Documentation/admin-guide/kernel-parameters.txt
@@ -2124,6 +2124,43 @@
 
 			The format of <cpu-list> is described above.
 
+                         quiesce_on_exit_to_usermode
+
+			  This flag allows userspace to take preventive measures to
+			  avoid deferred actions and create a OS noise free environment for
+			  the application, by quiescing such activities on
+			  return from syscalls (that is, perform the necessary
+			  background work on return to userspace, rather than allowing
+			  it to happen when userspace is executing, in the form of
+			  an interruption to the application).
+
+			  There might be a performance degradation from using this,
+			  on systemcall heavy workloads, for the isolated CPUs.
+			  This option is intended to be used by specialized workloads.
+
+			  It should be deprecated in favour of a prctl() interface
+			  to enable this mode (which allows the quiescing to take
+			  place only on select sections of userspace execution, namely
+			  the latency sensitive loops).
+
+			  Note: one of the preventive measures this option
+			  enables is the following.
+
+			  Page counters are maintained in per-CPU counters to
+			  improve performance. When a CPU modifies a page counter,
+			  this modification is kept in the per-CPU counter.
+			  Certain activities require a global count, which
+			  involves requesting each CPU to flush its local counters
+			  to the global VM counters.
+			  This flush is implemented via a workqueue item, which
+			  requires scheduling the workqueue task on isolated CPUs.
+
+			  To avoid this interruption, quiesce_on_exit_to_usermode
+			  syncs the page counters on each return from system calls.
+			  To ensure the application returns to userspace
+			  with no modified per-CPU counters, its necessary to
+			  use mlockall() in addition to this isolcpus flag.
+
 	iucv=		[HW,NET]
 
 	ivrs_ioapic	[HW,X86-64]


