Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8938D523
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhEVKaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:30:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5738 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhEVKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:30:18 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnKNv46zFzqTyK;
        Sat, 22 May 2021 18:25:19 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:28:52 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:28:52 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <puck.chen@hisilicon.com>, <guodong.xu@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] regulator: hisilicon: use the correct HiSilicon copyright
Date:   Sat, 22 May 2021 18:25:51 +0800
Message-ID: <1621679151-15617-1-git-send-email-fanghao11@huawei.com>
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
 drivers/regulator/hi6421v600-regulator.c | 2 +-
 drivers/regulator/hi655x-regulator.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index f6a14e9..612b964 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -3,7 +3,7 @@
 // Device driver for regulators in Hisi IC
 //
 // Copyright (c) 2013 Linaro Ltd.
-// Copyright (c) 2011 Hisilicon.
+// Copyright (c) 2011 HiSilicon Ltd.
 // Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
 //
 // Guodong Xu <guodong.xu@linaro.org>
diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index ac2ee20..68cdb17 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -2,7 +2,7 @@
 //
 // Device driver for regulators in Hi655x IC
 //
-// Copyright (c) 2016 Hisilicon.
+// Copyright (c) 2016 HiSilicon Ltd.
 //
 // Authors:
 // Chen Feng <puck.chen@hisilicon.com>
-- 
2.8.1

