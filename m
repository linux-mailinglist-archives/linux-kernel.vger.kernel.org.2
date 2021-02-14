Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EF31AE91
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 01:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBNAHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 19:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBNAHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 19:07:12 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E575EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 16:06:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z7so1734095plk.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 16:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3dunhjuge82EZFNBw1SP5OgsJ3YUo0+A3T8/54pbBw=;
        b=kkvhtd0et8dKiabKSEuyFORv6JemghPpBfB2zKZJz21JBc9w3UJk+ws+VHSkT/wPfJ
         gPJ/Y7Wrxsm7RBrzrgkn6Zpvx3iaBYt+HzZ8185SHiiSQ/WZ1qX8WVtP0J3Rt3nrQGtN
         /xutdAmTO/GCd9vOfUOXHcduzFlZpV75pzmDU+heB8t5nz1zYWVwWx/6eMiqFqBRTcyj
         AbDiJhJlEvIHItF51O6KkQ611lgv4KGZlAYHsz5ZpP/Y03Krm7eAA1xVhG5LRcD46Gdn
         1W4DTLl7ZsbcXkXTE5oVpcbWz+jDywSF1a126jssEHr+mawlNgLnqEfKTKr0lqoy135t
         8Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3dunhjuge82EZFNBw1SP5OgsJ3YUo0+A3T8/54pbBw=;
        b=chRFNtdB8/rn/tZUt1mw0J3Qe+JkrUsA/FUa9MMoyiWUpSlEY7JdQYY/KcoERpADR5
         OyTj/u36Xu/cuG5gO4McH7gGsniTfaRb54Dhww9/8gG1OILy5nCMtWqqXRoYu01C/yzM
         a80fIzlLj1rd6Kzb4c4tW5a44mRApEzjbM8KuiZWntkK7hWVkLwSfyv7blZdJ2TW8rt7
         3OrL9IOSNVW5G7Krs3G505+AcN0jLQd0ihuJYssGq/7nx1rC3UaBS3NOb+YGEQ2uJZm6
         Yl4P96nMQkUIG8JVgqbbYII20VaH2YDTvIF9fTCq2dGzt7Ku/oyO6qnhFV/ga4RkSIlD
         NZ0w==
X-Gm-Message-State: AOAM532TFtuFEwspZ9FWF8Eu2adGpfCi4z7NMJUPci5BJpFnMYWaNfhd
        iUsJUKK6guQSq8KHyDAyAblREg==
X-Google-Smtp-Source: ABdhPJxcrgcLjQU7azvPVoahs8OM/62NQAnqLRP+jkTTelU2yx7e5RN2TOcX8FL7j7NkRLBjH7sr8g==
X-Received: by 2002:a17:902:728a:b029:e3:530:cc73 with SMTP id d10-20020a170902728ab02900e30530cc73mr8534117pll.60.1613261191285;
        Sat, 13 Feb 2021 16:06:31 -0800 (PST)
Received: from zzyiwei.c.googlers.com.com (152.33.83.34.bc.googleusercontent.com. [34.83.33.152])
        by smtp.gmail.com with ESMTPSA id r5sm13080545pfh.13.2021.02.13.16.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 16:06:30 -0800 (PST)
From:   Yiwei Zhang <zzyiwei@android.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Yiwei Zhang <zzyiwei@android.com>
Subject: [PATCH] kthread: add kthread_mod_pending_delayed_work api
Date:   Sun, 14 Feb 2021 00:06:11 +0000
Message-Id: <20210214000611.2169820-1-zzyiwei@android.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing kthread_mod_delayed_work api will queue a new work if
failing to cancel the current work due to no longer being pending.
However, there's a case that the same work can be enqueued from both
an async request and a delayed work, and a racing could happen if the
async request comes right after the timeout delayed work gets scheduled,
because the clean up work may not be safe to run twice.

Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
---
 include/linux/kthread.h |  3 +++
 kernel/kthread.c        | 48 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0c494d..250cdc5ff2a5 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -192,6 +192,9 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 bool kthread_mod_delayed_work(struct kthread_worker *worker,
 			      struct kthread_delayed_work *dwork,
 			      unsigned long delay);
+bool kthread_mod_pending_delayed_work(struct kthread_worker *worker,
+				      struct kthread_delayed_work *dwork,
+				      unsigned long delay);
 
 void kthread_flush_work(struct kthread_work *work);
 void kthread_flush_worker(struct kthread_worker *worker);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index a5eceecd4513..13881076afdd 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1142,6 +1142,54 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
 
+/**
+ * kthread_mod_pending_delayed_work - modify delay of a pending delayed work
+ * @worker: kthread worker to use
+ * @dwork: kthread delayed work to queue
+ * @delay: number of jiffies to wait before queuing
+ *
+ * If @dwork is still pending modify @dwork's timer so that it expires after
+ * @delay. If @dwork is still pending and @delay is zero, @work is guaranteed to
+ * be queued immediately.
+ *
+ * Return: %true if @dwork was pending and its timer was modified,
+ * %false otherwise.
+ *
+ * A special case is when the work is being canceled in parallel.
+ * It might be caused either by the real kthread_cancel_delayed_work_sync()
+ * or yet another kthread_mod_delayed_work() call. We let the other command
+ * win and return %false here. The caller is supposed to synchronize these
+ * operations a reasonable way.
+ *
+ * This function is safe to call from any context including IRQ handler.
+ * See __kthread_cancel_work() and kthread_delayed_work_timer_fn()
+ * for details.
+ */
+bool kthread_mod_pending_delayed_work(struct kthread_worker *worker,
+				      struct kthread_delayed_work *dwork,
+				      unsigned long delay)
+{
+	struct kthread_work *work = &dwork->work;
+	unsigned long flags;
+	int ret = true;
+
+	raw_spin_lock_irqsave(&worker->lock, flags);
+	if (!work->worker || work->canceling ||
+	    !__kthread_cancel_work(work, true, &flags)) {
+		ret = false;
+		goto out;
+	}
+
+	/* Work must not be used with >1 worker, see kthread_queue_work() */
+	WARN_ON_ONCE(work->worker != worker);
+
+	__kthread_queue_delayed_work(worker, dwork, delay);
+out:
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kthread_mod_pending_delayed_work);
+
 static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 {
 	struct kthread_worker *worker = work->worker;
-- 
2.30.0.478.g8a0d178c01-goog

