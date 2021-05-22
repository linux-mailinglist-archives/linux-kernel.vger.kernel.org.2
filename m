Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3B38D50A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhEVKRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:17:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3910 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhEVKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:17:30 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FnK6q6d3kzBvQ7;
        Sat, 22 May 2021 18:13:07 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:15:56 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:15:56 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <jassisinghbrar@gmail.com>, <leo.yan@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH RESEND] mailbox: hisilicon: Use the correct HiSilicon copyright
Date:   Sat, 22 May 2021 18:12:54 +0800
Message-ID: <1621678374-14236-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Hisilicon/HiSilicon/.
It should use capital S, according to
https://www.hisilicon.com/en.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/mailbox/hi3660-mailbox.c | 2 +-
 drivers/mailbox/hi6220-mailbox.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index 53f4bc2..395ddc2 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2017-2018 Hisilicon Limited.
+// Copyright (c) 2017-2018 HiSilicon Limited.
 // Copyright (c) 2017-2018 Linaro Limited.
 
 #include <linux/bitops.h>
diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index cc236ac..560cd09 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -2,7 +2,7 @@
 /*
  * Hisilicon's Hi6220 mailbox driver
  *
- * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 HiSilicon Limited.
  * Copyright (c) 2015 Linaro Limited.
  *
  * Author: Leo Yan <leo.yan@linaro.org>
-- 
2.8.1

