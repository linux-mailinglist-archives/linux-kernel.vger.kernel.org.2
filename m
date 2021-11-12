Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A344E690
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhKLMq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234881AbhKLMq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636721046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZDAta50xbhABIw2pC4Q9CsEEsNb22fCOOo8/f+tX5x4=;
        b=dNRUJTRabbSVdRx0eYzj0MEoOmb8cwoIW0WdiVvO5KUMDTFDExYbf7qK1CBD07W0ZN2g4Q
        sdjE4fI/g6T9PgMI514AyKi8R6NkPwRP3s/Nkp2OU6GPeINMxjY0g1KkevzYVIBNFEL8g3
        9RexWoKIoNP9TFxoYLA3iyo5PVbubnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-dirL-GJMMtOXE53hxTIJxw-1; Fri, 12 Nov 2021 07:44:03 -0500
X-MC-Unique: dirL-GJMMtOXE53hxTIJxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 823761015DA3;
        Fri, 12 Nov 2021 12:44:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 398BF5D6D5;
        Fri, 12 Nov 2021 12:44:02 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 4234A409718D; Fri, 12 Nov 2021 09:42:32 -0300 (-03)
Message-ID: <20211112123750.782995020@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 12 Nov 2021 09:35:36 -0300
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
Subject: [patch v7 05/10] task isolation: add hook to task exit
References: <20211112123531.497831890@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add task isolation specific hook to task exit routines.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/task_isolation.h |   11 +++++++++++
 kernel/exit.c                  |    2 ++
 kernel/fork.c                  |    1 +
 kernel/task_isolation.c        |    4 ++++
 4 files changed, 18 insertions(+)

Index: linux-2.6/kernel/exit.c
===================================================================
--- linux-2.6.orig/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
+#include <linux/task_isolation.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -778,6 +779,7 @@ void __noreturn do_exit(long code)
 	}
 
 	io_uring_files_cancel();
+	tsk_isol_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	/* sync mm's RSS info before statistics gathering */
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -2446,6 +2446,7 @@ bad_fork_free_pid:
 	if (pid != &init_struct_pid)
 		free_pid(pid);
 bad_fork_cleanup_task_isolation:
+	tsk_isol_exit(p);
 	tsk_isol_free(p);
 bad_fork_cleanup_thread:
 	exit_thread(p);
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -21,6 +21,10 @@
 #include <linux/mm.h>
 #include <linux/vmstat.h>
 
+void __tsk_isol_exit(struct task_struct *tsk)
+{
+}
+
 void __tsk_isol_free(struct task_struct *tsk)
 {
 	if (!tsk->isol_info)
Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -27,6 +27,13 @@ static inline void tsk_isol_free(struct
 		__tsk_isol_free(tsk);
 }
 
+void __tsk_isol_exit(struct task_struct *tsk);
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+	if (tsk->isol_info)
+		__tsk_isol_exit(tsk);
+}
+
 int prctl_task_isolation_feat_get(unsigned long arg2, unsigned long arg3,
 				  unsigned long arg4, unsigned long arg5);
 int prctl_task_isolation_cfg_get(unsigned long arg2, unsigned long arg3,
@@ -57,6 +64,10 @@ static inline void tsk_isol_free(struct
 {
 }
 
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+}
+
 static inline int prctl_task_isolation_feat_get(unsigned long arg2,
 						unsigned long arg3,
 						unsigned long arg4,


