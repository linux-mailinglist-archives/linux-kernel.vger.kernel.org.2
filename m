Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9934E190
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhC3Gxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:53:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14192 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhC3Gx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:53:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8g7r4Xmyzmc9T
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:50:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:53:16 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <p.zabel@pengutronix.de>
CC:     <puck.chen@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH] reset: hi6220: Use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:50:44 +0800
Message-ID: <1617087044-19572-1-git-send-email-fanghao11@huawei.com>
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
 drivers/reset/hisilicon/hi6220_reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 1992650..5ca145b 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -3,7 +3,7 @@
  * Hisilicon Hi6220 reset controller driver
  *
  * Copyright (c) 2016 Linaro Limited.
- * Copyright (c) 2015-2016 Hisilicon Limited.
+ * Copyright (c) 2015-2016 HiSilicon Limited.
  *
  * Author: Feng Chen <puck.chen@hisilicon.com>
  */
-- 
2.8.1

