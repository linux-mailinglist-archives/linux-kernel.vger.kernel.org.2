Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3B38D95C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhEWG75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 02:59:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5521 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhEWG74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 02:59:56 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnrhW6kkMzkY2C
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 14:55:39 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 23 May 2021 14:58:29 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 23
 May 2021 14:58:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clockevents: use DEVICE_ATTR_<RO|WO> macro
Date:   Sun, 23 May 2021 14:58:25 +0800
Message-ID: <20210523065825.19684-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_<RO|WO> helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/time/clockevents.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index f5490222e134..0056d2bed53e 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -668,9 +668,9 @@ static struct bus_type clockevents_subsys = {
 static DEFINE_PER_CPU(struct device, tick_percpu_dev);
 static struct tick_device *tick_get_tick_dev(struct device *dev);
 
-static ssize_t sysfs_show_current_tick_dev(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t current_device_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
 {
 	struct tick_device *td;
 	ssize_t count = 0;
@@ -682,12 +682,12 @@ static ssize_t sysfs_show_current_tick_dev(struct device *dev,
 	raw_spin_unlock_irq(&clockevents_lock);
 	return count;
 }
-static DEVICE_ATTR(current_device, 0444, sysfs_show_current_tick_dev, NULL);
+static DEVICE_ATTR_RO(current_device);
 
 /* We don't support the abomination of removable broadcast devices */
-static ssize_t sysfs_unbind_tick_dev(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
+static ssize_t unbind_device_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	char name[CS_NAME_LEN];
 	ssize_t ret = sysfs_get_uname(buf, name, count);
@@ -714,7 +714,7 @@ static ssize_t sysfs_unbind_tick_dev(struct device *dev,
 	mutex_unlock(&clockevents_mutex);
 	return ret ? ret : count;
 }
-static DEVICE_ATTR(unbind_device, 0200, NULL, sysfs_unbind_tick_dev);
+static DEVICE_ATTR_WO(unbind_device);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static struct device tick_bc_dev = {
-- 
2.17.1

