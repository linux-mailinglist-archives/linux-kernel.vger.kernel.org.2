Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468DA44E692
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhKLMrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234959AbhKLMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636721049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=af7UUkQfwANXCH9PPiFH5Q1V8TxWCsTgXvJBilVgbwM=;
        b=UWDCO6uZMSEAve5XvgDsvP1WZSFuE1tiq40nK9wMkswUL/apz7TNQYPqM9+NYknHpMfIof
        oulxOrS6b/JRYo/aHTBSFORrahKzEHj+J90AMNiQc+uQHrkfF0ZYpYok5MR0TgBTh7i8Z/
        NRemx5X3DDZd5a991IkNA5cj+1zEBlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-mv6jUbggOWuCksHV4E-VmA-1; Fri, 12 Nov 2021 07:44:05 -0500
X-MC-Unique: mv6jUbggOWuCksHV4E-VmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27B2100CCD1;
        Fri, 12 Nov 2021 12:44:04 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E9C156A97;
        Fri, 12 Nov 2021 12:44:04 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 4F6C9437FF9A; Fri, 12 Nov 2021 09:42:32 -0300 (-03)
Message-ID: <20211112123750.879874410@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 12 Nov 2021 09:35:39 -0300
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
Subject: [patch v7 08/10] KVM: x86: process isolation work from VM-entry code path
References: <20211112123531.497831890@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


