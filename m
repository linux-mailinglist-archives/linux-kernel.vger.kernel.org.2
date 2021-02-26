Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC28032673B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBZTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:08:34 -0500
Received: from m12-13.163.com ([220.181.12.13]:40684 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhBZTI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=c+0Ws
        0JxCob3jtsWsI2a6eecdZHS/h55NwNp2HwVmsY=; b=L5PzEpGyBCXsAs5JsCSno
        mdjNrQ/gUS110IrFz0JsygipzvuXj28cwXlUpZs0h7B9z5+ozBl73JHqWmqODyIj
        GRq7c1njO5ekJzrrRtfsjuS365X9GbrNRmSst7mBZcyRZetTIzz2gfN4WeUIGsnQ
        kagjs0jeux+KQQGZCrpNTY=
Received: from [192.168.1.196] (unknown [183.206.6.163])
        by smtp9 (Coremail) with SMTP id DcCowAA3Z49qEDlg3baPgw--.13281S2;
        Fri, 26 Feb 2021 23:14:50 +0800 (CST)
To:     tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
From:   Canjiang Lu <craftsfish@163.com>
Subject: workqueue: useless call of smp_mb() is removed from insert_work
Message-ID: <0594105e-0bb2-07e9-56f1-ed38d9a7b951@163.com>
Date:   Fri, 26 Feb 2021 23:14:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DcCowAA3Z49qEDlg3baPgw--.13281S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWkXw13WF4xAF1UWrW5trb_yoW8Aw1kpr
        sxKry3tay8Xryjva4UJr4jvr45Gw1Yqr9xWF48Gw1Fyws8AF9aqa4xKrySvr95ArZ7Xr45
        ZFWUKrW2kF4DZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b3uc_UUUUU=
X-Originating-IP: [183.206.6.163]
X-CM-SenderInfo: hfudw3pvil2xi6rwjhhfrp/1tbiowpFKVUMWHlPKgAAsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When worker is going to sleep, check whether an new idle worker should be
kicked is protected by pool->lock. Since insert_work is also protected by
pool->lock, both parts are serialized. The original lock-less design doesn't
make sense anymore and we can remove the call of smp_mb() from insert_work.
Related comments are also removed.

Signed-off-by: Canjiang Lu <craftsfish@163.com>
---
 kernel/workqueue.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9880b6c0e272..861f23a6f1ba 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -883,18 +883,6 @@ void wq_worker_sleeping(struct task_struct *task)
 
        worker->sleeping = 1;
        raw_spin_lock_irq(&pool->lock);
-
-       /*
-        * The counterpart of the following dec_and_test, implied mb,
-        * worklist not empty test sequence is in insert_work().
-        * Please read comment there.
-        *
-        * NOT_RUNNING is clear.  This means that we're bound to and
-        * running on the local cpu w/ rq lock held and preemption
-        * disabled, which in turn means that none else could be
-        * manipulating idle_list, so dereferencing idle_list without pool
-        * lock is safe.
-        */
        if (atomic_dec_and_test(&pool->nr_running) &&
            !list_empty(&pool->worklist)) {
                next = first_idle_worker(pool);
@@ -1334,14 +1322,6 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
        set_work_pwq(work, pwq, extra_flags);
        list_add_tail(&work->entry, head);
        get_pwq(pwq);
-
-       /*
-        * Ensure either wq_worker_sleeping() sees the above
-        * list_add_tail() or we see zero nr_running to avoid workers lying
-        * around lazily while there are works to be processed.
-        */
-       smp_mb();
-
        if (__need_more_worker(pool))
                wake_up_worker(pool);
 }
-- 
2.17.1

