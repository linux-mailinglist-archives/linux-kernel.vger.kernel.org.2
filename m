Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21DE398885
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFBLqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:46:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2965 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFBLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:45:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw6Y952hNz6933;
        Wed,  2 Jun 2021 19:41:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:57 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:57 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 6/9] mfd: kempld-core: use DEVICE_ATTR_RO macro
Date:   Wed, 2 Jun 2021 19:43:36 +0800
Message-ID: <20210602114339.11223-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210602114339.11223-1-thunder.leizhen@huawei.com>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/kempld-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 9166075c1f321a4..bb26241c73bdb8f 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -344,16 +344,16 @@ static const char *kempld_get_type_string(struct kempld_device_data *pld)
 	return version_type;
 }
 
-static ssize_t kempld_version_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t pld_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct kempld_device_data *pld = dev_get_drvdata(dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%s\n", pld->info.version);
 }
 
-static ssize_t kempld_specification_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t pld_specification_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
 {
 	struct kempld_device_data *pld = dev_get_drvdata(dev);
 
@@ -361,18 +361,17 @@ static ssize_t kempld_specification_show(struct device *dev,
 		       pld->info.spec_minor);
 }
 
-static ssize_t kempld_type_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t pld_type_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct kempld_device_data *pld = dev_get_drvdata(dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%s\n", kempld_get_type_string(pld));
 }
 
-static DEVICE_ATTR(pld_version, S_IRUGO, kempld_version_show, NULL);
-static DEVICE_ATTR(pld_specification, S_IRUGO, kempld_specification_show,
-		   NULL);
-static DEVICE_ATTR(pld_type, S_IRUGO, kempld_type_show, NULL);
+static DEVICE_ATTR_RO(pld_version);
+static DEVICE_ATTR_RO(pld_specification);
+static DEVICE_ATTR_RO(pld_type);
 
 static struct attribute *pld_attributes[] = {
 	&dev_attr_pld_version.attr,
-- 
2.26.0.106.g9fadedd


