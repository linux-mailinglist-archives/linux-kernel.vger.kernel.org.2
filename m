Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22C738D529
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhEVKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:32:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3913 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhEVKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:32:02 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FnKRl5vgnzBvPj;
        Sat, 22 May 2021 18:27:47 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:30:36 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:30:36 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <robh@kernel.org>, <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <haojian.zhuang@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] dt-binding: clk: hisilicon: use the correct HiSilicon copyright
Date:   Sat, 22 May 2021 18:27:33 +0800
Message-ID: <1621679253-15837-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 include/dt-bindings/clock/hi3620-clock.h  | 2 +-
 include/dt-bindings/clock/hi6220-clock.h  | 2 +-
 include/dt-bindings/clock/hip04-clock.h   | 2 +-
 include/dt-bindings/clock/hix5hd2-clock.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/clock/hi3620-clock.h b/include/dt-bindings/clock/hi3620-clock.h
index f9dc6f6..baf5e42 100644
--- a/include/dt-bindings/clock/hi3620-clock.h
+++ b/include/dt-bindings/clock/hi3620-clock.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 HiSilicon Limited.
  * Copyright (c) 2012-2013 Linaro Limited.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/include/dt-bindings/clock/hi6220-clock.h b/include/dt-bindings/clock/hi6220-clock.h
index 9e40605..37b92d8 100644
--- a/include/dt-bindings/clock/hi6220-clock.h
+++ b/include/dt-bindings/clock/hi6220-clock.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 HiSilicon Limited.
  *
  * Author: Bintian Wang <bintian.wang@huawei.com>
  */
diff --git a/include/dt-bindings/clock/hip04-clock.h b/include/dt-bindings/clock/hip04-clock.h
index 088d70c..86b3bd1 100644
--- a/include/dt-bindings/clock/hip04-clock.h
+++ b/include/dt-bindings/clock/hip04-clock.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (c) 2013-2014 Hisilicon Limited.
+ * Copyright (c) 2013-2014 HiSilicon Limited.
  * Copyright (c) 2013-2014 Linaro Limited.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/include/dt-bindings/clock/hix5hd2-clock.h b/include/dt-bindings/clock/hix5hd2-clock.h
index 2b8779f1..ca6acc5 100644
--- a/include/dt-bindings/clock/hix5hd2-clock.h
+++ b/include/dt-bindings/clock/hix5hd2-clock.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (c) 2014 Linaro Ltd.
- * Copyright (c) 2014 Hisilicon Limited.
+ * Copyright (c) 2014 HiSilicon Limited.
  */
 
 #ifndef __DTS_HIX5HD2_CLOCK_H
-- 
2.8.1

