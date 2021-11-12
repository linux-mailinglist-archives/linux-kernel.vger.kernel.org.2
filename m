Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60B844E65D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhKLMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235002AbhKLMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636720261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=mFaPY5bnZcGo9LFtsyFMRFMJXrQNbmEUybHFHIH9lIk=;
        b=VQX+nTCK37wIJKGmMNZoLcZPoPfS/QzM90fGnXxXFkzVRDfMVqQcjHKkE+nIwZ59ndvRbh
        zI4sA06wXoUmnpF0wi4FeHPUMR3zW5URMDi16eBgo5iojOT4ncXQLje+Why6wRXD/73ipX
        CWF1t99qYqOkzDkyQT0yNSF2sTC2hE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-COp9kQVpMoajU8QvODzJ6A-1; Fri, 12 Nov 2021 07:30:57 -0500
X-MC-Unique: COp9kQVpMoajU8QvODzJ6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD9741574E;
        Fri, 12 Nov 2021 12:30:27 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 587775FC25;
        Fri, 12 Nov 2021 12:29:30 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 91C7A437FF9A; Fri, 12 Nov 2021 09:29:05 -0300 (-03)
Message-ID: <20211112122642.121429459@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 12 Nov 2021 09:16:50 -0300
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
Subject: [patch v6 08/10] KVM: x86: process isolation work from VM-entry code path
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

VM-entry code path is an entry point similar to userspace return
when task isolation is concerned.

Call isolation_exit_to_user_mode before VM-enter.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/entry-kvm.h |    4 +++-
 kernel/entry/kvm.c        |   18 ++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

Index: linux-2.6/kernel/entry/kvm.c
===================================================================
--- linux-2.6.orig/kernel/entry/kvm.c
+++ linux-2.6/kernel/entry/kvm.c
@@ -2,8 +2,11 @@
 
 #include <linux/entry-kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/task_isolation.h>
 
-static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
+static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu,
+				   unsigned long ti_work,
+				   unsigned long tsk_isol_work)
 {
 	do {
 		int ret;
@@ -26,14 +29,20 @@ static int xfer_to_guest_mode_work(struc
 		if (ret)
 			return ret;
 
+		if (tsk_isol_work)
+			isolation_exit_to_user_mode();
+
 		ti_work = READ_ONCE(current_thread_info()->flags);
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+		tsk_isol_work = task_isol_has_work();
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched() ||
+		 tsk_isol_work);
 	return 0;
 }
 
 int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 {
 	unsigned long ti_work;
+	unsigned long tsk_isol_work;
 
 	/*
 	 * This is invoked from the outer guest loop with interrupts and
@@ -44,9 +53,10 @@ int xfer_to_guest_mode_handle_work(struc
 	 * to disable interrupts here.
 	 */
 	ti_work = READ_ONCE(current_thread_info()->flags);
-	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
+	tsk_isol_work = task_isol_has_work();
+	if (!((ti_work & XFER_TO_GUEST_MODE_WORK) || tsk_isol_work))
 		return 0;
 
-	return xfer_to_guest_mode_work(vcpu, ti_work);
+	return xfer_to_guest_mode_work(vcpu, ti_work, tsk_isol_work);
 }
 EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
Index: linux-2.6/include/linux/entry-kvm.h
===================================================================
--- linux-2.6.orig/include/linux/entry-kvm.h
+++ linux-2.6/include/linux/entry-kvm.h
@@ -8,6 +8,7 @@
 #include <linux/seccomp.h>
 #include <linux/sched.h>
 #include <linux/tick.h>
+#include <linux/task_isolation.h>
 
 /* Transfer to guest mode work */
 #ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
@@ -76,8 +77,9 @@ static inline void xfer_to_guest_mode_pr
 static inline bool __xfer_to_guest_mode_work_pending(void)
 {
 	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long tsk_isol_work = task_isol_has_work();
 
-	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
+	return !!((ti_work & XFER_TO_GUEST_MODE_WORK) || tsk_isol_work);
 }
 
 /**


