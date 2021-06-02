Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C653983CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhFBIIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:08:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6134 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhFBIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:08:01 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw1kF0C09zYnKq;
        Wed,  2 Jun 2021 16:03:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:06:17 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:06:16 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] regulator: userspace-consumer: use DEVICE_ATTR_RO/RW macro
Date:   Wed, 2 Jun 2021 16:05:26 +0800
Message-ID: <20210602080526.11117-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO/RW macro helper instead of plain DEVICE_ATTR, which
makes the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/regulator/userspace-consumer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 8e3b5a67cfd84e5..8ca28664776eb56 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -29,15 +29,15 @@ struct userspace_consumer_data {
 	struct regulator_bulk_data *supplies;
 };
 
-static ssize_t reg_show_name(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct userspace_consumer_data *data = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%s\n", data->name);
 }
 
-static ssize_t reg_show_state(struct device *dev,
+static ssize_t state_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct userspace_consumer_data *data = dev_get_drvdata(dev);
@@ -48,8 +48,8 @@ static ssize_t reg_show_state(struct device *dev,
 	return sprintf(buf, "disabled\n");
 }
 
-static ssize_t reg_set_state(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
+static ssize_t state_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct userspace_consumer_data *data = dev_get_drvdata(dev);
 	bool enabled;
@@ -87,8 +87,8 @@ static ssize_t reg_set_state(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(name, 0444, reg_show_name, NULL);
-static DEVICE_ATTR(state, 0644, reg_show_state, reg_set_state);
+static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RW(state);
 
 static struct attribute *attributes[] = {
 	&dev_attr_name.attr,
-- 
2.26.0.106.g9fadedd


