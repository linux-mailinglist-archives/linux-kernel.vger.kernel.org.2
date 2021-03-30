Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B634B34E186
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhC3Gu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:50:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15816 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhC3GuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:50:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8g4x3734z93Ls;
        Tue, 30 Mar 2021 14:48:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:50:13 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <xuejiancheng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] phy: hisilicon: Use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:47:41 +0800
Message-ID: <1617086861-13900-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S,
according to https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/phy/hisilicon/phy-hi6220-usb.c   | 2 +-
 drivers/phy/hisilicon/phy-hix5hd2-sata.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi6220-usb.c b/drivers/phy/hisilicon/phy-hi6220-usb.c
index be05292..e92ba78 100644
--- a/drivers/phy/hisilicon/phy-hi6220-usb.c
+++ b/drivers/phy/hisilicon/phy-hi6220-usb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Linaro Ltd.
- * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 HiSilicon Limited.
  */
 
 #include <linux/mfd/syscon.h>
diff --git a/drivers/phy/hisilicon/phy-hix5hd2-sata.c b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
index c67b78c..b0f99a9 100644
--- a/drivers/phy/hisilicon/phy-hix5hd2-sata.c
+++ b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Linaro Ltd.
- * Copyright (c) 2014 Hisilicon Limited.
+ * Copyright (c) 2014 HiSilicon Limited.
  */
 
 #include <linux/delay.h>
-- 
2.8.1

