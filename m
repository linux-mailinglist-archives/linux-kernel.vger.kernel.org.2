Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40E34E181
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhC3GtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:49:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15815 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhC3GtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:49:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8g3P3mJmz93dF;
        Tue, 30 Mar 2021 14:46:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:48:52 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>
CC:     <majun258@huawei.com>, <wuyun.wu@huawei.com>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] irqchip/hisi: Use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:46:20 +0800
Message-ID: <1617086780-8521-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Hisilicon/HiSilicon/
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/irqchip/irq-hip04.c  | 4 ++--
 drivers/irqchip/irq-mbigen.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index a6ed877..058ebae 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon HiP04 INTC
+ * HiSilicon HiP04 INTC
  *
  * Copyright (C) 2002-2014 ARM Limited.
- * Copyright (c) 2013-2014 Hisilicon Ltd.
+ * Copyright (c) 2013-2014 HiSilicon Ltd.
  * Copyright (c) 2013-2014 Linaro Ltd.
  *
  * Interrupt architecture for the HIP04 INTC:
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index ff7627b..2cb45c6 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 Hisilicon Limited, All Rights Reserved.
+ * Copyright (C) 2015 HiSilicon Limited, All Rights Reserved.
  * Author: Jun Ma <majun258@huawei.com>
  * Author: Yun Wu <wuyun.wu@huawei.com>
  */
@@ -390,4 +390,4 @@ module_platform_driver(mbigen_platform_driver);
 MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
 MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Hisilicon MBI Generator driver");
+MODULE_DESCRIPTION("HiSilicon MBI Generator driver");
-- 
2.8.1

