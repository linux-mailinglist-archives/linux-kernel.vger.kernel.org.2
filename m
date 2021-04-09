Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302603599AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhDIJoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:44:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16860 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhDIJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:43:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGtS05nccz7v35;
        Fri,  9 Apr 2021 17:41:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:24 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] dca: use DEFINE_SPINLOCK() for spinlock and DEFINE_IDR() for idr
Date:   Fri, 9 Apr 2021 17:51:49 +0800
Message-ID: <20210409095149.2294378-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().
idr can be initialized automatically with DEFINE_IDR()
rather than explicitly calling idr_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/dca/dca-sysfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dca/dca-sysfs.c b/drivers/dca/dca-sysfs.c
index 21ebd0af268b..c56e917f0f19 100644
--- a/drivers/dca/dca-sysfs.c
+++ b/drivers/dca/dca-sysfs.c
@@ -14,8 +14,8 @@
 #include <linux/export.h>
 
 static struct class *dca_class;
-static struct idr dca_idr;
-static spinlock_t dca_idr_lock;
+static DEFINE_IDR(dca_idr);
+static DEFINE_SPINLOCK(dca_idr_lock);
 
 int dca_sysfs_add_req(struct dca_provider *dca, struct device *dev, int slot)
 {
@@ -71,9 +71,6 @@ void dca_sysfs_remove_provider(struct dca_provider *dca)
 
 int __init dca_sysfs_init(void)
 {
-	idr_init(&dca_idr);
-	spin_lock_init(&dca_idr_lock);
-
 	dca_class = class_create(THIS_MODULE, "dca");
 	if (IS_ERR(dca_class)) {
 		idr_destroy(&dca_idr);

