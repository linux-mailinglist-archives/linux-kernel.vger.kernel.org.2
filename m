Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3853939F634
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhFHMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:18:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8092 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhFHMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:18:23 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzq040YsczYrwN;
        Tue,  8 Jun 2021 20:13:40 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:16:24 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:16:24 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mtd: Convert list_for_each to entry variant
Date:   Tue, 8 Jun 2021 20:34:59 +0800
Message-ID: <1623155699-61935-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/mtd/chips/chipreg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/chips/chipreg.c b/drivers/mtd/chips/chipreg.c
index ff86373..a05e103 100644
--- a/drivers/mtd/chips/chipreg.c
+++ b/drivers/mtd/chips/chipreg.c
@@ -31,14 +31,11 @@ void unregister_mtd_chip_driver(struct mtd_chip_driver *drv)
 
 static struct mtd_chip_driver *get_mtd_chip_driver (const char *name)
 {
-	struct list_head *pos;
 	struct mtd_chip_driver *ret = NULL, *this;
 
 	spin_lock(&chip_drvs_lock);
 
-	list_for_each(pos, &chip_drvs_list) {
-		this = list_entry(pos, typeof(*this), list);
-
+	list_for_each_entry(this, &chip_drvs_list, list) {
 		if (!strcmp(this->name, name)) {
 			ret = this;
 			break;
-- 
2.6.2

