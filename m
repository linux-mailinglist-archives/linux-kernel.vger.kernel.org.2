Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9764350016
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhCaMVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:21:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14655 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbhCaMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:20:42 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9QLx20HdznWxB;
        Wed, 31 Mar 2021 20:18:01 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 20:20:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <mihai.carabas@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] misc/pvpanic: Make some symbols static
Date:   Wed, 31 Mar 2021 20:17:06 +0800
Message-ID: <20210331121706.15268-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/misc/pvpanic/pvpanic.c:28:18: warning:
 symbol 'pvpanic_list' was not declared. Should it be static?
drivers/misc/pvpanic/pvpanic.c:29:12: warning:
 symbol 'pvpanic_lock' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/pvpanic/pvpanic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 804099c2d7fa..65f70a4da8c0 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -25,8 +25,8 @@ MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
 MODULE_DESCRIPTION("pvpanic device driver ");
 MODULE_LICENSE("GPL");
 
-struct list_head pvpanic_list;
-spinlock_t pvpanic_lock;
+static struct list_head pvpanic_list;
+static spinlock_t pvpanic_lock;
 
 static void
 pvpanic_send_event(unsigned int event)
-- 
2.17.1

