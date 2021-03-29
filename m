Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0934CD35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhC2Jk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:40:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15090 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhC2Jkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:40:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F86vv0T66z19Jrw;
        Mon, 29 Mar 2021 17:38:35 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 17:40:27 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 1/2] drivers: most: use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 29 Mar 2021 17:40:14 +0800
Message-ID: <20210329094015.66942-1-liushixin2@huawei.com>
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
 drivers/most/most_cdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 044880760b58..8b69cf3ca60b 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -45,7 +45,7 @@ struct comp_channel {
 
 #define to_channel(d) container_of(d, struct comp_channel, cdev)
 static struct list_head channel_list;
-static spinlock_t ch_list_lock;
+static DEFINE_SPINLOCK(ch_list_lock);
 
 static inline bool ch_has_mbo(struct comp_channel *c)
 {
@@ -495,7 +495,6 @@ static int __init mod_init(void)
 		return PTR_ERR(comp.class);
 
 	INIT_LIST_HEAD(&channel_list);
-	spin_lock_init(&ch_list_lock);
 	ida_init(&comp.minor_id);
 
 	err = alloc_chrdev_region(&comp.devno, 0, CHRDEV_REGION_SIZE, "cdev");
-- 
2.25.1

