Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A5A3B97EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhGAVIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229934AbhGAVIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625173582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R2GnfEY8rIunwOPUeuKtl3LcTIkeJFBi1RbECT8Hf2c=;
        b=fcX20uUIdjb3DxFbXD2t8Jwu31BQF5wS2r2hXCWnbRXxw8WHmFCY+zUVrxRdSIta5FBp9R
        8+Fzkf6rE2mGUwKa5UKiINJCrQdBfM4xRn6VqXhTO4+s03foG+B2ql3+SDqk7RU0/DfU5P
        1c/W+0wIP6uMP9ogBLr1IRF2k+HC5KQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-ngLHCh3zOMCgAMKdKJRAbg-1; Thu, 01 Jul 2021 17:06:20 -0400
X-MC-Unique: ngLHCh3zOMCgAMKdKJRAbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B350D800D55;
        Thu,  1 Jul 2021 21:06:19 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BF625C230;
        Thu,  1 Jul 2021 21:06:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 202F64179DC0; Thu,  1 Jul 2021 18:06:06 -0300 (-03)
Message-ID: <20210701210458.290498604@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 01 Jul 2021 18:03:37 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/5] sched: isolation: introduce vmstat_sync isolcpu flags
References: <20210701210336.358118649@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new isolcpus flag "vmstat_sync" to control whether
to sync per-CPU counters to global counters when returning
to userspace.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6-vmstat-update/include/linux/sched/isolation.h
===================================================================
--- linux-2.6-vmstat-update.orig/include/linux/sched/isolation.h
+++ linux-2.6-vmstat-update/include/linux/sched/isolation.h
@@ -15,6 +15,7 @@ enum hk_flags {
 	HK_FLAG_WQ		= (1 << 6),
 	HK_FLAG_MANAGED_IRQ	= (1 << 7),
 	HK_FLAG_KTHREAD		= (1 << 8),
+	HK_FLAG_VMSTAT_SYNC	= (1 << 9),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
Index: linux-2.6-vmstat-update/kernel/sched/isolation.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/sched/isolation.c
+++ linux-2.6-vmstat-update/kernel/sched/isolation.c
@@ -173,6 +173,12 @@ static int __init housekeeping_isolcpus_
 			continue;
 		}
 
+		if (!strncmp(str, "vmstat_sync,", 12)) {
+			str += 12;
+			flags |= HK_FLAG_VMSTAT_SYNC;
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
@@ -2124,6 +2124,23 @@
 
 			The format of <cpu-list> is described above.
 
+                        vmstat_sync
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
+			  To avoid this interruption, this option syncs the
+			  page counters on each return from system calls.
+			  To ensure the application returns to userspace
+  			  with no modified per-CPU counters, its necessary to
+			  use mlockall() in addition to this isolcpus flag.
+
 	iucv=		[HW,NET]
 
 	ivrs_ioapic	[HW,X86-64]


