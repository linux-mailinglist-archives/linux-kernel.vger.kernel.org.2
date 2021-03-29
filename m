Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8EC34CD38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhC2JlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:41:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15092 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhC2Jkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:40:40 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F86vv0sqFz19Jtx;
        Mon, 29 Mar 2021 17:38:35 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 17:40:31 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 2/2] s390/cio: use DECLARE_WAIT_QUEUE_HEAD() for wait_queue
Date:   Mon, 29 Mar 2021 17:40:19 +0800
Message-ID: <20210329094019.67044-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329094019.67044-1-liushixin2@huawei.com>
References: <20210329094019.67044-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_queue_head_t can be initialized automatically with DECLARE_WAIT_QUEUE_HEAD()
rather than explicitly calling init_waitqueue_head().

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/s390/cio/css.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index f01ef6325039..a974943c27da 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -652,13 +652,12 @@ static void css_sch_todo(struct work_struct *work)
 
 static struct idset *slow_subchannel_set;
 static DEFINE_SPINLOCK(slow_subchannel_lock);
-static wait_queue_head_t css_eval_wq;
+static DECLARE_WAIT_QUEUE_HEAD(css_eval_wq);
 static atomic_t css_eval_scheduled;
 
 static int __init slow_subchannel_init(void)
 {
 	atomic_set(&css_eval_scheduled, 0);
-	init_waitqueue_head(&css_eval_wq);
 	slow_subchannel_set = idset_sch_new();
 	if (!slow_subchannel_set) {
 		CIO_MSG_EVENT(0, "could not allocate slow subchannel set\n");
-- 
2.25.1

