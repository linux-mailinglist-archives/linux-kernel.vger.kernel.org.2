Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D543829CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhEQK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:29:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2952 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbhEQK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:29:53 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkFdq3nNnzCspT;
        Mon, 17 May 2021 18:25:51 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 18:28:36 +0800
Received: from huawei.com (10.67.165.24) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 18:28:36 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH] uacce: use sysfs_emit instead of sprintf
Date:   Mon, 17 May 2021 18:25:37 +0800
Message-ID: <1621247137-42693-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the sysfs_emit to replace sprintf.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/misc/uacce/uacce.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d07af4e..c8db16c 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -289,7 +289,7 @@ static ssize_t api_show(struct device *dev,
 {
 	struct uacce_device *uacce = to_uacce_device(dev);
 
-	return sprintf(buf, "%s\n", uacce->api_ver);
+	return sysfs_emit(buf, "%s\n", uacce->api_ver);
 }
 
 static ssize_t flags_show(struct device *dev,
@@ -297,7 +297,7 @@ static ssize_t flags_show(struct device *dev,
 {
 	struct uacce_device *uacce = to_uacce_device(dev);
 
-	return sprintf(buf, "%u\n", uacce->flags);
+	return sysfs_emit(buf, "%u\n", uacce->flags);
 }
 
 static ssize_t available_instances_show(struct device *dev,
@@ -309,7 +309,7 @@ static ssize_t available_instances_show(struct device *dev,
 	if (!uacce->ops->get_available_instances)
 		return -ENODEV;
 
-	return sprintf(buf, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		       uacce->ops->get_available_instances(uacce));
 }
 
@@ -318,7 +318,7 @@ static ssize_t algorithms_show(struct device *dev,
 {
 	struct uacce_device *uacce = to_uacce_device(dev);
 
-	return sprintf(buf, "%s\n", uacce->algs);
+	return sysfs_emit(buf, "%s\n", uacce->algs);
 }
 
 static ssize_t region_mmio_size_show(struct device *dev,
@@ -326,7 +326,7 @@ static ssize_t region_mmio_size_show(struct device *dev,
 {
 	struct uacce_device *uacce = to_uacce_device(dev);
 
-	return sprintf(buf, "%lu\n",
+	return sysfs_emit(buf, "%lu\n",
 		       uacce->qf_pg_num[UACCE_QFRT_MMIO] << PAGE_SHIFT);
 }
 
@@ -335,7 +335,7 @@ static ssize_t region_dus_size_show(struct device *dev,
 {
 	struct uacce_device *uacce = to_uacce_device(dev);
 
-	return sprintf(buf, "%lu\n",
+	return sysfs_emit(buf, "%lu\n",
 		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
 }
 
-- 
2.8.1

