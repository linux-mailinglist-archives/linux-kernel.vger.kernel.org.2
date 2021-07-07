Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9BA3BE3CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGGHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:45:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14030 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhGGHp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:45:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GKWXz2p47zZp6s;
        Wed,  7 Jul 2021 15:40:03 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Jul 2021 15:43:10 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Jul 2021 15:43:09 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kay Sievers <kay.sievers@novell.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 1/1] driver core: Fix error return code in really_probe()
Date:   Wed, 7 Jul 2021 15:43:01 +0800
Message-ID: <20210707074301.2722-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of error handling, the error code returned by the subfunction
should be propagated instead of 0.

Fixes: 1901fb2604fb ("Driver core: fix "driver" symlink timing")
Fixes: 23b6904442d0 ("driver core: add dev_groups to all drivers")
Fixes: 8fd456ec0cf0 ("driver core: Add state_synced sysfs file for devices that support it")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/base/dd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index daeb9b5763ae..2b8cdb78384c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -580,7 +580,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
-	if (driver_sysfs_add(dev)) {
+	ret = driver_sysfs_add(dev);
+	if (ret) {
 		pr_err("%s: driver_sysfs_add(%s) failed\n",
 		       __func__, dev_name(dev));
 		goto probe_failed;
@@ -602,15 +603,18 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		goto probe_failed;
 	}
 
-	if (device_add_groups(dev, drv->dev_groups)) {
+	ret = device_add_groups(dev, drv->dev_groups);
+	if (ret) {
 		dev_err(dev, "device_add_groups() failed\n");
 		goto dev_groups_failed;
 	}
 
-	if (dev_has_sync_state(dev) &&
-	    device_create_file(dev, &dev_attr_state_synced)) {
-		dev_err(dev, "state_synced sysfs add failed\n");
-		goto dev_sysfs_state_synced_failed;
+	if (dev_has_sync_state(dev)) {
+		ret = device_create_file(dev, &dev_attr_state_synced);
+		if (ret) {
+			dev_err(dev, "state_synced sysfs add failed\n");
+			goto dev_sysfs_state_synced_failed;
+		}
 	}
 
 	if (test_remove) {
-- 
2.25.1


