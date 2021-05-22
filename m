Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5E38D522
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhEVK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:29:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3635 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhEVK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:29:42 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnKNC5jxJzQjJg;
        Sat, 22 May 2021 18:24:43 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:28:17 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:28:16 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <lee.jones@linaro.org>, <puck.chen@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] mfd: hisilicon: use the correct HiSilicon copyright
Date:   Sat, 22 May 2021 18:25:15 +0800
Message-ID: <1621679115-15479-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Hisilicon/HiSilicon/.
It should use capital S, according to the official website
https://www.hisilicon.com/en.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/mfd/hi655x-pmic.c       | 2 +-
 include/linux/mfd/hi655x-pmic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index d3c86a7..6909d07 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -2,7 +2,7 @@
 /*
  * Device driver for MFD hi655x PMIC
  *
- * Copyright (c) 2016 Hisilicon.
+ * Copyright (c) 2016 HiSilicon Ltd.
  *
  * Authors:
  * Chen Feng <puck.chen@hisilicon.com>
diff --git a/include/linux/mfd/hi655x-pmic.h b/include/linux/mfd/hi655x-pmic.h
index b061713..af5d972 100644
--- a/include/linux/mfd/hi655x-pmic.h
+++ b/include/linux/mfd/hi655x-pmic.h
@@ -2,7 +2,7 @@
 /*
  * Device driver for regulators in hi655x IC
  *
- * Copyright (c) 2016 Hisilicon.
+ * Copyright (c) 2016 HiSilicon Ltd.
  *
  * Authors:
  * Chen Feng <puck.chen@hisilicon.com>
-- 
2.8.1

