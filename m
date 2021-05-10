Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11C37903E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbhEJOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhEJOEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:04:02 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28753C0611A7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:44:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y32so13304393pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v+DW+5IyKCx+0DFPwK3g1lZXBK5W5GsagNNGu0cU0o4=;
        b=mLl6CJXDKzJ+cWFwGrmrH3t5RFGyzmadBvIIQWjBpCgu40enf7fG9N1e/hxUC24mtH
         tFIUVd2jPEwZNqZdOpVXdRcruwqVEetwetGGkd5N3AJ3Y/bU+SBhA8ddoQvEo5/Pp+bR
         SVhn/NJRzM6Ox6lD6P0kPz41EKs35ueu4EQRmmF483BAspCU0oBiD3Ud9pqH8h0Vk8Gu
         Kw1lSNDD2YukgL3YqE4tH6ACBUe4ulBUm9TLDnL+fqoc1tdId/vUe9qIIFLgbE4kClSC
         dLQYWHjmDx0KpK8ACbt7r7Q49Qcb/0/FMIgbOsiFb+/9TmxC0rYk21kRsxKS70fiJFuQ
         vxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+DW+5IyKCx+0DFPwK3g1lZXBK5W5GsagNNGu0cU0o4=;
        b=RNjbXfQtb25+uKE6Ffaf02RoaRq5Z7Uc53Pc/MuE5uQf+f1d4j+1p/0QR93Bz81n+V
         soIWkF99nqmFQb4Ae3x/udKun+usyRIknN4QqVEzq6KtcY+4+f1iGo6hr4p3plSD+D5y
         plQFq35KXeznXviIFbXjkdCjNagbVkiGXlISbbfg7U+7WntfIu8Do+VnIBMKjG1RzkPX
         pqu7f8Zuti5mGgRAAKM5i/zkm6bu3Q/O4Xhv45CIqmq4Aq7BzltLHGkR8EnseFSQz8zs
         GOKd7AEG6PdW6RmrzRlK7JNvmTOlMzgzvo5k+sQPCu3g2f8ktxvSwcZp1Y/CB1EJRXjk
         tu7A==
X-Gm-Message-State: AOAM533Bdp0OyL2+tDLGmdwF5tizQsZYJIfRnaepOUwMb6znMUk/wA8I
        pAuL9dMEaZfrnMd3l430zV8=
X-Google-Smtp-Source: ABdhPJxQM9uCU/vlQyf5u7nXcNffDE6ZvkFneMrPR24WnrG3ID1ryCPaG4ncmqlo50lL5Y8uNqFimA==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr25270829pgi.50.1620654257766;
        Mon, 10 May 2021 06:44:17 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([45.67.53.159])
        by smtp.gmail.com with ESMTPSA id n203sm11537432pfd.31.2021.05.10.06.44.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 May 2021 06:44:17 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
X-Google-Original-From: Yejune Deng <yejunedeng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tglx@linutronix.de, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejunedeng@gmail.com>
Subject: [PATCH v2] lib/smp_processor_id: Use is_percpu_thread() check affinity
Date:   Mon, 10 May 2021 21:43:58 +0800
Message-Id: <1620654238-1410-1-git-send-email-yejunedeng@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <87pmxyj1tr.mognet@arm.com>
References: <87pmxyj1tr.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_percpu_thread() instead of 'current->nr_cpus_allowed == 1',
and add PF_NO_SETAFFINITY flag in init_idle().This would be nice to
the sched_setaffinity(), and it also more readable.

v1->v2:
  - add PF_NO_SETAFFINITY flag in init_idle().

Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
---
 kernel/sched/core.c    | 2 +-
 lib/smp_processor_id.c | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9143163..82e21ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7446,7 +7446,7 @@ void init_idle(struct task_struct *idle, int cpu)
 
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
-	idle->flags |= PF_IDLE;
+	idle->flags |= PF_IDLE | PF_NO_SETAFFINITY;
 
 	scs_task_reset(idle);
 	kasan_unpoison_task_stack(idle);
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 1c1dbd3..046ac62 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -19,11 +19,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (irqs_disabled())
 		goto out;
 
-	/*
-	 * Kernel threads bound to a single CPU can safely use
-	 * smp_processor_id():
-	 */
-	if (current->nr_cpus_allowed == 1)
+	if (is_percpu_thread())
 		goto out;
 
 #ifdef CONFIG_SMP
-- 
2.7.4

