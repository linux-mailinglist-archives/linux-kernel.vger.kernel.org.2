Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0E34A3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhCZJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14910 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCZJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:11:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F6GQK3JCkzkfyk;
        Fri, 26 Mar 2021 17:10:01 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 17:11:33 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>
CC:     <yekai13@huawei.com>
Subject: [PATCH v3] uacce: delete unneeded variable initialization
Date:   Fri, 26 Mar 2021 17:09:07 +0800
Message-ID: <1616749747-3882-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

delete unneeded variable initialization.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
Changes v2 -> v3:
 re-edit the subject line.

 drivers/misc/uacce/uacce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d07af4e..94843e0 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -126,7 +126,7 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 {
 	struct uacce_device *uacce;
 	struct uacce_queue *q;
-	int ret = 0;
+	int ret;
 
 	uacce = xa_load(&uacce_xa, iminor(inode));
 	if (!uacce)
-- 
2.8.1

