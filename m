Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A67353A1B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 01:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhDDXAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 19:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhDDXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 19:00:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B591C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 16:00:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d8so4818897plh.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/jVzrK4+3kAwFLLfo3nehN9aumdxd6U+dNyc14k2DIY=;
        b=eIBVdnApiT4hxVDAa3ucwhVr1ExRuUwj/eVWEeCRmku/EWP7PGz4ogaywYylub5C+p
         mDdR5mkO56sjs5Ii6BtwBEE2t2YLrHJkxGtKdyG9IhCkJ3wgnTUY6Gl698tv5vBvvgcI
         Sl4Q5C7Z4vHPQTUvL7ARFPxP7vG/+T3rV4hH+1s+GuGeC+WZmrITOBVZTvWtOd7Tdz4O
         OqI46rG5+PsgG0m9LRrHUCTQzFYntG6VV0kZ0YbDZdFcwz7HHlxRJhi5nytxCsZP2Rvv
         Ne0PrKxuViTqzXddFIqaj3sd2R+sVf9YiJuBneL42a49biZB7zRLdi4A1f+mSXdSBl0+
         35/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/jVzrK4+3kAwFLLfo3nehN9aumdxd6U+dNyc14k2DIY=;
        b=nDKgO7meI3k++0g3vHNCN4NYFuFAUdSL0PH51Yl5bAAJeDN35T/EskwJNgmQqFBD8M
         HdRyGVZrZAUlV/DiMXljvwkRQx2C/OryxQPU+mLhJpqVvBO+UGfBMnEIAlUcbVF+j5dn
         Z3NHJE8WO286Y441i41tWOVxIg4QqlXE7bd2tf/rJF3dxIPylVHsBtkNHM1xgIZzqUrE
         vX53jE0WkBxYuawW0Lbo5/1zqkkitWW8Lr0gDpeiSJLackmabdhP+aG3FCBnRhD5HqQi
         kO3VlBPoLYTeKtvwFXMmO8hbyy/JSrr5ygqYzRNst2Xv3ymY07CTQ6rWS+SB/wPPUlXs
         DRbA==
X-Gm-Message-State: AOAM531ibV+Qe8Y1dlUzxZiRS9H17Ox9za5yqQQXjHxrkK7KFztqyM9M
        Yi81JIoiAqX6LP9DiySy/rc6evh/1ipCWw==
X-Google-Smtp-Source: ABdhPJxG/Ne/k5Z++7IMbICMjd3dfAT6ijYSkTvaiEEN3OtTJPiO6VOi9bU/tvt2AhXNjymhPFhi4A==
X-Received: by 2002:a17:902:7786:b029:e6:cc0f:4dff with SMTP id o6-20020a1709027786b02900e6cc0f4dffmr21757050pll.4.1617577233181;
        Sun, 04 Apr 2021 16:00:33 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i1sm14340708pfu.96.2021.04.04.16.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 16:00:32 -0700 (PDT)
To:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] task_work: add helper for more targeted task_work canceling
Message-ID: <b036dde8-d025-5a9e-6a4c-60b4ce2d47b2@kernel.dk>
Date:   Sun, 4 Apr 2021 17:00:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only exported helper we have right now is task_work_cancel(), which
cancels any task_work from a given task where func matches the queued
work item. This is a bit too coarse for some use cases. Add a
task_work_cancel_match() that allows to more specifically target
individual work items outside of purely the callback function used.

task_work_cancel() can be trivially implemented on top of that, hence do
so.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

I've got a patch on top of this that uses task_work_cancel_match(), but
sending this one out separately. There should be no functional changes
in this patch, it just allows someone to build func == func && data ==
data matches on top.

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 0d848a1e9e62..5b8a93f288bb 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -22,6 +22,8 @@ enum task_work_notify_mode {
 int task_work_add(struct task_struct *task, struct callback_head *twork,
 			enum task_work_notify_mode mode);
 
+struct callback_head *task_work_cancel_match(struct task_struct *task,
+	bool (*match)(struct callback_head *, void *data), void *data);
 struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
 void task_work_run(void);
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 9cde961875c0..e9316198c64b 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -59,18 +59,17 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 }
 
 /**
- * task_work_cancel - cancel a pending work added by task_work_add()
+ * task_work_cancel_match - cancel a pending work added by task_work_add()
  * @task: the task which should execute the work
- * @func: identifies the work to remove
- *
- * Find the last queued pending work with ->func == @func and remove
- * it from queue.
+ * @match: match function to call
  *
  * RETURNS:
  * The found work or NULL if not found.
  */
 struct callback_head *
-task_work_cancel(struct task_struct *task, task_work_func_t func)
+task_work_cancel_match(struct task_struct *task,
+		       bool (*match)(struct callback_head *, void *data),
+		       void *data)
 {
 	struct callback_head **pprev = &task->task_works;
 	struct callback_head *work;
@@ -86,7 +85,7 @@ task_work_cancel(struct task_struct *task, task_work_func_t func)
 	 */
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 	while ((work = READ_ONCE(*pprev))) {
-		if (work->func != func)
+		if (!match(work, data))
 			pprev = &work->next;
 		else if (cmpxchg(pprev, work, work->next) == work)
 			break;
@@ -96,6 +95,28 @@ task_work_cancel(struct task_struct *task, task_work_func_t func)
 	return work;
 }
 
+static bool task_work_func_match(struct callback_head *cb, void *data)
+{
+	return cb->func == data;
+}
+
+/**
+ * task_work_cancel - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @func: identifies the work to remove
+ *
+ * Find the last queued pending work with ->func == @func and remove
+ * it from queue.
+ *
+ * RETURNS:
+ * The found work or NULL if not found.
+ */
+struct callback_head *
+task_work_cancel(struct task_struct *task, task_work_func_t func)
+{
+	return task_work_cancel_match(task, task_work_func_match, func);
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *

-- 
Jens Axboe

