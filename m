Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D2C38D526
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhEVKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:31:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3912 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhEVKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:31:13 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FnKQp50TLzBvJQ;
        Sat, 22 May 2021 18:26:58 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:29:47 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:29:47 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <haojian.zhuang@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] clk: hisilicon: use the correct HiSilicon copyright
Date:   Sat, 22 May 2021 18:26:35 +0800
Message-ID: <1621679195-15701-1-git-send-email-fanghao11@huawei.com>
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
It should use capital S, according to the official website
https://www.hisilicon.com/en.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/clk/hisilicon/clk-hi3620.c        | 2 +-
 drivers/clk/hisilicon/clk-hi3660-stub.c   | 2 +-
 drivers/clk/hisilicon/clk-hi6220-stub.c   | 2 +-
 drivers/clk/hisilicon/clk-hi6220.c        | 2 +-
 drivers/clk/hisilicon/clk-hip04.c         | 2 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       | 2 +-
 drivers/clk/hisilicon/clk.c               | 2 +-
 drivers/clk/hisilicon/clk.h               | 2 +-
 drivers/clk/hisilicon/clkdivider-hi6220.c | 2 +-
 drivers/clk/hisilicon/clkgate-separated.c | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7..994413e 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -2,7 +2,7 @@
 /*
  * Hisilicon Hi3620 clock driver
  *
- * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 HiSilicon Limited.
  * Copyright (c) 2012-2013 Linaro Limited.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/drivers/clk/hisilicon/clk-hi3660-stub.c b/drivers/clk/hisilicon/clk-hi3660-stub.c
index 3a653d5..a92c820 100644
--- a/drivers/clk/hisilicon/clk-hi3660-stub.c
+++ b/drivers/clk/hisilicon/clk-hi3660-stub.c
@@ -2,7 +2,7 @@
 /*
  * Hisilicon clock driver
  *
- * Copyright (c) 2013-2017 Hisilicon Limited.
+ * Copyright (c) 2013-2017 HiSilicon Limited.
  * Copyright (c) 2017 Linaro Limited.
  *
  * Author: Kai Zhao <zhaokai1@hisilicon.com>
diff --git a/drivers/clk/hisilicon/clk-hi6220-stub.c b/drivers/clk/hisilicon/clk-hi6220-stub.c
index 4fdee44..6ae2b0d 100644
--- a/drivers/clk/hisilicon/clk-hi6220-stub.c
+++ b/drivers/clk/hisilicon/clk-hi6220-stub.c
@@ -2,7 +2,7 @@
 /*
  * Hi6220 stub clock driver
  *
- * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 HiSilicon Limited.
  * Copyright (c) 2015 Linaro Limited.
  *
  * Author: Leo Yan <leo.yan@linaro.org>
diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index e7cdf72..e9177e8 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -2,7 +2,7 @@
 /*
  * Hisilicon Hi6220 clock driver
  *
- * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 HiSilicon Limited.
  *
  * Author: Bintian Wang <bintian.wang@huawei.com>
  */
diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index 785b9fa..a455404 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -2,7 +2,7 @@
 /*
  * Hisilicon HiP04 clock driver
  *
- * Copyright (c) 2013-2014 Hisilicon Limited.
+ * Copyright (c) 2013-2014 HiSilicon Limited.
  * Copyright (c) 2013-2014 Linaro Limited.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 64bdd3f..54a8f98 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2014 Linaro Ltd.
- * Copyright (c) 2014 Hisilicon Limited.
+ * Copyright (c) 2014 HiSilicon Limited.
  */
 
 #include <linux/of_address.h>
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc..72bfeac 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -2,7 +2,7 @@
 /*
  * Hisilicon clock driver
  *
- * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 HiSilicon Limited.
  * Copyright (c) 2012-2013 Linaro Limited.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 61cbd90..b24cd21 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -2,7 +2,7 @@
 /*
  * Hisilicon Hi3620 clock gate driver
  *
- * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 HiSilicon Limited.
  * Copyright (c) 2012-2013 Linaro Limited.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
index 5348baf..033c5ab 100644
--- a/drivers/clk/hisilicon/clkdivider-hi6220.c
+++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
@@ -2,7 +2,7 @@
 /*
  * Hisilicon hi6220 SoC divider clock driver
  *
- * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 HiSilicon Limited.
  *
  * Author: Bintian Wang <bintian.wang@huawei.com>
  */
diff --git a/drivers/clk/hisilicon/clkgate-separated.c b/drivers/clk/hisilicon/clkgate-separated.c
index 90d8585..475948c 100644
--- a/drivers/clk/hisilicon/clkgate-separated.c
+++ b/drivers/clk/hisilicon/clkgate-separated.c
@@ -2,7 +2,7 @@
 /*
  * Hisilicon clock separated gate driver
  *
- * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 HiSilicon Limited.
  * Copyright (c) 2012-2013 Linaro Limited.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
-- 
2.8.1

