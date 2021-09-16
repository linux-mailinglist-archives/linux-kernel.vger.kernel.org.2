Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A2340E98C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbhIPSIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351505AbhIPSGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:06:21 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8621C061D6C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:37:29 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r3-20020a0cc403000000b00377a3318261so59374628qvi.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sBm/kHNsJOwk5GfFSoVxh83u5s0/i8ma9jvWkgSwVDk=;
        b=q7TdV5nqyczGXKbDqK5IDRxzCdI5uOWbNjmqKEblwGVPIUd7/rLYzYGuoU9+4UMuXM
         TfOY5CKLh+FugU5A/lRxwJDyvdOgGMzc5jIDKFcYdx6wBhkn6JWKMbKcua31Pe9ESdoh
         Q05R0T3MrLUJGPe07AuurLURngQSxJHl6+fOXiAlH259Zm6f+nCrCPpj0KeHoIIE6vUN
         hhuo7b1wnzJCfdCKhP5JJf6cAhBlJPV/EW5oO0UOIX+/GDgQVXj8M0JzU9+gdTpr4HNG
         eWFdo1dTzisoRAqPlaTABMbsDwqjHcuSFMxS4OJQrSmS4RdS5qnTZE2joweuoD1EjhRP
         4yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sBm/kHNsJOwk5GfFSoVxh83u5s0/i8ma9jvWkgSwVDk=;
        b=yK8jfjY+kpOKrvFANB8Ic+fuK//c+h9OGSOtEEByG1Cu+Wy3lzuVP4ClbNvFerNEM9
         6w8cjEjylYyqwRMjWskQDHhbOM3awhJo/Jwpp7H07GgGS562KGCyWn7wH1eKwcpBvXgx
         Oay3qefFv/Nndz9xFZkT4rxnVpQQowLtGblt50S3VNfsiRELMJVt5Rev7Ar/s2BXA13v
         rfrmiwLi1nTOt352TiVlOjhcJLwOVU3BoTAAODqIs7yi+1lRjYf56sbiv0pqL9dkQaPe
         /KDeEulVGpMtpLCJ94mLrP983QTy3h5/NOlQjC8dmH1VzgWaNNJdOY8rndz4oHyIL3Nw
         ycmw==
X-Gm-Message-State: AOAM530Ud+AopmYgsHrsWm1GIUPjICK2K5ehwM7hmGEUGWVyIrAGzA3i
        yH0/PcGPxNfjKmwLFd4oGS2uIMVGJhYpA3oh
X-Google-Smtp-Source: ABdhPJxE5nz90QMz6Xzc7bna2lWCZZomuSyI5AGtTrduj1/XGylKS5eKSRFy9SiFmO8ShPGinLF0SyBqMXiycn9B
X-Received: from clapinski.waw.corp.google.com ([2a00:79e0:2:11:1fc6:3621:21bf:1e5a])
 (user=mclapinski job=sendgmr) by 2002:ad4:4a93:: with SMTP id
 h19mr6265953qvx.41.1631810249185; Thu, 16 Sep 2021 09:37:29 -0700 (PDT)
Date:   Thu, 16 Sep 2021 18:37:17 +0200
Message-Id: <20210916163717.3179496-1-mclapinski@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] ipc: check checkpoint_restore_ns_capable() to modify C/R proc files
From:   Michal Clapinski <mclapinski@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes the requirement to be root to modify sem_next_id,
msg_next_id and shm_next_id and checks checkpoint_restore_ns_capable
instead.

Since those files are specific to the IPC namespace, there is no reason
they should require root privileges. This is similar to ns_last_pid,
which also only checks checkpoint_restore_ns_capable.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 ipc/ipc_sysctl.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 3f312bf2b116..f8e27203ca49 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -104,6 +104,19 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	return ret;
 }
 
+#ifdef CONFIG_CHECKPOINT_RESTORE
+static int proc_ipc_dointvec_minmax_checkpoint_restore(struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct user_namespace *user_ns = current->nsproxy->ipc_ns->user_ns;
+
+	if (write && !checkpoint_restore_ns_capable(user_ns))
+		return -EPERM;
+
+	return proc_ipc_dointvec_minmax(table, write, buffer, lenp, ppos);
+}
+#endif
+
 #else
 #define proc_ipc_doulongvec_minmax NULL
 #define proc_ipc_dointvec	   NULL
@@ -111,6 +124,9 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 #define proc_ipc_dointvec_minmax_orphans   NULL
 #define proc_ipc_auto_msgmni	   NULL
 #define proc_ipc_sem_dointvec	   NULL
+#ifdef CONFIG_CHECKPOINT_RESTORE
+#define proc_ipc_dointvec_minmax_checkpoint_restore	NULL
+#endif	/* CONFIG_CHECKPOINT_RESTORE */
 #endif
 
 int ipc_mni = IPCMNI;
@@ -198,8 +214,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.procname	= "sem_next_id",
 		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
-		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec_minmax,
+		.mode		= 0666,
+		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
 	},
@@ -207,8 +223,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.procname	= "msg_next_id",
 		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
-		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec_minmax,
+		.mode		= 0666,
+		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
 	},
@@ -216,8 +232,8 @@ static struct ctl_table ipc_kern_table[] = {
 		.procname	= "shm_next_id",
 		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
-		.mode		= 0644,
-		.proc_handler	= proc_ipc_dointvec_minmax,
+		.mode		= 0666,
+		.proc_handler	= proc_ipc_dointvec_minmax_checkpoint_restore,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
 	},
-- 
2.33.0.309.g3052b89438-goog

