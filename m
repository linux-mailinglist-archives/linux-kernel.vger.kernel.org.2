Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978A944F81C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 14:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhKNNe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 08:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhKNNd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 08:33:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53925C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 05:31:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636896660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ymFrLJNdQ3Ngar2zdYGx+GnuiHGV38bDJLupixhNtWU=;
        b=PiH0tCZKmFE9Bm6FWchK2cG34fUUA60GAkSpvsmTjKsmOg8WaDCwD5995w1ZGlZPp3RhQz
        +UDMkVeI/sH8ge4iGmn48uyoctCWpFtXlJD+Qh7iMNiCtRNyNthOZZtx0oINQaDdgnjXyM
        d8eadRvUqcXSbCNkI+1BqV04htf5bKYTqYMgDItgN4K1zjuXUZMdUcyH9I+Oet2UD2d1Qa
        woASolfpdSi+u7GTIttch4WK7E7CV2iv/ifaCtGqxCG6K/izD+XO/oa7OFeyQcA+BKdPN9
        h4UqOxEY20//ELwSAVyMMLGVNl8n2dUypcASevpiIdH1r6/F9iZQUYp/WFEYbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636896660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ymFrLJNdQ3Ngar2zdYGx+GnuiHGV38bDJLupixhNtWU=;
        b=GgfHjBj8my+caM8Wp53EOxvJ0sAkhbL1VKWwWAJIMqZJ2i0DP7BTtWsNYLFPKkhIzVDK1l
        L3AO6Gz0ipg7rPDg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.16-rc1
References: <163689642456.3249160.13397023971040961440.tglx@xen13>
Message-ID: <163689642744.3249160.6971106813056927807.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 14 Nov 2021 14:30:59 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
21-11-14

up to:  ca7752caeaa7: posix-cpu-timers: Clear task::posix_cputimers_work in c=
opy_process()

A single fix for POSIX CPU timers to address a problem where POSIX CPU
timer delivery stops working for a new child task because copy_process()
copies state information which is only valid for the parent task.

Thanks,

	tglx

------------------>
Michael Pratt (1):
      posix-cpu-timers: Clear task::posix_cputimers_work in copy_process()


 include/linux/posix-timers.h   |  2 ++
 kernel/fork.c                  |  1 +
 kernel/time/posix-cpu-timers.c | 19 +++++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 00fef0064355..5bbcd280bfd2 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -184,8 +184,10 @@ static inline void posix_cputimers_group_init(struct pos=
ix_cputimers *pct,
 #endif
=20
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+void clear_posix_cputimers_work(struct task_struct *p);
 void posix_cputimers_init_work(void);
 #else
+static inline void clear_posix_cputimers_work(struct task_struct *p) { }
 static inline void posix_cputimers_init_work(void) { }
 #endif
=20
diff --git a/kernel/fork.c b/kernel/fork.c
index 8e9feeef555e..8269ae2e5d7c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2279,6 +2279,7 @@ static __latent_entropy struct task_struct *copy_proces=
s(
 	p->pdeath_signal =3D 0;
 	INIT_LIST_HEAD(&p->thread_group);
 	p->task_works =3D NULL;
+	clear_posix_cputimers_work(p);
=20
 #ifdef CONFIG_KRETPROBES
 	p->kretprobe_instances.first =3D NULL;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 643d412ac623..96b4e7810426 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1158,14 +1158,29 @@ static void posix_cpu_timers_work(struct callback_hea=
d *work)
 	handle_posix_cpu_timers(current);
 }
=20
+/*
+ * Clear existing posix CPU timers task work.
+ */
+void clear_posix_cputimers_work(struct task_struct *p)
+{
+	/*
+	 * A copied work entry from the old task is not meaningful, clear it.
+	 * N.B. init_task_work will not do this.
+	 */
+	memset(&p->posix_cputimers_work.work, 0,
+	       sizeof(p->posix_cputimers_work.work));
+	init_task_work(&p->posix_cputimers_work.work,
+		       posix_cpu_timers_work);
+	p->posix_cputimers_work.scheduled =3D false;
+}
+
 /*
  * Initialize posix CPU timers task work in init task. Out of line to
  * keep the callback static and to avoid header recursion hell.
  */
 void __init posix_cputimers_init_work(void)
 {
-	init_task_work(&current->posix_cputimers_work.work,
-		       posix_cpu_timers_work);
+	clear_posix_cputimers_work(current);
 }
=20
 /*

