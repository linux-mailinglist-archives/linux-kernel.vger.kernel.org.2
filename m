Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8DE3A0CC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhFIGzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:55:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5300 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhFIGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:55:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0Hkg0VWBz1BJml;
        Wed,  9 Jun 2021 14:48:43 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:53:34 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 14:53:34 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next v2] clockevents: Use list_move instead of list_del/list_add in clockevents.c
Date:   Wed, 9 Jun 2021 15:02:42 +0800
Message-ID: <20210609070242.1322450-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using list_move() instead of list_del() + list_add() in clockevents.c.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
        CC mailist

 kernel/time/clockevents.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0056d2bed53e..d59ac319f9f4 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -347,8 +347,7 @@ static void clockevents_notify_released(void)
 	while (!list_empty(&clockevents_released)) {
 		dev = list_entry(clockevents_released.next,
 				 struct clock_event_device, list);
-		list_del(&dev->list);
-		list_add(&dev->list, &clockevent_devices);
+		list_move(&dev->list, &clockevent_devices);
 		tick_check_new_device(dev);
 	}
 }
@@ -576,8 +575,7 @@ void clockevents_exchange_device(struct clock_event_device *old,
 	if (old) {
 		module_put(old->owner);
 		clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
-		list_del(&old->list);
-		list_add(&old->list, &clockevents_released);
+		list_move(&old->list, &clockevents_released);
 	}
 
 	if (new) {

