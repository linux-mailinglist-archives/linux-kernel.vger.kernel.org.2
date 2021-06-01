Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85A396DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhFAHa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:30:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3488 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAHa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:30:27 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvNxP3z2yzYqp0;
        Tue,  1 Jun 2021 15:26:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:28:45 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:28:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mfd: da9055: Use DEFINE_RES_IRQ_NAMED() to simplify code
Date:   Tue, 1 Jun 2021 15:28:30 +0800
Message-ID: <20210601072830.10310-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/da9055-core.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index d074d213e66170b..c3bcbd8905c6cfa 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -254,41 +254,19 @@ const struct regmap_config da9055_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(da9055_regmap_config);
 
-static const struct resource da9055_onkey_resource = {
-	.name = "ONKEY",
-	.start = DA9055_IRQ_NONKEY,
-	.end   = DA9055_IRQ_NONKEY,
-	.flags = IORESOURCE_IRQ,
-};
+static const struct resource da9055_onkey_resource =
+	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_NONKEY, "ONKEY");
 
 static const struct resource da9055_rtc_resource[] = {
-	{
-		.name = "ALM",
-		.start = DA9055_IRQ_ALARM,
-		.end   = DA9055_IRQ_ALARM,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "TICK",
-		.start = DA9055_IRQ_TICK,
-		.end   = DA9055_IRQ_TICK,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_ALARM, "ALM"),
+	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_TICK, "TICK"),
 };
 
-static const struct resource da9055_hwmon_resource = {
-	.name = "HWMON",
-	.start = DA9055_IRQ_HWMON,
-	.end   = DA9055_IRQ_HWMON,
-	.flags = IORESOURCE_IRQ,
-};
+static const struct resource da9055_hwmon_resource =
+	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_HWMON, "HWMON");
 
-static const struct resource da9055_ld05_6_resource = {
-	.name = "REGULATOR",
-	.start = DA9055_IRQ_REGULATOR,
-	.end   = DA9055_IRQ_REGULATOR,
-	.flags = IORESOURCE_IRQ,
-};
+static const struct resource da9055_ld05_6_resource =
+	DEFINE_RES_IRQ_NAMED(DA9055_IRQ_REGULATOR, "REGULATOR");
 
 static const struct mfd_cell da9055_devs[] = {
 	{
-- 
2.26.0.106.g9fadedd


