Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EED39C64E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEGeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:34:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4480 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhFEGeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:34:24 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxqVg4LhwzZcjD;
        Sat,  5 Jun 2021 14:29:47 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:32:34 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:32:33 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <axboe@kernel.dk>, <oleg@redhat.com>, <tglx@linutronix.de>,
        <dvyukov@google.com>, <akpm@linux-foundation.org>,
        <walter-zh.wu@mediatek.com>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] task_work: fix doc warnings in task_work.c
Date:   Sat, 5 Jun 2021 14:41:47 +0800
Message-ID: <20210605064147.690390-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for `task_work_cancel_match` to fix the W=1 warnings:

kernel/task_work.c:76: warning: Function parameter or
 member 'data' not described in 'task_work_cancel_match'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/task_work.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 1698fbe6f0e1..3992ebaabde5 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -65,7 +65,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
  * task_work_cancel_match - cancel a pending work added by task_work_add()
  * @task: the task which should execute the work
  * @match: match function to call
- *
+ * @data: data to match
  * RETURNS:
  * The found work or NULL if not found.
  */
-- 
2.31.1

