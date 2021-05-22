Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C738D516
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhEVK00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:26:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5736 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhEVK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:26:25 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnKJQ40FKzqTsv;
        Sat, 22 May 2021 18:21:26 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:24:59 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:24:58 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <xuwei5@hisilicon.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH] ARM: dts: hisilicon: use the correct HiSilicon copyright
Date:   Sat, 22 May 2021 18:21:57 +0800
Message-ID: <1621678917-15089-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
 arch/arm/boot/dts/hi3620.dtsi        | 4 ++--
 arch/arm/boot/dts/hip01-ca9x2.dts    | 4 ++--
 arch/arm/boot/dts/hip01.dtsi         | 4 ++--
 arch/arm/boot/dts/hip04.dtsi         | 4 ++--
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts | 2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi    | 2 +-
 arch/arm/boot/dts/sd5203.dts         | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index 905900b..cf48ec1 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon Ltd. Hi3620 SoC
+ * HiSilicon Ltd. Hi3620 SoC
  *
- * Copyright (C) 2012-2013 Hisilicon Ltd.
+ * Copyright (C) 2012-2013 HiSilicon Ltd.
  * Copyright (C) 2012-2013 Linaro Ltd.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/arch/arm/boot/dts/hip01-ca9x2.dts b/arch/arm/boot/dts/hip01-ca9x2.dts
index 0314763..f3faf24 100644
--- a/arch/arm/boot/dts/hip01-ca9x2.dts
+++ b/arch/arm/boot/dts/hip01-ca9x2.dts
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon Ltd. HiP01 SoC
+ * HiSilicon Ltd. HiP01 SoC
  *
- * Copyright (C) 2014 Hisilicon Ltd.
+ * Copyright (C) 2014 HiSilicon Ltd.
  * Copyright (C) 2014 Huawei Ltd.
  *
  * Author: Wang Long <long.wanglong@huawei.com>
diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hip01.dtsi
index 2a79636..e17f36b 100644
--- a/arch/arm/boot/dts/hip01.dtsi
+++ b/arch/arm/boot/dts/hip01.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon Ltd. HiP01 SoC
+ * HiSilicon Ltd. HiP01 SoC
  *
- * Copyright (c) 2014 Hisilicon Ltd.
+ * Copyright (c) 2014 HiSilicon Ltd.
  * Copyright (c) 2014 Huawei Ltd.
  *
  * Author: Wang Long <long.wanglong@huawei.com>
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index bccf5ba..2424cc5 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Hisilicon Ltd. HiP04 SoC
+ * HiSilicon Ltd. HiP04 SoC
  *
- * Copyright (C) 2013-2014 Hisilicon Ltd.
+ * Copyright (C) 2013-2014 HiSilicon Ltd.
  * Copyright (C) 2013-2014 Linaro Ltd.
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
index 22b122d..7758c19 100644
--- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
+++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2013-2014 Linaro Ltd.
- * Copyright (c) 2013-2014 Hisilicon Limited.
+ * Copyright (c) 2013-2014 HiSilicon Limited.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 9721138..dc991ba 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2013-2014 Linaro Ltd.
- * Copyright (c) 2013-2014 Hisilicon Limited.
+ * Copyright (c) 2013-2014 HiSilicon Limited.
  */
 
 #include <dt-bindings/clock/hix5hd2-clock.h>
diff --git a/arch/arm/boot/dts/sd5203.dts b/arch/arm/boot/dts/sd5203.dts
index 3cc9a23..a61a078 100644
--- a/arch/arm/boot/dts/sd5203.dts
+++ b/arch/arm/boot/dts/sd5203.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2020 Hisilicon Limited.
+ * Copyright (c) 2020 HiSilicon Limited.
  *
  * DTS file for Hisilicon SD5203 Board
  */
-- 
2.8.1

