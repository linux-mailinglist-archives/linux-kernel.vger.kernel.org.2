Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45B1417F8A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 05:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbhIYD5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 23:57:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:21968 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhIYD5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 23:57:07 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HGZh519RzzbmlD;
        Sat, 25 Sep 2021 11:51:17 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Sat, 25 Sep 2021 11:55:30 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 25 Sep 2021 11:55:30 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] regulator: dummy: Use devm_regulator_register()
Date:   Sat, 25 Sep 2021 11:55:07 +0800
Message-ID: <20210925035507.1904-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs code complained at boot time that

  debugfs: Directory 'reg-dummy-regulator-dummy' with parent 'regulator'
  already present!

if we compile kernel with DEBUG_TEST_DRIVER_REMOVE. The problem is that we
don't provide .remove() method for dummy_regulator_driver, which should
invoke regulator_unregister() on device teardown to properly free things.

Though it's harmless as dummy_pdev never gets unbound in practice, let's
use devm_regulator_register() to get rid of the inconsistency.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/regulator/dummy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index d8059f596391..24e586f93855 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -45,7 +45,8 @@ static int dummy_regulator_probe(struct platform_device *pdev)
 	config.dev = &pdev->dev;
 	config.init_data = &dummy_initdata;
 
-	dummy_regulator_rdev = regulator_register(&dummy_desc, &config);
+	dummy_regulator_rdev = devm_regulator_register(&pdev->dev, &dummy_desc,
+						       &config);
 	if (IS_ERR(dummy_regulator_rdev)) {
 		ret = PTR_ERR(dummy_regulator_rdev);
 		pr_err("Failed to register regulator: %d\n", ret);
-- 
2.19.1

