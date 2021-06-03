Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19317399DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFCJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:30:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2974 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:30:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwgVY65cZz6trs;
        Thu,  3 Jun 2021 17:25:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:28:36 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:28:36 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        nvdimm <nvdimm@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] device-dax: use DEVICE_ATTR_ADMIN_RO() helper macro
Date:   Thu, 3 Jun 2021 17:24:05 +0800
Message-ID: <20210603092405.11824-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_ADMIN_RO() helper macro instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dax/bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 5aee26e1bbd6dba..a8a26398a313cd9 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -655,7 +655,7 @@ static ssize_t start_show(struct device *dev,
 
 	return rc;
 }
-static DEVICE_ATTR(start, 0400, start_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(start);
 
 static ssize_t end_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -671,9 +671,9 @@ static ssize_t end_show(struct device *dev,
 
 	return rc;
 }
-static DEVICE_ATTR(end, 0400, end_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(end);
 
-static ssize_t pgoff_show(struct device *dev,
+static ssize_t page_offset_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct dev_dax_range *dax_range;
@@ -687,7 +687,7 @@ static ssize_t pgoff_show(struct device *dev,
 
 	return rc;
 }
-static DEVICE_ATTR(page_offset, 0400, pgoff_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(page_offset);
 
 static struct attribute *dax_mapping_attributes[] = {
 	&dev_attr_start.attr,
@@ -1191,7 +1191,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return sprintf(buf, "%#llx\n", start);
 }
-static DEVICE_ATTR(resource, 0400, resource_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(resource);
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
-- 
2.26.0.106.g9fadedd


