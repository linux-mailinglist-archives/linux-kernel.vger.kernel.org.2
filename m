Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C103EEB71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbhHQLSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQLSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:18:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF6C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l11so24527283plk.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5z+18XqAOtvaOZHF/XKN1S01if/H156ss0nlJ2TcPPc=;
        b=Dzu+qOOZeBG0MJcO1sajclg1Pf7eClP3aNvmheyik7l1RvjU8v75DNKe77vB9+eDoF
         orMHdGu+xnvPQLGjIiKFTmujJsbdhtKR599qi5KOEyW09I/TXgOouDqoqllobwcnww+e
         YOOkjUHPqUg4eQ4n8xD9SLD2li0WC8FdM42idqYW7en1MnbzEuCukWOgE9YDbIPFsgmI
         72ouLvbY05FH5AVs2LbTjSHTATO2WqfcLJu9oNXhDQxlLt+C7R/zB5bS26anLFj8MOdP
         jOra27dDJaQDSnsQbnTsMp6OKztVpKM1qw5Vu1PlWAemA+TRRM1CuknOMrZucKd2MJA2
         wrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5z+18XqAOtvaOZHF/XKN1S01if/H156ss0nlJ2TcPPc=;
        b=oZ8vOIUtJV6AFAZLj+6KosiiHMt7E3huYRvQOx5PawHmxdQg8bBU5UNrpWosb70YJV
         9u3qmNI5KxlkILkyMWkxWMyDuNxEzPMYIQmn8an0Q8xCB+hCp1C5DphUAtD7jIeUGllA
         C0Et+VX72I99aqanaDw0jDahyiJuS2HaYzx38GNAtOZIxVlvpSsgh1ZOL/zTsyh9KRus
         0TuaOBlu/ch1CcLgXsOLjmqflE4NJ1SJ1JIT+Yduo6rIsoskwBctT0LkQysFubATVNHe
         tvMtI4aBiN9IaIgx4IsJ/pha1yij1gTlskLmu1W9htNCrcx60Oouek/PqfT0Rv8YMYr3
         QB1g==
X-Gm-Message-State: AOAM532YTgWNZLBwbtvY5D8Iu5D5vlXV2Ai/etuWhFx2eRKfsTk8L6fO
        Q8kpMtxauAmw0q3FdvkzcPo2p2GqArE=
X-Google-Smtp-Source: ABdhPJyJsuMNvgPYODhFLCcxgm4irmxZhpCyWJlkq2hTbg7HLK25R+gMp4PQ2mKU5CjAvKWuDJMz0A==
X-Received: by 2002:a05:6a00:8c7:b029:3a1:119b:736 with SMTP id s7-20020a056a0008c7b02903a1119b0736mr3234522pfu.52.1629199087743;
        Tue, 17 Aug 2021 04:18:07 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id u6sm2600568pgr.3.2021.08.17.04.18.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 04:18:07 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 2/6] workqueue: Change arguement of pwq_dec_nr_in_flight()
Date:   Tue, 17 Aug 2021 09:32:35 +0800
Message-Id: <20210817013239.3921-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210817013239.3921-1-jiangshanlai@gmail.com>
References: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
 <20210817013239.3921-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Make pwq_dec_nr_in_flight() use work_data rather just work_color.

Prepare for later patch to get WORK_STRUCT_INACTIVE bit from work_data
in pwq_dec_nr_in_flight().

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b2712807c403..0a4fae7cb918 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -579,9 +579,9 @@ static unsigned int work_color_to_flags(int color)
 	return color << WORK_STRUCT_COLOR_SHIFT;
 }
 
-static int get_work_color(struct work_struct *work)
+static int get_work_color(unsigned long work_data)
 {
-	return (*work_data_bits(work) >> WORK_STRUCT_COLOR_SHIFT) &
+	return (work_data >> WORK_STRUCT_COLOR_SHIFT) &
 		((1 << WORK_STRUCT_COLOR_BITS) - 1);
 }
 
@@ -1159,7 +1159,7 @@ static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 /**
  * pwq_dec_nr_in_flight - decrement pwq's nr_in_flight
  * @pwq: pwq of interest
- * @color: color of work which left the queue
+ * @work_data: work_data of work which left the queue
  *
  * A work either has completed or is removed from pending queue,
  * decrement nr_in_flight of its pwq and handle workqueue flushing.
@@ -1167,8 +1167,10 @@ static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
  * CONTEXT:
  * raw_spin_lock_irq(pool->lock).
  */
-static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
+static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_data)
 {
+	int color = get_work_color(work_data);
+
 	/* uncolored work items don't participate in flushing or nr_active */
 	if (color == WORK_NO_COLOR)
 		goto out_put;
@@ -1291,7 +1293,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 			pwq_activate_inactive_work(work);
 
 		list_del_init(&work->entry);
-		pwq_dec_nr_in_flight(pwq, get_work_color(work));
+		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
 
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
@@ -2173,7 +2175,7 @@ __acquires(&pool->lock)
 	struct pool_workqueue *pwq = get_work_pwq(work);
 	struct worker_pool *pool = worker->pool;
 	bool cpu_intensive = pwq->wq->flags & WQ_CPU_INTENSIVE;
-	int work_color;
+	unsigned long work_data;
 	struct worker *collision;
 #ifdef CONFIG_LOCKDEP
 	/*
@@ -2209,7 +2211,7 @@ __acquires(&pool->lock)
 	worker->current_work = work;
 	worker->current_func = work->func;
 	worker->current_pwq = pwq;
-	work_color = get_work_color(work);
+	work_data = *work_data_bits(work);
 
 	/*
 	 * Record wq name for cmdline and debug reporting, may get
@@ -2315,7 +2317,7 @@ __acquires(&pool->lock)
 	worker->current_work = NULL;
 	worker->current_func = NULL;
 	worker->current_pwq = NULL;
-	pwq_dec_nr_in_flight(pwq, work_color);
+	pwq_dec_nr_in_flight(pwq, work_data);
 }
 
 /**
-- 
2.19.1.6.gb485710b

