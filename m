Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9912034E194
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhC3Gyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:54:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15035 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhC3GyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:54:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8g8w4mjvzPmkQ;
        Tue, 30 Mar 2021 14:51:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:54:12 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <linux@armlinux.org.uk>, <xuwei5@hisilicon.com>
CC:     <haojian.zhuang@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] ARM: hisi: use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:51:40 +0800
Message-ID: <1617087100-20949-1-git-send-email-fanghao11@huawei.com>
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
 arch/arm/mach-hisi/hisilicon.c | 4 ++--
 arch/arm/mach-hisi/hotplug.c   | 2 +-
 arch/arm/mach-hisi/platmcpm.c  | 2 +-
 arch/arm/mach-hisi/platsmp.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 07ea28b..b8d14b3 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * (Hisilicon's SoC based) flattened device tree enabled machine
+ * (HiSilicon's SoC based) flattened device tree enabled machine
  *
- * Copyright (c) 2012-2013 Hisilicon Ltd.
+ * Copyright (c) 2012-2013 HiSilicon Ltd.
  * Copyright (c) 2012-2013 Linaro Ltd.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 5c5f255..c517941 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2013 Linaro Ltd.
- * Copyright (c) 2013 Hisilicon Limited.
+ * Copyright (c) 2013 HiSilicon Limited.
  */
 
 #include <linux/cpu.h>
diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index f155e32..96a4840 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2013-2014 Linaro Ltd.
- * Copyright (c) 2013-2014 Hisilicon Limited.
+ * Copyright (c) 2013-2014 HiSilicon Limited.
  */
 #include <linux/init.h>
 #include <linux/smp.h>
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index da7a09c..a56cc64 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2013 Linaro Ltd.
- * Copyright (c) 2013 Hisilicon Limited.
+ * Copyright (c) 2013 HiSilicon Limited.
  * Based on arch/arm/mach-vexpress/platsmp.c, Copyright (C) 2002 ARM Ltd.
  */
 #include <linux/smp.h>
-- 
2.8.1

