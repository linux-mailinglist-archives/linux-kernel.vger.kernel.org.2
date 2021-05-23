Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6070238D961
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhEWHDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:03:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3658 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhEWHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:03:54 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fnrnh22sgzmYZJ;
        Sun, 23 May 2021 15:00:08 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 23 May 2021 15:02:26 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 23
 May 2021 15:02:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>, <yuehaibing@huawei.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] xen/pcpu: Use DEVICE_ATTR_RW macro
Date:   Sun, 23 May 2021 15:02:14 +0800
Message-ID: <20210523070214.34948-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RW helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/pcpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index 1bcdd5227771..47aa3a1ccaf5 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -92,7 +92,7 @@ static int xen_pcpu_up(uint32_t cpu_id)
 	return HYPERVISOR_platform_op(&op);
 }
 
-static ssize_t show_online(struct device *dev,
+static ssize_t online_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
@@ -101,7 +101,7 @@ static ssize_t show_online(struct device *dev,
 	return sprintf(buf, "%u\n", !!(cpu->flags & XEN_PCPU_FLAGS_ONLINE));
 }
 
-static ssize_t __ref store_online(struct device *dev,
+static ssize_t __ref online_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
@@ -130,7 +130,7 @@ static ssize_t __ref store_online(struct device *dev,
 		ret = count;
 	return ret;
 }
-static DEVICE_ATTR(online, S_IRUGO | S_IWUSR, show_online, store_online);
+static DEVICE_ATTR_RW(online);
 
 static struct attribute *pcpu_dev_attrs[] = {
 	&dev_attr_online.attr,
-- 
2.17.1

