Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7A34CD39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC2JlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:41:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15093 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhC2Jkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:40:40 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F86vv1c5Sz19Jtg;
        Mon, 29 Mar 2021 17:38:35 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 17:40:30 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 1/2] s390/cio: use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 29 Mar 2021 17:40:18 +0800
Message-ID: <20210329094019.67044-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/s390/cio/css.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 253ab4e7a415..f01ef6325039 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -651,13 +651,12 @@ static void css_sch_todo(struct work_struct *work)
 }
 
 static struct idset *slow_subchannel_set;
-static spinlock_t slow_subchannel_lock;
+static DEFINE_SPINLOCK(slow_subchannel_lock);
 static wait_queue_head_t css_eval_wq;
 static atomic_t css_eval_scheduled;
 
 static int __init slow_subchannel_init(void)
 {
-	spin_lock_init(&slow_subchannel_lock);
 	atomic_set(&css_eval_scheduled, 0);
 	init_waitqueue_head(&css_eval_wq);
 	slow_subchannel_set = idset_sch_new();
-- 
2.25.1

