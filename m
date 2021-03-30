Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF134E188
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhC3Gvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:51:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15817 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhC3GvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:51:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8g62461Fz93j3;
        Tue, 30 Mar 2021 14:49:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:51:11 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <jassisinghbrar@gmail.com>, <leo.yan@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] mailbox: hisilicon: Use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:48:40 +0800
Message-ID: <1617086920-15952-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/mailbox/hi3660-mailbox.c | 4 ++--
 drivers/mailbox/hi6220-mailbox.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index 53f4bc2..45c6d69 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2017-2018 Hisilicon Limited.
+// Copyright (c) 2017-2018 HiSilicon Limited.
 // Copyright (c) 2017-2018 Linaro Limited.
 
 #include <linux/bitops.h>
@@ -297,5 +297,5 @@ static void __exit hi3660_mbox_exit(void)
 module_exit(hi3660_mbox_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Hisilicon Hi3660 Mailbox Controller");
+MODULE_DESCRIPTION("HiSilicon Hi3660 Mailbox Controller");
 MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index cc236ac..9fdc25e 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon's Hi6220 mailbox driver
+ * HiSilicon's Hi6220 mailbox driver
  *
- * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 HiSilicon Limited.
  * Copyright (c) 2015 Linaro Limited.
  *
  * Author: Leo Yan <leo.yan@linaro.org>
-- 
2.8.1

