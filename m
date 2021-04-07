Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB051356C77
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352349AbhDGMp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:45:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16061 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbhDGMpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:45:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFkb90Pl3z16J2P;
        Wed,  7 Apr 2021 20:43:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 20:45:35 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <alexander.shishkin@linux.intel.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] stm class: initialize static variable in declaration
Date:   Wed, 7 Apr 2021 20:53:58 +0800
Message-ID: <20210407125358.4135345-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

list head can be initialized automatically with LIST_HEAD() rather
than explicitly calling INIT_LIST_HEAD().

srcu_struct can be initialized automatically with DEFINE_STATIC_SRCU()
rather than explicitly calling init_srcu_struct().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/hwtracing/stm/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 2712e699ba08..1e13993e7969 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -31,7 +31,7 @@ static unsigned int stm_core_up;
  * stm_source_write() caller, which may want to have as little overhead as
  * possible.
  */
-static struct srcu_struct stm_source_srcu;
+DEFINE_STATIC_SRCU(stm_source_srcu);
 
 static ssize_t masters_show(struct device *dev,
 			    struct device_attribute *attr,
@@ -366,8 +366,8 @@ static int major_match(struct device *dev, const void *data)
  * Modules can implement STM protocol drivers and (un-)register them
  * with the STM class framework.
  */
-static struct list_head stm_pdrv_head;
-static struct mutex stm_pdrv_mutex;
+static LIST_HEAD(stm_pdrv_head);
+static DEFINE_MUTEX(stm_pdrv_mutex);
 
 struct stm_pdrv_entry {
 	struct list_head			entry;
@@ -1324,10 +1324,6 @@ static int __init stm_core_init(void)
 	if (err)
 		goto err_src;
 
-	init_srcu_struct(&stm_source_srcu);
-	INIT_LIST_HEAD(&stm_pdrv_head);
-	mutex_init(&stm_pdrv_mutex);
-
 	/*
 	 * So as to not confuse existing users with a requirement
 	 * to load yet another module, do it here.
-- 
2.25.4

