Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B0943E144
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhJ1MyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:54:12 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26201 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1MyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:54:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Hg54n3bHmz8tym
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 20:50:17 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 20:51:38 +0800
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 20:51:38 +0800
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <wuxu.wu@huawei.com>, Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] genirq: Use AFFINITY and AFFINITY_LIST in
 write_irq_affinity()
Message-ID: <3edf17ad-e784-f541-1b49-3c95a982d6b5@huawei.com>
Date:   Thu, 28 Oct 2021 20:51:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 0d3f54257dc3 ("genirq: Introduce effective affinity mask")
introduce AFFINITY and AFFINITY_LIST Enumerated Type, so use it in
write_irq_affinity().

No functional change.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/irq/proc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index ee595ec09778..423f65203a69 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -147,10 +147,16 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;

-	if (type)
+	switch (type) {
+	case AFFINITY_LIST:
 		err = cpumask_parselist_user(buffer, count, new_value);
-	else
+		break;
+	case AFFINITY:
 		err = cpumask_parse_user(buffer, count, new_value);
+		break;
+	default:
+		err = -EINVAL;
+	}
 	if (err)
 		goto free_cpumask;

@@ -179,13 +185,13 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 static ssize_t irq_affinity_proc_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)
 {
-	return write_irq_affinity(0, file, buffer, count, pos);
+	return write_irq_affinity(AFFINITY, file, buffer, count, pos);
 }

 static ssize_t irq_affinity_list_proc_write(struct file *file,
 		const char __user *buffer, size_t count, loff_t *pos)
 {
-	return write_irq_affinity(1, file, buffer, count, pos);
+	return write_irq_affinity(AFFINITY_LIST, file, buffer, count, pos);
 }

 static int irq_affinity_proc_open(struct inode *inode, struct file *file)
-- 
2.27.0
